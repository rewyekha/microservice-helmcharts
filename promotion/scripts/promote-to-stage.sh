#!/bin/bash
# Script to promote images from dev to staging environment

set -e

# Get the service name from the first argument
SERVICE_NAME=$1
if [ -z "$SERVICE_NAME" ]; then
  echo "Error: Service name is required"
  echo "Usage: $0 <service-name>"
  exit 1
fi

# Get the current image tag from dev environment
DEV_IMAGE_FILE="env/dev/${SERVICE_NAME}/${SERVICE_NAME}-image.yaml"
if [ ! -f "$DEV_IMAGE_FILE" ]; then
  echo "Error: Dev image file not found: $DEV_IMAGE_FILE"
  exit 1
fi

# Extract image details
REPO=$(grep "repository:" "$DEV_IMAGE_FILE" | awk '{print $2}')
TAG=$(grep "tag:" "$DEV_IMAGE_FILE" | awk '{print $2}' | tr -d '"')

echo "Promoting $SERVICE_NAME from dev to staging with image $REPO:$TAG"

# Ensure staging directory exists
mkdir -p "env/stage/${SERVICE_NAME}"

# Update the staging image file
STAGE_IMAGE_FILE="env/stage/${SERVICE_NAME}/${SERVICE_NAME}-image.yaml"
cat > "$STAGE_IMAGE_FILE" << EOF
image:
  repository: $REPO
  tag: "$TAG"
EOF

# Copy the service config file if it doesn't exist
DEV_CONFIG_FILE="env/dev/${SERVICE_NAME}/${SERVICE_NAME}.yaml"
STAGE_CONFIG_FILE="env/stage/${SERVICE_NAME}/${SERVICE_NAME}.yaml"

if [ -f "$DEV_CONFIG_FILE" ] && [ ! -f "$STAGE_CONFIG_FILE" ]; then
  cp "$DEV_CONFIG_FILE" "$STAGE_CONFIG_FILE"
fi

echo "Successfully promoted $SERVICE_NAME to staging environment"