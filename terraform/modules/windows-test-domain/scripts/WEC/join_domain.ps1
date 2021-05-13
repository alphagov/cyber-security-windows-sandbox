Add-Computer -DomainName "$env:domain" -OUPath "OU=Servers,DC=shire,DC=com"

Restart-Computer -Force
