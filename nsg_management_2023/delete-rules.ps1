<#PARAMETERS BLOCK#>
$subscriptionId = "98152792-9287-4fb2-a062-2bad4ee71a0a"
Set-AzContext -Subscription $subscriptionId
$nsgnome = "nsgtest420"
$nsgresource = "rg-test-storage"

<#CODE BLOCK#>
$nsgobject= Get-AzNetworkSecurityGroup -Name $nsgnome -ResourceGroupName $nsgresource
$rulesconfig = Get-AzNetworkSecurityGroup -Name $nsgnome -ResourceGroupName $nsgresource `
| Get-AzNetworkSecurityRuleConfig

foreach($rule in $rulesconfig) {
Write-Output $rule
Remove-AzNetworkSecurityRuleConfig -Name $rule.Name -NetworkSecurityGroup $nsgobject | Set-AzNetworkSecurityGroup
}