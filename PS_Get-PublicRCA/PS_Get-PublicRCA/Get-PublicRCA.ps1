#Author: Peter Gu (petergu@microsoft.com)
#Version: 3.0

Param(
    [Parameter(Mandatory=$False,Position=1)][String][ValidatePattern("^https://icm\.ad\.msft\.net/portal/publicpostmortem/Details/[1-9]\d\d$")]$URL,
    [Parameter(Mandatory=$False)][String][ValidatePattern("^[1-9]\d\d$")]$PirID
)

Function OpenInIE ([string]$URL_In)
{
    $IE = New-Object -ComObject internetexplorer.application
    $IE.navigate2($URL_In)
    $IE.visible = $true
}

if ($URL){
    #Original format: https://icm.ad.msft.net/portal/publicpostmortem/Details/450
    #Dest. format: https://icm.ad.msft.net/imp/PublicPostmortems.aspx?id=450
    $URL_In = $URL.Replace('https://icm.ad.msft.net/portal/publicpostmortem/Details/', 'https://icm.ad.msft.net/imp/PublicPostmortems.aspx?id=')
    OpenInIE $URL_In
}

elseif ($PirId) {
    $URL_In = 'https://icm.ad.msft.net/imp/PublicPostmortems.aspx?id=' + $PirId
    OpenInIE $URL_In
}

else {
    Write-Warning 'You have to specify -URL <Original URL provided by IcM notification email> or -PirID <3 digit Public RCA ID>'
}