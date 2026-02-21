#!/usr/bin/env bash
set -e

APP_NAME="bronew"
IMAGE="ghcr.io/joecelaster/bronew:latest"
PORT="3000"

echo "🚀 Deploying $APP_NAME..."

# Pull latest image
docker pull "$IMAGE"

# Save current image as previous (best-effort)
docker tag "$IMAGE" bronew:previous || true

# Stop and remove existing container (if any)
docker stop "$APP_NAME" || true
docker rm "$APP_NAME" || true

# Run the new container
docker run -d \
  --name "$APP_NAME" \
  -p "$PORT:$PORT" \
  "$IMAGE"

# Wait a bit and show logs
sleep 5
echo "📜 Container logs:"
docker logs "$APP_NAME" || true

echo "✅ New version started for $APP_NAME"