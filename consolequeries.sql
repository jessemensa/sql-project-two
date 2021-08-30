/* fields are id, first_name, last_name and email */
desc customers;
/* fields are id, order_date, amount, and customer_id */
desc orders;

select * from customers;
select * from orders;

select * from customers, orders where customers.id = orders.customer_id;

/* Implicit Inner Joins */
select first_name, last_name, order_date, amount from customers, orders where
      customers.id = orders.customer_id;

/* Explicit Inner Joins */
/* Group by and order by */
select * from customers join orders on customers.id = orders.customer_id;
select first_name, last_name, order_date, amount from customers
       join orders on customers.id = orders.customer_id;
select first_name, last_name, order_date, amount from customers
       join orders on customers.id = orders.customer_id order by order_date;
select first_name, last_name, sum(amount) as total_spent from customers
       join orders on customers.id = orders.customer_id
       group by orders.customer_id order by total_spent desc;

/* Joins */
select * from customers left join orders on customers.id = orders.customer_id;
select first_name, last_name, ifnull(sum(amount), 0) as total_spent
       from customers left join orders on customers.id = orders.customer_id
       group by customers.id order by total_spent;


/* Movie Reviews */
desc reviews; /* id, rating, series_id, reviewer_id */
desc series; /* id, title, released_year, genre */
desc reviewers; /* id first_name last_name */

select * from series; /* all columns and rows in series */
select * from reviews; /* same */
select * from reviewers; /* same */

/* get ratings for all the movies */
select title, rating from series join reviews on series.id = reviews.series_id;

/* get the average rating for all the movies */
select title, avg(rating) as 'average rating' from series
       join reviews on series.id = reviews.series_id
       group by series.id order by 'average rating';
/* get the first name, last name and ratings of reviewers */
select first_name, last_name, rating from reviewers
       inner join reviews on reviewers.id = reviews.reviewer_id;
/* get the first, last name and ratings of reviewers */
select first_name, last_name, rating from reviews
       inner join reviewers on reviews.reviewer_id = reviewers.id;
/* get the unreviewed series */
select title as unreviewedseries from series
       left join reviews on series.id = reviews.series_id where
       rating is null;
/* get the average rating of all movie genres */
select genre, round(avg(rating), 2) as averagerating from series
       inner join reviews on series.id = reviews.series_id group by genre;
/*
get the first name, lastname and number of series rated
highest and lowest ratings for movies, average ratings and status of reviewers 
   */
select first_name, last_name, count(rating) as count,
       ifnull(min(rating), 0) as min,
       ifnull(max(rating), 0) as max,
       round(ifnull(avg(rating), 0), 2) as avg,
       if(count(rating) > 0, 'active', 'inactive') as status
       from reviewers left join reviews on reviewers.id = reviews.reviewer_id
       group by reviewers.id;