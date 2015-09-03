#/usr/bin/env bash

echo "==> Starting a Kibana instance..."

CMD="sudo docker run -d --restart always \
--name kibana \
--link elasticsearch:elasticsearch \
-p 5601:5601 \
-t kibana:4.1.1"

echo "==> $CMD"

$CMD
