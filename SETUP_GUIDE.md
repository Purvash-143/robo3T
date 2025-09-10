# Quick Setup Guide

## 🚀 Getting Started with Robo 3T Vulnerability Demo

### Prerequisites
- Docker Desktop installed and running
- Git installed
- GitHub account (for CI/CD workflow)

### Option 1: Quick Local Test

```bash
# Clone or download this repository
git clone <your-repo-url>
cd robo3T

# Run the automated test script
./test-local.sh
```

### Option 2: Manual Steps

```bash
# Build the Docker image
docker build -t robo3t-vulnerable:latest .

# Run the container
docker run --rm robo3t-vulnerable:latest

# If you have Trivy installed locally
trivy image --severity HIGH,CRITICAL robo3t-vulnerable:latest
```

### Option 3: Docker Compose

```bash
# Build and run with docker-compose
docker-compose up --build

# Clean up
docker-compose down
```

### GitHub Actions Setup

1. **Push to GitHub**: Upload this project to a GitHub repository
2. **Enable Actions**: Ensure GitHub Actions are enabled in repository settings
3. **Trigger Scan**: 
   - Go to Actions tab → Trivy Scan → Run workflow
   - Or push changes to main/master branch
   - Or create a pull request

### Expected Results

✅ **Container builds successfully**
✅ **Robo 3T v1.4.4 installed in `/opt/robo3t`**
✅ **Trivy detects HIGH and CRITICAL vulnerabilities**
✅ **Scan results available in GitHub Actions summary**

### Troubleshooting

**Docker build fails**:
- Check internet connection (needs to download Robo 3T)
- Verify Docker has sufficient disk space
- Try: `docker system prune -f` to clean up space

**Trivy scan shows no results**:
- This might happen with newer Trivy versions
- The demo still shows the scanning process
- Check the Ubuntu 20.04 base image for vulnerabilities

**GitHub Actions workflow fails**:
- Verify the workflow file syntax
- Check repository permissions
- Ensure Actions are enabled

### Next Steps

- 📊 Analyze the vulnerability reports
- 🛡️ Compare with modern, updated software
- 📚 Learn about container security best practices
- 🔧 Try implementing security improvements

---

**Remember**: This is a security demonstration project. Never use vulnerable software in production!
