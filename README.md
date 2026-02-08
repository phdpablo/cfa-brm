# Best practices for your confirmatory factor analysis: A JASP and lavaan tutorial

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/phdpablo/cfa-brm/main) [![Cite BRM Article](https://img.shields.io/badge/Cite%20BRM%20Article-PDF-red)](https://link.springer.com/article/10.3758/s13428-024-02375-7) [![GitHub Pages](https://img.shields.io/github/deployments/phdpablo/cfa-brm/github-pages?label=GitHub%20Pages)](https://phdpablo.github.io/cfa-brm/) [![OSF](https://img.shields.io/badge/OSF-10.17605/OSF.IO/CV8WB-blue)](https://osf.io/cv8wb/)  [![License](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/) [![R version](https://img.shields.io/badge/R-4.4.2-orange)](https://www.r-project.org/) [![Quarto](https://img.shields.io/badge/Quarto-1.6.42-orange)](https://quarto.org/) [![Docker](https://img.shields.io/badge/Docker-4.45.0-orange)](https://www.docker.com/) [![renv](https://img.shields.io/badge/renv-1.0.7-orange)](https://rstudio.github.io/renv/)

## How to reproduce

### Prerequisites

- [R](https://www.r-project.org/) ≥ 4.4.2
- [Quarto](https://quarto.org/) ≥ 1.6
- [renv](https://rstudio.github.io/renv/) (installed automatically on first run)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/phdpablo/cfa-brm.git
cd cfa-brm

# 2. Restore the R package environment
Rscript -e 'renv::restore()'

# 3. Render the manuscript
quarto render
```

The rendered output will be placed in the `docs/` directory. The WHOQOL dataset
is downloaded automatically from [Mendeley Data](https://data.mendeley.com/datasets/rdky78bk8r/2)
on first run and cached locally in `data/`.

### Project structure

```
cfa-brm/
├── index.qmd          # Main manuscript (Quarto Markdown)
├── _quarto.yml        # Quarto project configuration
├── R/                 # Modular R helper functions
│   ├── utils-data.R   #   Data loading, caching, and validation
│   ├── utils-models.R #   CFA model specifications (lavaan syntax)
│   └── utils-fit.R    #   Fit extraction and model comparison
├── data/              # Local data cache (auto-populated, git-ignored)
├── renv.lock          # Locked R package versions for reproducibility
├── renv/              # renv infrastructure
├── jasp/              # JASP analysis files
├── docker/            # Docker setup for containerized execution
├── .binder/           # Binder configuration
├── references.bib     # BibTeX references
└── apa7ed.csl         # APA 7th edition citation style
```

### Alternative: Docker

See `docker/README.md` for instructions on running the analysis in a container.

### Alternative: Binder

Click the Binder badge above to launch the project in a cloud environment.

## Citation

If you use this template, please cite it as:

Rogers, P. Best practices for your confirmatory factor analysis: A JASP and lavaan tutorial. Behav Res 56, 6634–6654 (2024). <https://doi.org/10.3758/s13428-024-02375-7>

**BibTex:**

``` r
@article{rogers2024c,
  title = {Best Practices for Your Confirmatory Factor Analysis: {{A JASP}} and Lavaan Tutorial},
  shorttitle = {Best Practices for Your Confirmatory Factor Analysis},
  author = {Rogers, Pablo},
  date = {2024-03-13},
  journaltitle = {Behavior Research Methods},
  shortjournal = {Behav Res},
  issn = {1554-3528},
  doi = {10.3758/s13428-024-02375-7},
  url = {https://link.springer.com/10.3758/s13428-024-02375-7},
  urldate = {2024-03-14},
  langid = {english},
  keywords = {ProjetoOS},
  file = {C:\Users\pablo\OneDrive\Zotero\CFA\Rogers_2024_Best practices for your confirmatory factor analys.pdf}
}
```

## License

This project is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License - see the [LICENSE](LICENSE) file for details.