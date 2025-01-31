FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    git \
    ca-certificates \
    nano \
    redis-server \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 devuser \
    && useradd --uid 1000 --gid devuser --shell /bin/bash --create-home devuser \
    && mkdir -p /workspace/data \
    && chown -R devuser:devuser /workspace

COPY --chown=devuser:devuser redis.conf /workspace/redis.conf

USER devuser
WORKDIR /workspace

EXPOSE 6379

ENV SHELL=/bin/bash

CMD ["redis-server", "/workspace/redis.conf"]