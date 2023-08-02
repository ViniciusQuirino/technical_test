#!/usr/bin/env bash

echo "Running composer"
composer install --no-dev --working-dir=/var/www/html

echo "Caching config"
php artisan config:cache

echo "Caching routes"
php artisan route:cache

echo "Running migration"
php artisan migrate --force

echo "Starting queue worker in the background"
nohup php artisan queue:work database --daemon --tries=5 &

sleep 5

echo "Deployment completed!"