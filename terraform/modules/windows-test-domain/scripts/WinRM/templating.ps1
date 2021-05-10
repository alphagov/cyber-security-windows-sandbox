$files = Get-ChildItem -Path "C:\\alphagov-windows-sandbox\\terraform\\modules\\windows-test-domain\\scripts\\WEC" -Recurse -Filter *.xml
foreach ($f in $files){
    Get-Content $f.FullName -replace '{{domain}}', '$env:domain' | Set-Content $f.FullName
}
