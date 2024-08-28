#!/bin/bash
#Create directory and download transport
mkdir abap_sdk_transport
cd abap_sdk_transport
wget  https://storage.googleapis.com/cloudsapdeploy/connectors/abapsdk/abap-sdk-for-google-cloud-1.7.zip

#Unzip the transport files
unzip abap-sdk-for-google-cloud-1.7.zip

#Copy the file to the trans folder of the docker container
sudo docker cp K900271.GM1 a4h:/usr/sap/trans/cofiles/K900271.GM1
sudo docker cp R900271.GM1 a4h:/usr/sap/trans/data/R900271.GM1
sudo docker cp K900275.GM1 a4h:/usr/sap/trans/cofiles/K900275.GM1
sudo docker cp R900275.GM1 a4h:/usr/sap/trans/data/R900275.GM1

#Run the "tp" command to import the transport
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900271 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900271 A4H U128 client=001'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900275 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900275 A4H U128 client=001'