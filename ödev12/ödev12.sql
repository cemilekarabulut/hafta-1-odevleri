--1. film tablosunda film uzunluğu length sütununda gösterilmektedir. Uzunluğu ortalama film uzunluğundan fazla kaç tane film vardır?
SELECT COUNT(*) FROM film WHERE length > (SELECT AVG(length) FROM film);
--2. film tablosunda en yüksek rental_rate değerine sahip kaç tane film vardır?
SELECT COUNT(*) FROM film WHERE rental_rate = (SELECT MAX(rental_rate) FROM film);
--3. film tablosunda en düşük rental_rate ve en düşük replacement_cost değerlerine sahip filmleri sıralayınız.
SELECT * FROM film WHERE (rental_rate, replacement_cost) = (SELECT MIN(rental_rate), MIN(replacement_cost) FROM film);
--4. payment tablosunda en fazla sayıda alışveriş yapan müşterileri(customer) sıralayınız.
SELECT * FROM customer
WHERE customer_id IN (
	SELECT shoppings.customer_id 
	FROM (SELECT customer_id, COUNT(*) as shopping_count FROM payment GROUP BY customer_id ) AS shoppings
	WHERE shoppings.shopping_count >= ALL (
		SELECT COUNT(*) as shopping_count FROM payment GROUP BY customer_id 
	)
);