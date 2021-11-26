"""
This script will send random data to Kafka topic quickstart-
events every second using an Avro schema loaded in the file
schema.avsc.

Though Avro Producer is currently legacy, it does a couple
of things automatically (like registering schemas and data
serialization), that otherwise would have to be done
manually.
"""

import random
import avro.schema

from confluent_kafka.avro import AvroProducer
from time import sleep


if __name__ == '__main__':
    producer = AvroProducer({'bootstrap.servers': 'broker:9092',
                             'schema.registry.url': 'http://schema-registry:8081'})

    with open('schema.avsc', 'r') as f:
        value_schema = avro.schema.parse(f.read())

    print("INFO: Producing messages to quickstart-events")
    record_id=0
    while True:
        try:
            record_value = {"id": record_id,
                            "value": random.randint(1, 500)}
            producer.produce(
                topic='quickstart-events',
                value=record_value,
                value_schema=value_schema,
            )
            producer.poll(1)
            producer.flush(1)
        except Exception as e:
            # probably still can't connect to the broker
            sleep(10)
            continue
            #print(e)
        else:
            record_id += 1
            sleep(1)

