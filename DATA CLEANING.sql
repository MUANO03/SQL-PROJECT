 -- DATA CLEANING
 -- https://mavenanalytics.io/data-playground?order=date_added%2Cdesc&page=8&pageSize=5


select*
from telecom_customer_churn;

-- 1.REMOVAL OF DUPLICATES
-- 2.STANDARDIZE THE DATA
-- 3.NULL VALUES OR BLANK VALUES
-- 4.REMOVE ANY COLUMNS


-- 1.REMOVAL OF DUPLICATES
-- CREATION OF A TABLE TO APPLY CLEANING METHODS

-- TABLE CREATION    
create table telecom_cust
like telecom_customer_churn;

-- CHECKING IF THE TABLE IS CREATED
select *
from telecom_cust;

-- INSERTING ORIGINAL DATA INTO THE NEW TABLE
INSERT telecom_cust
select *
from telecom_customer_churn;

-- CHECKING IF THE DATA FRROM THE ORIGINAL TABLE telecom_customer_churn IS LOADED
select *
from telecom_cust;


-- CHECKING DUPLICATES FROM THE DATASET

SELECT  Gender, Age, Married, City, `Zip Code`, Latitude, Longitude, `Number of Referrals`, `Tenure in Months`, Offer, `Phone Service`, `Avg Monthly Long Distance Charges`, 
       `Multiple Lines`, `Internet Service`, `Internet Type`, `Avg Monthly GB Download`, `Online Security`, `Online Backup`, `Device Protection Plan`, `Premium Tech Support`, `Streaming TV`, 
       `Streaming Movies`, `Streaming Music`, `Unlimited Data`, Contract, `Paperless Billing`, `Payment Method`, `Monthly Charge`, `Total Charges`, `Total Refunds`, `Total Extra Data Charges`, `Total Long Distance Charges`, `Total Revenue`, 
       `Customer Status`, `Churn Category`, `Churn Reason`,ROW_NUMBER() OVER(
           PARTITION BY  Gender, Age, Married, City, `Zip Code`, Latitude, Longitude, `Number of Referrals`, `Tenure in Months`, Offer, 
                        `Phone Service`, `Avg Monthly Long Distance Charges`, `Multiple Lines`, `Internet Service`, `Internet Type`, `Avg Monthly GB Download`, `Online Security`, 
                        `Online Backup`, `Device Protection Plan`, `Premium Tech Support`, `Streaming TV`, `Streaming Movies`, `Streaming Music`, `Unlimited Data`, Contract, `Paperless Billing`, 
                        `Payment Method`, `Monthly Charge`, `Total Charges`, `Total Refunds`, `Total Extra Data Charges`, `Total Long Distance Charges`, `Total Revenue`, 
                        `Customer Status`, `Churn Category`, `Churn Reason`) AS row_num
FROM telecom_cust;




-- CHECKNG FOR DUPLICATES USING A CTE TABLE CREATED FROM telecom_cust
-- first create a cte(common table expression)

WITH duplicate_cte AS (
    SELECT 
        Gender, Age, Married, City, `Zip Code`, Latitude, Longitude, `Number of Referrals`, `Tenure in Months`, Offer, `Phone Service`, `Avg Monthly Long Distance Charges`, `Multiple Lines`, `Internet Service`, 
        `Internet Type`, `Avg Monthly GB Download`, `Online Security`, `Online Backup`, `Device Protection Plan`, `Premium Tech Support`, `Streaming TV`, `Streaming Movies`, `Streaming Music`, `Unlimited Data`, 
        Contract, `Paperless Billing`, `Payment Method`, `Monthly Charge`, `Total Charges`, `Total Refunds`, `Total Extra Data Charges`, `Total Long Distance Charges`, `Total Revenue`, `Customer Status`, 
        `Churn Category`, `Churn Reason`,
        ROW_NUMBER() OVER (
            PARTITION BY Gender, Age, Married, City, `Zip Code`, Latitude, Longitude, `Number of Referrals`, `Tenure in Months`, Offer, `Phone Service`, `Avg Monthly Long Distance Charges`, `Multiple Lines`, 
                         `Internet Service`, `Internet Type`, `Avg Monthly GB Download`, `Online Security`, `Online Backup`, `Device Protection Plan`, `Premium Tech Support`, `Streaming TV`, `Streaming Movies`, 
                         `Streaming Music`, `Unlimited Data`, Contract, `Paperless Billing`, `Payment Method`, `Monthly Charge`,`Total Charges`, `Total Refunds`, `Total Extra Data Charges`, 
                         `Total Long Distance Charges`, `Total Revenue`,`Customer Status`, `Churn Category`, `Churn Reason`
        ) AS row_num
    FROM telecom_cust
)

