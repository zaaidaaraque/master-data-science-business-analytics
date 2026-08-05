# Natural Language Processing with Disaster Tweets
This project contains my solution to the **Natural Language Processing with Disaster Tweets** Kaggle competition.

The objective is to build a binary text classification model capable of determining whether a tweet refers to a real 
disaster or not.

The project covers the complete NLP workflow, from exploratory data analysis and text preprocessing to traditional machine
learning models and Transformer-based architectures.

---

## Project Structure

```
.
├── notebook_disaster_tweets.ipynb # main notebook
└── README.md
```

---

## Dataset

The competition provides two datasets:

* **train**
* **test**

The dataset consists of tweets collected from Twitter.

Each observation contains:

- id: Unique tweet identifier.
- keyword: Disaster-related keyword (optional).
- location: User location (optional).
- text: Tweet content.
- target:
  - 1 → real disaster.
  - 0 → not a real disaster.
 
> The dataset is not included in this repository. It can be downloaded directly from the competition page after
> registering for the competition: [Natural Language Processing with Disaster Tweets](https://www.kaggle.com/competitions/nlp-getting-started/overview)

---

## Methodology
The project follows the typical workflow of a Natural Language Processing pipeline:

### 1. Exploratory Data Analysis (EDA)

The initial analysis focused on understanding both the dataset and the text characteristics.

The following aspects were explored:

- Dataset structure and missing values.
- Target class distribution.
- Most frequent keywords.
- Location analysis.
- Tweet length distribution.
- Presence of URLs, mentions and hashtags.
- Duplicate observations.
- Language detection.

This analysis helped identify data quality issues and define the preprocessing strategy.

### 2. Text Preprocessing
Several preprocessing techniques were applied before training the traditional Machine Learning models.

The preprocessing pipeline includes:

- Lowercase conversion
- URL removal
- HTML tag removal
- Escape character removal
- Punctuation removal
- Number removal
- Stopword removal
- Lemmatization
- Extra whitespace removal

Different preprocessing combinations were tested to evaluate their impact on model performance.

For the Transformer models, the original tweet text was used since Transformer models perform their own tokenization and contextual representation internally.

### 3. Models

Several models were implemented and compared throughout the project.
1. Logistic Regression with Bag of Words
2. Logistic Regression with TF-IDF
3. Naive Bayes with Bag of Words
4. SVM with Bag of Words
5. Logistic Regression with GridSearchCV
6. Logistic Regression with more features
7. DistilBERT
8. RoBERTa

The best-performing solution was a **DistilBERT**

| Metric                       |      Score |
| ---------------------------- | ---------: |
| Accuracy          | **0.84390** |
| F1-score               | **0.81250** |
| Kaggle Score | **0.83328** |


The competition evaluation metric is the F1 Score.

---

## Key Findings
Some of the main conclusions obtained during the project include:

- Proper text preprocessing noticeably improved the traditional Machine Learning models.
- Bag of Words consistently outperformed the TF-IDF representation.
- Adding the **keyword** and **location** variables did not improve performance.
- Hyperparameter optimization didn't produced marginal improvements over the baseline models.
- DistilBERT significantly outperformed every traditional Machine Learning model.
- RoBERTa did not generalize as well as DistilBERT on this dataset despite being a larger architecture.
- Transformer models require considerably less manual feature engineering than classical NLP pipelines.

---

---

## Stack

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-learn
- NLTK
- Hugging Face Transformers
- PyTorch

---

## How to run
Clone the repository:

```bash
git clone https://github.com/zaaidaaraque/master-data-science-business-analytics.git
cd master-data-science-business-analytics/natural_language_processing/disaster_tweets
```

Install the required libraries:

```bash
pip install pandas numpy matplotlib seaborn scikit-learn nltk datasets transformers torch accelerate scipy
```

Launch Jupyter Notebook:

```bash
jupyter notebook disaster_tweets_notebook.ipynb
```
