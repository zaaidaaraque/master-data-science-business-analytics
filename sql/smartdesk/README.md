# SmartDesk SQL Analysis
This project contains SQL queries and business analysis performed on SmartDesk's sales data using Snowflake. SmartDesk is an office solutions company operating across 15+ countries and 16 industries. The goal of this analysis is to extract actionable business insights from three relational tables: accounts, sales, and forecasts.

# Dataset Description
Accounts.csv : Customer account information: country, region, industry

Sales.csv : Historical sales data: revenue, units sold, profit by category and year

Forecasts.csv : Sales forecasts: predicted revenue, opportunity age, prediction category

# Key Insights
### 1. Sales and Profit Analysis by Product Category
Adabs Entertainment requested only two product categories from SmartDesk in 2020: Chairs and Electronics.

Chairs generated $1,835,672 in total sales and $605,772 in profit, while Electronics generated $2,100,000 in total sales and $756,000 in profit.

Electronics is the more profitable product line, with a higher profit margin (33%) compared to Chairs (36%). This difference is partially driven by support services, which generated $500,000 in Electronics and $0 in Chairs, indicating that the client does not require after-sales or technical support for this product category.

Recommendations

It is recommended to strengthen the relationship with Adabs Entertainment by expanding sales into the Break Room and Desks categories, which were not purchased in 2020. The client already trusts the brand and uses support services, increasing the likelihood of successful cross-selling.

Additionally, since Electronics provides more opportunities for recurring revenue through after-sales services and support, SmartDesk should encourage the expansion of this product line across other clients.

### 2. Performance Comparison by Country in APAC and EMEA Regions
The APAC region, despite having only four countries compared to eight in EMEA, concentrates the highest average profit levels in its key markets. Singapore and Australia stand out, both exceeding $1M in profit, followed by South Korea with approximately $597K.

In EMEA, performance is more balanced across countries. Austria and Germany lead the region with around $500K in profit, while countries such as Italy and Sweden show lower performance levels.

Given that APAC presents higher profitability in key markets, and considering that Japan underperforms compared to regional leaders, it is recommended to strengthen this market by replicating successful strategies from Singapore and Australia.

At the same time, EMEA should be developed more steadily, using Austria and Germany as benchmarks to improve weaker markets.

### 3. Industry Profitability Analysis: Customers in Commitment Stage
Four out of seven industries exceed the $1M profit threshold and are classified as High profitability: Consulting, Retail, Technology, and Healthcare.

These industries represent the highest immediate revenue potential and should therefore be prioritized in sales conversion efforts

### 4. Forecast vs Actual Profit Evolution by Category
Break Room is the highest-performing category in 2021, with approximately $22M in actual profit and the highest forecast for 2022 at around $33M, indicating an expected growth of 50%.

Electronics and Desks are expected to grow by 64% and 81% respectively, suggesting strong upward momentum in these categories.

Chairs ranks lowest in both actual 2021 profit and forecasted 2022 growth.

Given this expected growth trend, SmartDesk should align production capacity with projected demand to avoid supply shortages.

Additionally, Break Room, Electronics, and Desks have long-standing open opportunities (between 378 and 383 days), so prioritizing their closure is critical to prevent revenue loss.

## Business Case: Most Profitable Industries
### Business Question
Which industries generate the highest profit for Smart Desk, and which ones present high sales volume but low profit margins?

Smart Desk operates across 16 different industries, with varying levels of customer concentration. Identifying high-margin industries allows the company to prioritize resources, refine its strategy, and focus on markets with higher revenue potential.

It also helps detect segments where high sales volume does not translate into proportional profitability.

Given Smart Desk’s international presence, it is also relevant to understand which industries should be prioritized across different countries. Combining industry-level and geographic analysis enables better strategic decisions and improved overall profitability.

### Exploratory Analysis
Initial analysis shows that Consulting, Retail, and Technology are the most frequent industries within Smart Desk’s customer base, while Education and Banking appear less frequently.

A country-level breakdown shows how industries are distributed across markets. Additionally, total profit, revenue, units sold, and profit margins were analysed by country. The United States, Germany, and France stand out due to their higher customer concentration and overall business activity.

An industry-level aggregation of profit, revenue, and margin shows that Retail, Entertainment & Media, Consulting, Technology, and Finance are the most profitable industries, but also those with the highest number of customers.

However, it was observed that profitability is not always proportional to either sales volume or total revenue. Therefore, a deeper analysis of profitability efficiency is required to better identify the most strategic industries for future investment.

### Results
To classify industries based on profitability, both profit margin and units sold were used as key metrics. Industry-level and country-level averages were calculated for both variables.

A threshold of 35% profit margin and 30,000 units sold was defined to classify performance.

The results show that Consulting, Technology, and Finance are the most profitable industries overall.

At country level, the United States emerges as the most profitable market. Australia, Portugal, and South Korea also show high profitability but with significantly lower sales volumes.

Further analysis identifies industries operating in these high-performing countries to detect missing opportunities in already profitable markets.

Finally, a country-industry matrix was built to detect local anomalies and expansion opportunities. The average units sold threshold (8,247 units) was used to classify performance levels.

### Conclusions
The analysis answers the business question by identifying that Retail, Entertainment & Media, and Consulting generate the highest total profit for Smart Desk. However, high profit does not necessarily imply high efficiency.

Retail and Entertainment & Media show high sales volumes (between 72,000 and 77,000 units) but relatively lower profit margins (33%–34.5%), below the 35% benchmark.

Consulting stands out as the core strategic industry, combining a high profit margin (36.69%) with strong volume (~59,000 units). Technology and Finance are also classified as highly profitable, although with lower sales volumes.

Some industries such as Healthcare, Hospitality, and Real Estate present the highest profit margins (up to 38%), but their sales volumes remain limited, indicating strong per-transaction profitability but low market penetration.

From a geographical perspective, the United States is the strongest market, combining both high margins and high volumes. Germany and France follow in terms of volume but show margins below the 35% threshold.

Australia, Portugal, and South Korea exhibit the highest margins but lower sales volumes, highlighting untapped potential for growth.

Country-industry analysis shows that profitability is strongly influenced by industry mix rather than only customer volume. For example, the United States achieves the highest total profit ($34.6M) due to its diversified portfolio across all key industries.

The analysis also identifies clear expansion opportunities:

- Australia lacks Finance exposure and represents a low-risk expansion opportunity
- South Korea shows strong responsiveness to Consulting and could benefit from Finance and Technology expansion
- Portugal presents strong potential for Consulting expansion
- Mexico shows high-margin potential but higher risk due to low maturity
- Japan offers opportunities to expand Consulting and Technology based on existing Finance presence

### Strategic Recommendations
- Consolidate Consulting as the core strategic industry
- Improve margins in Retail and Entertainment & Media through pricing strategies and value-added services
- Expand Hospitality, the highest-margin industry, currently underrepresented
- Review Banking and Insurance due to consistently low margins and investigate cost structure inefficiencies
- Target selective expansion opportunities in Automotive, Legal, Education, Manufacturing, and Entertainment depending on country-specific performance

In the short term, priority should be given to expanding Finance in Australia, the most attractive high-margin market opportunity. Additionally, South Korea should be further developed by leveraging existing Consulting success to replicate performance in Finance and Technology.

Finally, expansion decisions should not be driven solely by sales volume, but by a combined analysis of profitability and strategic industry-country alignment.
