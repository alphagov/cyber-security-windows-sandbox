# Author: Jonathan Johnson
# Purpose: Install GPO's from: https://github.com/Cyb3rWard0g/mordor/tree/master/environment/shire/GPOBackup.


Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Configuring auditing policy GPOs."


#Default Domain Controller Policy
$GPOName = 'Default Domain Controllers Policy'
$OU = "ou=Domain Controllers,{{paths}}"
Write-Host "Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\default_domain_controllers_policy" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Adjusting Time Rights
$GPOName = 'Adjusting Time Rights'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\adjusting_time_rights" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$gPLinks = Get-ADOrganizationalUnit -Identity $OU1 -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Disable Lock Screen
$GPOName = 'Disable Lock Screen'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\disable_lock_screen" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Disable Open File Security Warning
$GPOName = 'Disable Open File Security Warning'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\disable_open_file_security_warning" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}


#Disable Sleep Mode
$GPOName = 'Disable Sleep Mode'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\disable_sleep_mode" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}


#Disable Defender
$GPOName = 'Disable Windows Defender'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\disable_windows_defender" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Disable Defender Firewall
$GPOName = 'Disable Windows Defender Firewall'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\disable_windows_defender_firewall" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Disable Windows Update
$GPOName = 'Disable Windows update'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\disable_windows_update" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}


#Workstation Auditing
$GPOName = 'Full Domain Auditing Workstations'
$OU = "ou=Workstations,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\full_domain_auditing_workstations" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}


#Inactivity Limit
$GPOName = 'Inactivity Limit'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\inactivity_limit" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Powershell Logging
$GPOName = 'Powershell Logging'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\powershell_logging" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Ristrict SAM Remote Calls
$GPOName = 'Restrict SAM Remote Calls'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\restrict_sam_remove_calls" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

Remove-GPLink -Name "Windows Event Forwarding" -Target "OU=Servers,{{paths}}"

#Windows Event Forwarding
$GPOName = 'Windows Event Forwarding'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\windows_event_forwarding" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes

}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}


#Windows Script Host
$GPOName = 'Windows Script Host'
$OU = "ou=Workstations,{{paths}}"
$OU1 = "ou=Domain Controllers,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\windows_script_host" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU1 -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Workstation Administrators
$GPOName = 'Workstation Administrators'
$OU = "ou=Workstations,{{paths}}"
$OU2 = "ou=Servers,{{paths}}"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "C:\alphagov-windows-sandbox\terraform\modules\windows-test-domain\scripts\DC\GPOBackup\workstation_administrators" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
    New-GPLink -Name $GPOName -Target $OU2 -Enforced yes

}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

