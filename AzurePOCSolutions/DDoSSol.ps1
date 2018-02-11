$vnetProps = (Get-AzureRmResource -ResourceType "Microsoft.Network/virtualNetworks" -ResourceGroup "Contoso-DevOps" -ResourceName "Contoso-DevOps-vnet").Properties
$vnetProps.enableDdosProtection = $true
$vnetProps.enableVmProtection = $true
Set-AzureRmResource -PropertyObject $vnetProps -ResourceGroupName "Contoso-DevOps" -ResourceName "Contoso-DevOps-vnet" -ResourceType Microsoft.Network/virtualNetworks -Force