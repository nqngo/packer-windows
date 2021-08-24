# Install Google Chrome from build repo using PACKER_HTTP server.

# Bypass the proxy
$WebClient = New-Object System.Net.WebClient
$WebClient.Proxy = [System.Net.GlobalProxySelection]::GetEmptyWebProxy()

# Get the Google Chrome version
$BaseUrl = "http://${env:PACKER_HTTP_ADDR}/Google_Chrome"
$VER = $WebClient.DownloadString("$BaseUrl/version.txt") -replace "\n", ""

# Download the MSI
$google_chrome_download_url = "$BaseUrl/Google_Chrome_$VER.msi"
Write-Output "Installing Google_Chrome_${VER}.msi"
$WebClient.DownloadFile($google_chrome_download_url, "C:\Windows\Temp\Google_Chrome.msi")

# Install MSI
Start-Process -Wait -PassThru -FilePath msiexec -ArgumentList "/i C:\Windows\Temp\Google_Chrome.msi /qn /l*v C:\Windows\Temp\Google_Chrome.log /qn /norestart"
Write-output "Google Chrome successfully installed!"
