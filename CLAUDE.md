# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a sandbox project for experimenting with Redis, featuring a FastAPI-based inventory management system that uses Redis as its data store. The application demonstrates Redis hash operations, ID generation, and item quantity management.

## Development Environment

The project supports two development approaches:

### 1. Dev Container (Primary Method)
- Uses VS Code Dev Containers with Ubuntu 22.04 base
- Redis server runs automatically via entrypoint script
- Configuration: `.devcontainer/devcontainer.json` and `Dockerfile`
- Non-root user: `devuser` (uid 1000)
- Redis config: `/workspace/redis.conf`
- Redis data: `/workspace/data`

### 2. Local Development with Miniconda
- Python 3.11 environment managed by Conda
- Environment name: `sandbox-redis`
- Activate with: `source activate-env.sh` (must be sourced, not executed)
- Dependencies defined in `environment.yml`

## Running the Application

### Start the FastAPI Server
```bash
# From activated conda environment
fastapi dev main.py
```

The server runs on the default FastAPI development port (typically 8000).

### Redis Connection
- Host: `0.0.0.0`
- Port: `6379`
- Database: `0`

The Redis client is initialized in main.py:12 with `decode_responses=True` for automatic string conversion.

## Application Architecture

### Data Model (main.py:5-8)
The application uses a single `ItemPayload` model with:
- `item_id`: Integer (auto-generated)
- `item_name`: String
- `quantity`: Integer

### Redis Data Structure

The application uses two key patterns:

1. **Item Storage** - Redis hashes: `item_id:{id}`
   - Fields: `item_id`, `item_name`, `quantity`
   - Accessed via: `HGET`, `HSET`, `HGETALL`, `HINCRBY`, `DELETE`

2. **Name-to-ID Index** - Redis hash: `item_name_to_id`
   - Maps item names to their IDs
   - Used for name-based lookups and duplicate detection
   - Must be kept in sync with item deletions

3. **ID Generation** - Redis counter: `item_ids`
   - Atomically incremented via `INCR` for new items

### API Endpoints

- `POST /items/{item_name}/{quantity}` - Add item or increment quantity (main.py:15)
- `GET /items/{item_id}` - Get item by ID (main.py:46)
- `GET /items` - List all items (main.py:54)
- `DELETE /items/{item_id}` - Delete entire item (main.py:84)
- `DELETE /items/{item_id}/{quantity}` - Remove quantity, delete if ≤0 (main.py:96)

### Key Implementation Details

- Adding an existing item (by name) increments its quantity rather than creating a duplicate (main.py:21-25)
- Deletion operations must clean up both `item_id:{id}` and the `item_name_to_id` mapping (main.py:90-91)
- Quantity removal automatically deletes items when quantity reaches zero (main.py:108-112)
- All Redis hash values are stored as strings and must be type-converted when retrieved

## Important Notes

- README.md must be kept up to date with any significant project changes
- The Redis server starts automatically in the dev container via entrypoint.sh
- The application expects Redis to already be running before startup
- No authentication is configured for Redis in this sandbox environment
