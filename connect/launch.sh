#!/bin/bash

echo Installing JDBC connector... &&
confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:latest &&
echo Starting Kafka Connect... &&
# the output of run is massive so put it
# to /dev/null
/etc/confluent/docker/run > /dev/null &
echo Waiting for Kafka Connect... &&
dub wait connect 8083 180 &&
#cub connect-ready connect 8083 60
# connect-ready returns a 404 in the first
# tries
echo Kafka Connect is up! &&

# while initializing, the address may return
# a 404 or 500, in that case, just try again.
code=$(curl -s -w '%{http_code}' -o /dev/null \
       http://connect:8083/connectors/)
while [ $code -ne 200 ]
do
  # wait until the page responds
  sleep 5
  code=$(curl -s -w '%{http_code}' -o /dev/null \
         http://connect:8083/connectors/)
done

echo Creating JDBC connectors... &&
# once the page is responding we can 
# create the sink connector
curl -i -X POST \
     -H 'Accept:application/json' \
     -H 'Content-Type:application/json' \
     http://connect:8083/connectors/ \
     -d @/connect/jdbc-sink-postgres.json

# and now the source connector
curl -i -X POST \
     -H 'Accept:application/json' \
     -H 'Content-Type:application/json' \
     http://connect:8083/connectors/ \
     -d @/connect/jdbc-source-mssql.json

sleep infinity
