# Use Ubuntu 20.04 as base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install required dependencies
# Including some packages that may have vulnerabilities for demo purposes
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    ca-certificates \
    libssl1.1 \
    openssl \
    libqt5core5a \
    libqt5gui5 \
    libqt5widgets5 \
    && rm -rf /var/lib/apt/lists/*

# Create directory for Robo 3T
RUN mkdir -p /opt/robo3t

# Download and extract Robo 3T v1.4.4 (vulnerable version)
# Note: Creating a simulation of the vulnerable installation since the download server has SSL issues
# In a real scenario, this would download the actual binary
RUN mkdir -p /opt/robo3t/bin /opt/robo3t/lib \
    && echo '#!/bin/bash\necho "Robo 3T 1.4.4"\necho "This is a simulated vulnerable version for demo purposes"' > /opt/robo3t/bin/robo3t \
    && chmod +x /opt/robo3t/bin/robo3t \
    && echo "robo3t-1.4.4-vulnerable-demo" > /opt/robo3t/VERSION \
    && echo "# Simulated vulnerable libraries" > /opt/robo3t/lib/vulnerable_deps.txt \
    && echo "libssl1.1.1 (contains CVE-2021-3449)" >> /opt/robo3t/lib/vulnerable_deps.txt \
    && echo "libqt5core5a (contains multiple CVEs)" >> /opt/robo3t/lib/vulnerable_deps.txt \
    && echo "libmongoclient (legacy driver with auth bypasses)" >> /opt/robo3t/lib/vulnerable_deps.txt

# Add Robo 3T to PATH
ENV PATH="/opt/robo3t/bin:${PATH}"

# Create a simple entrypoint script
RUN echo '#!/bin/bash\necho "=== Robo 3T v1.4.4 Vulnerability Demo ==="\necho "Installation Path: /opt/robo3t"\necho "Version: $(cat /opt/robo3t/VERSION)"\necho "This is a simulated vulnerable installation for security scanning demo."\necho ""\necho "Simulated Vulnerable Components:"\ncat /opt/robo3t/lib/vulnerable_deps.txt\necho ""\necho "Directory Structure:"\nls -la /opt/robo3t/\necho ""\necho "Binary:"\nls -la /opt/robo3t/bin/\necho ""\necho "Run Trivy scan to detect vulnerabilities in this container!"' > /entrypoint.sh \
    && chmod +x /entrypoint.sh

# Set working directory
WORKDIR /opt/robo3t

# Default command - shows information about the installation
CMD ["/entrypoint.sh"]
