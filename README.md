# Robo 3T Vulnerability Scanning Demo

This project demonstrates a DevSecOps use case where an outdated GUI application (Robo 3T v1.4.4) is containerized and automatically scanned for vulnerabilities using Trivy in a CI/CD pipeline.

## 🎯 Project Purpose

This repository serves as a **security demonstration** showing how container vulnerability scanning can detect outdated software components. The project intentionally uses **Robo 3T version 1.4.4**, which is deprecated and likely contains security vulnerabilities.

## ⚠️ Important Notice

- **Robo 3T v1.4.4 is outdated and deprecated** - it may contain known security vulnerabilities
- This project is for **educational and security testing purposes only**
- The containerized Robo 3T is **not intended to be run as a GUI application**
- Always use the latest versions of software in production environments

## 🏗️ Project Structure

```
robo3T/
├── Dockerfile                    # Container definition with vulnerable Robo 3T v1.4.4
├── .github/workflows/trivy.yml   # GitHub Actions workflow for vulnerability scanning
└── README.md                     # This documentation
```

## 🐳 Container Details

The Docker container:
- Uses **Ubuntu 20.04** as the base image
- Simulates **Robo 3T v1.4.4** installation (due to SSL issues with the original download server)
- Installs vulnerable system packages including Qt libraries and OpenSSL
- Includes mock vulnerable components that represent real-world security risks
- Creates the application structure in `/opt/robo3t`

### Implementation Note
Due to SSL configuration issues with the original Robo 3T download server, this demo creates a simulated installation that represents the same security risks. The container includes:
- Outdated Ubuntu 20.04 packages that may contain vulnerabilities
- Qt libraries (common in GUI applications like Robo 3T)
- OpenSSL libraries (potential SSL/TLS vulnerabilities)
- Mock vulnerable components that simulate real dependencies

This approach still effectively demonstrates vulnerability scanning while avoiding download server issues.

## 🔍 Vulnerability Scanning with Trivy

This project uses [Trivy](https://github.com/aquasecurity/trivy) to automatically detect vulnerabilities in:

1. **The built Docker image** containing Robo 3T v1.4.4
2. **Filesystem components** within the container
3. **Additional third-party images** (Keycloak, Apache NiFi, Istio) for comparison

### GitHub Actions Workflow

The workflow (`./github/workflows/trivy.yml`) automatically:
- 🏗️ Builds the Docker image containing Robo 3T v1.4.4
- 🔍 Runs Trivy scans on multiple targets
- 📊 Displays results in the GitHub Actions summary
- 📎 Uploads scan results as artifacts

### Scan Types Performed

1. **Container Image Scan**: Scans the built `robo3t-vulnerable:latest` image
2. **Filesystem Scan**: Scans project files and dependencies
3. **External Image Scans**: Scans popular container images for reference

## 🚀 Usage

### Local Testing

Build and test the container locally:

```bash
# Build the Docker image
docker build -t robo3t-vulnerable:latest .

# Run the container (shows installation info)
docker run --rm robo3t-vulnerable:latest

# Scan with Trivy (if installed locally)
trivy image robo3t-vulnerable:latest
```

### GitHub Actions

The vulnerability scan runs automatically on:
- Manual trigger (`workflow_dispatch`)
- Push to `main`/`master` branch
- Pull requests to `main`/`master` branch

To manually trigger the scan:
1. Go to the **Actions** tab in your GitHub repository
2. Select the **Trivy Scan** workflow
3. Click **Run workflow**

## 📊 Expected Results

The Trivy scan should detect vulnerabilities in:

- **Ubuntu 20.04 system packages** with known CVEs
- **OpenSSL libraries** (potential SSL/TLS vulnerabilities)  
- **Qt libraries** (GUI framework vulnerabilities)
- **System utilities** and dependencies with security issues

The simulated vulnerable components represent the types of issues commonly found in outdated GUI applications like Robo 3T v1.4.4.

## 🛡️ Security Best Practices Demonstrated

1. **Automated vulnerability scanning** in CI/CD pipelines
2. **Container security** assessment before deployment
3. **Dependency tracking** for third-party applications
4. **Security reporting** and artifact collection
5. **DevSecOps integration** with GitHub Actions

## 📚 Educational Value

This project helps demonstrate:
- How outdated software introduces security risks
- The importance of regular vulnerability scanning
- Integration of security tools in development workflows
- Container security best practices
- Supply chain security awareness

## ⚡ Quick Start

1. Fork or clone this repository
2. Enable GitHub Actions if not already enabled
3. Trigger the Trivy scan workflow manually or push changes
4. Review the vulnerability report in the Actions summary

## 🔗 Related Resources

- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [Robo 3T Official Site](https://robomongo.org/)
- [Container Security Best Practices](https://snyk.io/blog/10-docker-image-security-best-practices/)
- [OWASP Container Security](https://owasp.org/www-project-docker-security/)

---

**Disclaimer**: This project is for educational and security demonstration purposes only. Do not use outdated software in production environments.
