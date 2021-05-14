$User = "SHIRE\wecserver"
$Password = ConvertTo-SecureString -String "$env:DOMAIN_PASSWORD" -AsPlainText -Force # pragma: allowlist secret
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password

Add-Computer -WorkGroupName Servers
Add-Computer -DomainName "SHIRE" -Server $env:DOMAIN_CONTROLLER_IP -OUPath "OU=Servers,DC=shire,DC=com" -Credential $Credential -Force -Options JoinWithNewName,AccountCreate
