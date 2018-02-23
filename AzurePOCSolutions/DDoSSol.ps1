Param(
     [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
     [string] [Parameter(Mandatory=$true)] $VnetName
    
   )

$vnetProps = (Get-AzureRmResource -ResourceType "Microsoft.Network/virtualNetworks" -ResourceGroup "$ResourceGroupName" -ResourceName "$VnetName").Properties
$vnetProps.enableDdosProtection = $true
$vnetProps.enableVmProtection = $true
Set-AzureRmResource -PropertyObject $vnetProps -ResourceGroupName "$ResourceGroupName" -ResourceName "$VnetName" -ResourceType "Microsoft.Network/virtualNetworks" -Force