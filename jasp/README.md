This folder contains detailed technical commentary documents for the confirmatory factor analysis (CFA) of the WHOQOL-BREF scale, serving as supplementary materials for the article:

**Rogers, P. (2024).** Best practices for your confirmatory factor analysis: A JASP and lavaan tutorial. *Behavior Research Methods*. https://doi.org/10.3758/s13428-024-02375-7

**Supplementary Materials OSF Repository:** https://doi.org/10.17605/OSF.IO/CV8WB

---

## 📁 Files in This Folder


### 1. `WHOQOL CFA - RDWLS Estimator.jasp`

**Description:** JASP file with technical comments for CFA analyses treating WHOQOL-BREF items as **ordinal variables** (best practice for Likert-type scales).

**Key Features:**
- **Estimation method:** RDWLS (Robust Diagonally Weighted Least Squares)
- **Sample:** n = 1,047 (Brazil)
- **Models evaluated:** 
  - Four-correlated-factor model (4F-A) with 24 items
  - Four-factor model without Q5P (4F-B)
  - Bifactor model with general + specific factors
  - Second-order hierarchical model (4F-2nd)
- **Outputs commented:**
  - Fit indices (CFI, TLI, RMSEA, SRMR)
  - Factor loadings and covariances
  - Modification indices (cross-loadings, residual covariances)
  - Reliability coefficients (McDonald's ω, GLB)
  - Model comparisons

**Software:** JASP v0.17.1

---

### 1. `WHOQOL CFA - MLR Estimator.jasp`

**Description:** JASP file with technical comments for CFA analyses treating WHOQOL-BREF items as **continuous variables** (alternative approach for comparison).

**Key Features:**
- **Estimation method:** ML (Maximum Likelihood with robust standard errors)
- **Sample:** n = 1,047 (Brazil)
- **Models evaluated:** Same four competing models as ordinal analysis
- **Outputs commented:** Identical structure to ordinal file
- **Important note:** Treating 5-point Likert items as continuous is debated in the literature; ordinal treatment (RDWLS) is generally recommended

**Software:** JASP v0.17.1

---

## 🎯 Purpose of These Documents

These technical comments provide:

1. **Detailed interpretation** of every JASP output table for each CFA model
2. **Contextualization** within contemporary psychometric literature
3. **Critical evaluation** of fit indices, reliability estimates, and model specifications
4. **Methodological guidance** for conducting rigorous CFA with ordinal vs. continuous data
5. **Decision-making frameworks** for model selection and reporting

Each comment is positioned to appear immediately below its corresponding JASP output table, facilitating direct interpretation during analysis review.

---

## ⚠️ Reproducibility Warning

**These analyses were developed in JASP v0.17.1** (https://github.com/jasp-stats/jasp-desktop/releases/tag/v0.17.1).

**You may encounter reproducibility issues if using other versions of JASP**, as the software is under active development and features, algorithms, or default settings may change across versions.

For full reproducibility:
- Use JASP v0.17.1
- Consult the main article for detailed methodological specifications
- Access the original JASP files and data from here (in this folder) or the OSF repository

---

## 📚 Recommended Citation

If you use these technical comments in your work, please cite:

> Rogers, P. (2024). Best practices for your confirmatory factor analysis: A JASP and lavaan tutorial. *Behavior Research Methods*. https://doi.org/10.3758/s13428-024-02375-7

For the supplementary materials specifically:

> Rogers, P. (2024). Supplementary materials for "Best practices for your confirmatory factor analysis: A JASP and lavaan tutorial." Open Science Framework. https://doi.org/10.17605/OSF.IO/CV8WB

---

## 🔗 Additional Resources

- **Main article:** https://doi.org/10.3758/s13428-024-02375-7
- **OSF project:** https://doi.org/10.17605/OSF.IO/CV8WB
- **JASP software:** https://jasp-stats.org/
- **lavaan R package:** https://lavaan.ugent.be/

---

## 📧 Contact

**Pablo Rogers**  
Federal University of Uberlândia, Brazil  
Email: pablorogers@ufu.br

---

## 📄 License

These materials are distributed under the same license as the main article's supplementary materials. Please refer to the OSF repository for licensing details.
