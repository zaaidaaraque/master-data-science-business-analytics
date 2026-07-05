# Movies Analysis Dashboard
 
Interactive Power BI dashboard analyzing almost 10,000 movies (TMDB-format dataset), exploring production trends over time, 
distribution by genre and language, and popularity/rating rankings.

## Overview
<img width="1163" height="656" alt="image" src="https://github.com/user-attachments/assets/e2e94f36-a083-464c-95fd-a802a88905f2" />
<img width="1279" height="718" alt="image" src="https://github.com/user-attachments/assets/4d4852ac-c34b-49a2-af66-751869653211" />

## Project goal
 
Build a general-overview dashboard of the film industry that answers:
- How has movie production evolved over time?
- Which genres and languages dominate the catalog?
- Is there a relationship between the number of movies in a genre and its average popularity?
- Which movies are the most popular and highest rated?

## Dataset
 
Source: [Netflix Movies and TV Shows Data Analysis](https://www.kaggle.com/datasets/nalisha/netflix-movies-and-tv-shows-data-analysis) 
(Kaggle), a TMDB-format dataset with ~9,800 records: title, release date, popularity, vote count, average rating, original language, genre(s), and poster.
 
**Dataset license:** [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/)
 
> The raw CSV is not included in this repository. Download it directly from the Kaggle link above if you want to reproduce this project.

## Data model
 
Star schema with 3 main tables + a measures table:
 
| Table | Role | Rows | Description |
|---|---|---|---|
| `mymoviedb (1)` | Fact | 9,827 | One row per movie, with unique `ID` (Title + Release Date) |
| `mymoviedb (2)` | Bridge | 25,774 | One row per movie–genre combination (M:N relationship via `Genre`) |
| `Calendar` | Time dimension | 44,639 | Continuous date table, marked as the official date table |
| `Measures table` | Measures | — | Container table for all DAX measures |
 
**Key relationship:** `mymoviedb (2)[ID]` → `mymoviedb (1)[ID]`, many-to-one cardinality, bidirectional cross-filter

### Key transformations (Power Query)
 
- Removed rows with source errors/nulls.
- Composite `ID` column (`Date — Title`) to avoid collisions between movies with duplicate titles.
- Extracted `Year` and `Month Name` from `Release_Date`.
- Split `Genre` into a long-format bridge table (one row per genre), with text trimmed to remove whitespace-based duplicates.
- Translated ISO language codes (`en`, `ja`, `es`...) into full names (`English`, `Japanese`, `Spanish`...) for more readable visuals.

## Dashboard content
 
**Overview** page:
- **KPI cards**: total movies, genres, languages, votes, and average rating.
- **Line chart**: yearly trend of movies released (1902–2024).
- **Column chart**: total movies by genre.
- **Donut chart**: top 5 languages by movie count.
- **Scatter chart**: relationship between number of movies and average popularity by genre.
- **Ranking table**: top movies by popularity and rating.
- **Slicers**: year, language, genre, and rating, for cross-filtering exploration.
Also includes **5 custom tooltip pages** (Scatterplot, Language, Date, Genre, Movies) providing enriched context on hover over the main visuals.
 
## Tech stack
 
- Power BI Desktop
- Power Query (M)
- DAX
  
## How to use
 
1. Clone this repository.
2. Open `netflix_movies_analysis.pbix` with Power BI Desktop.
3. If needed, update the data source path (`Home → Transform data → Data source settings`) to point to the CSV on your machine.
4. Refresh the data (`Home → Refresh`).

## License
 
- **Dataset**: [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) — as published on [Kaggle](https://www.kaggle.com/datasets/nalisha/netflix-movies-and-tv-shows-data-analysis). No rights reserved by the original author.
- **This project** (dashboard, DAX measures, documentation): released under the [MIT License](https://opensource.org/licenses/MIT) — see `LICENSE` file.

