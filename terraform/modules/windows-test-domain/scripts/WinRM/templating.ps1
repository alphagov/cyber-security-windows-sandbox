$matchString = '{{domain}}'
$replaceString = $env:DOMAIN
$files = Get-ChildItem -Path 'C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts' -filter *.xml -Recurse
foreach ($file in $files) {
    $matchFound = $false
    $output = switch -regex -file $file.fullname {
        $matchString { $_ -replace $matchString,$replaceString
                       $matchFound = $true
        }
        default { $_ }
    }
    if ($matchFound) {
        $output | Set-Content $file.fullname
    }
}
