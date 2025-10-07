# SQL-PROJECT
Customer Insights Project – SQL & Data Analysis

Goal:
To analyze large customer datasets to identify the top-performing cities by revenue and customer engagement.

Process:
 1. Data Extraction & Cleaning:
 • Pulled customer and transaction data from a relational database using SQL Server.
 • Used CTEs (Common Table Expressions) and subqueries to merge multiple tables (customers, transactions, locations).
 • Removed duplicates and handled missing values by applying filtering conditions (WHERE, IS NOT NULL) and window functions like ROW_NUMBER().
 2. Data Validation:
 • Verified the integrity of customer IDs and revenue fields using aggregation queries and cross-checks with control totals.
 • Conducted accuracy testing by comparing SQL outputs with summary reports—achieved over 80% validation accuracy.
 3. Analysis & Insights:
 • Designed ranking metrics using SQL functions such as RANK() and SUM() to calculate city-level revenue performance.
 • Identified that certain urban regions contributed disproportionately to revenue, influencing targeted marketing strategies.

Outcome:
Provided actionable insights that helped management prioritize high-performing cities for promotional campaigns.
