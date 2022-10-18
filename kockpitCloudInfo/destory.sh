#!/bin/sh
machineName1=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName1.txt`

echo "
cd /home/anmol/clouddrive/kockpitCloudInfo/"$machineName1"

terraform destroy -target azurerm_virtual_machine."$machineName1"
terraform destroy -target azurerm_network_interface."$machineName1"-nic
terraform destroy -target azurerm_network_security_group."$machineName1"-nsg
terraform destroy -target azurerm_public_ip."$machineName1"-publicip
terraform destroy -target azurerm_virtual_network."$machineName1"-main
" > /home/anmol/clouddrive/kockpitCloudInfo/testing.txt
