# Craftista Microservices Helm Charts

A comprehensive GitOps-based solution for deploying and promoting microservices across environments using Helm charts, ArgoCD, and Kargo.

## Overview

This repository contains Helm charts and GitOps configurations for the Craftista microservices platform. It implements a complete deployment pipeline with:

- **Helm Charts**: Templated Kubernetes manifests for each microservice
- **ArgoCD**: Continuous deployment from Git to Kubernetes
- **Kargo**: Automated promotion workflows between environments

## Repository Structure

```
microservice-helmcharts/
├── argocd/                # ArgoCD application manifests
├── env/                   # Environment-specific configurations
├── kargo/                 # Kargo promotion configuration
└── service-charts/        # Helm charts for each microservice
```

For a detailed breakdown of the repository structure, see [repository-structure.md](argocd/repository-structure.md).

## Microservices

The Craftista platform consists of the following microservices:

- **Frontend**: User interface service
- **Catalogue**: Product catalog service
- **Catalogue-DB**: Database for product information
- **Recommendation**: Service for personalized product recommendations
- **Voting**: Service for user ratings and reviews

## Deployment Guide

### Prerequisites

- Kubernetes cluster
- ArgoCD installed on the cluster
- Kargo installed (optional, for automated promotions)
- `kubectl` CLI tool
- Git access to this repository

### Quick Start

1. **Create the ArgoCD Project**:
   ```bash
   kubectl apply -f argocd/application/craftista-project.yaml
   ```

2. **Deploy to Development**:
   ```bash
   kubectl apply -f argocd/application/dev/
   ```

3. **Deploy to Staging**:
   ```bash
   kubectl apply -f argocd/application/staging/
   ```

4. **Deploy to Production**:
   ```bash
   kubectl apply -f argocd/application/prod/
   ```

5. **Set Up Kargo** (optional):
   ```bash
   kubectl apply -k kargo/
   ```

For a detailed deployment guide, see [deployment-guide-blog.md](argocd/deployment-guide-blog.md).

## GitOps Workflow

Our GitOps workflow follows these principles:

1. **Git as Single Source of Truth**: All configuration is stored in this repository
2. **Declarative Configuration**: Desired state is declared in YAML files
3. **Automated Synchronization**: ArgoCD ensures the cluster state matches Git
4. **Environment Promotion**: Changes flow from dev → staging → production

## Environment Configuration

Environment-specific configurations are stored in the `/env` directory:

- **Development**: Uses latest images for rapid iteration
- **Staging**: Uses specific image versions for testing
- **Production**: Uses stable, tested image versions

## Promotion Strategy

We use Kargo to implement a promotion strategy:

1. **Development**: Automatic deployment of new images
2. **Staging**: Automated promotion after successful verification in dev
3. **Production**: Manual approval required before promotion

## Documentation

- [Repository Structure](argocd/repository-structure.md)
- [Deployment Guide](argocd/deployment-guide-blog.md)
- [ArgoCD Implementation](argocd/blog-post.md)
- [Kargo Setup](kargo/README.md)

## Usage Examples

### Manually Promote to Production

```bash
kubectl kargo promote frontend-freight --stage frontend-staging-stage --to-stage frontend-prod-stage -n craftista
```

### View Deployment Status

```bash
kubectl get applications -n argocd
```

### Monitor Promotions

```bash
kubectl get promotions -n craftista
```

## CI/CD Pipeline

This repository includes a GitHub Actions workflow for building and pushing Docker images to Docker Hub:

- **Repository**: nitheesh86/microservice-frontend
- **Versioning**: Semantic versioning based on commit messages
  - `feat:` - Minor version bump
  - `fix:` - Patch version bump
  - `BREAKING CHANGE` or `!:` - Major version bump

### Setup Requirements

1. Add a Docker Hub token as a GitHub secret named `DOCKER_HUB_TOKEN`

2. Customize the workflow in `.github/workflows/docker-ci.yml` for additional microservices

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.