#!/bin/bash
# Script to promote images from staging to production environment

set -e

# Get the service name from the first argument
SERVICE_NAME=$1
if [ -z "$SERVICE_NAME" ]; then
  echo "Error: Service name is required"
  echo "Usage: $0 <service-name>"
  exit 1
fi

# Get the current image tag from staging environment
STAGE_IMAGE_FILE="env/stage/${SERVICE_NAME}/${SERVICE_NAME}-image.yaml"
if [ ! -f "$STAGE_IMAGE_FILE" ]; then
  echo "Error: Staging image file not found: $STAGE_IMAGE_FILE"
  exit 1
fi

# Extract image details
REPO=$(grep "repository:" "$STAGE_IMAGE_FILE" | awk '{print $2}')
TAG=$(grep "tag:" "$STAGE_IMAGE_FILE" | awk '{print $2}' | tr -d '"')

echo "Promoting $SERVICE_NAME from staging to production with image $REPO:$TAG"

# Ensure production directory exists
mkdir -p "env/prod/${SERVICE_NAME}"

# Update the production image file
PROD_IMAGE_FILE="env/prod/${SERVICE_NAME}/${SERVICE_NAME}-image.yaml"
cat > "$PROD_IMAGE_FILE" << EOF
image:
  repository: $REPO
  tag: "$TAG"
EOF

# Copy the service config file if it doesn't exist
STAGE_CONFIG_FILE="env/stage/${SERVICE_NAME}/${SERVICE_NAME}.yaml"
PROD_CONFIG_FILE="env/prod/${SERVICE_NAME}/${SERVICE_NAME}.yaml"

if [ -f "$STAGE_CONFIG_FILE" ] && [ ! -f "$PROD_CONFIG_FILE" ]; then
  cp "$STAGE_CONFIG_FILE" "$PROD_CONFIG_FILE"
fi

echo "Successfully promoted $SERVICE_NAME to production environment"