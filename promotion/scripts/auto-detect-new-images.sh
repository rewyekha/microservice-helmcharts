#!/bin/bash
# Script to automatically detect new images in ECR and update dev environment

set -e

# List of services to check
SERVICES=("catalogue" "catalogue-db" "frontend" "recommendation" "voting")

for SERVICE in "${SERVICES[@]}"; do
  echo "Checking for new images for $SERVICE..."
  
  # Get the current image details from dev environment
  DEV_IMAGE_FILE="env/dev/${SERVICE}/${SERVICE}-image.yaml"
  
  if [ ! -f "$DEV_IMAGE_FILE" ]; then
    echo "Warning: Dev image file not found for $SERVICE, skipping"
    continue
  fi
  
  # Extract current repository and tag
  REPO=$(grep "repository:" "$DEV_IMAGE_FILE" | awk '{print $2}')
  CURRENT_TAG=$(grep "tag:" "$DEV_IMAGE_FILE" | awk '{print $2}' | tr -d '"')
  
  # Get the latest tag from ECR
  REPO_NAME=$(echo $REPO | cut -d'/' -f2-)
  echo "Querying ECR for repository: $REPO_NAME"
  
  # Get the latest semantic version tag from ECR
  LATEST_TAG=$(aws ecr describe-images \
    --repository-name $REPO_NAME \
    --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags[0]' \
    --output text)
  
  if [ "$LATEST_TAG" == "None" ] || [ -z "$LATEST_TAG" ]; then
    echo "No tags found for $REPO_NAME, skipping"
    continue
  fi
  
  echo "Current tag: $CURRENT_TAG, Latest tag: $LATEST_TAG"
  
  # Compare versions (simple string comparison for now)
  if [ "$CURRENT_TAG" != "$LATEST_TAG" ]; then
    echo "New version detected for $SERVICE: $LATEST_TAG"
    
    # Update the image file with the new tag
    sed -i "s/tag: \"$CURRENT_TAG\"/tag: \"$LATEST_TAG\"/" "$DEV_IMAGE_FILE"
    echo "Updated $DEV_IMAGE_FILE with new tag: $LATEST_TAG"
    
    # Trigger the promotion to staging workflow if auto-promotion is enabled
    # This is commented out as it requires additional setup
    # gh workflow run github-workflow.yml -f service=$SERVICE -f environment=stage -f auto_approve=true
  else
    echo "No new version available for $SERVICE"
  fi
done