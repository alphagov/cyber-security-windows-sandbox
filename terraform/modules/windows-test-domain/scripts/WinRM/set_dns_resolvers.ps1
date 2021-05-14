$interface = (Get-NetIPConfiguration).InterfaceIndex

Set-DnsClientServerAddress -InterfaceIndex $interface -ServerAddresses $env.DOMAIN_CONTROLLER_IP, 8.8.8.8