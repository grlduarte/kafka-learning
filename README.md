### Learning Kafka

Este é um ambiente mínimo com o objetivo de entender o funcionamento do conector
JDBC do Kafka. Os dados são coletados da tabela `quickstart-source` num banco de
dados MS SQL Server e colocados no tópico `quickstart-events` do Kafka. Assim
que o JDBC Sink detecta os dados no tópico, estes são colocados na tabela
`quickstart-sink` num banco de dados Postgres.

Rode com `docker-compose up`. Recomendo não usar o modo *dettached* pra poder
ter uma visão instantânea dos logs. Pode rodar também com a flag `-d` e depois
retomar os logs com `docker-compose logs -f <container>`.

Para testar o funcionamento, crie o banco e tabela no MS SQL Server conforme descrito
no script `db/create-db-mssql.sql` e depois insira novos dados na tabela usando 
`INSERT INTO "quickstart-source" (id, value) values (1, 123);`. 
Assim que inseridos, os dados aparecerão no tópico do Kafka e logo depois na tabela `quickstart-sink` do Postgres. O JDBC Source está usando a *primary key* para saber 
que dados já foram coletados do Source. Esses offsets são registrados no tópico `docker-connect-offsets`.

O script em `kafka-python/producer.py` produz dados para o tópico
`quickstart-events`, mas como o JDBC Source está sendo usando, este serviço está
comentado. Os conectores JDBC Source e Sink estão configurados em `connect/`. O
*schema* dos dados é automaticamente lido do banco de dados Source e repassado
para o *schema* do tópico do Kafka e em sequência para o banco de dados Sink.

Pra explorar outros comandos do Kafka entre no container com `docker exec -it
broker bash` ou se quiser testar funções da API Python entre com `docker exec
-it producer ipython`.

O Control Center é uma ótima ferramenta de monitoramento da Confluent e pode ser
acessado em [localhost:9021](https://localhost:9021).

