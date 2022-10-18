#/bin/bash
#mkdir kockpitCloudInfo
############################################MachineName##################################

cd /home/$USER/clouddrive/kockpitCloudInfo/
machineName=`jq '.machineName' kockpitCloudInfo.json`
echo $machineName > machineName2.txt
echo $machineName | sed "s/['\"]//g" > machineName1.txt
echo $machineName | sed 's/.$//' > machineName.txt
machineName1=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName1.txt`
machineName=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName.txt`
machineName2=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName2.txt`
############################################Location##################################

location=`jq '.location' kockpitCloudInfo.json`
#echo $location | sed "s/['\"]//g" > location.txt
#location=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/location.txt`
#location1=`awk 'FNR ==1 {print $2}' /home/$USER/clouddrive/kockpitCloudInfo/location.txt`

############################################resourceGroup##################################

#resourceGroup=`jq '.resourceGroup' kockpitCloudInfo.json`
#echo $resourceGroup | sed 's/.$//' > resourceGroup.txt
#resourceGroup=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/resourceGroup.txt`

############################################osVersion##################################

osVersion=`jq '.osVersion' kockpitCloudInfo.json`
#echo $osVersion | sed "s/['\"]//g" > osVersion.txt
#osVersion=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/osVersion.txt`

############################################$machineName1Size##################################

vmSize=`jq '.vmSize' kockpitCloudInfo.json`
#echo $$machineName1Size | sed "s/['\"]//g" > $machineName1Size.txt
#$machineName1Size=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/$machineName1Size.txt`

############################################disk##################################

disk=`jq '.disk' kockpitCloudInfo.json`
#echo $disk | sed "s/['\"]//g" > disk.txt
#disk=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/disk.txt`

############################################username##################################

username=`jq '.username' kockpitCloudInfo.json`
#echo $username | sed "s/['\"]//g" > username.txt
#username=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/username.txt`

############################################password##################################

password=`jq '.password' kockpitCloudInfo.json`
#echo $password | sed "s/['\"]//g" > password.txt
#password=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/password.txt`

############################################ip##################################

ip=`jq '.ip' kockpitCloudInfo.json`
#echo $ip | sed "s/['\"]//g" > ip.txt
#ip=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/ip.txt`

cd /home/$USER/clouddrive/kockpitCloudInfo/
# jq -c '.machineName[]' kockpitCloudInfo.json |
# while read i;
# do
#   echo " mkdir $machineName1$i" | sed "s/['\"]//g" >> directory.sh
# done

OS=`jq '.osVersion' kockpitCloudInfo.json`
echo $OS | sed "s/['\"]//g" > /home/$USER/clouddrive/kockpitCloudInfo/list/OS.txt
OS=`awk 'FNR ==1 {print $2}' /home/$USER/clouddrive/kockpitCloudInfo/list/OS.txt`
if [[ $OS == *18* ]]
then
    mkdir $machineName1
    echo '
    resource "azurerm_resource_group" "kockpitNucleas" {
        name     = "kockpitNucleas"
        location = "Central India"
    } ' > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.tf

    echo "terraform import azurerm_resource_group.kockpitNucleas /subscriptions/3f279ea5-d4f5-4dc5-b528-a179ceea52c0/resourceGroups/kockpitNucleas" > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.sh

    echo '
    provider "azurerm" {
      features {}
      skip_provider_registration = true
    }
    variable "prefix" {
      default = "tf$machineName1ex"
    }
    
    
    resource "azurerm_virtual_network" '"$machineName"'-main" {
      name                = '"$machineName"'-network"
      address_space       = ["10.0.0.0/16"]
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
    }
    
    resource "azurerm_subnet" '"$machineName"'-internal" {
      name                 = '"$machineName"'-internal"
      resource_group_name  = azurerm_resource_group.kockpitNucleas.name
      virtual_network_name = azurerm_virtual_network.'"$machineName1"'-main.name
      address_prefixes     = ["10.0.2.0/24"]
    }
    
    resource "azurerm_network_interface" '"$machineName"'-nic" {
      name                = '"$machineName"'-nic"
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
    
      ip_configuration {
        name                          = "testconfiguration1"
        subnet_id                     = azurerm_subnet.'"$machineName1"'-internal.id
        private_ip_address_allocation = '"$ip"'
        public_ip_address_id = azurerm_public_ip.'"$machineName1"'-publicip.id
      }
    }
    
    resource "azurerm_virtual_machine" '"$machineName2"' {
      name                  = '"$machineName2"'
      location              = '"$location $location1"'
      resource_group_name   = azurerm_resource_group.kockpitNucleas.name
      network_interface_ids = [azurerm_network_interface.'"$machineName1"'-nic.id]
      vm_size               = '"$vmSize"'
    
      storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18_04-lts-gen2"
        version   = "latest"
      }
      storage_os_disk {
        name              = '"$machineName"'-osdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = '"$disk"'
      }
      os_profile {
        computer_name  = '"$machineName2"'
        admin_username = '"$username"'
        admin_password = '"$password"'
      }
      os_profile_linux_config {
        disable_password_authentication = false
      }
      tags = {
        environment = "staging"
      }
    }
    resource "azurerm_network_security_group" '"$machineName"'-nsg" {
      name                = '"$machineName"'-nsg"
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
    
      security_rule {
        name                       = '"$machineName"'-Port8080"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
        security_rule {
        name                       = '"$machineName"'-Port8181"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8181"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
        security_rule {
        name                       = "SSH"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    
      tags = {
        environment = "Production"
      }
    }
    resource "azurerm_subnet_network_security_group_association" '"$machineName"'-nsga" {
      subnet_id                 = azurerm_subnet.'"$machineName1"'-internal.id
      network_security_group_id = azurerm_network_security_group.'"$machineName1"'-nsg.id
    }
    
    resource "azurerm_public_ip" '"$machineName"'-publicip" {
      name                = '"$machineName"'-publicip"
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
      location            = '"$location $location1"'
      allocation_method   = '"$ip"'
    
      tags = {
        environment = "Production"
      }
    } ' > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/$machineName1.tf
    sed 's/^[ \t]*//' /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/$machineName1.tf > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/terraform.tf
    cd /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/
    rm -rf $machineName1.tf
    terraform init
    /bin/bash /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.sh
    terraform apply -auto-approve
    rm -rf /home/$USER/clouddrive/kockpitCloudInfo/$machineName1
