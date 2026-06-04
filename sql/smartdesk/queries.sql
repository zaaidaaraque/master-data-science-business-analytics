-- =========================================
-- PROFITABILITY ANALYSIS PROJECT
-- SQL Business Case Study
-- =========================================

-- SET  CONTEXT
USE DATABASE UCM;
USE SCHEMA SMART_DESK;

-- 1. Sales and Profit Analysis by Product Category
SELECT category AS "Categoría", 
       maintenance AS "Mantenimiento", 
       product AS "Producto", 
       parts AS "Partes", 
       support AS "Soporte", 
       total AS "Total Ventas",
       units_sold AS "Unidades Vendidas", 
       profit AS "Beneficio Total"
FROM sales
WHERE account = 'Adabs Entertainment' AND year = 2020
ORDER BY category;

-- 2. Performance Comparison by Country in APAC and EMEA Regions
SELECT a.region AS "Región",
       a.country AS "País",
       ROUND(AVG(s.total), 2) AS "Ingreso Promedio",
       ROUND(AVG(s.units_sold), 2) AS "Unidades Vendidas Promedio",
       ROUND(AVG(s.profit), 2) AS "Beneficio Promedio"        
FROM sales AS s
INNER JOIN accounts AS a ON s.account = a.account
WHERE a.region = 'APAC' OR a.region = 'EMEA'
GROUP BY a.region, a.country
ORDER BY "Ingreso Promedio" DESC;

-- 3. Industry Profitability Analysis: Customers in Commitment Stage
SELECT a.industry AS "Industria",
       SUM(s.profit) AS "Beneficio Total",
       CASE 
           WHEN SUM(s.profit) > 1000000 THEN 'Alto'
           ELSE 'Normal'
       END AS "Categoría según beneficio"
FROM sales AS s
INNER JOIN accounts AS a ON s.account = a.account
WHERE s.account IN (SELECT account
                    FROM forecasts
                    WHERE prediction_category = 'Commit' AND forecast > 500000)
GROUP BY a.industry
ORDER BY "Beneficio Total" DESC;

-- 4. Forecast vs Actual Profit Evolution by Category
SELECT COALESCE(s.category, f.category) AS "Categoría",
       SUM(s.profit) AS "Sumatorio del Beneficio en 2021",
       SUM(f.forecast) AS "Sumatorio del Beneficio en 2022",
       MIN(f.opportunity_age) AS "Oportunidad Más Reciente",
       MAX(f.opportunity_age) AS "Oportunidad Más Antigua"       
FROM sales AS s FULL OUTER JOIN forecasts AS f ON s.year = f.year AND s.category = f.category
WHERE s.year = 2021 OR f.year = 2022
GROUP BY "Categoría"
ORDER BY "Sumatorio del Beneficio en 2021" DESC;

-- =========================================
-- BUSINESS CASE: MOST PROFITABLE INDUSTRIES
-- =========================================

-- Business Question:
-- Which industries generate the highest profit for Smart Desk,
-- and which ones show high sales volume but low profitability?

-- Context:
-- Smart Desk operates across 16 different industries.
-- Some industries are more frequent than others, and identifying
-- the most profitable ones allows the company to:
--
-- 1. Prioritize resources in high-margin industries
-- 2. Adjust strategy to strengthen key markets
-- 3. Detect segments where high sales volume does not translate into profit
--
-- Additionally, Smart Desk operates internationally across multiple countries.
-- Combining industry and geographic analysis helps optimize expansion strategy
-- and improve overall profitability.



-- 1. Exploratory Data Analysis

-- Industry overview
SELECT industry AS "Industria",
       COUNT(industry) AS "Número de usuarios en la industria"
FROM accounts
GROUP BY industry;

-- Industry overview by region
SELECT a.country AS "País",
       a.industry AS "Industria",
       COUNT(DISTINCT s.account) AS "Número de usuarios en la industria",
       SUM(s.profit) AS "Beneficio Total"
FROM sales AS s
INNER JOIN accounts AS a ON s.account = a.account
GROUP BY a.country, a.industry
ORDER BY a.country, "Número de usuarios en la industria" DESC, "Beneficio Total" DESC;

-- Profit, sales and margin analysis by industry
SELECT a.industry AS "Industria",
       COUNT(DISTINCT s.account) AS "Número de usuarios en la industria",
       SUM(s.total) AS "Ventas Totales",
       SUM(s.profit) AS "Beneficio Total",
       SUM(s.units_sold) AS "Unidades Vendidas",
       ROUND(SUM(s.profit)/SUM(s.total)*100, 2) AS "Margen de Beneficios"
FROM sales AS s INNER JOIN accounts AS a ON s.account = a.account
GROUP BY a.industry
ORDER BY "Beneficio Total" DESC;

-- Identification of most profitable regions
SELECT a.region AS "Región",
       a.country AS "País",
       COUNT(DISTINCT s.account) AS "Número de usuarios",
       SUM(s.total) AS "Ingresos Totales",
       SUM(s.units_sold) AS "Unidades Vendidas",
       SUM(s.profit) AS "Beneficios Totales",  
       ROUND(SUM(s.profit)/SUM(s.total)*100, 2) AS "Margen de Beneficios"
FROM sales AS s
INNER JOIN accounts AS a ON s.account = a.account
GROUP BY a.region, a.country
ORDER BY "Beneficios Totales" DESC;

