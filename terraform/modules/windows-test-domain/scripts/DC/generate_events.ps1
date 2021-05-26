# Set up new source for application log
New-EventLog -Source DCTestApplicationSource -LogName Application
# Send a test event through
Write-EventLog -LogName "Application" -Source DCTestApplicationSource   -EventID 3001 -EntryType Information -Message "This is a test message"
# Check test event has been sent
Get-WinEvent -FilterHashtable @{logname='Application'; ID = 3001} | Where-Object  { $_.Message -Match "This is a test message"}

# Set up new source for system log
New-EventLog -Source DCTestSystemSource -LogName System
# Send a test event through
Write-EventLog -LogName "System" -Source DCTestSystemSource -EventID 3001 -EntryType Information -Message "This is a test message"
# Check test event has been sent
Get-WinEvent -FilterHashtable @{logname='System'; ID = 3001} | Where-Object  { $_.Message -Match "This is a test message"}