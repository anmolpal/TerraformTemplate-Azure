machineName1=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName1.txt`
az vm start --name $machineName1 --resource-group kockpitNucleas
