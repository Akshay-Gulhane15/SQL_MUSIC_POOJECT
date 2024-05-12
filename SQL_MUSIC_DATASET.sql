CREATE DATABASE sql_practice

-- Q1: Who is the senior most employee based on job title? 

SELECT title, last_name, first_name 
FROM employee
ORDER BY levels DESC
LIMIT 1

-- Q2: Which countries have the most Invoices? 

SELECT COUNT(*) AS c, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY c DESC

-- Q3: What are top 3 values of total invoice? 

SELECT total 
FROM invoice
ORDER BY total DESC
limit 3

/* Q4: Which city has the best customers? 
query that returns one city that has the highest sum of invoice totals */

SELECT billing_city,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC
LIMIT 1;

--  Q5: Who is the best customer (The customer who has spent the most money ) 

SELECT customer.customer_id, first_name, last_name, SUM(total) AS total_spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total_spending DESC
LIMIT 1;

-- Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 

SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;

-- Q7:Let's invite the artists who have written the most rock music in our dataset.

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

-- Q8: All the track names that have a song length longer than the average song length.

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;

-- Q9 : Joins 

SELECT * FROM album2 
INNER JOIN artist
ON album2.artist_id = artist.artist_id

SELECT * FROM playlist_track AS p
RIGHT JOIN track AS t 
ON p.track_id = t.track_id

SELECT * FROM customer AS c
LEFT JOIN employee AS e
ON c.country = e.country

SELECT * FROM genre AS g
OUTER JOIN media_type AS m
ON g.name = m.name