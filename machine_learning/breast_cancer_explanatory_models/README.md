# Breast Cancer Diagnosis — Explanatory Logistic Regression with and without PCA

Binary classification study on the Breast Cancer dataset comparing two explanatory modelling approaches: logistic regression on selected raw features vs. 
logistic regression on PCA components. The focus is on coefficient interpretability (odds ratios) rather than predictive performance, with cross-validation
used solely to assess model stability.

---

## Project Structure

```
.
├── breast_cancer_explanatory_models.ipynb   # main notebook
└── README.md
```

---

## Overview

| | Model A — Raw Features | Model B — PCA |
|---|---|---|
| Approach | Iterative VIF-based feature selection | Dimensionality reduction → logistic regression |
| Final features | 7 (VIF < 5, p < 0.05) | 5 principal components |
| Pseudo R² | 0.897 | 0.889 |
| CV ROC-AUC (5-fold, mean) | 0.990 | 0.994 |
| Interpretability | Direct — odds ratios per original feature | Indirect — OR per component, explained via loadings |
| Multicollinearity | Eliminated via stepwise VIF pruning | Eliminated by construction |

---

## Dataset

[Breast Cancer (Diagnostic)](https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic) — 569 tumour samples, 
30 numeric features derived from digitised fine-needle aspirate (FNA) images of cell nuclei. Binary target: `M` (malignant) or `B` (benign).

Features are grouped in three statistical blocks for ten nucleus characteristics:
- **mean** — average across all nuclei in the image
- **se** — standard error across nuclei
- **worst** — average of the three most extreme nuclei

---

## Methodology

### Why explanatory, not predictive?

The dataset has only 569 rows. With 30 features spread across three correlated blocks, a train/test split would leave too few samples for 
stable coefficient estimation. The goal here is to understand which nuclear characteristics drive malignancy and by how much — not to build
a production classifier. Cross-validation is included as a robustness check, not as the primary evaluation criterion.

### Model A — Raw features

1. **EDA & preprocessing** — encode target, standardise features
2. **Correlation heatmap** — confirms severe pairwise collinearity, especially in the size block (radius, perimeter, area are geometrically redundant)
3. **VIF analysis** — all features start above VIF = 10; the `worst` variants are preferred over `mean` and `SE` equivalents because they capture the most
4.  extreme nucleus behaviour
5. **Iterative feature removal** — one feature at a time by highest VIF until all remaining features satisfy VIF < 5
6. **p-value pruning** — remove any remaining features with p > 0.05
7. **Final model** — 7 features, all significant; odds ratios with 95% CIs computed for interpretation

### Model B — PCA

1. **Full PCA scree plot** — identifies elbow at 6 components (≈89% variance explained; the 7th adds only ~2%)
2. **Scatter plot PC1 vs PC2** — confirms clean visual separation between benign and malignant
3. **Logistic regression on 6 components** — PC6 is non-significant (p > 0.05) and removed
4. **Final model** — 5 components; loadings inspected to interpret what each component captures
5. **Threshold optimisation** — grid search over [0, 1] finds that 0.49 marginally improves accuracy over the default 0.50

---

## Key findings

**Model A**
- `area_worst` dominates: a one-SD increase multiplies the odds of malignancy by ~37.5
- `compactness_se` is the only protective factor — higher variability in compactness across nuclei is associated with benign diagnosis
- High fit (Pseudo R² = 0.897) with low cross-validation variance confirms stability rather than overfitting

**Model B**
- PC1 (OR ≈ 18) is the strongest predictor — loaded by concavity and worst-block size features; it captures tumour irregularity and overall size
- PC2 acts as a protective factor — driven by fractal dimension features; high complexity without enlarged nuclei is associated with benign outcome
- PC3 is also protective — represents across-nucleus variability in texture, smoothness, and symmetry

---

## Stack

```
Python 3.10
pandas · numpy · matplotlib · seaborn
statsmodels     — explanatory logistic regression, odds ratios, VIF
scikit-learn    — StandardScaler, PCA, cross_val_score, accuracy_score
pca             — scree plots and explained variance tables
```

---

## How to run

```bash
pip install pandas numpy matplotlib seaborn statsmodels scikit-learn pca
jupyter notebook breast_cancer_explanatory_models.ipynb
```

The dataset loads automatically from a public URL inside the notebook — no local data file needed.
