#!/bin/bash

set -e

APP_NAME="devops-app"
IMAGE_NAME="devops-app:latest"

echo "Checking application..."

if [ -f "index.html" ]; then
    echo "HTML application detected"

    cat > Dockerfile <<EOF
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EOF

elif [ -f "index.php" ]; then
    echo "PHP application detected"

    cat > Dockerfile <<EOF
FROM php:8.2-apache
COPY index.php /var/www/html/index.php
EOF

else
    echo "No index.html or index.php found"
    exit 1
fi

echo "Building Docker image..."
docker build -t $IMAGE_NAME .

echo "Docker image built successfully: $IMAGE_NAME"
