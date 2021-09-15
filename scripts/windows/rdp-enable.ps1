# Enable RDP
Set-ItemProperty -Path 'REGISTRY::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 0

# Enable RDP Firewall rule
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"