<div align="center">
  <img src="logo.png" alt="sandbox-redis" width="512"/>

  [![Python](https://img.shields.io/badge/Python-3.11-blue.svg)](https://www.python.org/)
  [![FastAPI](https://img.shields.io/badge/FastAPI-latest-009688.svg)](https://fastapi.tiangolo.com/)
  [![Redis](https://img.shields.io/badge/Redis-7.4+-red.svg)](https://redis.io/)
  [![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

  **A FastAPI-based inventory management system powered by Redis for lightning-fast data operations**

  [Quick Start](#quick-start) · [API Reference](#api-endpoints) · [Development](#development-environment)
</div>

## Overview

sandbox-redis is a demonstration project showcasing Redis hash operations with a FastAPI backend. It implements a complete inventory management system with atomic ID generation, name-based lookups, and quantity tracking.

## Features

- **Atomic Operations** - Redis-powered ID generation and quantity updates
- **Duplicate Prevention** - Smart name-to-ID indexing prevents duplicate items
- **Auto-Cleanup** - Items automatically deleted when quantity reaches zero
- **Fast Lookups** - O(1) retrieval by ID or name using Redis hashes

## Quick Start

### Prerequisites

- Python 3.11+
- Redis 7.4+
- Conda (for local development) or Docker (for dev container)

### Installation

```bash
# Clone the repository
git clone https://github.com/tsilva/sandbox-redis.git
cd sandbox-redis

# Activate conda environment
source activate-env.sh

# Start the server
fastapi dev main.py
```

The API will be available at `http://localhost:8000`.

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/items/{item_name}/{quantity}` | Add item or increment quantity |
| `GET` | `/items/{item_id}` | Get item by ID |
| `GET` | `/items` | List all items |
| `DELETE` | `/items/{item_id}` | Delete entire item |
| `DELETE` | `/items/{item_id}/{quantity}` | Remove quantity (auto-deletes if ≤0) |

### Usage Examples

```bash
# Add 10 apples
curl -X POST http://localhost:8000/items/apples/10

# Get item by ID
curl http://localhost:8000/items/1

# List all items
curl http://localhost:8000/items

# Remove 3 apples
curl -X DELETE http://localhost:8000/items/1/3

# Delete item entirely
curl -X DELETE http://localhost:8000/items/1
```

## Development Environment

### Option 1: Dev Container (Recommended)

Open the project in VS Code and select "Reopen in Container". Redis starts automatically.

### Option 2: Local Development with Miniconda

```bash
# Create and activate environment
conda env create -f environment.yml
source activate-env.sh

# Start Redis (must be running before the app)
redis-server

# Start the FastAPI server
fastapi dev main.py
```

### Redis Connection

| Setting | Value |
|---------|-------|
| Host | `0.0.0.0` |
| Port | `6379` |
| Database | `0` |

## Architecture

### Data Model

```python
class ItemPayload(BaseModel):
    item_id: int      # Auto-generated
    item_name: str
    quantity: int
```

### Redis Key Patterns

| Pattern | Type | Purpose |
|---------|------|---------|
| `item_id:{id}` | Hash | Item storage (id, name, quantity) |
| `item_name_to_id` | Hash | Name-to-ID index for lookups |
| `item_ids` | String | Atomic counter for ID generation |

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

## Dependencies

- **fastapi[standard]** - Modern web framework
- **redis** - Python Redis client
- **python-dotenv** - Environment configuration

## License

MIT
