#!/usr/bin/env bash

echo "==> Updating Docker Lumberjack plugin..."
CMD="sudo docker exec logstash /opt/logstash/bin/plugin update logstash-input-lumberjack"
echo $CMD
$CMD

echo "==> Updating Docker RabbitMQ plugins..."
CMD="sudo docker exec logstash /opt/logstash/bin/plugin update logstash-output-rabbitmq logstash-input-rabbitmq"
echo $CMD
$CMD

echo "==> Restarting Docker logstash container..."
CMD="sudo docker stop logstash; sudo docker start logstash"
echo $CMD
$CMD
