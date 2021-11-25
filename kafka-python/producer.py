import random
from time import sleep

import json
import avro.schema
from confluent_kafka.avro import AvroProducer


producer = AvroProducer({'bootstrap.servers': 'broker:9092',
                         'schema.registry.url': 'http://schema-registry:8081'})

with open('schema.avsc', 'r') as f:
    value_schema = avro.schema.parse(f.read())

record_id=0
while True:
    try:
        record_value = {"id": record_id,
                        "value": random.randint(1, 500)}
        record_id += 1
        producer.produce(
            topic='quickstart-events',
            value=record_value,
            value_schema=value_schema,
        )
        producer.poll(1)
        producer.flush(1)
        sleep(1)
    except KeyboardInterrupt:
        break
