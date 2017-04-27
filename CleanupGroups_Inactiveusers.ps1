#Remove inactive users from security groups
#Displays groups with no users

$searchOU = "ou=ssg,ou=securitygroups,dc=domain,dc=local"

$groupsempty = Get-ADGroup -Filter {GroupCategory -eq 'Security'} -SearchBase $searchou | Where-Object {@(Get-ADGroupMember $_).Length -eq 0} | Select-Object -Property Name
#Removes disabled users from the $searchou groups

Get-ADGroup -Filter 'GroupCategory -eq "Security" -or GroupCategory -eq "Distribution"' -SearchBase $searchOU | ForEach-Object{ $group = $_
	Get-ADGroupMember -Identity $group -Recursive | %{Get-ADUser -Identity $_.distinguishedName -Properties Enabled | ?{$_.Enabled -eq $false}} | ForEach-Object{ $user = $_
	Remove-ADGroupMember -Identity $group -Member $user -Confirm:$false
	}
}
