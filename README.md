### Learning Kafka

Estou construindo aos poucos um ambiente mínimo centrado no Apache Kafka. A
intenção é ter um banco de dados (a princípio Postgres ou um MS SQL Server)
atuando como producer em uma ponta e um banco de dados (Postgres) atuando
como consumer na outra ponta.

Rode com `docker-compose up`. Recomendo não usar o modo *dettached* pra poder
ter uma visão instantânea dos logs. Pode rodar também com a flag `-d` e depois
retomar os logs com `docker-compose logs -f <container>`.

O script em `kafka-python/producer.py` está produzindo dados para o tópico
quickstart-events e o JDBC Sink configurado em `connect/register-sink.json`
joga esses dados no banco de dados Postgres na tabela quickstart-events.
Para o sink funcionar corretamente vale observar que a serialização e
desserialização das mensagens precisa ser bastante clara, por isso usei o
AvroProducer em vez do Producer tradicional do `confluent_kafka`.

Pra explorar outros comandos do Kafka entre no container com `docker exec -it
broker bash` ou se quiser testar funções da API Python entre com `docker exec
-it producer ipython`.

O Control Center é uma ótima ferramenta de monitoramento da Confluent e pode
ser acessado em [localhost:9021](https://localhost:9021).
