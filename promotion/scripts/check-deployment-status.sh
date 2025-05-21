#!/bin/bash
# Script to check if a service deployment is healthy in the dev environment

set -e

# Get the service name from the first argument
SERVICE_NAME=$1
if [ -z "$SERVICE_NAME" ]; then
  echo "Error: Service name is required"
  echo "Usage: $0 <service-name>"
  exit 1
fi

# Get the namespace (default to demo)
NAMESPACE=${2:-demo}

echo "Checking deployment status for $SERVICE_NAME in $NAMESPACE namespace"

# Check if deployment exists
kubectl get deployment $SERVICE_NAME -n $NAMESPACE &> /dev/null
if [ $? -ne 0 ]; then
  echo "Deployment $SERVICE_NAME not found in namespace $NAMESPACE"
  exit 1
fi

# Check if deployment is available
AVAILABLE=$(kubectl get deployment $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.status.availableReplicas}')
DESIRED=$(kubectl get deployment $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.status.replicas}')

if [ -z "$AVAILABLE" ] || [ "$AVAILABLE" -lt "$DESIRED" ]; then
  echo "Deployment $SERVICE_NAME is not fully available. Available: $AVAILABLE, Desired: $DESIRED"
  exit 1
fi

# Check if deployment is up-to-date
UPDATED=$(kubectl get deployment $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.status.updatedReplicas}')
if [ "$UPDATED" -lt "$DESIRED" ]; then
  echo "Deployment $SERVICE_NAME is not fully updated. Updated: $UPDATED, Desired: $DESIRED"
  exit 1
fi

# Check if there are any failed pods
FAILED_PODS=$(kubectl get pods -n $NAMESPACE -l app=$SERVICE_NAME -o jsonpath='{.items[?(@.status.phase=="Failed")].metadata.name}')
if [ ! -z "$FAILED_PODS" ]; then
  echo "Failed pods found for $SERVICE_NAME: $FAILED_PODS"
  exit 1
fi

echo "Deployment $SERVICE_NAME is healthy in $NAMESPACE namespace"
exit 0