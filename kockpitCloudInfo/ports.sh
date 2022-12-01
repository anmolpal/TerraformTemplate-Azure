x=100
machineName1=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName1.txt`
jq -c '.port[]' kockpitCloudInfo.json |
while read i;
do
    echo "az vm open-port --resource-group kockpitNucleas --name "$machineName1" --port $i --priority $x" | sed "s/['\"]//g" >> /home/$USER/clouddrive/kockpitCloudInfo/list/port.sh
    #echo $machinename1
    #echo $i
    x=$(expr $x + 1)
done 
/bin/bash /home/$USER/clouddrive/kockpitCloudInfo/list/port.sh
rm /home/$USER/clouddrive/kockpitCloudInfo/list/port.sh
