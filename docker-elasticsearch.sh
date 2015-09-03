#/usr/bin/env bash

echo "==> Starting an Elasticsearch instance..."

CMD="sudo docker run -d --restart always \
--name elasticsearch \
-v /opt/elasticsearch/data:/usr/share/elasticsearch/data \
-t elasticsearch:1.7.1 \
elasticsearch -Des.node.name=LogstashNode"

echo "==> $CMD"

$CMD