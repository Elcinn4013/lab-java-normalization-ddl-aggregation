-- Exercise 1: Normalize a Blog Database

create table if not exists authors(
id int auto_increment primary key,
name varchar(50) not null
);
create table if not exists posts(
id int auto_increment primary key,
title varchar(100) not null,
word_count int not null,
views int not null,
author_id int not null,
constraint fk_posts_author foreign key (author_id) references authors(id)
);
INSERT INTO authors (name) 
VALUES ('Maria Charlotte'), ('Juan Perez'), ('Gemma Alcocer');

INSERT INTO posts (author_id, title, word_count, views) VALUES
  (1, 'Best Paint Colors', 814, 14),
  (2, 'Small Space Decorating Tips', 1146, 221),
  (1, 'Hot Accessories', 986, 105),
  (1, 'Mixing Textures', 765, 22),
  (2, 'Kitchen Refresh', 1242, 307),
  (1, 'Homemade Art Hacks', 1002, 193),
  (3, 'Refinishing Wood Floors', 1571, 7542);


-- Exercise 2: Normalize an Airline Database
create table if not exists customers (
    id int auto_increment primary key,
    customer_name varchar(50) not null,
    status varchar(50) not null,
    total_mileage int not null
);

create table if not exists aircrafts (
    id int auto_increment primary key,
    aircraft_name varchar(50) not null,
    seats int not null
);

create table if not exists flights (
    id int auto_increment primary key,
    flight_number varchar(10) not null unique,
    mileage int not null,
    aircraft_id int not null,
    constraint fk_flights_aircraft
        foreign key (aircraft_id) references aircrafts(id)
);

create table if not exists bookings (
    id int auto_increment primary key,
    customer_id int not null,
    flight_number varchar(10) not null,
    constraint fk_bookings_customers
        foreign key (customer_id) references customers(id),
    constraint fk_bookings_flights
        foreign key (flight_number) references flights(flight_number)
);

insert into customers (customer_name, status, total_mileage) values
('Agustine Riviera', 'Silver', 115235),
('Alaina Sepulvida', 'None', 6008),
('Tom Jones', 'Gold', 205767),
('Sam Rio', 'None', 2653),
('Jessica James', 'Silver', 127656),
('Ana Janco', 'Silver', 136773),
('Jennifer Cortez', 'Gold', 300582),
('Christian Janco', 'Silver', 14642);

insert into aircrafts (aircraft_name, seats) values
('Boeing 747', 400),
('Airbus A330', 236),
('Boeing 777', 264);

insert into flights (flight_number, mileage, aircraft_id) values
('DL143', 135, 1),
('DL122', 4370, 2),
('DL53', 2078, 3),
('DL222', 1765, 3),
('DL37', 531, 1);

insert into bookings (customer_id, flight_number) values
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
select avg(mileage) from flights;

-- 3.Average number of seats per aircraft:
select avg(seats) from aircrafts;

-- 4.Average miles flown by customers, grouped by status:
select status, avg(total_mileage) from customers group by status;

-- 5.Max miles flown by customers, grouped by status:
select status, max(total_mileage) from customers group by status;

-- 6.Number of aircrafts with "Boeing" in their name:
select count(*) from aircrafts where aircraft_name like '%Boeing%';

-- 7.Flights with distance between 300 and 2000 miles:
select * from flights where mileage between 300 and 2000;

-- 8.Average flight distance booked, grouped by customer status:
select c.status, avg(f.mileage) 
from bookings b 
join customers c on b.customer_id = c.id
join flights f ON b.flight_number = f.flight_number
group by status;

-- 9.Most booked aircraft among Gold status members:
select a.aircraft_name, count(*) as total_booking
from bookings b 
join customers c on b.customer_id =c.id
join flights f ON b.flight_number = f.flight_number
join aircrafts a ON f.aircraft_id= a.id
where c.status = 'Gold'
group by a.aircraft_name
order by total_booking desc 
limit 1;


