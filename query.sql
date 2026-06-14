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