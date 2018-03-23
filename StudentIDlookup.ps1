Function Stulookup{
$stuid = Read-Host -Prompt 'Input Student ID'
Get-ADUser -filter 'employeeid -like $stuid' -Properties EmployeeID
}