-- 2. Business Question Analysis

-- Average profit margin
SELECT AVG(profit / total * 100) AS "Promedio Margen"
FROM sales;

-- Average units sold by industry
SELECT AVG("Unidades Vendidas") AS "Promedio Unidades Vendidas"
FROM (
    SELECT a.industry AS "Industria",
           SUM(s.units_sold) AS "Unidades Vendidas" 
    FROM sales AS s
    INNER JOIN accounts AS a ON a.account = s.account
    GROUP BY "Industria"
);

-- Average units sold by country
SELECT AVG("Unidades Vendidas") AS "Promedio Unidades Vendidas"
FROM (
    SELECT a.country AS "País",
           SUM(s.units_sold) AS "Unidades Vendidas" 
    FROM sales AS s
    INNER JOIN accounts AS a ON a.account = s.account
    GROUP BY "País"
);

-- Industry profitability classification
SELECT a.industry AS "Industria",
       SUM(s.total) AS "Beneficio Total",
       SUM(s.units_sold) AS "Unidades Vendidas", 
       ROUND(SUM(s.profit)/SUM(s.total)*100, 2) AS "Margen de Beneficios",
       CASE 
        WHEN SUM(s.profit)/SUM(s.total) >= 0.35 AND SUM(s.units_sold) >= 30000 THEN 'Rentabilidad Muy Alta'
        WHEN SUM(s.profit)/SUM(s.total) >= 0.35 AND SUM(s.units_sold) < 30000 THEN 'Rentabilidad Alta'
        WHEN SUM(s.profit)/SUM(s.total) < 0.35 AND SUM(s.units_sold) >= 30000 THEN 'Rentabilidad Media'
        ELSE 'Rentabilidad Baja'
       END AS "Clasificación Rentabilidad"
FROM sales AS s 
INNER JOIN accounts AS a ON s.account = a.account
GROUP BY a.industry
ORDER BY "Beneficio Total" DESC;

-- Regional profitability classification
SELECT a.country AS "País",
       SUM(s.total) AS "Beneficio Total",
       SUM(s.units_sold) AS "Unidades Vendidas", 
       ROUND(SUM(s.profit)/SUM(s.total)*100, 2) AS "Margen de Beneficios",
       CASE 
        WHEN SUM(s.profit)/SUM(s.total) >= 0.35 AND SUM(s.units_sold) >= 30000 THEN 'Rentabilidad Muy Alta'
        WHEN SUM(s.profit)/SUM(s.total) >= 0.35 AND SUM(s.units_sold) < 30000 THEN 'Rentabilidad Alta'
        WHEN SUM(s.profit)/SUM(s.total) < 0.35 AND SUM(s.units_sold) >= 30000 THEN 'Rentabilidad Media'
        ELSE 'Rentabilidad Baja'
       END AS "Clasificación Rentabilidad"
FROM sales AS s 
INNER JOIN accounts AS a ON s.account = a.account
GROUP BY "País"
ORDER BY "Beneficio Total" DESC;

-- Countries operating in high-profit industries
SELECT a.country AS "País",
       a.industry AS "Industria",
       COUNT(DISTINCT s.account) AS "Número de usuarios en la industria",
       SUM(s.profit) AS "Beneficio Total",
       ROUND(SUM(s.profit)/SUM(s.total)*100, 2) AS "Margen de Beneficios",
FROM sales AS s
INNER JOIN accounts AS a ON s.account = a.account
WHERE a.industry IN ('Consulting', 'Technology', 'Finance')
GROUP BY a.country, a.industry
ORDER BY a.country, "Número de usuarios en la industria" DESC, "Beneficio Total" DESC;

-- Overall average units sold
SELECT AVG("Unidades Vendidas") AS "Promedio Unidades Vendidas"
FROM (
    SELECT a.country AS "País",
           a.industry AS "Industria",
           SUM(s.units_sold) AS "Unidades Vendidas" 
    FROM sales AS s
    INNER JOIN accounts AS a ON a.account = s.account
    GROUP BY "País", "Industria"
);

-- Industry-level margin analysis by country
SELECT a.region AS "Región",
       a.country AS "País",
       a.industry AS "Industria",
       COUNT(DISTINCT s.account) AS "Número de usuarios",
       SUM(s.total) AS "Ingresos Totales",
       SUM(s.units_sold) AS "Unidades Vendidas",
       SUM(s.profit) AS "Beneficios Totales",  
       ROUND(SUM(s.profit)/SUM(s.total)*100, 2) AS "Margen de Beneficios"
       CASE 
        WHEN SUM(s.profit)/SUM(s.total) >= 0.35 AND SUM(s.units_sold) >= 8000 THEN 'Rentabilidad Muy Alta'
        WHEN SUM(s.profit)/SUM(s.total) >= 0.35 AND SUM(s.units_sold) < 8000 THEN 'Rentabilidad Alta'
        WHEN SUM(s.profit)/SUM(s.total) < 0.35 AND SUM(s.units_sold) >= 8000 THEN 'Rentabilidad Media'
        ELSE 'Rentabilidad Baja'
       END AS "Clasificación Rentabilidad"
FROM sales AS s
INNER JOIN accounts AS a ON s.account = a.account
GROUP BY a.region, a.country, a.industry
ORDER BY "Margen de Beneficios" DESC;

