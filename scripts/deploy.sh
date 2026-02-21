#!/usr/bin/env bash
set -e

APP_NAME="bronew"
PORT="3000"

echo "🚀 Deploying $APP_NAME..."

# Save current image as previous (best-effort)
docker tag bronew:latest bronew:previous || true

# Stop and remove existing container (if any)
docker stop "$APP_NAME" || true
docker rm "$APP_NAME" || true

# Run the new container
docker run -d \
  --name "$APP_NAME" \
  -p "$PORT:$PORT" \
  bronew:latest

echo "✅ New version started for $APP_NAME"