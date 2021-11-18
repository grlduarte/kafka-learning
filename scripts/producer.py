import random
from time import sleep

from kafka import KafkaProducer


producer = KafkaProducer(bootstrap_servers='broker:9092',
                         value_serializer=lambda v: str(v).encode('utf-8'))

while True:
    producer.send('quickstart', random.randint(1, 999))
    sleep(1)
