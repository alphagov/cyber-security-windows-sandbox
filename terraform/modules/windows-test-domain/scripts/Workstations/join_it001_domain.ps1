$User = "$env:domain\pgustavo"
$Password = ConvertTo-SecureString -String "S@lv@m3!M0d3" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password

Add-Computer -DomainName "$env:domain" -OUPath "OU=Workstations,$env:PATHS" -Credential $Credential -Force -Restart