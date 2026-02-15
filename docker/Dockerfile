# Base image: rocker/verse includes R, Quarto, Pandoc, and TinyTeX
FROM rocker/verse:4.5.2

# Metadata about the image
LABEL maintainer="Pablo Rogers <pablorogers@ufu.br>" \
      version="4.5.2" \
      description="https://doi.org/10.3758/s13428-024-02375-7"

# Set environment variables for renv paths
ENV RENV_PATHS_CACHE=/home/rstudio/renv/cache \
    RENV_PATHS_LIBRARY_ROOT=/home/rstudio/renv/library

WORKDIR /home/rstudio

# Copy renv files for package restoration
COPY --chown=rstudio:rstudio renv.lock .
COPY --chown=rstudio:rstudio .Rprofile .
COPY --chown=rstudio:rstudio renv/activate.R renv/

# Restore R packages during build
USER rstudio
RUN R -s -e "renv::restore()"
USER root

# Copy all project files with correct ownership
COPY --chown=rstudio:rstudio . .

# Set working directory
WORKDIR /home/rstudio

# Fix ownership and permissions of the project directory and contents
RUN chown -R rstudio:rstudio /home/rstudio && \
    find /home/rstudio -type d -exec chmod 755 {} \; && \
    find /home/rstudio -type f -exec chmod 644 {} \;

# Install additional LaTeX packages via tinytex
RUN R -e "tinytex::tlmgr_install(c('unicode-math', 'booktabs', 'caption', 'float', 'pdfcol', 'fontawesome5', 'tcolorbox', 'lualatex-math', 'luatexbase', 'amssymb')); tinytex::tlmgr_update()"

# Copy initialization script for LaTeX sync on first run
COPY init-latex.sh /init-latex.sh
RUN chmod +x /init-latex.sh
