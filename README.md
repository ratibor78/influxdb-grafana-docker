# InfluxDB+Grafana with Docker Compose

![Alt text](https://github.com/ratibor78/influxdb-grafana-docker/blob/master/influxdb-grafana.png?raw=true "Grafana + InfluxDB")

Use Docker Compose for quick setup a monitoring solution based on InfluxDB and Grafana.

This repository contains a simple docker-compose file that will create a local installation
of InfluxDb + Grafana on your host system. 

It will expose the InfluxDB on public portt = 8086 and Grafana will be exposed on 3000 port.

### Installation

1. For quick installation clone the git repository and run the install.sh script then. 

2. Or you can do it manually with a few steps listed below:

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

Next step you need to add the InfluxDB as a new data source in Grafana with URL = 'http://influxdb:8086' 
and database name telegraf with user credentials that you were created.

![Alt text](https://github.com/ratibor78/influxdb-grafana-docker/blob/master/data_source.png?raw=true "Add the new data source for Grafana")

After that you're ready to serve the first incoming request and create Grafana dashboards.


Have fun !

License
----

MIT

**Free Software, Hell Yeah!**
