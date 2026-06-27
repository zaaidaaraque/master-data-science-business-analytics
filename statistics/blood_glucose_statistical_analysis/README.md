# Blood Glucose Statistical Analysis
 
Statistical analysis of fasting and post-glucose blood glucose levels across two control groups. 
This project applies descriptive statistics, linear regression, and inferential statistics to a clinical dataset of 65 patients (35 in Group 1, 30 in Group 2), measuring blood glucose levels at baseline (fasting) and 60 minutes after glucose intake.

## Dataset
 
`EVALMASTER.xlsx` — 65 observations restructured into a wide format with four columns:
 
| Column | Description |
|---|---|
| `Group1_Basal` | Fasting blood glucose — Group 1 (mg/dL) |
| `Group1_60min` | Blood glucose at 60 min — Group 1 (mg/dL) |
| `Group2_Basal` | Fasting blood glucose — Group 2 (mg/dL) |
| `Group2_60min` | Blood glucose at 60 min — Group 2 (mg/dL) |
 
> Group 2 has 30 observations vs 35 in Group 1, so the last 5 rows of Group 2 columns are NaN. All functions handle this with `.dropna()`.

 ## Project Structure
 
```
├── blood_glucose_statistical_analysis.ipynb   # Main analysis notebook
├── EVALMASTER.xlsx            # Dataset
└── README.md
```

## Analysis
 
### 1. Descriptive Statistics
 
- **Centrality and dispersion**: mean, median, mode, range, IQR, variance, standard deviation and coefficient of variation for all four columns
- **Shape**: skewness and kurtosis for all groups and conditions, supported by histograms
- **Boxplots and outlier detection**: MAD-based modified Z-score with two thresholds — extreme (3.5) and mild (3.0) — to capture all outliers identified visually in the boxplots
- **Normality test**: Shapiro-Wilk applied to all four columns

Key findings:
- All groups show representative means (CV < 0.11 in all cases)
- Group 2 shows higher glucose levels and greater variability after 60 minutes compared to Group 1
- Skewness values are close to zero across all columns; Group 1 at 60 min shows the highest kurtosis (1.45), indicating a slightly more peaked distribution
- Normality is not rejected for any column (Shapiro-Wilk p > 0.05)

### 2. Linear Regression (Group 1)
 
- Scatter plot and Pearson correlation between fasting and 60-min glucose
- Simple linear regression model via `numpy.polyfit`
- Interactive prediction: user inputs a basal glucose value and gets the estimated 60-min level
- Marginal effect: user inputs a delta and gets the associated change in 60-min glucose
Model:
 
```
Glucose_60min = 91.3837 + 0.6969 × Glucose_basal     R² = 0.634
```
 
- Pearson r = 0.796 (strong positive), p < 0.01
- A 5 mg/dL increase in fasting glucose is associated with a ~3.48 mg/dL increase at 60 minutes
  
### 3. Inferential Statistics
 
- **One-sample t-test**: 95% and 99% CI for mean basal glucose in Group 1; H₀: μ = 88 mg/dL rejected at α = 0.05 but not at α = 0.01
- **Two-sample t-test**: 95% CI for difference in means between groups; Levene's test confirms equal variances; means are significantly different
- **Proportion Z-test**: 98% CI for proportion of patients with glucose > 95 mg/dL; H₀: p = 0.15 not rejected
- **Paired t-test (Group 2)**: Significant increase after 60 minutes (mean difference = −82.43 mg/dL, p ≈ 0)

## Stack
 
- Python 3
- `pandas`, `numpy` — data manipulation and reshaping
- `scipy.stats` — Shapiro-Wilk, Levene, t-tests, Z-test, Pearson correlation
- `statsmodels` — confidence intervals
- `seaborn`, `matplotlib` — histograms, boxplots, scatter plot
  
## How to Run
 
```bash
pip install pandas numpy scipy statsmodels seaborn matplotlib openpyxl
jupyter notebook blood_glucose_statistical_analysis.ipynb
```
 
> The notebook reads `EVALMASTER.xlsx` from the working directory. Make sure both files are in the same folder.
