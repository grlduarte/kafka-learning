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
# a 404, in that case, just try again.
# if after 5 attempts it still can't connect,
# then maybe something else is wrong.
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
    # http code 201 -> created
    echo JDBC connector is up!
    break
  elif [ $code -eq 409 ]
  then
    # http code 409 -> conflict
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
