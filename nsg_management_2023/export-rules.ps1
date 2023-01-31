<#PARAMETERS BLOCK#>
$subscriptionId = "98152792-9287-4fb2-a062-2bad4ee71a0a"
Set-AzContext -Subscription $subscriptionId

<#CODE BLOCK#>
$outputfinal=@()
$nsg=Get-AzNetworkSecurityGroup -Name "nsgtest420" -ResourceGroupName "rg-test-storage"
$securityrules=$nsg.SecurityRules
foreach ($securityrule in $securityrules)
{
$outputtemp = "" | SELECT  NSGName,NSGLocation,RGName,Direction,Priority,RuleName,DestinationPort,Protocol,SourceAddress,SourcePort,DestinationAddress,Action,Description
$outputtemp.NSGName=$nsg.name
$outputtemp.NSGLocation=$nsg.location
$outputtemp.RGName=$nsg.ResourceGroupName
$outputtemp.Direction=$securityrule.direction
$outputtemp.Priority=$securityrule.Priority
$outputtemp.RuleName=$securityrule.Name
$outputtemp.DestinationPort=$securityrule.DestinationPortRange -join ", "
$outputtemp.Protocol=$securityrule.Protocol -join ", "
$outputtemp.SourceAddress=$securityrule.SourceAddressPrefix -join ", "
$outputtemp.SourcePort=$securityrule.SourcePortRange -join ", "
$outputtemp.DestinationAddress=$securityrule.DestinationAddressPrefix -join ", "
$outputtemp.Action=$securityrule.Access
$outputtemp.Description=$securityrule.Description
$outputfinal += $outputtemp
}
$outputfinal | Export-Csv "c:\report.csv" -NoTypeInformation
