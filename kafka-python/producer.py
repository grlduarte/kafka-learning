import random
from time import sleep

import json
from confluent_kafka import Producer


producer = KafkaProducer(bootstrap_servers='broker:9092',
                         value_serializer=lambda v: str(v).encode('utf-8'))

while True:
    record_value = {"value": random.randint(1, 500)}
    producer.send('quickstart-events', value=record_value)
    sleep(1)
