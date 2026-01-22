<div align="center">
  <img src="logo.png" alt="sandbox-redis" width="512"/>

  **🗄️ FastAPI inventory management system using Redis as the data store**

</div>

## Overview

A sandbox project for experimenting with Redis, featuring a FastAPI-based inventory management system. Demonstrates Redis hash operations, ID generation, and item quantity management.

## Features

- **CRUD operations** - Create, read, update, delete items
- **Quantity tracking** - Add/remove quantities from items
- **Name-based lookup** - Find items by name
- **Auto-increment IDs** - Atomic ID generation with Redis
- **DevContainer support** - Ready-to-use containerized environment

## Quick Start

### Using DevContainer (Recommended)

1. Open in VS Code with DevContainer extension
2. Redis starts automatically
3. Run the API:
```bash
fastapi dev main.py
```

### Using Conda

```bash
# Activate environment
source activate-env.sh

# Start FastAPI server
fastapi dev main.py
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/items/{name}/{qty}` | Add item or increment quantity |
| `GET` | `/items/{id}` | Get item by ID |
| `GET` | `/items` | List all items |
| `DELETE` | `/items/{id}` | Delete item |
| `DELETE` | `/items/{id}/{qty}` | Remove quantity |

## Redis Data Structure

```
item_id:{id}      # Hash: item_id, item_name, quantity
item_name_to_id   # Hash: maps names to IDs
item_ids          # Counter: auto-increment ID
```

## Requirements

- Python 3.11
- Redis server
- Conda (for local development)

## License

MIT
