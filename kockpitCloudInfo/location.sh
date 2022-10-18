#!/bin/sh
cd /home/$USER/clouddrive/kockpitCloudInfo
location=`jq '.location' kockpitCloudInfo.json`
cd /home/$USER/clouddrive/kockpitCloudInfo/list/
echo "$location" | sed "s/['\"]//g" >> jsonlocation.txt
locationa=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/list/jsonlocation.txt`
locationb=`awk 'FNR ==1 {print $2}' /home/$USER/clouddrive/kockpitCloudInfo/list/jsonlocation.txt`
az vm list-usage --location "$locationa $locationb" -o table >> azlocdump.txt
rm -rf jsonlocation.txt
grep "Total Regional vCPUs" /home/$USER/clouddrive/kockpitCloudInfo/list/azlocdump.txt >> regionalcpu.txt
rm azlocdump.txt
nocpus=`awk 'FNR ==1 {print $4}' /home/$USER/clouddrive/kockpitCloudInfo/list/regionalcpu.txt`
limit=`awk 'FNR ==1 {print $5}' /home/$USER/clouddrive/kockpitCloudInfo/list/regionalcpu.txt`
rm regionalcpu.txt
az vm list-skus -l $locationa$locationb -o table > /home/$USER/clouddrive/kockpitCloudInfo/list/regionlist.txt
grep "virtualMachines" /home/$USER/clouddrive/kockpitCloudInfo/list/regionlist.txt > regionName.txt
awk=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/list/regionName.txt`
echo "$locationa$locationb" |sed -e 's/\(.*\)/\L\1/' > /home/$USER/clouddrive/kockpitCloudInfo/list/smallRegion.txt
smallRegion=`awk 'FNR ==1 {print $1}' /home/$USER/clouddrive/kockpitCloudInfo/list/smallRegion.txt`

wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header 'Cookie: ARRAffinity=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6; ARRAffinitySameSite=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6' \
   'https://prices.azure.com/api/retail/prices?currencyCode='\''INR'\''&$filter=productName eq '\''Virtual Machines BS Series Windows'\'' and armSkuName eq '\''Standard_B1ls'\'' and armRegionName eq '\'''$smallRegion''\''and priceType eq '\''Consumption'\''' -O cost1$locationa$locationb.json
wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header 'Cookie: ARRAffinity=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6; ARRAffinitySameSite=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6' \
   'https://prices.azure.com/api/retail/prices?currencyCode='\''INR'\''&$filter=productName eq '\''Virtual Machines BS Series Windows'\'' and armSkuName eq '\''Standard_B1s'\'' and armRegionName eq '\'''$smallRegion''\''and priceType eq '\''Consumption'\''' -O cost2$locationa$locationb.json
wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header 'Cookie: ARRAffinity=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6; ARRAffinitySameSite=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6' \
   'https://prices.azure.com/api/retail/prices?currencyCode='\''INR'\''&$filter=productName eq '\''Virtual Machines DSv2 Series Windows'\'' and armSkuName eq '\''Standard_DS1_v2'\'' and armRegionName eq '\'''$smallRegion''\''and priceType eq '\''Consumption'\'' and meterName eq '\''DS1 v2'\''' -O cost3$locationa$locationb.json 
wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header 'Cookie: ARRAffinity=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6; ARRAffinitySameSite=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6' \
   'https://prices.azure.com/api/retail/prices?currencyCode='\''INR'\''&$filter=productName eq '\''Virtual Machines BS Series Windows'\'' and armSkuName eq '\''Standard_B2s'\'' and armRegionName eq '\'''$smallRegion''\''and priceType eq '\''Consumption'\'' and meterName eq '\''B2s'\''' -O cost4$locationa$locationb.json
wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header 'Cookie: ARRAffinity=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6; ARRAffinitySameSite=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6' \
   'https://prices.azure.com/api/retail/prices?currencyCode='\''INR'\''&$filter=productName eq '\''Virtual Machines BS Series Windows'\'' and armSkuName eq '\''Standard_B4ms'\'' and armRegionName eq '\'''$smallRegion''\''and priceType eq '\''Consumption'\'' and meterName eq '\''B4ms'\''' -O cost5$locationa$locationb.json         
wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header 'Cookie: ARRAffinity=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6; ARRAffinitySameSite=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6' \
   'https://prices.azure.com/api/retail/prices?currencyCode='\''INR'\''&$filter=productName eq '\''Virtual Machines DSv3 Series Windows'\'' and armSkuName eq '\''Standard_D2s_v3'\'' and armRegionName eq '\'''$smallRegion''\''and priceType eq '\''Consumption'\'' and meterName eq '\''D2s v3'\''' -O cost6$locationa$locationb.json     
