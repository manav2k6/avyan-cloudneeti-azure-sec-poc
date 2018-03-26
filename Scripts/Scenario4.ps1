Param
     (
     [string] [Parameter(Mandatory=$true)] $Command,
     [string] [Parameter(Mandatory=$true)] $DeploymentPrefix
     )


$artifactStagingDirectories = @(
   "..\Resources\dsa-cs2.ps1"
    )
$ResourceGroupName= $DeploymentPrefix+'-'+'RG'
$ResourceGroupLocation = 'Southeast Asia'
$StorageAccountName = "staccount$(Get-Random)"
$TemplateFile = '..\Templates\Scenario4.json'
$storageContainerName = "stageartifacts"
$DeploymentName= "scenariodeploy"

switch($Command)
{
   Deploy
	{
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force -ErrorAction Stop


New-AzureRmStorageAccount -StorageAccountName $storageAccountName -Type 'Standard_LRS' -ResourceGroupName $ResourceGroupName -Location $ResourceGroupLocation
$StorageAccount= Get-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName
New-AzureStorageContainer -Name $storageContainerName -Context $storageAccount.Context -Permission Container -ErrorAction SilentlyContinue


$strAcc = $storageAccount.Context.BlobEndPoint + $storageContainerName

$ArtifactFilePaths = Get-ChildItem $artifactStagingDirectories -Recurse -File | ForEach-Object -Process {$_.FullName}

$temp = Set-AzureStorageBlobContent -File $ArtifactFilePaths -Container $storageContainerName -Context $storageAccount.Context -Force


$TemplateFile = [System.IO.Path]::Combine($PSScriptRoot, $TemplateFile)
$ArtifactsLocationName = $strAcc + '/' + $temp.Name


# Update parameter file with deployment values.
$parameter = New-Object -TypeName Hashtable
$parameter.add("_artifactsLocation", $ArtifactsLocationName)
#$parameter.add("artifactsLocationSasToken", $artifactsLocationSasTokenName)


# Run deployment by passing updated parameter file.
New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterObject $parameter -Mode Incremental -DeploymentDebugLogLevel All -Verbose -Force
 }
ClearResources
     {
Remove-AzureRmResourceGroup -Name $ResourceGroupName 
     }
}