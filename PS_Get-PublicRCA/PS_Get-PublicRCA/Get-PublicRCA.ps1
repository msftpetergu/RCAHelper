#Author: Peter Gu (petergu@microsoft.com)
#Version: 1.0

Param([Parameter(Mandatory=$True,Position=1)][String]$URL)
#Original format: https://icm.ad.msft.net/portal/publicpostmortem/Details/450
#Dest. format: https://icm.ad.msft.net/imp/PublicPostmortems.aspx?id=450

$URL = $URL.Replace('https://icm.ad.msft.net/portal/publicpostmortem/Details/', 'https://icm.ad.msft.net/imp/PublicPostmortems.aspx?id=')

$IE = New-Object -ComObject internetexplorer.application
$IE.navigate2($URL)
$IE.visible = $true