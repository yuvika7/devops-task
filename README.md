# DevOps Assignment

## Overview

This project demonstrates a simple end-to-end DevOps workflow for deploying a web application using Docker, Kubernetes, Helm, and Jenkins.

The goal was to containerize the application, deploy it on a Kubernetes cluster, package the deployment using Helm, and automate the process through a Jenkins pipeline.

---

## Technologies Used

- Docker
- Kubernetes (Minikube)
- Helm
- Jenkins
- Git & GitHub

---

## Project Structure

```
.
├── Dockerfile
├── Dockerfile.jenkins
├── Jenkinsfile
├── index.html
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── pvc.yaml
│   └── hpa.yaml
├── app-chart/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
└── README.md
```

---

## What I Implemented

- Containerized the application using Docker.
- Created Kubernetes manifests for Deployment, Service, Ingress, Persistent Volume Claim (PVC), and Horizontal Pod Autoscaler (HPA).
- Packaged the Kubernetes resources into a Helm chart.
- Built a Jenkins pipeline to automate the build and deployment process.
- Verified the deployment using Kubernetes and Helm commands.

---

## Jenkins Pipeline

The pipeline performs the following steps:

1. Clone the project from GitHub.
2. Build the Docker image.
3. Package the Helm chart.
4. Deploy or upgrade the application using Helm.
5. Verify the deployment.

---

## How to Run

### Build Docker Image

```bash
docker build -t devops-app:latest .
```

### Deploy Kubernetes Resources

```bash
kubectl apply -f k8s/
```

### Install Using Helm

```bash
helm install devops-release app-chart
```

or

```bash
helm upgrade --install devops-release app-chart
```

### Verify Deployment

```bash
kubectl get pods
kubectl get svc
kubectl get ingress
kubectl get pvc
kubectl get hpa
```

---

## Challenges Faced

During the implementation, I encountered a few issues, including:

- Docker permission issues inside the Jenkins container.
- Minikube API connectivity problems.
- Helm chart validation errors.
- Existing PVC ownership conflict during Helm installation.
- Metrics Server configuration affecting HPA metrics.

I resolved these issues by troubleshooting the configuration, rebuilding the Jenkins image with the required tools, correcting the Kubernetes context, and updating the Helm chart where necessary.

---

## Key Learnings

This assignment helped me gain practical experience with:

- Docker image creation and containerization.
- Kubernetes deployments and networking.
- Helm chart creation and package management.
- CI/CD pipeline creation using Jenkins.
- Debugging deployment and infrastructure issues.

It also improved my understanding of how these tools work together in a typical DevOps workflow.

---
