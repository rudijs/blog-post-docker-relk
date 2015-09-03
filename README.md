# blog-post-docker-relk
Demo Vagrant App of Docker RabbitMQ, Elasticsearch, Logstash, Kibana and Logstash-Forwarder

- vagrant up
- vagrant ssh relk
- ./docker-rabbitmq.sh
 
```
==> Starting a RabbitMQ instance...
==> sudo docker run -d --restart always --hostname rabbitmq.example.com --name rabbitmq -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=admin -t rabbitmq:3.5.4-management
573cada414b224533b611ebbfb6f919ae57b26fa16860abcc94696db8410a515
```

- http://192.168.33.100:15672/
- ./docker-rabbitmq-configure.sh

``` 
==> Create RabbitMQ 'relk' vhost...
docker exec rabbitmq rabbitmqctl add_vhost relk
Creating vhost "relk" ...
==> Create RabbitMQ logstash user account...
docker exec rabbitmq rabbitmqctl add_user relk-logstash abc123
Creating user "relk-logstash" ...
==> Set RabbitMQ relk vhost permission for admin user account...
docker exec rabbitmq rabbitmqctl set_permissions -p relk admin '.*' '.*' '.*'
Setting permissions for user "admin" in vhost "relk" ...
==> Set RabbitMQ relk vhost permission for relk-logstash user account...
docker exec rabbitmq rabbitmqctl set_permissions -p relk relk-logstash '.*' '.*' '.*'
Setting permissions for user "relk-logstash" in vhost "relk" ...
```

- ./docker-elasticsearch.sh
 
``` 
==> Starting an Elasticsearch instance...
==> sudo docker run -d --restart always --name elasticsearch -v /opt/elasticsearch/data:/usr/share/elasticsearch/data -t elasticsearch:1.7.1 elasticsearch -Des.node.name=LogstashNode
8d1ace361a03b0b13c98c9c835d5c978c64c6950743707388eac736c79e83e6a
```
- ./docker-logstash.sh

```
==> Starting a Logstash instance...
==> sudo docker run -d --restart always --name logstash -v /etc/logstash/conf.d:/etc/logstash/conf.d:ro -v /etc/pki:/etc/pki:ro --link rabbitmq:rabbitmq --link elasticsearch:elasticsearch -p 9876:9876 -p 9877:9877 -t logstash:1.5.4-1 logstash -f /etc/logstash/conf.d
c2314283ba9ccaf84951e6eea2a425f5678de50081d0e3a3604e7f437fe60e20
```

- vagrant ssh app
