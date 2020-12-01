$Host.UI.RawUI.WindowTitle = "Running Sysprep..."

$unattendedXmlPath = "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\Unattend.xml"

C:\Windows\system32\sysprep\sysprep.exe /generalize /shutdown /oobe /unattend:"$unattendedXmlPath"