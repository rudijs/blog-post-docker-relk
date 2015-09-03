#!/usr/bin/env bash

echo "==> Create RabbitMQ 'relk' vhost..."
CMD="sudo docker exec rabbitmq rabbitmqctl add_vhost relk"
echo $CMD
$CMD

for USER in logstashInput logstashOutput; do
    echo "==> Create RabbitMQ logstash user account..."
    CMD="sudo docker exec rabbitmq rabbitmqctl add_user ${USER} abc123"
    echo $CMD
    $CMD
done

for USER in admin logstashInput logstashOutput; do
    echo "==> Set RabbitMQ relk vhost permission for ${USER} user account..."
    CMD="sudo docker exec rabbitmq rabbitmqctl set_permissions -p relk ${USER} '.*' '.*' '.*'"
    echo $CMD
    $CMD
done
