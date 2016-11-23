# new VM by using function
New-LabVM -VMName EL-DEMO-01 -VMIP 172.16.0.88

# add static mapping
Add-NetNatStaticMapping -NatName HO_Lab_Network -ExternalIPAddress 0.0.0.0 -ExternalPort 4001 -InternalIPAddress 172.16.0.88 -InternalPort 3389 -Protocol TCP
# Open firewall on host server
New-NetFirewallRule -Name TCP4001 -Protocol TCP -LocalPort 4001 -Action Allow -Enabled True

# install hyper-v role
Enter-PSSession -VMName EL-DEMO-01
Install-WindowsFeature hyper-v -IncludeAllSubFeature -IncludeManagementTools

#region stop vm
Exit-PSSession
stop-vm -VMName el-demo-01

# enable Nested Hyper-V
Set-VMProcessor -VMName EL-DEMO-01 -ExposeVirtualizationExtensions $true
start-vm -VMName EL-DEMO-01

# install hyper-v role
Enter-PSSession -VMName EL-DEMO-01
Install-WindowsFeature hyper-v -IncludeAllSubFeature
