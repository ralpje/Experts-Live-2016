# add static mapping
Add-NetNatStaticMapping -NatName HO_Lab_Network -ExternalIPAddress 0.0.0.0 -ExternalPort 4001 -InternalIPAddress 172.16.0.88 -InternalPort 3389 -Protocol TCP

# Open firewall on host server
New-NetFirewallRule -Name TCP4001 -Protocol TCP -LocalPort 4001 -Action Allow -Enabled True