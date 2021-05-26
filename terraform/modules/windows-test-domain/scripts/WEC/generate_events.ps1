# Set up new source for application log
New-EventLog -Source TestSource -LogName Application
# Send a test event through
Write-EventLog -LogName "Application" -Source TestSource -EventID 3001 -EntryType Information -Message "This is a test message"
# Check test event has been sent
Get-WinEvent -FilterHashtable @{logname='Application'; ID = 3001} | Where-Object  { $_.Message -Match "This is a test message"}