else 
    echo "Ubuntu 18 Skipped"    
fi

if [[ $OS == *20* ]]
then
    mkdir $machineName1
    echo '
    resource "azurerm_resource_group" "kockpitNucleas" {
        name     = "kockpitNucleas"
        location = "Central India"
    } ' > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.tf

    echo "terraform import azurerm_resource_group.kockpitNucleas /subscriptions/3f279ea5-d4f5-4dc5-b528-a179ceea52c0/resourceGroups/kockpitNucleas" > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.sh

    echo '
    provider "azurerm" {
      features {}
      skip_provider_registration = true
    }
    variable "prefix" {
      default = "tf$machineName1ex"
    }
    
    
    resource "azurerm_virtual_network" '"$machineName"'-main" {
      name                = '"$machineName"'-network"
      address_space       = ["10.0.0.0/16"]
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
    }
    
    resource "azurerm_subnet" '"$machineName"'-internal" {
      name                 = '"$machineName"'-internal"
      resource_group_name  = azurerm_resource_group.kockpitNucleas.name
      virtual_network_name = azurerm_virtual_network.'"$machineName1"'-main.name
      address_prefixes     = ["10.0.2.0/24"]
    }
    
    resource "azurerm_network_interface" '"$machineName"'-nic" {
      name                = '"$machineName"'-nic"
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
    
      ip_configuration {
        name                          = "testconfiguration1"
        subnet_id                     = azurerm_subnet.'"$machineName1"'-internal.id
        private_ip_address_allocation = '"$ip"'
        public_ip_address_id = azurerm_public_ip.'"$machineName1"'-publicip.id
      }
    }
    
    resource "azurerm_virtual_machine" '"$machineName2"' {
      name                  = '"$machineName2"'
      location              = '"$location $location1"'
      resource_group_name   = azurerm_resource_group.kockpitNucleas.name
      network_interface_ids = [azurerm_network_interface.'"$machineName1"'-nic.id]
      vm_size               = '"$vmSize"'
    
      storage_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts-gen2"
        version   = "latest"
      }
      storage_os_disk {
        name              = '"$machineName"'-osdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = '"$disk"'
      }
      os_profile {
        computer_name  = '"$machineName2"'
        admin_username = '"$username"'
        admin_password = '"$password"'
      }
      os_profile_linux_config {
        disable_password_authentication = false
      }
      tags = {
        environment = "staging"
      }
    }
    resource "azurerm_network_security_group" '"$machineName"'-nsg" {
      name                = '"$machineName"'-nsg"
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
    
      security_rule {
        name                       = '"$machineName"'-Port8080"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
        security_rule {
        name                       = '"$machineName"'-Port8181"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8181"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
        security_rule {
        name                       = "SSH"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    
      tags = {
        environment = "Production"
      }
    }
    resource "azurerm_subnet_network_security_group_association" '"$machineName"'-nsga" {
      subnet_id                 = azurerm_subnet.'"$machineName1"'-internal.id
      network_security_group_id = azurerm_network_security_group.'"$machineName1"'-nsg.id
    }
    
    resource "azurerm_public_ip" '"$machineName"'-publicip" {
      name                = '"$machineName"'-publicip"
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
      location            = '"$location $location1"'
      allocation_method   = '"$ip"'
    
      tags = {
        environment = "Production"
      }
    } ' > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/$machineName1.tf
    sed 's/^[ \t]*//' /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/$machineName1.tf > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/terraform.tf
    cd /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/
    rm -rf $machineName1.tf
    terraform init
    /bin/bash /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.sh
    terraform apply -auto-approve
    rm -rf /home/$USER/clouddrive/kockpitCloudInfo/$machineName1
