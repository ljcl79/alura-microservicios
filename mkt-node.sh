#!/usr/bin/env bash

if [ ! -d node_modules ]; then
  npm install
fi

echo "Esperando RabbitMQ..."
until node -e "
const net = require('net');
const client = net.connect(${RABBITMQ_PORT}, '${RABBITMQ_HOST}', () => { process.exit(0); });
client.on('error', () => process.exit(1));
" 2>/dev/null; do
  echo "RabbitMQ no disponible, reintentando en 3s..."
  sleep 3
done

echo "RabbitMQ listo."

npm start
