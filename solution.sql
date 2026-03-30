-- Exercise 1: Normalize a Blog Database

create table if not exists authors(
id int auto_increment primary key,
name varchar(50) not null
);
create table if not exists posts(
id int auto_increment primary key,
title varchar(50) not null,
word_count int not null,
views int not null,
author_id int ,
constraint fk_posts_author foreign key (author_id) references authors(id)
);
INSERT INTO authors (name) VALUES
('Ali Hasan'),
('Leyla Mammadova');
INSERT INTO posts (title, word_count, views, author_id) VALUES
('Java Basics', 500, 120, 1),
('SQL Fundamentals', 650, 200, 2),
('Spring Boot Intro', 700, 150, 1);
select * from authors;


-- Exercise 2: Normalize an Airline Database

create table if not exists customers(
id int auto_increment primary key,
customer_name varchar(50) not null,
status varchar(50) not null,
mileage int not null
);

create table if not exists aircrafts(
id int auto_increment primary key,
aircraft_name varchar(50) not null,
seats int not null
);

create table if not exists flights(
id int auto_increment primary key,
flight_number varchar(10) not null unique,
mileage int not null,
aircraft_id int not null,
constraint fk_flights_aircraft foreign key(aircraft_id) references aircrafts(id)
);


create table if not exists bookings (
id int auto_increment primary key,
customer_id int not null,
constraint fk_bookings_customers foreign key(customer_id) references customers(id),
flight_id int not null,
constraint fk_bookings_flights foreign key(flight_number) references flights(flight_number)
);


INSERT INTO customers (customer_name, customer_status, mileage) VALUES
('Agustine Riviera', 'Silver', 115235),
('Alaina Sepulvida', 'None', 6008),
('Tom Jones', 'Gold', 205767),
('Sam Rio', 'None', 2653),
('Jessica James', 'Silver', 127656),
('Ana Janco', 'Silver', 136773),
('Jennifer Cortez', 'Gold', 300582),
('Christian Janco', 'Silver', 14642);

INSERT INTO aircrafts (aircraft_name, seats) VALUES
('Boeing 747', 400),
('Airbus A330', 236),
('Boeing 777', 264);


INSERT INTO flights (flight_number, mileage, aircraft_id) VALUES
('DL143', 135, 1),   
('DL122', 4370, 2),  
('DL53', 2078, 3),   
('DL222', 1765, 3),  
('DL37', 531, 1);    

INSERT INTO bookings (customer_id, flight_number) VALUES
(1, 'DL143'),
(1, 'DL122'),
(2, 'DL122'),
(3, 'DL122'),
(3, 'DL53'),
(3, 'DL222'),
(4, 'DL143'),
(4, 'DL37'),
(5, 'DL143'),
(5, 'DL122'),
(6, 'DL222'),
(7, 'DL222'),
(8, 'DL222');

-- Exercise 3: Write SQL Queries on the Airline Database
-- 1.Total number of flights:
select count(distinct flight_number) from flights;

-- 2.Average flight distance:
select avg(milage) from flights;

-- 3.Average number of seats per aircraft:
select avg(seats) from aircrafts;

-- 4.Average miles flown by customers, grouped by status:
select status, avg(milage) from customers group by status;

-- 5.Max miles flown by customers, grouped by status:
select status, max(milage) from customers group by status;

-- 6.Number of aircrafts with "Boeing" in their name:
select count(*) from aircrafts where aircraft_name like '%Boeing%';

-- 7.Flights with distance between 300 and 2000 miles:
select * from flights where mileage between 300 and 2000;

-- 8.Average flight distance booked, grouped by customer status:
select c.status, avg(f.milage) 
from bookings b 
join costumers c on b.customer_id = c.id
join flights f ON b.flight_number = f.flight_number
group by status;

-- 9.Most booked aircraft among Gold status members:
select a.aircraft_name, count(*) as total_booking
from bookings b 
join costumers c on b.cucustomer_id=c.id
join flights f ON b.flight_number = f.flight_number
join aircrafts a ON a.aircraft_id= a.id
where c.status = 'GOLD'
group by a.name
order by total_booking desc 
limit 1;


