#/usr/bin/env bash

echo "==> Starting a RabbitMQ instance..."

CMD="sudo docker run -d --restart always \
--hostname rabbitmq.example.com \
--name rabbitmq \
-p 5672:5672 \
-p 15672:15672 \
-e RABBITMQ_DEFAULT_USER=admin \
-e RABBITMQ_DEFAULT_PASS=admin \
-t rabbitmq:3.5.4-management"

echo "==> $CMD"

$CMD