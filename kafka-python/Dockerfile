FROM python:3.8.0
WORKDIR /scripts
COPY . .
RUN pip install requests kafka-python confluent-kafka avro ipython
CMD [ "python3", "producer.py" ]