else 
    echo "Ubuntu 20 Skipped"    
fi


OS=`jq '.osVersion' /home/$USER/clouddrive/kockpitCloudInfo/kockpitCloudInfo.json`
echo $OS | sed "s/['\"]//g" > /home/$USER/clouddrive/kockpitCloudInfo/list/OS.txt
OS=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/list/OS.txt`
if [[ $OS == *Windows* ]]
then
    mkdir $machineName1
    echo '
    resource "azurerm_resource_group" "kockpitNucleas" {
        name     = "kockpitNucleas"
        location = "Central India"
    } ' > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.tf

    echo "terraform import azurerm_resource_group.kockpitNucleas /subscriptions/3f279ea5-d4f5-4dc5-b528-a179ceea52c0/resourceGroups/kockpitNucleas" > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.sh

    echo '
    provider "azurerm" {
      features {}
      skip_provider_registration = true
    }
    
    resource "azurerm_virtual_network" '"$machineName2"' {
      name                = '"$machineName"'-network"
      address_space       = ["10.0.0.0/16"]
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
    }
    
    resource "azurerm_subnet" '"$machineName2"' {
      name                 = "internal"
      resource_group_name  = azurerm_resource_group.kockpitNucleas.name
      virtual_network_name = azurerm_virtual_network.'"$machineName1"'.name
      address_prefixes     = ["10.0.2.0/24"]
    }
    
    resource "azurerm_network_interface" '"$machineName1"' {
      name                = '"$machineName"'-nic"
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
    
      ip_configuration {
        name                          = "testconfiguration1"
        subnet_id                     = azurerm_subnet.'"$machineName1"'.id
        private_ip_address_allocation = '"$ip"'
        public_ip_address_id = azurerm_public_ip.'"$machineName1"'-publicip.id
      }
    }
    
    resource "azurerm_windows_virtual_machine" '"$machineName2"' {
      name                = '"$machineName2"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
      location            = '"$location $location1"'
      size                = '"$vmSize"'
      admin_username      = '"$username"'
      admin_password      = '"$password"'
      network_interface_ids = [
        azurerm_network_interface.'"$machineName1"'.id,
      ]
    
      os_disk {
        caching              = "ReadWrite"
        storage_account_type = '"$disk"'
      }
    
      source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2019-Datacenter"
        version   = "latest"
      }
    } 
    
    resource "azurerm_network_security_group" '"$machineName"'-nsg" {
      name                = '"$machineName"'-nsg"
      location            = '"$location $location1"'
      resource_group_name = azurerm_resource_group.kockpitNucleas.name

      security_rule {
        name                       = '"$machineName"'-Port8080"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
        security_rule {
        name                       = '"$machineName"'-Port8181"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8181"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
        security_rule {
        name                       = "RDP"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

      tags = {
        environment = "Production"
      }
    }

    resource "azurerm_subnet_network_security_group_association" '"$machineName"'-nsga" {
      subnet_id                 = azurerm_subnet.'"$machineName1"'.id
      network_security_group_id = azurerm_network_security_group.'"$machineName1"'-nsg.id
    }

    resource "azurerm_public_ip" '"$machineName"'-publicip" {
      name                = '"$machineName"'-publicip"
      resource_group_name = azurerm_resource_group.kockpitNucleas.name
      location            = '"$location $location1"'
      allocation_method   = '"$ip"'
    
      tags = {
        environment = "Production"
      }
    } ' > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/$machineName1.tf
    sed 's/^[ \t]*//' /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/$machineName1.tf > /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/terraform.tf
    cd /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/
    rm -rf $machineName1.tf
    terraform init
    /bin/bash /home/$USER/clouddrive/kockpitCloudInfo/$machineName1/import.sh
    terraform apply -auto-approve
    rm -rf /home/$USER/clouddrive/kockpitCloudInfo/$machineName1
    az vm show -d -g kockpitNucleas -n $machineName1 --query publicIps -o tsv
else 
    echo "Windows 2019 Server Edition Skipped"    
fi
