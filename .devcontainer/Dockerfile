FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    git \
    ca-certificates \
    nano \
    redis-server \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p $CONDA_DIR \
    && rm -rf /tmp/miniconda.sh \
    && $CONDA_DIR/bin/conda clean -afy

# Create a non-root user
RUN groupadd --gid 1000 devuser \
    && useradd --uid 1000 --gid devuser --shell /bin/bash --create-home devuser \
    && mkdir -p /workspace/data \
    && chown -R devuser:devuser /workspace

# Copy Redis configuration and Entrypoint script
COPY --chown=devuser:devuser redis.conf /workspace/redis.conf
COPY --chown=devuser:devuser entrypoint.sh /workspace/entrypoint.sh

# Ensure Entrypoint script is executable
RUN chmod +x /workspace/entrypoint.sh

# Switch to the non-root user
USER devuser
WORKDIR /workspace

# Ensure conda is initialized for the user
RUN /opt/conda/bin/conda init bash

# Expose Redis port
EXPOSE 6379

# Set shell and entrypoint
ENV SHELL=/bin/bash
ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD ["sleep", "infinity"]
