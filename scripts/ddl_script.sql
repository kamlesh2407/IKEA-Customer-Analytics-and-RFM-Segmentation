Select * from public.retail_year_2009_2010;

Select * from public.retail_year_2010_2011;

DROP 

-- COMBINE BOTH YEARS AND CONVERT TYPE SAFELY
Select 
Trim("Invoice") as invoice,
Trim("StockCode") as stockcode,
"Description" as description,
"Quantity" as quantity,
TO_TIMESTAMP(TRIM("InvoiceDate"), 'DD-MM-YYYY HH24:MI')::TIMESTAMP AS invoicedate,
"Price" as price,
"Customer ID" as customer_id,
Trim("Country") as country
INTO public.retail_combined
from public.retail_year_2010_2011

UNION ALL

Select 
Trim("Invoice") as invoice,
Trim("StockCode") as stockcode,
"Description" as description,
"Quantity" as quantity,
TO_TIMESTAMP(TRIM("InvoiceDate"), 'DD-MM-YYYY HH24:MI')::TIMESTAMP AS invoicedate,
"Price" as price,
"Customer ID" as customer_id,
Trim("Country") as country
from public.retail_year_2009_2010



-- CHECK IF THE DATA CONVERSION Costed some data loss

Select count(*) as total_Rows from public.retail_combined;

Select count("invoicedate") as failed_invoicedate from public.retail_combined where invoicedate is null;

Select count("price") as failed_price from public.retail_combined where price is null;

