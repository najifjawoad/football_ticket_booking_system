DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

create table Users (
  user_id serial primary key,
  full_name varchar(100) not null,
  email varchar(100) not null unique,
  role varchar(20) not null check (role in ('Ticket Manager', 'Football Fan')),
  phone_number varchar(20) unique
);

create table matches (
  match_id serial primary key,
  fixture varchar(200) not null,
  tournament_category varchar(100) not null,
  base_ticket_price decimal(10, 2) not null check (base_ticket_price >= 0),
  match_status varchar(20) not null check (
    match_status in (
      'Available',
      'Selling Fast',
      'Sold Out',
      'Postponed'
    )
  )
)
create table bookings (
  booking_id serial primary key,
  user_id int not null,
  match_id int not null,
  seat_number varchar(20) ,
  payment_status varchar(20) check (
    payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  ),
  total_cost decimal(10, 2) not null check (total_cost >= 0),
  constraint fk_booking_user foreign key (user_id) references users (user_id) on delete cascade,
  constraint fk_booking_match foreign key (match_id) references matches (match_id) on delete cascade,
  constraint unique_match_seat unique (match_id, seat_number)
)


insert into users(user_id , full_name ,email , role , phone_number)
values
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

insert into matches(match_id, fixture, tournament_category, base_ticket_price, match_status)
values
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

insert into bookings(booking_id , user_id , match_id , seat_number , payment_status , total_cost)
values
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);