### Learning Kafka

Estou construindo aos poucos um ambiente mínimo centrado no Apache Kafka. A intenção é ter um consumer no que seriaum backend e um banco de dados que é alimentado pelos dados que caem nos tópicos do Kafka.

Rode com `docker-compose up`. Recomendo não usar o modo *dettached* pra poder ter uma visão instantânea dos logs.

Pra explorar os comandos do kafka entre no container com `docker exec -it broker bash`. O control center está disponível em [localhost:9021](https://localhost:9021).
