# Easy Loans 2023 — Tableau Dashboard

An interactive Tableau analysis of Easy Loans' operations and refunds data for the year 2023.

This workbook provides a comprehensive visual analysis of loan operations, merchant activity, 
and refund behaviour across different countries. The data covers orders, merchants, and refunds, 
with metrics broken down by time, geography, and merchant.

The dashboard is publicly available on Tableau Public:

[Easy Loans 2023 — Tableau Public](https://public.tableau.com/views/easyloans2023/Landing?:language=es-ES&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

# Dashboards & Sheets

The workbook includes the following views:

## Dashboards

**Landing**

Entry point of the workbook, designed as a navigation home page. Displays the Easy Loans branding and logo,
with buttons linking directly to the other two dashboards: Resumen Operaciones and Análisis Comercios.

**Resumen Operaciones (Operations Overview)**

Overview of the company's loan operations for 2023. Includes a geographic map showing the distribution of 
operations by country, a deviation chart comparing each country's average loan amount against the global average,
and a set of KPI cards covering cumulative value, average, overall average, maximum, minimum, and total number of
merchants. The dashboard includes filters by country and date, as well as a minimum loan value parameter to 
dynamically adjust the analysis.

**Análisis Comercios (Merchant Analysis)**

Merchant-level analysis combining loan and refund data. Features a bar chart of loans and refunds by merchant, 
a country breakdown of merchant activity, and a refund section with charts on refund types, refunded amounts, 
and detailed refund info. KPI cards display cumulative value, average, minimum, maximum, and overall average. 
A measure selector parameter allows toggling between number of loans and number of refunds across the visuals.

## Sheets

| Sheet | Description |
|---|---|
| **KPI Valor Acumulado** | Cumulative value KPI |
| **KPI Promedio** | Average loan amount KPI |
| **KPI Promedio Total** | Overall average KPI |
| **KPI Máximo** | Maximum loan value KPI |
| **KPI Mínimo** | Minimum loan value KPI |
| **KPI Total Comercios** | Total number of merchants KPI |
| **KPI Total Devoluciones** | Total refunds KPI |
| **Mapa** | Geographic distribution of operations by country |
| **Gráfico de Áreas** | Cumulative loan amount over time |
| **Desviación** | Deviation of loan amounts from the overall average |
| **Número Operaciones** | Number of operations over time |
| **Gráfico Marcas** | Loan and refund amounts by merchant |
| **Importe Reembolsado** | Total refunded amounts |
| **Tipo Reembolsos** | Refund type classification |
| **Info Reembolso** | Detailed refund information |
| **Países Marcas** | Merchant activity by country |
| **Operaciones Marcas** | Operations breakdown by merchant |

# Dataset 

The workbook uses three related tables joined together:

- **Orders** — individual loan transactions (`order_id`, `amount`, `country`, `created_at`, `merchant_id`, `status`)
- **Merchant** — merchant reference data (`merchant_id`, `name`)
- **Refunds** — refund records (`order_id`, `amount`, `refunded_at`)

# Requirements

- Tableau Desktop or Tableau Reader (version 18.1 or later)
- The `.twbx` file is self-contained — no external data connection needed
