#! /usr/bin/env bash

##
## Installation script for Docker Compose with InfluxDB & Grafana
## Alexey Nizhegolenko 2019
##

WORKDIR=$(pwd)

if [[ $(which docker) ]] && [[ $(which docker-compose) ]]

  then

    echo "Starting the installation of your new InfluxDb + Grafana monitoring stack!"
    echo ""
    echo " Creating Docker network with name  'monitoring'"
    docker network create monitoring
    echo ""
    echo " Creating Docker volumes with names  'grafana-volume, influxdb-volume'"
    docker volume create grafana-volume
    docker volume create influxdb-volume
    echo ""
    echo "Preparing InfluxDB base and users list, please answer the questions below."
    read -e -p "Enter InfluxDB admin username 'admin' for default: " -i "admin" ADMINNAME
    read -e -p "Enter InfluxDB admin user password 'supersecretpassword' for default: " -i "supersecretpassword" ADMINPASS
    read -e -p "Enter InfluxDB regular user username 'telegraf' for default: " -i "telegraf" USERNAME
    read -e -p "Enter InfluxDB regular user password 'secretpassword' for default: " -i "secretpassword" USERPASS
    echo ""
    echo "OK, all data collected will create a InfluxDB users with InfluxDB admin as $ADMINNAME and regular user $USERNAME"

    docker run --rm \
      -e INFLUXDB_DB=telegraf -e INFLUXDB_ADMIN_ENABLED=true \
      -e INFLUXDB_ADMIN_USER=$ADMINNAME \
      -e INFLUXDB_ADMIN_PASSWORD=$ADMINPASS \
      -e INFLUXDB_USER=$USERNAME -e INFLUXDB_USER_PASSWORD=$USERPASS \
      -v influxdb-volume:/var/lib/influxdb influxdb /init-influxdb.sh
   
     echo ""
     echo "strting Docker Compose "
     docker-compose up -d
     echo ""
     echo "Cheking docker container status"
     docker ps

   else 

    echo "Docker or Docker Compose not installed or not configured properly, please install it first and then try again."
fi
