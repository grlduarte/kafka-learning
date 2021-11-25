#!/bin/bash

echo Installing JDBC connector... &&
confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:latest &&
echo Starting Kafka Connect... &&
/etc/confluent/docker/run > /dev/null &
echo Waiting for Kafka Connect... &&
dub wait connect 8083 120 &&
#cub connect-ready connect 8083 60
# connect-ready returns a 404 in the first
# tries
echo Kafka Connect is up! &&

echo Creating JDBC connector... &&
attempts=0
while [ $attempts -le 5 ]
do
  code=$(curl -s -w '%{http_code}' -o /dev/null \
         -i -X POST -H 'Accept:application/json' \
         -H 'Content-Type:application/json' \
         http://connect:8083/connectors/ \
         -d @/connect/register-sink.json)
  if [ $code -eq 201 ]
  then
    echo JDBC connector is up!
    break
  elif [ $code -eq 409 ]
  then
    echo 409: Connector already exists!
    break
  elif [ $attempts -eq 5 ]
  then
    echo "Unable to create the connector: error $code"
    break
  else
    attempts=$(( attempts+1 ))
    sleep 5
  fi
done

sleep infinity
