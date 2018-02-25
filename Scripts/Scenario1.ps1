Param(
     [string] [Parameter(Mandatory=$true)] $Command,
     [string] [Parameter(Mandatory=$true)] $DeploymentPrefix
     )
$ResourceGroupName= $DeploymentPrefix+'-'+'RG'
$ResourceGroupLocation= "Southeast Asia"
$TemplateFile = "..\templates\Scenario1.json"
$TemplateFile1parameter = "..\templates\IP-Param.json"

switch($Command)
{
   Deploy
	{

# Create or update the resource group with name Scenario1 at location southeast asia.
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

# Deploying infrastructure
New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -Name "Deployment" -TemplateParameterFile $TemplateFile1parameter -Verbose
     }
   Metigate
     {
$VnetName = 'test-vnet'
$vnetProps = (Get-AzureRmResource -ResourceType "Microsoft.Network/virtualNetworks" -ResourceGroup "$ResourceGroupName" -ResourceName "$VnetName").Properties
$vnetProps.enableDdosProtection = $true
$vnetProps.enableVmProtection = $true
Set-AzureRmResource -PropertyObject $vnetProps -ResourceGroupName "$ResourceGroupName" -ResourceName "$VnetName" -ResourceType "Microsoft.Network/virtualNetworks" -Force
     }
   ClearResources
     {
Remove-AzureRmResourceGroup -Name $ResourceGroupName 
     }
}
