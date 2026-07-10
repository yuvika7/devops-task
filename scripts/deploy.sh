#!/bin/bash

set -e

APP_NAME="devops-app"
IMAGE_NAME="devops-app:latest"

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
    echo "No supported application found."
    exit 1
fi

echo ""
echo "Building Docker Image..."
docker build -t $IMAGE_NAME .

echo ""
echo "Deploying to Kubernetes..."

kubectl apply -f k8s/pvc.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml

echo ""
echo "Restarting Deployment..."

kubectl rollout restart deployment devops-app

echo ""
echo "Waiting for Pods..."

kubectl rollout status deployment/devops-app

echo ""
echo "Deployment Successful!"

kubectl get pods
kubectl get svc
kubectl get ingress
