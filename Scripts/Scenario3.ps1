Param
     (
     [string] [Parameter(Mandatory=$true)] $Command,
     [string] [Parameter(Mandatory=$true)] $DeploymentPrefix
     )


$artifactStagingDirectories = @(
    "..\Templates"
    "..\Resources"
    "..\Scripts"
)
$ResourceGroupName= $DeploymentPrefix+'-'+'RG'
$ResourceGroupLocation = 'Southeast Asia'
$StorageAccountName = "staccount$(Get-Random)"
$webappname= $DeploymentPrefix+"webapp$(Get-Random)"
$sqlservername= $DeploymentPrefix+"sql$(Get-Random)"
$TemplateFile = '..\Templates\scenario3.json'
$Username= "testuser"
$Password= "Welkom@123"
$storageContainerName = "stageartifacts"

switch($Command)
{
   Deploy
	{

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force -ErrorAction Stop

New-AzureRmStorageAccount -StorageAccountName $storageAccountName -Type 'Standard_LRS' -ResourceGroupName $ResourceGroupName -Location $ResourceGroupLocation
$StorageAccount= Get-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName
New-AzureStorageContainer -Name $storageContainerName -Context $storageAccount.Context -Permission Container -ErrorAction SilentlyContinue *>&1


# Generate the value for artifacts location & 4 hour SAS token for the artifacts location.
$artifactsLocationName = $storageAccount.Context.BlobEndPoint + $storageContainerName
$artifactsLocationSasTokenName = New-AzureStorageContainerSASToken -Container $storageContainerName -Context $storageAccount.Context -Permission r -ExpiryTime (Get-Date).AddHours(4)

# Copy files from the local storage staging location to the storage account container
foreach ($artifactStagingDirectory in $artifactStagingDirectories) {
    $ArtifactFilePaths = Get-ChildItem $ArtifactStagingDirectory -Recurse -File | ForEach-Object -Process {$_.FullName}
    foreach ($SourcePath in $ArtifactFilePaths) {
        Set-AzureStorageBlobContent -File $SourcePath -Blob $SourcePath.Substring((Split-Path($ArtifactStagingDirectory)).length + 1) `
            -Container $storageContainerName -Context $storageAccount.Context -Force
    }
}


# Update parameter file with deployment values.
$parameter= @{}
$parameter.add("artifactsLocation", $artifactsLocationName)
$parameter.add("artifactsLocationSasToken", $artifactsLocationSasTokenName)
$parameter.add("WebAppName", $Webappname)
$parameter.add("sqlservername", $sqlservername)

# Run deployment by passing updated parameter file.
New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterObject $parameter -Mode Incremental -DeploymentDebugLogLevel All -Verbose -Force
Set-AzureRMWebApp -ConnectionStrings @{ MyConnectionString = @{ Type="SQLAzure"; Value ="Server=tcp:$sqlservername.database.windows.net; Database=iisweb; User ID=$Username@$sqlservername;Password=$password;Trusted_Connection=False;Encrypt=True;" } } -Name $Webappname -ResourceGroupName $ResourceGroupName
}

 Metigate
     {
 
Set-AzureRmSqlDatabaseAuditing -State Enabled -StorageAccountName $StorageAccountName -ServerName $sqlservername -DatabaseName iisweb -ResourceGroupName $ResourceGroupName
Set-AzureRmSqlDatabaseThreatDetectionPolicy -ResourceGroupName $ResourceGroupName -ServerName $sqlservername -DatabaseName iisweb -EmailAdmins $true -StorageAccountName $StorageAccountName
Set-AzureRmSqlDatabase -DatabaseName iisweb -ResourceGroupName $ResourceGroupName -ServerName $sqlservername
     }

ClearResources
     {
Remove-AzureRmResourceGroup -Name $ResourceGroupName 
     }
}