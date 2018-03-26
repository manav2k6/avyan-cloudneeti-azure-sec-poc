$baseUrl=$args[0]
$hburl=$args[1]


[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$env:LogPath = "$env:appdata\Trend Micro\Deep Security Agent\installer"
New-Item -path $env:LogPath -type directory
Start-Transcript -path "$env:LogPath\dsa_deploy.log" -append
echo "$(Get-Date -format T) - DSA download started"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

if ( [intptr]::Size -eq 8 ) { 
   $sourceUrl=-join("$baseurl", "software/agent/Windows/x86_64/") }
else {
   $sourceUrl=-join("$baseurl", "software/agent/Windows/i386/") }
   #$sourceUrl

$webRequest = [net.WebRequest]::Create("$baseUrl")
$response = $webRequest.GetResponse()
if($response.StatusCode -ne 'OK'){
start-sleep -s 600
}
start-sleep -s 1200
echo "$(Get-Date -format T) - Download Deep Security Agent Package $sourceUrl"
(New-Object System.Net.WebClient).DownloadFile($sourceUrl,  "$env:temp\agent.msi")
if ( (Get-Item "$env:temp\agent.msi").length -eq 0 ) {
echo "Failed to download the Deep Security Agent. Please check if the package is imported into the Deep Security Manager. "
 exit 1 }
echo "$(Get-Date -format T) - Downloaded File Size:" (Get-Item "$env:temp\agent.msi").length
echo "$(Get-Date -format T) - DSA install started"
echo "$(Get-Date -format T) - Installer Exit Code:" (Start-Process -FilePath msiexec -ArgumentList "/i $env:temp\agent.msi /qn ADDLOCAL=ALL /l*v `"$env:LogPath\dsa_install.log`"" -Wait -PassThru).ExitCode 
echo "$(Get-Date -format T) - DSA activation started"
Start-Sleep -s 50
& $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -r
& $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -a $hburl
Stop-Transcript
echo "$(Get-Date -format T) - DSA Deployment Finished"