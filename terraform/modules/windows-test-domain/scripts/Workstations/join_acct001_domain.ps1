$User = "$env:domain\lrodriguez"
$Password = ConvertTo-SecureString -String "Ann0n@!" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password

Add-Computer -DomainName "$env:domain" -OUPath "OU=Workstations,$envv:PATHS" -DomainCredential $Credential -Force -Restart