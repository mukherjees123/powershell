<#PARAMETERS BLOCK#>
$subscriptionId = "98152792-9287-4fb2-a062-2bad4ee71a0a"
$csvFilePath = "C:\Users\Admin\Desktop\USB\Scripts\Powershell\scripts_managed_services\nsg_management_2023\input.csv"

<#CODE BLOCK#>
Set-AzContext -Subscription $subscriptionId
Import-Csv $csvFilePath |`
ForEach-Object {
$nsgName = $_."NSGName"
$nsgRuleName = $_."RuleName"
$nsgRuleDescription = $_."Description"
$nsgRuleAccess = $_."Action"
$nsgRuleProtocol = $_."Protocol"
$nsgRuleDirection = $_."Direction"
$nsgRulePriority = $_."Priority"
$nsgRuleSourceAddressPrefix = $_."SourceAddress"
$nsgRuleSourcePortRange = $_."SourcePort"
$nsgRuleDestinationAddressPrefix = $_."DestinationAddress"
$nsgRuleDestinationPortRange = $_."DestinationPort"
$resourceGroupName = $_."RGName"
#Getting the right NSG and setting new rule to it    
$nsgRuleNameValue = Get-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $resourceGroupName | 
Get-AzNetworkSecurityRuleConfig -Name $nsgRuleName -ErrorAction SilentlyContinue
if($nsgRuleNameValue.Name -match $nsgRuleName){
Write-Host "A rule with this name (" $nsgRuleNameValue.Name ") already exists"
}
else{
Get-AzNetworkSecurityGroup -Name  $nsgName -ResourceGroupName $resourceGroupName | 
Add-AzNetworkSecurityRuleConfig -Name $nsgRuleName -Description $nsgRuleDescription -Access `
$nsgRuleAccess -Protocol $nsgRuleProtocol -Direction $nsgRuleDirection -Priority $nsgRulePriority -SourceAddressPrefix $nsgRuleSourceAddressPrefix.split(",") `
-SourcePortRange $nsgRuleSourcePortRange.split(",") -DestinationAddressPrefix $nsgRuleDestinationAddressPrefix.split(",") -DestinationPortRange $nsgRuleDestinationPortRange.split(",") -Verbose | 
Set-AzNetworkSecurityGroup -Verbose
}
}