# Use Debian slim as the base image
FROM --platform=linux/amd64 debian:bookworm-slim

# Install dependencies and awscli
RUN apt-get update && \
    apt-get install -y \
    gnupg \
    curl \
    convmv \
    p7zip-full \
    unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&\
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# Create a non-root user and home directory
RUN useradd -m -s /bin/bash paperless-backup

RUN id -u backup

# Verify installation
RUN aws --version && \
    gpg --version && \
    kubectl version --client

# Default command (optional)
CMD ["bash"]
