# Use Debian slim as the base image
FROM --platform=linux/amd64 debian:bookworm-slim

# Install dependencies and awscli
RUN apt-get update && \
    apt-get install -y \
    gnupg \
    curl \
    p7zip-full \
    unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws/

# Create a non-root user and home directory
RUN useradd -m -s /bin/bash paperless-backup

RUN id -u backup

# Verify installation
RUN aws --version && \
    gpg --version

# Default command (optional)
CMD ["bash"]
