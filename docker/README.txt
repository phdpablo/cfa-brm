# Docker Configuration for CFA-BRM Tutorial

This directory contains Docker configuration files to **audit and verify the computational reproducibility** of the "Best Practices for CFA" tutorial.

## 📋 Overview

The Docker image serves as a **reproducibility checkpoint**, containing:

- Pre-built website files (including computationally intensive simulations)
- Complete R package environment (via `renv`)
- All dependencies required to render the tutorial

**Important**: The image was created for **verification purposes**. Due to the time-consuming nature of Monte Carlo simulations in the DFI and power analysis sections, the image also includes pre-rendered outputs (`docs/` folder) in case users do not wish to verify reproducibility by re-rendering the Quarto documents within the container.

## 🎯 Purpose

1. **Audit reproducibility**: Verify that all analyses can be reproduced
2. **Preserve computational environment**: Capture exact package versions and dependencies
3. **Learning**: Allows users to follow the implementation logic of the commands and analysis of the CFA proposed in the article

## 📦 What's Included

The Docker image contains:

- **R environment**: Rocker-based image (R 4.5.2) with RStudio Server, Quarto, and TinyTeX
- **Package versions**: Restored via `renv` during image build
- **Pre-built site**: Complete `docs/` folder with rendered outputs
- **Repository files**: All source files, scripts, and data embedded in the image

## 🚀 Quick Start

### Prerequisites

**Step 1**: Install Docker Desktop

