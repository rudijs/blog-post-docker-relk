#/usr/bin/env bash

echo "==> Starting a Logstash instance..."

CMD="sudo docker run -d --restart always \
--name logstash \
-v /home/vagrant/logstash/conf.d:/etc/logstash/conf.d:ro \
-v /etc/pki:/etc/pki:ro \
--link rabbitmq:rabbitmq \
--link elasticsearch:elasticsearch \
-p 9876:9876 \
-p 9877:9877 \
-t logstash:1.5.4-1 \
logstash -f /etc/logstash/conf.d"

echo "==> $CMD"

$CMD
