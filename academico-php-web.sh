#!/usr/bin/env bash

if [ ! -d vendor ]; then
  composer install
fi

# Esperar a que PostgreSQL esté listo
echo "Esperando PostgreSQL..."
until php artisan migrate --force 2>/dev/null; do
  echo "Base de datos no disponible, reintentando en 3s..."
  sleep 3
done

php artisan migrate
php artisan db:seed --force
php -S web-academico:8080 -t public
