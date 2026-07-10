#!/bin/bash

set -e

REPO_URL="https://github.com/yuvika7/devops-task.git"
PROJECT_DIR="devops-task"


if [ ! -d "$PROJECT_DIR" ]; then
    echo "Cloning repository..."
    git clone $REPO_URL
fi

cd $PROJECT_DIR

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
    echo "No application"
    exit 1
fi

echo "Building Docker image..."
docker build -t $IMAGE_NAME .

echo "Deploying application to Kubernetes..."

kubectl apply -f k8s/pvc.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml

echo "Restarting deployment..."
kubectl rollout restart deployment/$APP_NAME

echo "Waiting for deployment to complete..."
kubectl rollout status deployment/$APP_NAME

echo "Deployment completed successfully."

echo ""
kubectl get pods
kubectl get svc
kubectl get ingress
kubectl get hpa