-- CHECKING IF THERE ARE DUPLICATES
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;
 -- OUTCOME: NO DUPLICATES



-- 2.STANDARDIZE THE DATA
CREATE TABLE `telecom_cust2` (
  `Customer ID` text,
  `Gender` text,
  `Age` int(11) DEFAULT NULL,
  `Married` text,
  `Number of Dependents` int(11) DEFAULT NULL,
  `City` text,
  `Zip Code` int(11) DEFAULT NULL,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL,
  `Number of Referrals` int(11) DEFAULT NULL,
  `Tenure in Months` int(11) DEFAULT NULL,
  `Offer` text,
  `Phone Service` text,
  `Avg Monthly Long Distance Charges` double DEFAULT NULL,
  `Multiple Lines` text,
  `Internet Service` text,
  `Internet Type` text,
  `Avg Monthly GB Download` int(11) DEFAULT NULL,
  `Online Security` text,
  `Online Backup` text,
  `Device Protection Plan` text,
  `Premium Tech Support` text,
  `Streaming TV` text,
  `Streaming Movies` text,
  `Streaming Music` text,
  `Unlimited Data` text,
  `Contract` text,
  `Paperless Billing` text,
  `Payment Method` text,
  `Monthly Charge` double DEFAULT NULL,
  `Total Charges` double DEFAULT NULL,
  `Total Refunds` double DEFAULT NULL,
  `Total Extra Data Charges` int(11) DEFAULT NULL,
  `Total Long Distance Charges` double DEFAULT NULL,
  `Total Revenue` double DEFAULT NULL,
  `Customer Status` text,
  `Churn Category` text,
  `Churn Reason` text
  -- `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select*
from telecom_cust2;

INSERT INTO telecom_cust2
 SELECT 
        `Customer ID`,Gender, Age, Married,`Number of Dependents`, City, `Zip Code`, Latitude, Longitude, `Number of Referrals`, `Tenure in Months`, Offer, `Phone Service`, `Avg Monthly Long Distance Charges`, `Multiple Lines`, `Internet Service`, 
        `Internet Type`, `Avg Monthly GB Download`, `Online Security`, `Online Backup`, `Device Protection Plan`, `Premium Tech Support`, `Streaming TV`, `Streaming Movies`, `Streaming Music`, `Unlimited Data`, 
        Contract, `Paperless Billing`, `Payment Method`, `Monthly Charge`, `Total Charges`, `Total Refunds`, `Total Extra Data Charges`, `Total Long Distance Charges`, `Total Revenue`, `Customer Status`, 
        `Churn Category`, `Churn Reason`,
        ROW_NUMBER() OVER (
            PARTITION BY `Customer ID`,Gender, Age, Married,`Number of Dependents`, City, `Zip Code`, Latitude, Longitude, `Number of Referrals`, `Tenure in Months`, Offer, `Phone Service`, `Avg Monthly Long Distance Charges`, `Multiple Lines`, 
                         `Internet Service`, `Internet Type`, `Avg Monthly GB Download`, `Online Security`, `Online Backup`, `Device Protection Plan`, `Premium Tech Support`, `Streaming TV`, `Streaming Movies`, 
                         `Streaming Music`, `Unlimited Data`, Contract, `Paperless Billing`, `Payment Method`, `Monthly Charge`,`Total Charges`, `Total Refunds`, `Total Extra Data Charges`, 
                         `Total Long Distance Charges`, `Total Revenue`,`Customer Status`, `Churn Category`, `Churn Reason`
        ) AS row_num
    FROM telecom_cust;


-- CHECKING IF THE TABLE WAS INSERTED INTO THE THIRD TABLE
select*
from telecom_cust2;

-- CHECKING IF THEY ARE ANY REPITATIONS OF CITIES
select distinct(City)
from telecom_cust2
order by 1;

-- CHECKING IF THEY ARE ANY REPITATIONS OF ZIPCODE
select distinct(`Zip Code`)
from telecom_cust2
order by 1;

select *
from telecom_cust2;
-- AFTER NOT COMING ACROSS ERRORS WE PROGRESS TO MYSQL EXPLORATORY DATA ANALYSIS

-- 3.NULL VALUES OR BLANK VALUES
-- 4.REMOVE ANY COLUMNS


-- MYSQL EXPLORATORY DATA ANALYSIS

-- NUMBER OF PEOPLE THAT STAYED 
select count(`customer status`)
from telecom_cust2
where `customer status` = 'Stayed';

-- NUMBER OF PEOPLE THAT WERE CHURNED

select count(`customer status`)
from telecom_cust2
where `customer status` = 'churned';

select *
from telecom_cust2;

-- TOTAL CUSTOMERS WITH REVENUES GREATER THAN AVERAGE REVENUE
select*
FROM telecom_cust2
where `total revenue`>(select avg(`total revenue`)
from telecom_cust2);

-- TOTAL CUSTOMERS WITH REVENUES LESS THAN AVERAGE REVENUE
select*
FROM telecom_cust2
where `total revenue`<(select avg(`total revenue`)
from telecom_cust2);

-- MALE CUSTOMERS WITH LESS REVENUE THAN AVERAGE
select count(gender) as male_customers
from telecom_cust2
where gender = 'male'
and `total revenue`<(select avg(`total revenue`)
from telecom_cust2);


-- MALE CUSTOMERS WITH GREATER REVENUE THAN AVERAGE
select count(gender) as male_customers
from telecom_cust2
where gender = 'male'
and `total revenue`>(select avg(`total revenue`)
from telecom_cust2);

-- FEMALE CUSTOMERS WITH LESS REVENUE THAN AVERAGE
select count(gender) as female_customers
from telecom_cust2
where gender = 'female'
and `total revenue`<(select avg(`total revenue`)
from telecom_cust2);

-- FEMALE CUSTOMERS WITH GREATER REVENUE THAN AVERAGE
select count(gender) as female_customers
from telecom_cust2
where gender = 'female'
and `total revenue`>(select avg(`total revenue`)
from telecom_cust2);


-- BUILDING TO A CUMLATIVE SUM OF THE REVENUE

SELECT distinct(city), `payment method`,`Total Revenue`
FROM telecom_cust2
WHERE `Customer Status` = 'stayed'
GROUP BY gender, married, `payment method`
order by `Total Revenue` asc;

-- USING THE SUM TO GET THE REQUIRED REVENUE WITHIN A CTE TABLE
WITH rolling_total AS (
    SELECT distinct(city), `payment method`, `total revenue`,
        SUM(`Total Revenue`) OVER (ORDER BY city) AS rolling_total_rev
    FROM telecom_cust2
    WHERE `Customer Status` = 'stayed'
    order by `Total Revenue` asc
)
SELECT DISTINCT(city), `payment method`,`total revenue`, rolling_total_rev
FROM rolling_total
ORDER BY rolling_total_rev ASC;

select *
from telecom_cust2;


-- RANKING THE CITIES BY TOTAL REVENUE USING DENSE RANK

WITH rolling_total AS (
    SELECT distinct(city), round(`total revenue`,2)as Total_reveue, `tenure in months`,
         round(SUM(`Total Revenue`) OVER (ORDER BY city),2) AS rolling_total_rev
    FROM telecom_cust2
    WHERE `Customer Status` = 'stayed'
)
SELECT *,
       DENSE_RANK() OVER (PARTITION BY city ORDER BY `tenure in months`) AS ranked_cities
FROM rolling_total
ORDER BY rolling_total_rev ASC;



-- RANKING THE CITIES BY TOTAL REVENUE USING  RANK

WITH rolling_total AS (
    SELECT DISTINCT city,round(`total revenue`,2) as Total_reveue, `tenure in months`,
        ROUND(SUM(`Total Revenue`) OVER (ORDER BY city), 2) AS rolling_total_rev
    FROM telecom_cust2
    WHERE `Customer Status` = 'stayed'
)
SELECT *,
       RANK() OVER (PARTITION BY city ORDER BY `tenure in months`) AS ranked_cities
FROM rolling_total
ORDER BY rolling_total_rev ASC;


























