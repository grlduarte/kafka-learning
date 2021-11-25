#!/bin/bash

echo Installing JDBC connector... &&
confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:latest &&
echo Starting Kafka Connect... &&
/etc/confluent/docker/run > /dev/null &
dub wait connect 8083 120 &&
echo Waiting for Kafka Connect... &&
sleep 20 &&
cub connect-ready connect 8083 60 && 
echo Kafka Connect is up! &&
echo Creating JDBC connector... &&
curl -i -X POST \
  -H 'Accept:application/json' \
  -H 'Content-Type:application/json' \
  http://localhost:8083/connectors/ \
  -d @/connect/register-sink.json;
sleep infinity
