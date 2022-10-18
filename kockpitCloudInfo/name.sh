cd /home/$USER/clouddrive/kockpitCloudInfo/
machineName=`jq '.machineName' kockpitCloudInfo.json`
echo $machineName > machineName2.txt
echo $machineName | sed "s/['\"]//g" > machineName1.txt
echo $machineName | sed 's/.$//' > machineName.txt
machineName1=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName1.txt`
machineName=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName.txt`
machineName2=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/machineName2.txt`
mkdir list
az vm list > /home/$USER/clouddrive/kockpitCloudInfo/list/name.json
grep name /home/$USER/clouddrive/kockpitCloudInfo/list/name.json > /home/$USER/clouddrive/kockpitCloudInfo/list/nameFilter.json
machineName=`jq '.machineName' kockpitCloudInfo.json`
echo $machineName > /home/$USER/clouddrive/kockpitCloudInfo/list/machineName2.txt
machineName2=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/list/machineName2.txt`
grep $machineName2 /home/$USER/clouddrive/kockpitCloudInfo/list/nameFilter.json > /home/$USER/clouddrive/kockpitCloudInfo/list/foundName.txt
name1=`jq '.machineName' kockpitCloudInfo.json`
name2=`awk 'FNR ==1 {print $2}' /home/$USER/clouddrive/kockpitCloudInfo/list/foundName.txt`
echo $name1 | sed "s/['\"]//g" > /home/$USER/clouddrive/kockpitCloudInfo/list/Comp1.txt
echo $name2 | sed "s/['\",'\,]//g" > /home/$USER/clouddrive/kockpitCloudInfo/list/Comp2.txt
name1=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/list/Comp1.txt`
name2=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/list/Comp2.txt`
if [[ $name1 == $name2 ]]
then
    echo "VM Already Exists. Try Again!!"
else
    echo "Successfull"
fi

