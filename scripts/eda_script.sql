-- DUPLICATE RECORDS
Select 
invoice,stockcode,description,quantity,invoicedate,price,customer_id,country,
count(*) as duplicate_records
from public.retail_combined
group by invoice,stockcode,description,quantity,invoicedate,price,customer_id,country
having count(*)>1



--
Select * from retail_combined;

-- CHECK IF CUSTOMER_ID IS NULL

Select count(*) 
from retail_combined
where "customer_id" is null


-- CHECK IF PRICE LESS THAN OR EQUAL TO ZERO

Select 
--count(*)
*
from retail_combined
where price<=0

-- CHECK IF QUANTITY IS LESS THAN ZERO

Select 
-- count(*)
*
from retail_combined
where quantity<=0


-- CHECK IF THERE ARE ANY NULL INVOICES CELL
Select invoice from retail_combined
where invoice is null


-- WRITE QUERY TO DEDUPLICATE THE DATA AND SAVE IT AS TABLE - retailcleaned
With deduplicates as (
Select 
*,
ROW_NUMBER() OVER(
PARTITION BY invoice,stockcode,description,quantity,invoicedate,price,customer_id,country
ORDER BY (SELECT NULL)
) as row_num
from retail_combined
)
select 
invoice,stockcode,description,quantity,invoicedate,price,customer_id,country,sourcesheet
from deduplicates
where row_num =1