wget --no-check-certificate --quiet \
  --method GET \
  --timeout=0 \
  --header 'Cookie: ARRAffinity=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6; ARRAffinitySameSite=fcb63bcf31f69d50c9dd1fb124d3095f0f06a693b4de3eca70e0fec452c979e6' \
   'https://prices.azure.com/api/retail/prices?currencyCode='\''INR'\''&$filter=productName eq '\''Virtual Machines DSv3 Series Windows'\'' and armSkuName eq '\''Standard_D8s_v3'\'' and armRegionName eq '\'''$smallRegion''\''and priceType eq '\''Consumption'\'' and meterName eq '\''D8s v3'\''' -O cost7$locationa$locationb.json

price0=`jq '.Items[].unitPrice' /home/$USER/clouddrive/kockpitCloudInfo/list/cost1$locationa$locationb.json`
price1=`jq '.Items[].unitPrice' /home/$USER/clouddrive/kockpitCloudInfo/list/cost2$locationa$locationb.json`
price2=`jq '.Items[].unitPrice' /home/$USER/clouddrive/kockpitCloudInfo/list/cost3$locationa$locationb.json`
price3=`jq '.Items[].unitPrice' /home/$USER/clouddrive/kockpitCloudInfo/list/cost4$locationa$locationb.json`
price4=`jq '.Items[].unitPrice' /home/$USER/clouddrive/kockpitCloudInfo/list/cost5$locationa$locationb.json`
price5=`jq '.Items[].unitPrice' /home/$USER/clouddrive/kockpitCloudInfo/list/cost6$locationa$locationb.json`
price6=`jq '.Items[].unitPrice' /home/$USER/clouddrive/kockpitCloudInfo/list/cost7$locationa$locationb.json`

if [[ $awk == *virtualMachines* ]]
then
        echo "Region Available"
        if [[ $nocpus -ge $limit ]]
        then
            echo "No CPU Available"
            count=$(expr $limit - $nocpus)
            echo "Remaining CPUs Left $count"
        else
            echo "CPU Available"
            count=$(expr $limit - $nocpus)
            echo "Remaining CPUs Left $count"
            if [[ $count == 1 ]]
            then
                echo '"Standard_B1ls": "1 CPU 0.5GB RAM" :"price": "'$price0'"'
                echo '"Standard_B1s": "1 CPU 1GB RAM" :"price": "'$price1'"'
                echo '"Standard_DS1_v2": "1 CPU 3.5GB RAM" :"price": "'$price2'"'
            elif [[ $count == 2 ]]
            then    
                echo '"Standard_B1ls": "1 CPU 0.5GB RAM" :"price": "'$price0'"'
                echo '"Standard_B1s": "1 CPU 1GB RAM" :"price": "'$price1'"'
                echo '"Standard_DS1_v2": "1 CPU 3.5GB RAM" :"price": "'$price2'"'
                echo '"Standard_B2S": "2 CPU 4GB RAM" :"price": "'$price3'"'
            elif [[ $count == 4 ]]
            then   
                echo '"Standard_B1ls": "1 CPU 0.5GB RAM" :"price": "'$price0'"'
                echo '"Standard_B1s": "1 CPU 1GB RAM" :"price": "'$price1'"'
                echo '"Standard_DS1_v2": "1 CPU 3.5GB RAM" :"price": "'$price2'"'
                echo '"Standard_B2S": "2 CPU 4GB RAM" :"price": "'$price3'"'  
                echo '"Standard_B4ms": "4 CPU 16GB RAM" :"price": "'$price4'"'
            else
                echo '"Standard_B1ls": "1 CPU 0.5GB RAM" :"price": "'$price0'"'
                echo '"Standard_B1s": "1 CPU 1GB RAM" :"price": "'$price1'"'
                echo '"Standard_DS1_v2": "1 CPU 3.5GB RAM" :"price": "'$price2'"'
                echo '"Standard_B2S": "2 CPU 4GB RAM" :"price": "'$price3'"'
                echo '"Standard_D2s_v3": "2 CPU 8GB RAM" :"price": "'$price4'"'
                echo '"Standard_B4ms": "4 CPU 16GB RAM" :"price": "'$price5'"'
                echo '"Standard_D8s_v3": "8 CPU 32GB RAM" :"price": "'$price6'"'
            fi
        fi
else
        echo "Region Not Available"
fi
rm /home/$USER/clouddrive/kockpitCloudInfo/list/cost1$locationa$locationb.json
rm /home/$USER/clouddrive/kockpitCloudInfo/list/cost2$locationa$locationb.json
rm /home/$USER/clouddrive/kockpitCloudInfo/list/cost3$locationa$locationb.json
rm /home/$USER/clouddrive/kockpitCloudInfo/list/cost4$locationa$locationb.json
rm /home/$USER/clouddrive/kockpitCloudInfo/list/cost5$locationa$locationb.json
rm /home/$USER/clouddrive/kockpitCloudInfo/list/cost6$locationa$locationb.json
rm /home/$USER/clouddrive/kockpitCloudInfo/list/cost7$locationa$locationb.json
