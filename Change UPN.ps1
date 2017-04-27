#Replace with the old suffix
$oldSuffix = 'domain.local'

#Replace with the new suffix
$newSuffix = 'domain.com'

#Replace with the OU you want to change suffixes for
$ou = "Ou=Students,DC=domain,DC=local"

#Replace with the name of your AD server
$server = "dc.domain.local"

Get-ADUser -SearchBase $ou -filter * | ForEach-Object {
$newUpn = $_.UserPrincipalName.Replace($oldSuffix,$newSuffix)
$_ | Set-ADUser -server $server -UserPrincipalName $newUpn
}