- **Windows/Mac**: Download from [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/)
- **Linux**: Follow instructions at [docs.docker.com/engine/install](https://docs.docker.com/engine/install/)

### Using Helper Scripts (Recommended)

If you're unfamiliar with Docker commands, use the provided scripts:

#### **Start the Container**

```bash
# macOS/Linux
./start.sh

# Windows
start.bat
```

This script will:

- Build/pull the Docker image `phdpablo/cfa-brm:4.5.2` (includes all repository files)
- Start a container named `cfa-brm`
- Open RStudio Server on `http://127.0.0.1:8787`
- **No credentials needed** (authentication disabled)


#### **Stop the Container**

```bash
# macOS/Linux
./stop.sh

# Windows
stop.bat
```

This script will:

- Stop the running container
- **Preserve the container state** (does not delete)
- Allow you to restart later with `./start.sh`

---

### Using Docker Compose Directly

The repository uses `docker-compose.yml` for container orchestration.

#### **1. Start the Container**

From the repository root directory:

```bash
docker-compose -f docker/docker-compose.yml up -d
```

**What this does**:

- Builds the image if not present (using `docker/Dockerfile`)
- Creates container named `cfa-brm`
- Exposes RStudio Server on `http://127.0.0.1:8787`
- Mounts persistent volumes for LaTeX packages and RStudio cache
- Disables authentication (no password required)


#### **2. Access RStudio Server**

Open your browser and navigate to:

```
http://127.0.0.1:8787
```

**No login required** - authentication is disabled via `DISABLE_AUTH=true`

#### **3. Stop the Container**

```bash
docker-compose -f docker/docker-compose.yml stop
```


#### **4. Restart the Container**

```bash
docker-compose -f docker/docker-compose.yml start
```


#### **5. Stop and Remove the Container**

```bash
docker-compose -f docker/docker-compose.yml down
```

**Note**: This preserves the `texlive_data` volume. To remove volumes:

```bash
docker-compose -f docker/docker-compose.yml down -v
```


### Using Docker Commands Directly

If you prefer manual Docker commands:

#### **1. Pull the Image**

```bash
docker pull phdpablo/cfa-brm:4.5.2
```


#### **2. Run the Container**

```bash
docker run -d \
  --name cfa-brm \
  -p 127.0.0.1:8787:8787 \
  -e DISABLE_AUTH=true \
  phdpablo/cfa-brm:4.5.2
```

**Parameters explained**:

- `-d`: Run in detached mode (background)
- `--name cfa-brm`: Container name for easy reference
- `-p 127.0.0.1:8787:8787`: Map port 8787 (localhost only for security)
- `-e DISABLE_AUTH=true`: Disable RStudio authentication

**Note**: The repository files are **already inside the image** - no volume mounting needed for verification.

#### **3. Access RStudio Server**

```
http://127.0.0.1:8787
```

No credentials required.

#### **4. Stop the Container**

```bash
docker stop cfa-brm
```


#### **5. Restart the Container**

```bash
docker start cfa-brm
```


#### **6. Remove the Container**

```bash
docker rm cfa-brm
```


## ✅ Verifying Reproducibility

Once inside RStudio Server:

### **Option 1: Render from Terminal (Recommended)**

1. Click on `Terminal` tab in RStudio (next to Console)
2. You're already in the project directory (`/home/rstudio/`)
3. Render the entire project:
```bash
quarto render
```

This will regenerate all outputs and verify reproducibility.

### **Option 2: Render from RStudio GUI**

1. The project is already open (`cfa-brm.Rproj`)
2. Open the `Build` tab (top-right panel)
3. Click `Render Website`

### **Expected Behavior**

- ✅ **Quick render**: Most files render in seconds/minutes
- ⚠️ **Slow sections**: DFI and power analysis simulations may take 30-60+ minutes
- ✅ **Identical outputs**: The rendered files will replace the pre-compiled `docs/` folder.

## 📊 About the Simulations

The tutorial includes two **computationally intensive Monte Carlo simulations**:

1. **Dynamic Fit Index (DFI) calculation**: ~20-30 minutes
2. **Power analysis for CFA models**: ~30-40 minutes

**Why pre-rendered outputs are included**:

- Full rebuild could take 60-90+ minutes on typical hardware
- Allows quick verification of non-simulation components
- Users can still verify reproducibility by re-rendering


## 📝 Technical Architecture

### **Dockerfile Structure**

The `Dockerfile` uses an optimized build process:

1. **Base image**: `rocker/verse:4.5.2` (R + RStudio + Quarto + TinyTeX)
2. **renv restoration**: Packages restored during build via `renv::restore()`
3. **Package updates**: Updated to ensure rendering compatibility
4. **LaTeX packages**: Additional packages installed via `tinytex::tlmgr_install()`
5. **Repository files**: All source files copied into image
6. **Initialization script**: `init-latex.sh` syncs LaTeX on first start

### **Docker Compose Configuration**

Key features of `docker-compose.yml`:

- **Persistent volumes**:
    - `texlive_data`: Preserves LaTeX packages across container restarts
    - `./cache/.rstudio`: Caches RStudio session data locally
- **No authentication**: `DISABLE_AUTH=true` for easy access
- **Localhost binding**: Port `127.0.0.1:8787` for security
- **Automatic restart**: `restart: unless-stopped` keeps container running
- **Custom entrypoint**: `init-latex.sh` initializes LaTeX before starting RStudio


### **Package Management Strategy**

- **`renv.lock`**: Captures exact package versions from original analysis
- **Restoration**: Packages restored during image build, not at runtime
- **Updates**: Minimal updates applied to prevent rendering failures
- **Verification**: All packages required for analysis are available in the image


### **No External Volumes Needed**

Unlike typical development containers, this image:

- ✅ **Embeds all files**: Repository contents are inside the image
- ✅ **Self-contained**: No external file mounting required for verification
- ✅ **Reproducible**: Same files in every container instance
- ⚠️ **Non-persistent**: Changes inside container are lost on delete (by design)

## 🔍 Troubleshooting

### **Container won't start**

```bash
# Check if port 8787 is already in use
docker ps -a

# Stop conflicting containers
docker stop $(docker ps -q --filter "publish=8787")

# Check Docker logs
docker logs cfa-brm
```


### **Cannot access RStudio Server**

- Verify container is running: `docker ps`
- Check port mapping: Should show `127.0.0.1:8787->8787/tcp`
- Try `http://127.0.0.1:8787` (not `localhost` on some systems)
- Check firewall settings


### **LaTeX/TinyTeX errors during rendering**

The `init-latex.sh` script syncs LaTeX packages on first start. If issues occur:

```r
# Inside RStudio container Terminal
tlmgr update --self --all
```

Or rebuild the image to get fresh LaTeX installation.

### **Package loading errors**

The image should have all packages pre-installed via `renv`. If issues occur:

```r
# Inside RStudio Console
renv::status()
renv::restore()
```

## 📚 Additional Resources

- **Main repository README**: `../README.md`
- **Tutorial website**: [phdpablo.github.io/cfa-brm](https://phdpablo.github.io/cfa-brm/)
- **Published article**: [doi.org/10.3758/s13428-024-02375-7](https://doi.org/10.3758/s13428-024-02375-7)
- **Rocker project**: [rocker-project.org](https://rocker-project.org/)
- **Docker Compose docs**: [docs.docker.com/compose](https://docs.docker.com/compose/)


## 🤝 Contributing

Found an issue with the Docker setup? Please report it in the [main repository issues](https://github.com/phdpablo/cfa-brm/issues).

## 📄 License

This Docker configuration is part of the CFA-BRM project and follows the same license: [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)

---

**Last updated**: February 2026
**Image version**: `phdpablo/cfa-brm:4.5.2`
**Base image**: `rocker/verse:4.5.2`
**R version**: 4.5.2