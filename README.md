# sandbox-redis

A development container setup for experimenting with Redis.

## Setup

1. Install [VS Code](https://code.visualstudio.com/) and the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension
2. Clone this repository
3. Open in VS Code and click "Reopen in Container" when prompted

## Features

- Redis server (6379)
- Redis CLI tools
- Redis VS Code extension for GUI management

## Basic Redis Commands

```bash
# Start Redis CLI
redis-cli

# Basic operations
SET key value
GET key
DEL key
EXISTS key

# List operations
LPUSH mylist value
RPUSH mylist value
LRANGE mylist 0 -1

# Set operations
SADD myset value
SMEMBERS myset

# Hash operations
HSET user:1 name "John" age "30"
HGETALL user:1
```

## Configuration

Redis configuration file is located at `/workspace/redis.conf`.
