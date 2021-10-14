# Disable password authentication
# for sshd

$SSHD_PATH = "C:\ProgramData\ssh\sshd_config"

(Get-Content $SSHD_PATH) -replace '#PasswordAuthentication yes', "PasswordAuthentication no" | Out-File $SSHD_PATH