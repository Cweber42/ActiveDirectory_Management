Import-Module ActiveDirectory            
#Change the Search base for your OU structure
#Change the export CSV to where you want the CSV
#Change Import CSV to where you export the CSV too.

#This script only needs to be run ONCE to update the students ad info to change the ID from OFfice to EmployeeID. 
#EmployeeID is used because it is private, more information here: http://windowsitpro.com/active-directory/using-confidentiality-bit-hide-data-active-directory
#Incase the studentID you are using is the state specificID that is considered PII and we need to be careful about disclosure. 
$ousearch = "ou=students,dc=domain,dc=local"
$csvsave =  "C:\Scripts\change.csv"
       
Get-ADUser -Filter * -Properties SamAccountName,Office  -SearchBase $ousearch | Select SamAccountName,Office  | Export-Csv $csvsave

$users = Import-Csv $csvsave

Foreach ($user in $users){
Set-ADUser -Identity $($user.Samaccountname) -EmployeeID $($user.Office)
}