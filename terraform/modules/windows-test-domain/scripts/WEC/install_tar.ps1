#!/usr/bin/env pwsh

$BUCKET_NAME="cdio-cyber-security-splunk-apps-publishing-prod"
$FORWARDER=$env:FORWARDER
$AWS_ACCOUNT="779799343306"

$NEW_OR_UPDATED = 0

function Get-RoleArn {
  param([string]$forwarder, [string]$account)
  $TextInfo = (Get-Culture).TextInfo
  $words=($forwarder -replace "-", " ")
  $title=($TextInfo.ToTitleCase($words))
  $pascal=($title -replace " ", "")
  $arn="arn:aws:iam::${account}:role/SplunkForwarderRole${pascal}"
  $arn
}

function Calculate-LowerCaseFileHash {
  param([string]$path)
  $calculated_hash=((Get-FileHash $path).Hash)
  $calculated_hash.ToLower()
}

function Check-HashIsValid {
  param([string]$bucket, [string]$forwarder, [string]$file, [string]$hash, [Amazon.SecurityToken.Model.Credentials]$creds)
  $relpath="$forwarder/$file"
  $abspath="$PSScriptRoot/$relpath"
  $calculated_hash=(Calculate-LowerCaseFileHash -path $abspath)
  $METADATA_OBJECT=(Get-S3ObjectMetadata -Credential $creds -BucketName $bucket -Key $relpath)
  $published_hash=($METADATA_OBJECT.Metadata.Item("x-amz-meta-hash"))
  If ($published_hash -eq $calculated_hash -and
    $calculated_hash -eq $hash) {
    $hash_is_valid = 1
  } Else {
    $hash_is_valid = 0
  }
  $hash_is_valid
}

$splunk = Get-ChildItem "C:\Program Files\" |
  ?{$_.PSISContainer} |
  ?{$_.Name -Like '*Splunk*'}

If ($splunk.Length -eq 0) {
  Write-Host "Splunk not installed"
  exit 1
} Else {
  Write-Host  "Found local Splunk install"
}

If ($splunk.Length -gt 1) {
  Write-Host "Multiple Splunk folders found"
  exit 1
}

$env:SPLUNK_HOME = $splunk.FullName

Try {
  If (Get-Command Get-AWSPowerShellVersion -ErrorAction Stop) {
    Write-Host "AWS PowerShell common module already installed"
  }
} Catch {
  Write-Host "Installing AWS PowerShell common module"
  Install-Module -Name AWS.Tools.Common -Force
}

Try {
  If (Get-Command Get-S3Bucket -ErrorAction Stop) {
    Write-Host "AWS PowerShell S3 module already installed"
  }
} Catch {
  Write-Host "Installing AWS PowerShell S3 module"
  Install-Module -Name AWS.Tools.S3 -Force
}

Try {
  If (Get-Command Use-STSRole -ErrorAction Stop) {
    Write-Host "AWS PowerShell SecurityToken module already installed"
  }
} Catch {
  Write-Host "Installing AWS PowerShell SecurityToken module"
  Install-Module -Name AWS.Tools.SecurityToken -Force
}

Try {
  $ROLE_ARN=(Get-RoleArn -forwarder $FORWARDER -account $AWS_ACCOUNT)
  Write-Host "Assuming role: $ROLE_ARN"
  $ROLE_SESSION = (Use-STSRole -RoleArn $ROLE_ARN -RoleSessionName "CyberSession" -ErrorAction Stop).Credentials
} Catch {
  Write-Host "Failed to assume forwarder role"
  exit 1
}

# Download S3 path for forwarder to local directory
Try {
  Read-S3Object -Credential $ROLE_SESSION -KeyPrefix $FORWARDER -BucketName $BUCKET_NAME -Folder $PSScriptRoot/$FORWARDER -ErrorAction Stop
} Catch {
  Write-Host "Failed to read S3 bucket"
  exit 1
}

$METADATA_CSV=(Import-CSV $PSScriptRoot/$FORWARDER/metadata.csv)
ForEach ($APP in $METADATA_CSV){
  $app_id = $APP."app-id"
  $app_file = $APP."file-name"
  $app_version = $APP."version"
  $app_build = $APP."build"
  $app_hash = $APP."hash".ToLower()
  Write-Host Application: $app_id
  Write-Host File: $app_file
  Write-Host Version: $app_version
  Write-Host Build: $app_build
  Write-Host Hash: $app_hash
  $valid=(Check-HashIsValid -bucket $BUCKET_NAME -forwarder $FORWARDER -file $app_file -hash $app_hash -creds $ROLE_SESSION)
  Write-Host "Hash is valid: $valid"
  If ($valid -eq 1) {
    Write-Host "Hash matches"
    Write-Host "Downloaded - $app_id v:$app_version b:$app_build"
    $app_conf = "$env:SPLUNK_HOME/etc/apps/$app_id/default/app.conf"
    if (Test-Path $app_conf) {
      $matches = (Select-String -Path $app_conf -Pattern "^version|^build").Line
      $current_version = (($matches | ?{$_ -LIKE "version*"}) -split "=")[1].Trim()
      $current_build = (($matches | ?{$_ -LIKE "build*"}) -split "=")[1].Trim()
    } else {
      $current_version = 0
      $current_build = 0
    }
    Write-Host "Installed  - $app_id v:$current_version b:$current_build"
    if ($app_version -ne $current_version -or
        $app_build -ne $current_build) {
      Write-Host "App version or build changed - installing"
      $path="$PSScriptRoot/$FORWARDER/$app_file"
      tar -xf $path -C "$env:SPLUNK_HOME/etc/apps"
      $NEW_OR_UPDATED = 1
      type $app_conf
    } else {
      Write-Host "App matches existing version"
    }
  } Else {
    Write-Host "Ignoring app: Hash invalid for $app_id $version $build"
    exit 1
  }
}

if ($NEW_OR_UPDATED -eq 1) {
  Write-Host "Restarting Splunk to load new config"
  cd $env:SPLUNK_HOME
  bin/splunk restart
}

Write-Host "Cleaning up"
Remove-Item -Recurse -Force $PSScriptRoot/$FORWARDER

# Unwrap tar binary

New-Item -Path "c:\progra~1" -Name "WinTar" -ItemType "directory"
Expand-Archive -LiteralPath C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\utilities\WinTar.zip -DestinationPath C:\progra~1\WinTar

# add tar to $PATH
$profile_append_content = @"
`$env:PATH += `";C:\progra~1\WinTar;`"
"@

Try {
  If (Test-Path $profile) {
    Write-Host "Profile already exists"
  }
} Catch {
  New-Item $profile
  Write-Host "Creating empty default profile"
}
Add-Content $profile $profile_append_content

