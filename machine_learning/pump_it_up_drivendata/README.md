# Pump it Up: Data Mining the Water Table

This repository contains my solution to the **Pump it Up: Data Mining the Water Table** competition on DrivenData.

The objective of the competition is to predict the operational status of water pumps in Tanzania using demographic, geographic, and management-related information. This is a multiclass classification problem with three possible labels:

* Functional
* Functional needs repair
* Non-functional

The project follows a complete machine learning workflow, from exploratory data analysis to feature engineering, model comparison, hyperparameter tuning, and ensemble learning.

---

## Project Structure

```
.
├── pump_it_up_notebook.ipynb # main notebook
└── README.md
```

> **Note:** This repository includes an English README, but the Jupyter notebook is written in Spanish.
---

## Dataset

The competition provides three datasets:

* **Training features**
* **Training labels**
* **Test features**

The data contains information about each water point, including:

* Geographic location
* Water source characteristics
* Extraction methods
* Water quality
* Management organization
* Payment information
* Installation details
* Construction year
* Population served
* And many other numerical and categorical variables
  
> The dataset is not included in this repository. It can be downloaded directly from the competition page after
> registering for the competition: [Pump it Up: Data Mining the Water Table](https://www.drivendata.org/competitions/7/pump-it-up-data-mining-the-water-table/)

---

## Methodology

### 1. Exploratory Data Analysis (EDA)

A comprehensive exploratory analysis was performed to understand the dataset and identify potential issues.

The analysis included:

* Missing values
* Variable distributions
* Target distribution
* Feature correlations
* Categorical variable analysis
* Numerical variable analysis
* Identification of redundant and low-information features

### 2. Data Preprocessing

Several preprocessing strategies were evaluated.

Main preprocessing steps included:

* Missing value imputation
* Removal of irrelevant features
* Categorical feature handling
* Creation of different feature subsets
* Cross-validation

Different versions of the dataset were tested using both original and imputed variables.

### 3. Models Evaluated

Several machine learning algorithms were trained and compared:

* Logistic Regression
* Decision Tree
* Random Forest
* LightGBM
* XGBoost
* CatBoost
* Random Forest + SMOTE
* Stacking Ensembles

Each model was evaluated using:

* Accuracy
* Macro F1-score
* Cross-validation
* DrivenData leaderboard score

---

## Best Model

The best-performing solution was a **Stacking Ensemble**, combining:

* Random Forest
* LightGBM

### Performance

| Metric                       |      Score |
| ---------------------------- | ---------: |
| Validation Accuracy          | **0.8145** |
| Macro F1-score               | **0.7051** |
| Cross-validation Accuracy    | **0.8100** |
| DrivenData Leaderboard Score | **0.8215** |

The ensemble consistently outperformed all individual models tested.

---

## Key Findings

* Ensemble methods clearly outperformed linear models and single decision trees.
* Random Forest, LightGBM, XGBoost, and CatBoost achieved very similar performance after tuning.
* Hyperparameter optimization provided only modest improvements compared to choosing a strong model architecture.
* The **"Functional needs repair"** class remained the most challenging due to class imbalance and overlapping characteristics.
* Applying SMOTE improved minority class detection but did not significantly improve the final leaderboard performance.

---

## Stack


* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* Scikit-learn
* LightGBM
* XGBoost
* CatBoost
* Imbalanced-learn

---

## How to run
```bash
pip install pandas numpy matplotlib seaborn scikit-learn lightgbm xgboost catboost imbalanced-learn
jupyter notebook pump_it_up_notebook.ipynb
```
