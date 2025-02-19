# Use Debian slim as the base image
FROM --platform=linux/amd64 debian:bookworm-slim

# Install dependencies and awscli
RUN apt-get update && \
    apt-get install -y \
    gnupg \
    curl \
    unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws/

# Verify installation
RUN aws --version && \
    gpg --version

# Default command (optional)
CMD ["bash"]
