#!/bin/sh
set -e

echo "Login to registry"
echo "$INPUT_PASSWORD" | docker login "$INPUT_REGISTRY" \
  -u "$INPUT_USERNAME" --password-stdin

IMAGE="$INPUT_REGISTRY/$INPUT_IMAGE_NAME:$INPUT_TAG"

echo "Listing frontend directory"
ls -la frontend
ls -la frontend/dist

echo "Build Docker image"
docker build \
  -t "$IMAGE" \
  -f "$GITHUB_ACTION_PATH/Dockerfile.react" \
  frontend

echo "Push image"
docker push "$IMAGE"

echo "image_name=$IMAGE" >> $GITHUB_OUTPUT
