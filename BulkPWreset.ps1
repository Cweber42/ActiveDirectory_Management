#Reset all user passwords in an OU and child OU
# Created 8/4/16
# Rev 1-Original concept
# Rev 2- Added Force password change at next logon.

#For older versions of powershell
Import-Module ActiveDirectory

#OU location
$OU = "OU=Students,DC=domain,DC=local"
#New password

$Newpassword = "Default Password"


$Users = Get-ADuser -Filter * -SearchBase $OU

foreach ($User in $Users)
{
Set-ADAccountPassword -Identity $User -NewPassword (ConvertTo-SecureString -AsPlainText $Newpassword -Force)
Set-aduser $user -ChangePasswordAtLogon $True
}
