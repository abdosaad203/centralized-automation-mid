#!/bin/sh
set -e

echo "Logging in to registry..."
echo "$INPUT_PASSWORD" | docker login $INPUT_REGISTRY \
  -u "$INPUT_USERNAME" --password-stdin

IMAGE="$INPUT_REGISTRY/$INPUT_IMAGE_NAME:$INPUT_TAG"

echo "Building Docker image..."
docker build -t $IMAGE .

echo "Pushing Docker image..."
docker push $IMAGE

echo "image_name=$IMAGE" >> $GITHUB_OUTPUT
