#!/bin/bash

sudo wget -O Dynatrace-ActiveGate-Linux-x86-1.189.138.sh "https://$1.live.dynatrace.com/api/v1/deployment/installer/gateway/unix/latest?arch=x86&flavor=default" --header="Authorization: Api-Token $2" 
sudo /bin/sh Dynatrace-ActiveGate-Linux-x86-1.189.138.sh 

sleep 10s

sudo chmod 777 -Rf /var/lib/dynatrace/gateway/config/

sudo cat <<EOF > /var/lib/dynatrace/gateway/config/custom.properties
[http.client.external]
hostname-verification = no
certificate-validation = no
EOF

sudo service dynatracegateway stop 
sleep 10s
sudo service dynatracegateway start
