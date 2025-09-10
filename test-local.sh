#!/bin/bash

# Robo 3T Vulnerability Scanning Demo - Local Test Script

set -e

echo "🚀 Robo 3T Vulnerability Scanning Demo"
echo "========================================"
echo

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

echo "📦 Building Docker image..."
docker build -t robo3t-vulnerable:latest .

echo
echo "🏃 Running container to verify installation..."
docker run --rm robo3t-vulnerable:latest

echo
echo "🔍 Checking if Trivy is installed for local scanning..."
if command -v trivy &> /dev/null; then
    echo "✅ Trivy found! Running vulnerability scan..."
    echo
    echo "📊 Scanning robo3t-vulnerable:latest image..."
    trivy image --severity HIGH,CRITICAL robo3t-vulnerable:latest
else
    echo "⚠️  Trivy not found locally."
    echo "   Install Trivy to run local scans: https://aquasecurity.github.io/trivy/latest/getting-started/installation/"
    echo "   Or check the GitHub Actions workflow for automated scanning."
fi

echo
echo "✅ Local testing completed!"
echo "💡 Push to GitHub to trigger the full Trivy scan workflow."
echo "   Or manually trigger it from the Actions tab in your repository."
