$User = "$env:domain\wecserver"
$Password = ConvertTo-SecureString -String "Edhellen$" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password

Add-Computer -DomainName "$env:domain" -OUPath "OU=Servers,DC=shire,DC=com" -Credential $Credential

Restart-Computer -Force
