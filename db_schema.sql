CREATE TABLE items
(id integer not null primary key,
 title char(100) not null,
 description varchar(500),
 date timestamp not null, 
 buy_sell boolean not null,
 hash char(8) not null
);