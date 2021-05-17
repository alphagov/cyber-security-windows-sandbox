$User = "SHIRE\wecserver"
$Password = ConvertTo-SecureString -String "$env:DOMAIN_PASSWORD" -AsPlainText -Force # pragma: allowlist secret
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password

Add-Computer -WorkGroupName Servers
Add-Computer -DomainName $env:DOMAIN -Server WSDC01 -OUPath "OU=Servers,$env:PATHS" -Credential $Credential -Force -Options JoinWithNewName,AccountCreate
