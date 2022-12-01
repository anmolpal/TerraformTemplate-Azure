machineName1=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName1.txt`
az network nsg rule list -g kockpitNucleas --nsg-name "$machineName1-nsg" > /home/$USER/clouddrive/kockpitCloudInfo/list/portlist
grep priority /home/$USER/clouddrive/kockpitCloudInfo/list/portlist > /home/$USER/clouddrive/kockpitCloudInfo/priority.txt
sed 's/[^0-9]//g' /home/$USER/clouddrive/kockpitCloudInfo/priority.txt > /home/$USER/clouddrive/kockpitCloudInfo/priority1.txt
value=`cat /home/$USER/clouddrive/kockpitCloudInfo/priority1.txt`
prior=`jq '.priority' kockpitCloudInfo.json`
file=priority1.txt
if grep -Fxq "$prior" priority1.txt
then
   echo "$prior"
   echo "in a same priority"

else
   echo "$prior"
   echo "not in same priority"
fi
echo "Done!"
rm -rf /home/$USER/clouddrive/kockpitCloudInfo/priority.txt
rm -rf /home/$USER/clouddrive/kockpitCloudInfo/priority1.txt