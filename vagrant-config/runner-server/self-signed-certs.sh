#!/bin/bash

cd ./vagrant-config/runner-server/ssl
openssl genrsa -out registry.duy.com.key 2048
printf 'VN\n\n\n\n\nregistry.duy.com\n\n\n\n' | openssl req -key registry.duy.com.key -new -out registry.duy.com.csr
openssl x509 -signkey registry.duy.com.key -in registry.duy.com.csr -req -days 365 -out registry.duy.com.crt
openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in registry.duy.com.csr -out registry.duy.com.crt -days 365 -CAcreateserial -extfile registry.duy.com.ext