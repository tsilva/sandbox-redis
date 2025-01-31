#!/bin/bash
set -e

echo "Starting Redis server..."
exec redis-server /workspace/redis.conf
