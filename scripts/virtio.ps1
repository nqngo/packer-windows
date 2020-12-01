# Sign the certificates first
$DriverPath = Get-Item "E:\*\w10\amd64" 

$CertStore = Get-Item "cert:\LocalMachine\TrustedPublisher" 
$CertStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)

Get-ChildItem -Recurse -Path $DriverPath -Filter "*.cat" | % {
    $Cert = (Get-AuthenticodeSignature $_.FullName).SignerCertificate

    Write-Host ( "Added {0}, {1} from {2}" -f $Cert.Thumbprint,$Cert.Subject,$_.FullName )

    $CertStore.Add($Cert)
}

$CertStore.Close()

# Install virtio driver 
Start-Process -Wait -PassThru -FilePath msiexec -ArgumentList "/i E:\virtio-win-gt-x64.msi /qn /norestart /l*v C:\Windows\Temp\virtio-win-gt-x64.log"

# Install qemu guest agent
Start-Process -Wait -PassThru -FilePath msiexec -ArgumentList "/i E:\guest-agent\qemu-ga-x64.msi /qn /l*v C:\Windows\Temp\qemu-ga-x64.log"