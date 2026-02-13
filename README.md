# Best Practices for Your Confirmatory Factor Analysis: A JASP and lavaan Tutorial

[![Cite BRM Article](https://img.shields.io/badge/Cite%20BRM%20Article-PDF-red)](https://link.springer.com/article/10.3758/s13428-024-02375-7) [![GitHub Pages](https://img.shields.io/github/deployments/phdpablo/cfa-brm/github-pages?label=GitHub%20Pages)](https://phdpablo.github.io/cfa-brm/) [![OSF](https://img.shields.io/badge/OSF-10.17605/OSF.IO/CV8WB-blue)](https://osf.io/cv8wb/) [![License](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/) [![R version](https://img.shields.io/badge/R-4.5.2-orange)](https://www.r-project.org/) [![Quarto](https://img.shields.io/badge/Quarto-1.8.25-orange)](https://quarto.org/) [![Docker](https://img.shields.io/badge/Docker-4.60.1-orange)](https://www.docker.com/) [![renv](https://img.shields.io/badge/renv-1.1.7-orange)](https://rstudio.github.io/renv/)

## 📖 About

This repository contains the **complete reproducible materials** for the tutorial "Best Practices for Your Confirmatory Factor Analysis: A JASP and lavaan Tutorial" published in *Behavior Research Methods* (2024).

The tutorial provides a comprehensive guide for conducting Confirmatory Factor Analysis (CFA) with ordinal data in applied social sciences, demonstrating best practices using JASP and lavaan/R.

### Key Features

- ✅ **Six-step methodology** for conducting CFA in applied social sciences
- ✅ **Reproducible document** using Quarto with embedded R code
- ✅ **Pre-rendered website** in `docs/` folder (no need to wait for simulations)
- ✅ **JASP files** for point-and-click analysis
- ✅ **Docker environment** for computational reproducibility verification

## 🔗 Access the Materials

| Resource | Description | Link |
| :-- | :-- | :-- |
| **📄 Published Article** | Original paper in *Behavior Research Methods* | [doi.org/10.3758/s13428-024-02375-7](https://doi.org/10.3758/s13428-024-02375-7) |
| **🌐 Tutorial Website** | Pre-rendered complete tutorial | [phdpablo.github.io/cfa-brm](https://phdpablo.github.io/cfa-brm/) |
| **📦 OSF Project** | Supplementary materials | [osf.io/cv8wb](https://osf.io/cv8wb/) |
| **📊 Dataset** | WHOQOL-BREF data (n=1,047) | [Mendeley Data](https://data.mendeley.com/datasets/rdky78bk8r/2) |
| **🎯 Interactive Showcase** | Visual summary | [phdpablo.github.io/cfa-brm-showcase](https://phdpablo.github.io/cfa-brm-showcase/) |
| **🎬 Video Overview** | YouTube Overview | [youtu.be/QFzbf4KNNuE](https://youtu.be/QFzbf4KNNuE) |

## 📁 Repository Structure

```

cfa-brm/
├── index.qmd              \# Complete tutorial document with embedded code
├── _quarto.yml            \# Quarto project configuration
├── docs/                  \# Pre-rendered website (GitHub Pages)
├── jasp/                  \# JASP analysis files
├── docker/                \# Docker configuration for reproducibility
├── renv.lock              \# R package versions
├── .Rprofile              \# renv activation
└── references.bib         \# Bibliography

```

## 🚀 Quick Start

### Option 1: View Pre-Rendered Website (Fastest)

Simply visit the deployed website - no installation needed:

**[https://phdpablo.github.io/cfa-brm/](https://phdpablo.github.io/cfa-brm/)**

The `docs/` folder contains the complete pre-rendered tutorial, including all time-intensive simulations.

### Option 2: Local Rendering

**Prerequisites**: R 4.5.2+, RStudio, Quarto 1.8+

```bash
# Clone repository
git clone https://github.com/phdpablo/cfa-brm.git
cd cfa-brm

# Restore R packages
R -e "renv::restore()"

# Render tutorial (⚠️ 60-90 minutes due to simulations)
quarto render
```


### Option 3: Docker (Reproducibility Verification)

**Prerequisites**: Docker Desktop

```bash
cd docker
./start.sh         # macOS/Linux
start.bat          # Windows
```

Access RStudio Server at `http://127.0.0.1:8787` (no password).

See [`docker/README.md`](docker/README.md) for details.

### Option 4: JASP (Point-and-Click)

1. Download JASP from [jasp-stats.org](https://jasp-stats.org/)
2. Open files in `jasp/` folder
3. Explore analyses via graphical interface

#### ⚠️ Reproducibility Warning

**These analyses were developed in JASP v0.17.1**. For full reproducibility, use [JASP v0.17.1](https://github.com/jasp-stats/jasp-desktop/releases/tag/v0.17.1)

## 🔬 Why Pre-Rendered?

The `docs/` folder contains pre-rendered outputs because:

- ⏱️ **DFI calculation**: ~20-30 minutes
- ⏱️ **Power analysis**: ~30-40 minutes
- ✅ **Immediate access**: No waiting for simulations
- 🔄 **GitHub Pages**: Deployed from `docs/` on `main` branch


## 📄 Citation

Rogers, P. (2024). Best practices for your confirmatory factor analysis: A JASP and lavaan tutorial. *Behavior Research Methods*, *56*(6), 6634–6654. https://doi.org/10.3758/s13428-024-02375-7

**BibTeX:**

```bibtex
@article{rogers2024,
  title = {Best Practices for Your Confirmatory Factor Analysis: {A JASP} and Lavaan Tutorial},
  author = {Rogers, Pablo},
  year = {2024},
  journal = {Behavior Research Methods},
  volume = {56},
  number = {6},
  pages = {6634--6654},
  doi = {10.3758/s13428-024-02375-7}
}
```

## 🔧 Technical Details

**Software**: R 4.5.2 | Quarto 1.8.25 | Docker 4.60.1 | renv 1.1.7

**Key packages**: lavaan, semTools, dynamic, simsem, semPlot

**Docker image**: `phdpablo/cfa-brm:4.5.2`

## 📧 Contact

**Pablo Rogers, Ph.D.**
Universidade Federal de Uberlândia (UFU)
📧 pablorogers@ufu.br
🌐 [ORCID: 0000-0002-0093-3834](https://orcid.org/0000-0002-0093-3834)

## 📜 License

[Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)](https://creativecommons.org/licenses/by-nc/4.0/)