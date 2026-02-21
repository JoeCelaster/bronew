#!/usr/bin/env bash
set -e

APP_NAME="bronew"
IMAGE="ghcr.io/joecelaster/bronew:latest"
PORT="3000"

echo "🚀 Deploying $APP_NAME..."

docker pull "$IMAGE"

docker stop "$APP_NAME" || true
docker rm "$APP_NAME" || true

echo "▶️ Starting container..."
docker run -d \
  --name "$APP_NAME" \
  -p "$PORT:$PORT" \
  "$IMAGE"

echo "⏳ Waiting 5s for container..."
sleep 5

echo "📦 Docker ps:"
docker ps -a

echo "📜 Container logs:"
docker logs "$APP_NAME" || true

echo "✅ Deploy step finished"