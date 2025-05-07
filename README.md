# Microservices Helm Umbrella Chart

This Helm chart is an umbrella chart that deploys a set of microservices onto Kubernetes. Each microservice is packaged as an individual Helm subchart.

## 📦 Included Microservices

- `catalogue` – the main product catalogue service
- `catalogue-db` – PostgreSQL database for the catalogue service
- `frontend` – user-facing frontend
- `recommendation` – product recommendation engine
- `voting` – voting/rating service for products

## 📁 Directory Structure

/
├── Chart.yaml # Umbrella chart definition
├── values.yaml # Global and subchart override values
├── service-charts/
│ ├── catalogue/ # Subchart for catalogue
│ ├── catalogue-db/ # Subchart for PostgreSQL
│ ├── frontend/ # Subchart for frontend UI
│ ├── recommendation/ # Subchart for recommendation engine
│ ├── voting/ # Subchart for voting service
│ └── values-prod.yaml # Optional overrides for production


## 🚀 Prerequisites

- [Helm 3.x](https://helm.sh/)
- [Minikube](https://minikube.sigs.k8s.io/) or another Kubernetes cluster
- Docker images for your microservices should be available in a registry

## 🛠 Setup Instructions

1. **Navigate to the umbrella chart directory**:
   ```bash
   cd microservice-helmcharts
2. Build dependencies:
helm dependency build
helm install . --generate-name --values values-dev.yaml
