# create a new 'internal' vSwitch
New-VMSwitch -SwitchName 'Demo' -SwitchType Internal
# find the interface index for the new interface
Get-NetAdapter 'vEthernet (Demo)'
# Add an IP-address to the new interface
# The PrefixLength describes the subnet size, the Interface Index reflects the NetAdapter created earlier
New-NetIPAddress -IPAddress 172.16.10.1 -PrefixLength 24 -InterfaceIndex 32
# Configure NAT with the new IP-address
New-NetNat -Name Demo_Nat -InternalIPInterfaceAddressPrefix 172.16.10.0/24

# Optional: create a static mapping (ie for accessing servers via RDP)
# add static mapping
Add-NetNatStaticMapping -NatName HO_Lab_Network -ExternalIPAddress 0.0.0.0 -ExternalPort 5001 -InternalIPAddress 172.16.0.251 -InternalPort 3389 -Protocol TCP
# Open firewall on host server
New-NetFirewallRule -Name TCP5001 -Protocol TCP -LocalPort 5001 -Action Allow -Enabled True
