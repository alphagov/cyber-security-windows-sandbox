#!/usr/bin/env pwsh

$BUCKET_NAME=$env:BUCKET_NAME
$FORWARDER=$env:FORWARDER
$AWS_ACCOUNT=$env:AWS_ACCOUNT

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
  param([string]$bucket, [string]$path, [string]$file, [string]$hash, [Amazon.SecurityToken.Model.Credentials]$creds)
  $relpath="$path/$file"
  $abspath="$PSScriptRoot/$relpath"
  $calculated_hash=(Calculate-LowerCaseFileHash -path $abspath)
  $METADATA_OBJECT=(Get-S3ObjectMetadata -Credential $creds -BucketName $bucket -Key $relpath)
  $published_hash=($METADATA_OBJECT.Metadata.Item("x-amz-meta-hash"))

  # For some reason the S3 metadata hash is not working
  Write-Host("Hash from S3 metadata: $published_hash = $file")

  If ($hash -eq $calculated_hash) {
    $hash_is_valid = 1
  } Else {
    $hash_is_valid = 0
  }
  $hash_is_valid
}

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
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Read-S3Object -Credential $ROLE_SESSION -KeyPrefix packages -BucketName $BUCKET_NAME -Folder $PSScriptRoot/packages -ErrorAction Stop
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Read-S3Object -Credential $ROLE_SESSION -KeyPrefix scripts -BucketName $BUCKET_NAME -Folder $PSScriptRoot/scripts -ErrorAction Stop
} Catch {
  Write-Host "Failed to read S3 bucket"
  exit 1
}

$METADATA_CSV=(Import-CSV $PSScriptRoot/packages/metadata.csv)
ForEach ($package in $METADATA_CSV){
  $file = $package."file"
  $hash = $package."hash"
  $valid=(Check-HashIsValid -bucket $BUCKET_NAME -path packages -file $file -hash $hash -creds $ROLE_SESSION)
  Write-Host "Hash is valid: $valid"

  If ($valid -eq 1)
  {
    Write-Host "Hash matches"

    If ($file -eq "wintar.zip")
    {
      # Unwrap tar binary
      New-Item -Path "c:\progra~1" -Name "WinTar" -ItemType "directory"
      Expand-Archive -LiteralPath $PSScriptRoot/packages/WinTar.zip -DestinationPath C:\progra~1\WinTar

      # add tar to $PATH
      $profile_append_content = "`r`n`$env:PATH += `";C:\progra~1\WinTar;`"`r`n"

      Try
      {
        If (Test-Path $profile)
        {
          Write-Host "Profile already exists"
        }
      }
      Catch
      {
        New-Item $profile
        Write-Host "Creating empty default profile"
      }
      Add-Content $profile $profile_append_content
    }
    elseif ($file -match "splunk")
    {
      $DataStamp = get-date -Format yyyyMMddTHHmmss
      $LogFile = '{0}-{1}.log' -f $file,$DataStamp
      $MSIArguments = @(
          "/i"
          "$PSScriptRoot\packages\$file"
          "AGREETOLICENSE=Yes"
          "SPLUNKPASSWORD=$env:SPLUNK_PASSWORD"
          "/quiet"
          "/passive"
          "/qn"
          "/lv"
          "$PSScriptRoot\packages\$LogFile"
      )
      Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow
    }
  }
}

Try {
  If (Test-Path $PSScriptRoot\scripts\get-and-update.ps1) {
    Write-Host "Installing forwarder config"
    Invoke-Expression -Command "powershell $PSScriptRoot\scripts\get-and-update.ps1"
  }
} Catch {
  Write-Host "Splunk forwarder setup script not available"
}

Write-Host "Cleaning up"
Remove-Item -Recurse -Force $PSScriptRoot/packages
# Remove-Item -Recurse -Force $PSScriptRoot/scripts

