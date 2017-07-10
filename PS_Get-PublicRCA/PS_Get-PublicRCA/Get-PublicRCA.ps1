#Author: Peter Gu (petergu@microsoft.com)
#Version: 4.0
#Last update: 7/11/2017
#Examples of URL conversion:
#	Original format: https://icm.ad.msft.net/portal/publicpostmortem/Details/450
#	Destination format: https://icm.ad.msft.net/imp/PublicPostmortems.aspx?id=450

Param(
    [Parameter(Mandatory=$False,Position=1)][String][ValidatePattern("^https://icm\.ad\.msft\.net/portal/publicpostmortem/Details/[1-9][0-9][0-9]$")]$URL,
    [Parameter(Mandatory=$False)][String][ValidatePattern("^[1-9][0-9][0-9]$")]$PirID,
	[Parameter(Mandatory=$False)][Switch]$LegacyUI
)

if ($URL -and $PirID)
{
	Write-Warning "Error: Can't process both parameters -URL and -PirID at the same time."
	return
}

elseif (!$URL -and !$PirID)
{
    Write-Warning 'You have to specify either -URL <Original URL provided by IcM notification email> or -PirID <3 digit Public RCA ID>'
	return
}

elseif ($URL)
{
	#Collect PIR ID
	$PirID = $URL.Split("/")[-1]
}

#Generate the URL
if ($LegacyUI)
{
	$URL_In = 'https://icm.ad.msft.net/imp/PublicPostmortems.aspx?id=' + $PirID
}
else
{
	$URL_In = 'https://icm.ad.msft.net/imp/v3/incidents/publicpostmortem/' + $PirID + '?optin=true'
}

#Open converted URL in default browser
[Diagnostics.Process]::Start($URL_In)