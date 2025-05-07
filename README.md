# Microservices Helm Umbrella Chart

This Helm chart is an umbrella chart that deploys a set of microservices onto Kubernetes. Each microservice is packaged as an individual Helm subchart.

## 📦 Included Microservices

- `catalogue` – the main product catalogue service
- `catalogue-db` – PostgreSQL database for the catalogue service
- `frontend` – user-facing frontend
- `recommendation` – product recommendation engine
- `voting` – voting/rating service for products

## 🚀 Prerequisites

- [Helm 3.x](https://helm.sh/)
- [Minikube](https://minikube.sigs.k8s.io/) or another Kubernetes cluster
- Docker images for your microservices should be available in a registry

## 🛠 Setup Instructions

1. **Navigate to the umbrella chart directory**:
   ```bash
   cd microservice-helmcharts
2. **Install the chart with development values**:
   helm install . --generate-name --values values-dev.yaml

3. **Access services via Minikube:**
   minikube service frontend
