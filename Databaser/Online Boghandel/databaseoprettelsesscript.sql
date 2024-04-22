-- drops db if it exists, if/when not, creates database
drop database if exists OnlineBookStore;
create database if not exists OnlineBookStore;

-- creates a database admin and grants all permissions
-- create user 'admin'@'localhost' identified by 'admin';
grant all privileges on OnlineBookStore.* to 'admin'@'localhost' with grant option;

-- ensures the rest of the script is applied to the correct database
use onlinebookstore;

-- starts creating tables with no outside references
create table Author (
	author_id smallint primary key auto_increment,  -- using smallints to conserve space, as i don't figure i'll have very many entries, otherwise int instead of smallint
    name varchar(256) not null  -- using varchar to accept any character in name
);

-- triggers:
	-- log new author creation
    -- log author change
    -- log author deletion

create table Genre (
	genre_id smallint primary key auto_increment,
    name varchar(256) not null
);

-- triggers:
	-- log creation
    -- log change
    -- log delete

create table City (
	city_id smallint primary key auto_increment,
    name varchar(256) not null
);

-- triggers:
	-- log creation
    -- log change
    -- log delete
    
create table Postcode (
	postcode_id smallint primary key auto_increment,
    postcode smallint not null  -- smallint to ensure mathematical operations are available on postcodes
);

-- triggers:
	-- log creation
    -- log change
    -- log delete
    
create table Book (
	book_id smallint primary key auto_increment,
    title varchar(256) not null,
    author smallint not null,
    price int not null,
    genre smallint not null,
    foreign key (author) references Author(author_id),
    foreign key (genre) references Genre(genre_id)
);

-- triggers:
	-- log creation
    -- log change
    -- log delete
    
create table Address(
	address_id smallint primary key auto_increment,
    postcode smallint not null,
    city smallint not null,
    foreign key (postcode) references Postcode(postcode_id),
    foreign key (city) references City(city_id)
);

-- triggers:
	-- log creation
    -- log change
    -- log delete
    
create table Customer (
	customer_id smallint primary key auto_increment,
    name varchar(256) not null,
    email varchar(256) not null,
    road_and_number varchar(256) not null,
    address smallint not null,
    foreign key (address) references Address(address_id)
);

-- triggers:
	-- log creation
    -- log change
    -- log delete
    
-- name 'Order' unavailable
create table Purchase (
	order_id smallint primary key auto_increment,
    order_number int not null,
    customer smallint,
    foreign key (customer) references Customer(customer_id)
);

-- triggers:
	-- log creation
    -- log change
    -- log delete
    
create table BookOrder (
	order_id smallint primary key auto_increment,
    order_number smallint not null,
    book smallint not null,
    foreign key (order_number) references Purchase(order_id),
    foreign key (book) references Book(book_id)
);

-- triggers:
	-- log creation
    -- log change
    -- log delete
    
    -- log table
create table bogreden_log (
	log_id int primary key auto_increment,
    change_type varchar(10),
    id_key smallint,
    table_name varchar(64),
    log_time timestamp not null default current_timestamp
);
    
show tables;

-- TRIGGERS:

-- AUTHOR TRIGGERS
delimiter //
create trigger author_create_trigger
after insert
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.author_id, 'INSERT', 'Author');
end;

create trigger author_update_trigger
after update
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.author_id, 'UPDATE', 'Author');
end;

create trigger author_delete_trigger
after delete
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.author_id, 'DELETE', 'Author');
end//
delimiter ;

-- GENRE TRIGGERS
delimiter //
create trigger genre_create_trigger
after insert
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.genre_id, 'INSERT', 'Genre');
end;

create trigger genre_update_trigger
after update
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.genre_id, 'UPDATE', 'Genre');
end;

create trigger genre_delete_trigger
after delete
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.genre_id, 'DELETE', 'Genre');
end//
delimiter ;

-- CITY TRIGGERS
delimiter //
create trigger city_create_trigger
after insert
on city
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.city_id, 'INSERT', 'City');
end;

create trigger city_update_trigger
after update
on city
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.city_id, 'UPDATE', 'City');
end;

create trigger city_delete_trigger
after delete
on city
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.city_id, 'DELETE', 'City');
end//
delimiter ;

-- POSTCODE TRIGGERS
delimiter //
create trigger postcode_create_trigger
after insert
on postcode
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.postcode_id, 'INSERT', 'Postcode');
end;

create trigger _update_trigger
after update
on postcode
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.postcode_id, 'UPDATE', 'Postcode');
end;

create trigger _delete_trigger
after delete
on postcode
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.postcode_id, 'DELETE', 'Postcode');
end//
delimiter ;

-- BOOK TRIGGERS
delimiter //
create trigger book_create_trigger
after insert
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.book_id, 'INSERT', 'Book');
end;

create trigger book_update_trigger
after update
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.book_id, 'UPDATE', 'Book');
end;

create trigger book_delete_trigger
after delete
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.book_id, 'DELETE', 'Book');
end//
delimiter ;

-- ADDRESS TRIGGERS
delimiter //
create trigger address_create_trigger
after insert
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.address_id, 'INSERT', 'Address');
end;

create trigger address_update_trigger
after update
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.address_id, 'UPDATE', 'Address');
end;

create trigger address_delete_trigger
after delete
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.address_id, 'DELETE', 'Address');
end//
delimiter ;

-- CUSTOMER TRIGGERS
delimiter //
create trigger customer_create_trigger
after insert
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.customer_id, 'INSERT', 'Customer');
end;

create trigger customer_update_trigger
after update
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.customer_id, 'UPDATE', 'Customer');
end;

create trigger customer_delete_trigger
after delete
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.customer_id, 'DELETE', 'Customer');
end//
delimiter ;

-- PURCHASE TRIGGERS
delimiter //
create trigger purchase_create_trigger
after insert
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'INSERT', 'Purchase');
end;

create trigger purchase_update_trigger
after update
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'UPDATE', 'Purchase');
end;

create trigger purchase_delete_trigger
after delete
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.order_id, 'DELETE', 'Purchase');
end//
delimiter ;

-- BOOKORDER TRIGGERS
delimiter //
create trigger bookorder_create_trigger
after insert
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'INSERT', 'BookOrder');
end;

create trigger bookorder_update_trigger
after update
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'UPDATE', 'BookOrder');
end;

create trigger bookorder_delete_trigger
after delete
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.order_id, 'DELETE', 'BookOrder');
end//
delimiter ;

insert into Author
values (default, 'Halløj');

select * from bogreden_log;    