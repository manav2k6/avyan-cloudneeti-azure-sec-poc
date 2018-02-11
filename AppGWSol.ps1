$AppGw = Get-AzureRmApplicationGateway -Name "" -ResourceGroupName ""
$AppGw | Set-AzureRmApplicationGatewayWebApplicationFirewallConfiguration -Enabled $true -FirewallMode Prevention
Set-AzureRmApplicationGateway -ApplicationGateway $AppGw

#Stop-AzureRmApplicationGateway -ApplicationGateway $AppGw