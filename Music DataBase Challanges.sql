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

-- Challanges Moderate--
/*Write a query to return the Email, First name, Last Name & Genre for all Rock Music Listeners . Return your list order Alphabatically by email starting with A */
select distinct email,first_name, last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoiceline on  invoice.invoice_id = invoiceline.invoice_id
where track_id in (
  select track_id from track
  join genre on track.genre_id = genre.genre_id
  where genre.name like 'Rock')
order by email;

/*Lets invite the Artist who have written the most Rock Music in our Dataset . Write a query that returns the artist name and total track count of the top 10 rock bands */
 Select artist.artist_id , artist.name ,count(artist.artist_id) as number_of_songs
from track
join album on track.album_id = album.album_id
join artist on album.artist_id = artist.artist_id
join genre on track.genre_id = genre.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;

/*Return the track names that have the song length longer than the average song length. return the name and milliseconds for each track. Order by the song length
with the longest song listen first*/
select name , milliseconds from track
where milliseconds > ( select avg(milliseconds) from track)
order by milliseconds desc;

/*Find how much amount spent by each customer on artists ? Write a query to return customer name , artist name and total spents*/
with best_selling_artist as (
  select artist.artist_id as artist_id , artist.name as artist_name, 
  sum(invoice_line.unit_price*invoice_line.quntity) as total_sales from invoice_line
  
join track on track.track_id = invoice_line.track_id 
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
  group by 1
  order by 3 desc
  limit 1 )

select customer_id , c.first_name , c.last_name , bsa.artist_name, sum(il.unit_price * il.quantity) as amount_spent
from invoice i
join customer c on c.customer_id  = i.customer_id
join invoice_lin il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album alb on alb.album_id = t.album_id
join best_selling_artist bsa on bsa.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 desc;















