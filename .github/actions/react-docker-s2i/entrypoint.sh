#!/bin/sh
set -e

echo "Login to registry"
echo "$INPUT_PASSWORD" | docker login "$INPUT_REGISTRY" \
  -u "$INPUT_USERNAME" --password-stdin

IMAGE="$INPUT_REGISTRY/$INPUT_IMAGE_NAME:$INPUT_TAG"

echo "Workspace content:"
ls -la /github/workspace
ls -la /github/workspace/frontend
ls -la /github/workspace/frontend/dist

echo "Build Docker image"
docker build \
  -t "$IMAGE" \
  -f "$GITHUB_ACTION_PATH/Dockerfile.react" \
  /github/workspace/frontend

echo "Push Docker image"
docker push "$IMAGE"

echo "image_name=$IMAGE" >> $GITHUB_OUTPUT
