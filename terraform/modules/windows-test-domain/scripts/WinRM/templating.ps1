$matchDomain = '{{domain}}'
$replaceDomain = $env:DOMAIN

$matchPaths = '{{paths}}'
$replacePaths = $env:DOMAIN.split(".") -replace "^", "DC=" -join ","

$files = Get-ChildItem -Path 'C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts' -filter *.xml -Recurse
foreach ($file in $files) {
    $matchFound = $false
    $output = switch -regex -file $file.fullname {
        $matchDomain { $_ -replace $matchDomain,$replaceDomain
                       $matchFound = $true
        }
        $matchPaths { $_ -replace $matchPaths,$replacePaths
                       $matchFound = $true
        }
        default { $_ }
    }
    if ($matchFound) {
        $output | Set-Content $file.fullname
    }
}
