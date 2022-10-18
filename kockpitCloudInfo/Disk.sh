#!/bin/sh
machineName1=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName1.txt`
RANDOM=$$
jq -c '.attachDiskSize[]' kockpitCloudInfo.json |
while read i;
do
   echo " az vm disk attach --resource-group kockpitNucleas --vm-name "$machineName1" --name "myDataDisk$RANDOM" --size-gb "$i" --new" | sed "s/['\"]//g" >> /home/$USER/clouddrive/kockpitCloudInfo/list/diskupgrade.sh
done
/bin/bash /home/$USER/clouddrive/kockpitCloudInfo/list/diskupgrade.sh
rm /home/$USER/clouddrive/kockpitCloudInfo/list/diskupgrade.sh
