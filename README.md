Microservice Helm Charts
This repository contains Helm charts and GitOps configurations for deploying and promoting microservices across environments.

Repository Structure
microservice-helmcharts/
├── argocd/                # ArgoCD application manifests
│   └── application/       # Application definitions
│       ├── dev/           # Development environment applications
│       ├── stage/         # Staging environment applications
│       └── prod/          # Production environment applications
├── env/                   # Environment-specific configurations
│   ├── dev/               # Development environment values
│   ├── stage/             # Staging environment values
│   └── prod/              # Production environment values
├── kargo/                 # Kargo promotion configuration
│   ├── stages.yaml        # Stage definitions
│   ├── freight.yaml       # Freight definition
│   ├── warehouse.yaml     # Warehouse configuration
│   ├── analysis-template.yaml # Deployment verification
│   └── promotion-policy.yaml  # Promotion policies
├── service-charts/        # Helm charts for each microservice
└── promotion/             # Legacy promotion scripts
    ├── scripts/           # Promotion scripts
    └── workflows/         # CI/CD workflow definitions
GitOps Promotion Strategy with Kargo
This repository implements a GitOps-based promotion strategy using Kargo:

Automated deployment to development:

New Docker images are automatically detected and deployed to the dev environment
ArgoCD syncs changes to the dev cluster
Automatic promotion to staging with verification:

After successful deployment in dev, Kargo verifies the deployment health
If verification passes, Kargo automatically promotes to staging
Promotion updates the staging environment configuration files
Manual approval for production:

Production deployments require manual approval in Kargo
After approval, Kargo updates the production configuration files
Setup Instructions
Prerequisites
Kubernetes clusters for dev, stage, and prod environments
ArgoCD installed on all clusters
Kargo installed on all clusters
Installation
Install Kargo:

kubectl apply -f https://github.com/akuity/kargo/releases/latest/download/install.yaml
Apply Kargo configurations:

kubectl apply -f kargo/
Apply ArgoCD applications:

kubectl apply -f argocd/application/dev/
kubectl apply -f argocd/application/stage/
kubectl apply -f argocd/application/prod/
Usage
Promoting with Kargo
View available Freight:

kubectl get freight -n craftista
Manually promote to production:

kubectl kargo promote microservices-freight --stage stage --to-stage prod -n craftista
View promotion history:

kubectl get promotions -n craftista
```# test