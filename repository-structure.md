# Craftista Microservices Helm Charts Repository Structure

This document provides a comprehensive overview of the repository structure for the Craftista microservices Helm charts and GitOps configuration.

```
microservice-helmcharts/
├── argocd/                # ArgoCD application manifests
│   ├── application/       # Application definitions
│   │   ├── dev/           # Development environment applications
│   │   │   ├── catalogue-db.yaml
│   │   │   ├── catalogue.yaml
│   │   │   ├── frontend.yaml
│   │   │   ├── README.md
│   │   │   ├── recommendation.yaml
│   │   │   └── voting.yaml
│   │   ├── prod/          # Production environment applications
│   │   │   ├── catalogue-db.yaml
│   │   │   ├── catalogue.yaml
│   │   │   ├── frontend.yaml
│   │   │   ├── recommendation.yaml
│   │   │   └── voting.yaml
│   │   ├── staging/       # Staging environment applications
│   │   │   ├── catalogue-db.yaml
│   │   │   ├── catalogue.yaml
│   │   │   ├── frontend.yaml
│   │   │   ├── recommendation.yaml
│   │   │   └── voting.yaml
│   │   └── craftista-project.yaml  # ArgoCD project definition
│   └── blog-post.md       # Blog post about the ArgoCD implementation
├── env/                   # Environment-specific configurations
│   ├── dev/               # Development environment values
│   │   ├── catalogue/
│   │   │   └── catalogue-values.yaml
│   │   ├── catalogue-db/
│   │   │   └── catalogue-db-values.yaml
│   │   ├── frontend/
│   │   │   └── frontend-values.yaml
│   │   ├── recommendation/
│   │   │   └── recommendation-values.yaml
│   │   └── voting/
│   │       └── voting-values.yaml
│   ├── prod/              # Production environment values
│   │   ├── catalogue/
│   │   │   ├── catalogue-image.yaml
│   │   │   └── catalogue-values.yaml
│   │   ├── catalogue-db/
│   │   │   ├── catalogue-db.yaml
│   │   │   └── catalogue-image.yaml
│   │   ├── frontend/
│   │   │   ├── frontend-image.yaml
│   │   │   └── frontend-values.yaml
│   │   ├── recommendation/
│   │   │   ├── recommendation-image.yaml
│   │   │   └── recommendation.yaml
│   │   └── voting/
│   │       ├── voting-image.yaml
│   │       └── voting.yaml
│   └── staging/           # Staging environment values
│       ├── catalogue/
│       │   ├── catalogue-image.yaml
│       │   └── catalogue-values.yaml
│       ├── catalogue-db/
│       │   ├── catalogue-db.yaml
│       │   └── catalogue-image.yaml
│       ├── frontend/
│       │   ├── frontend-image.yaml
│       │   └── frontend-values.yaml
│       ├── recommendation/
│       │   ├── recommendation-image.yaml
│       │   └── recommendation.yaml
│       └── voting/
│           ├── voting-image.yaml
│           └── voting.yaml
├── kargo/                 # Kargo promotion configuration
│   ├── kargo.yaml         # ArgoCD application for Kargo installation
│   ├── kustomization.yaml # Kustomize configuration
│   ├── project.yaml       # Kargo project definition
│   ├── projectconfig.yaml # Project-wide promotion policies
│   ├── promotion-tasks.yaml # Promotion workflow definitions
│   ├── README.md          # Documentation for Kargo setup
│   ├── stages.yaml        # Environment stage definitions
│   └── warehouse.yaml     # Container image monitoring
└── service-charts/        # Helm charts for each microservice
    ├── catalogue/         # Catalogue service Helm chart
    │   ├── templates/
    │   │   ├── _helpers.tpl
    │   │   ├── deployment.yaml
    │   │   └── service.yaml
    │   ├── Chart.yaml
    │   └── values.yaml
    ├── catalogue-db/      # Catalogue database Helm chart
    │   ├── templates/
    │   │   ├── _helpers.tpl
    │   │   ├── deployment.yaml
    │   │   └── service.yaml
    │   ├── Chart.yaml
    │   └── values.yaml
    ├── common/            # Common chart dependencies
    ├── frontend/          # Frontend service Helm chart
    │   ├── templates/
    │   │   ├── _helpers.tpl
    │   │   ├── deployment.yaml
    │   │   └── service.yaml
    │   ├── Chart.yaml
    │   └── values.yaml
    ├── recommendation/    # Recommendation service Helm chart
    │   ├── templates/
    │   │   ├── _helpers.tpl
    │   │   ├── deployment.yaml
    │   │   └── service.yaml
    │   ├── Chart.yaml
    │   └── values.yaml
    ├── voting/            # Voting service Helm chart
    │   ├── templates/
    │   │   ├── _helpers.tpl
    │   │   ├── deployment.yaml
    │   │   └── service.yaml
    │   ├── Chart.yaml
    │   └── values.yaml
    └── Chart.yaml         # Parent chart definition
```

## Directory Structure Overview

### ArgoCD Configuration (`/argocd`)
Contains all ArgoCD application definitions organized by environment (dev, staging, prod) and the ArgoCD project definition.

### Environment-Specific Values (`/env`)
Stores environment-specific configuration values for each microservice, separated by environment and service.

### Kargo Promotion Configuration (`/kargo`)
Contains all Kargo-related configurations for implementing the GitOps promotion strategy.

### Service Helm Charts (`/service-charts`)
Contains the Helm charts for each microservice with their templates and default values.