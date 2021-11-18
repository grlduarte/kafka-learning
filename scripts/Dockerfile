FROM python:3.8
WORKDIR /scripts
COPY . .
RUN pip install kafka-python
CMD [ "python3", "producer.py" ]
