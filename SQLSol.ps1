Add-AzureRmAccount
Set-AzureRmSqlDatabaseAuditing -State Enabled -StorageAccountName azurepoc -ServerName "server-1416380557" -DatabaseName iisweb2 -ResourceGroupName "AzurePOC2RG"
Set-AzureRmSqlDatabaseThreatDetectionPolicy -ResourceGroupName "AzurePOC2RG" -ServerName "server-1416380557" -DatabaseName iisweb2 -EmailAdmins $true -StorageAccountName azurepoc
Set-AzureRmSqlDatabase -DatabaseName iisweb2 -ResourceGroupName "AzurePOC2RG" -ServerName "server-1416380557"