#/usr/bin/env bash

echo "==> Creating an example self-signed certificate/key pair for use with a server named 'logstash.example.com'..."

for FILE in lumberjack.crt lumberjack.key; do
    if [ -e $FILE ]; then
        echo "==> Removing existing file: $FILE"
        rm -fv $FILE
    fi
done

CMD="openssl req -x509  -batch -nodes -newkey rsa:2048 -keyout lumberjack.key -out lumberjack.crt -subj /CN=logstash.example.com"

echo "==> $CMD"

$CMD
