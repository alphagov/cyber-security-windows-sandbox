#Jonathan Johnson
#github:https://github.com/jsecurity101

Write-Output "
 _____                           _          _     _____ ___________ 
|_   _|                         | |        | |   |  _  |_   _| ___ \
  | | _ __ ___  _ __   ___  _ __| |_ ______| |   | | | | | | | |_/ /
  | || '_ ` _ \| '_ \ / _ \| '__| __|______| |   | | | | | | |    / 
 _| || | | | | | |_) | (_) | |  | |_       | |___\ \_/ / | | | |\ \ 
 \___/_| |_| |_| .__/ \___/|_|   \__|      \_____/\___/  \_/ \_| \_|
               | |                                                  
               |_|                                                                                               
"  

Function Import-Users()


{

Import-Module activedirectory
  
#Update the path to where the .csv file is stored. 

$ADUsers = Import-csv C:\mordor\environment\shire\aws\scripts\DC\domain_users.csv

foreach ($User in $ADUsers)

{
    #Read in data from .csv and assign it to the variable. This is done to import attributes in the New-ADUser.
        
    $username     = $User.username
    $password     = $env:DOMAIN_PASSWORD
    $firstname     = $User.firstname
    $lastname     = $User.lastname
    $ou         = $User.ou 
    $identity   = $User.identity
    $password = $User.Password
    $province = $User.province


    #Runs check against AD to verify User doesn't already exist inside of Active Directory

    if (Get-ADUser -F {SamAccountName -eq $Username })
    {
         Write-Warning "$Username already exists."
    }


#If User doesn't exist, New-ADUser will add $Username to AD based on the objects specified specified in the .csv file. 

    else


    {
        #Update to UserPrincipalName to match personal domain. Ex: If domain is: example.com. Should read as - $Username@example.com
        
        New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@$env:domain" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -state $province `
            -Enabled $True `
            -DisplayName "$firstname $lastname" `
            -Path $ou `
            -AccountPassword (convertto-securestring $password -AsPlainText -Force) -PasswordNeverExpires $True
            

           Add-ADGroupMember `
           -Members $username `
           -Identity $identity `
	    }
         Write-Output "$username has been added to the domain and added to the $identity group"
    }
    # setspn -a glamdring/$env:domain shire\gandalf
}
Import-Users
