# See the following link for more information
# https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start SSHD service
Start-Service -Name sshd

# Set SSHD service to start
Set-Service -Name sshd -StartupType 'Automatic'