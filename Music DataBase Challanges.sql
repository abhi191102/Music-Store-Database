-- Challanges Intermediate--
/* Who is the senior most Employee Base on the Job title*/

SELECT * from employee
order by level desc
limit 1;

/* Which Country have most Invoice*/

select count(*) as c , billing_country
from invoice
group by billing country
order by c desc;

/* What are top 3 values of total invoice */

select total from invoice
order by total desc 
limit 3

/* Which city has the best customer ? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of total invoice 
Return both the City name and sum of all invoice totals */

select sum(total) as invoice_total , billing_city
from invoice
group by billing city
order by invoice_total desc;

/* Who is the best customer ? the customer who has spent the most money will be declared as the best customer. Write a query that returns the person who spent the most money */

select customer.customer_id , customer.first_name , customer.last_name , sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1;






