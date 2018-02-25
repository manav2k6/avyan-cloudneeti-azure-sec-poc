#Requires -Version 3.0

Param(
     [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
     [string] [Parameter(Mandatory=$true)] $ResourceGroupLocation
     #[string] [Parameter(Mandatory=$true)] $VMName
   )
$TemplateFile = "c:\poc2\templates\Scenario1.json"
$TemplateFile1parameter = "c:\poc2\templates\IP-Param.json"


# Create or update the resource group using the specified template file and template parameters file
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -Name "Deployment" -TemplateParameterFile $TemplateFile1parameter -Verbose

                                       
