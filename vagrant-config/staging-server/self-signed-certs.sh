#!/bin/bash

# DOMAIN="registry.duy.com"
DOMAIN="stg.duy.com"
cd ./vagrant-config/staging-server/ssl
openssl genrsa -out $DOMAIN.key 2048
printf 'VN\n\n\n\n\n%s\n\n\n\n' "$DOMAIN" | openssl req -key $DOMAIN.key -new -out $DOMAIN.csr
openssl x509 -signkey $DOMAIN.key -in $DOMAIN.csr -req -days 365 -out $DOMAIN.crt
openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in $DOMAIN.csr -out $DOMAIN.crt -days 365 -CAcreateserial -extfile $DOMAIN.ext
printf '1\n' | sudo chmod 777 rootCA.crt rootCA.key $DOMAIN.csr $DOMAIN.crt $DOMAIN.ext $DOMAIN.key