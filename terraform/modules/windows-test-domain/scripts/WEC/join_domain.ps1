$User = "$env:domain\wecserver"
$Password = ConvertTo-SecureString -String "$env:DOMAIN_PASSWORD" -AsPlainText -Force # pragma: allowlist secret
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password

Add-Computer -DomainName "$env:domain" -Server SHIRE\WSDC01 -OUPath "OU=Servers,DC=shire,DC=com" -Unsecure -Credential $Credential
