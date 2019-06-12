# influxdb-grafana-docker
The Docker Compose file for quick setup a monitoring solution based on InfluxDB and Grafana.

This repository contains a simple docker-compose file that will create a local installation
of InfluxDb + Grafana on your host system. 

It will expose the InfluxDB on public portt = 8086 and Grafana will be exposed on 3000 port.

### Installation

1. For installation clone the git repository and run the install.sh script then. 

2 .Or you can do it manually with a few steps:

```
$ cd influxdb-grafana-docker

$ docker network create monitoring
$ docker volume create grafana-volume
$ docker volume create influxdb-volume

$ docker run --rm \
  -e INFLUXDB_DB=telegraf -e INFLUXDB_ADMIN_ENABLED=true \
  -e INFLUXDB_ADMIN_USER=admin \
  -e INFLUXDB_ADMIN_PASSWORD=supersecretpassword \
  -e INFLUXDB_USER=telegraf -e INFLUXDB_USER_PASSWORD=secretpassword \
  -v influxdb-volume:/var/lib/influxdb influxdb /init-influxdb.sh

$ docker-compose up -d
```

Then open server_ip:3000 and login into Grafana with admin:admin credentials for the first time.

Next step you need to add the InfluxDB as a new data source in Grafana. 

After that you're ready to serve the first incoming request and create Grafana dashboards.
