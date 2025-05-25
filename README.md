# Microservice Helm Charts

A comprehensive GitOps-based solution for deploying and promoting microservices across environments using Helm charts, ArgoCD, and Kargo.

## Table of Contents
- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [GitOps Promotion Strategy](#gitops-promotion-strategy)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)

## Overview

This repository contains Helm charts and GitOps configurations for deploying and promoting microservices across development, staging, and production environments.
The solution leverages ArgoCD for continuous deployment and Kargo for automated promotion workflows.

## Repository Structure

```
microservice-helmcharts/
├── argocd/                # ArgoCD application manifests
│   └── application/       # Application definitions
│       ├── dev/          # Development environment applications
│       ├── stage/        # Staging environment applications
│       └── prod/         # Production environment applications
├── env/                  # Environment-specific configurations
│   ├── dev/             # Development environment values
│   ├── stage/           # Staging environment values
│   └── prod/            # Production environment values
├── kargo/               # Kargo promotion configuration
│   ├── stages.yaml      # Stage definitions
│   ├── freight.yaml     # Freight definition
│   ├── warehouse.yaml   # Warehouse configuration
│   ├── analysis-template.yaml  # Deployment verification
│   └── promotion-policy.yaml   # Promotion policies
├── service-charts/      # Helm charts for each microservice
└── promotion/          # Legacy promotion scripts
    ├── scripts/        # Promotion scripts
    └── workflows/      # CI/CD workflow definitions
```

## GitOps Promotion Strategy

This repository implements a GitOps-based promotion strategy using Kargo with the following workflow:

### Automated Development Deployment

- New Docker images are automatically detected and deployed to the dev environment
- ArgoCD syncs changes to the dev cluster
- Automated verification ensures deployment health

### Automatic Staging Promotion

- After successful deployment in dev, Kargo verifies the deployment health
- If verification passes, Kargo automatically promotes to staging
- Promotion updates the staging environment configuration files

### Production Deployment

- Production deployments require manual approval in Kargo
- After approval, Kargo updates the production configuration files
- ArgoCD automatically syncs approved changes to production

## Setup Instructions

### Prerequisites

- Kubernetes clusters for dev, stage, and prod environments
- ArgoCD installed on all clusters
- Kargo installed on all clusters
- `kubectl` CLI tool
- Access to container registries

### Installation

1. Install Kargo:
```bash
kubectl apply -f https://github.com/akuity/kargo/releases/latest/download/install.yaml
```

2. Apply Kargo configurations:
```bash
kubectl apply -f kargo/
```

3. Apply ArgoCD applications:
```bash
kubectl apply -f argocd/application/dev/
kubectl apply -f argocd/application/stage/
kubectl apply -f argocd/application/prod/
```

## Usage

### Promoting with Kargo

1. View available Freight:
```bash
kubectl get freight -n craftista
```

2. Manually promote to production:
```bash
kubectl kargo promote microservices-freight --stage stage --to-stage prod -n craftista
```

3. View promotion history:
```bash
kubectl get promotions -n craftista
```

### Monitoring Deployments

1. Check deployment status:
```bash
kubectl get deployments -n <environment-namespace>
```

2. View ArgoCD sync status:
```bash
kubectl get applications -n argocd
```

### Troubleshooting

1. View Kargo logs:
```bash
kubectl logs -n kargo -l app=kargo
```

2. Check ArgoCD application status:
```bash
kubectl describe application -n argocd <application-name>
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.