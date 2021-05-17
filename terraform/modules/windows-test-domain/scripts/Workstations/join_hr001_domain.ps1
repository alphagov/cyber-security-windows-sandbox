$User = "$env:domain\nmartha"
$Password = ConvertTo-SecureString -String "ShiRe012!" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password

Add-Computer -DomainName "$env:domain" -OUPath "OU=Workstations,$env:PATHS" -Credential $Credential -Force -Restart