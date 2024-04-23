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

create table Genre (
	genre_id smallint primary key auto_increment,
    name varchar(256) not null
);

create table City (
	city_id smallint primary key auto_increment,
    name varchar(256) not null
);
    
create table Postcode (
	postcode_id smallint primary key auto_increment,
    postcode smallint not null  -- smallint to ensure mathematical operations are available on postcodes
);
    
create table Book (
	book_id smallint primary key auto_increment,
    title varchar(256) not null,
    author smallint not null,
    price int not null,
    genre smallint not null,
    foreign key (author) references Author(author_id),
    foreign key (genre) references Genre(genre_id)
);
    
create table Address(
	address_id smallint primary key auto_increment,
    postcode smallint not null,
    city smallint not null,
    foreign key (postcode) references Postcode(postcode_id),
    foreign key (city) references City(city_id)
);
    
create table Customer (
	customer_id smallint primary key auto_increment,
    name varchar(256) not null,
    email varchar(256) not null,
    road_and_number varchar(256) not null,
    address smallint not null,
    foreign key (address) references Address(address_id)
);
    
-- name 'Order' unavailable
create table Purchase (
	order_id smallint primary key auto_increment,
    order_number int not null,
    customer smallint,
    foreign key (customer) references Customer(customer_id)
);

create table BookOrder (
	order_id smallint primary key auto_increment,
    order_number smallint not null,
    book smallint not null,
    foreign key (order_number) references Purchase(order_id),
    foreign key (book) references Book(book_id)
);
    
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

-- STORED PROCEDURES

-- insert statement for later procedures to work
insert into Author
values (default, 'Hejsa');

-- insert statement for GetInfoByBookTitle procedure to work
insert into Genre
values (default, 'Fantasy');

insert into Book 
values (default, 'Hej Bog', 1, 100, 1);

-- insert statement for GetCustomerInfoByCustomerName to work
insert into City
values (default, 'Dyssegård');
insert into Postcode
values (default, 2870);
insert into Address
values (default, 1, 1);
insert into Customer
values (default, 'Sascha', 's@mail.dk', 'Søborg Hovedgade 1', 1);


-- fetches logs made in a span of dates 
delimiter //
create procedure GetLogsBetweenDates (IN firstDay INT, IN firstMonth INT, IN firstYear varchar(4), IN lastDay INT, IN lastMonth INT, IN lastYear varchar(4))
begin
    if firstYear = '' then set firstYear = '2024'; end if;
    if lastYear = '' then set lastYear = '2024'; end if;
    select log_id, change_type, table_name, id_key, log_time 
    from bogreden_log
    where log_time between concat(firstYear, '-', firstMonth, '-', firstDay)
    and concat(lastYear, '-', lastMonth, '-', lastDay)
    order by log_time;
end //
delimiter ;

call GetLogsBetweenDates('23', '04', '', '27', '04', '');

-- get books by author
delimiter //
create procedure GetBooksByAuthor (in authorName varchar(256))
begin 
	select title as Title, price as 'Price (kr.)', a.name as Author 
    from Book b
    join Author a 
    on b.author = a.author_id
    where b.author = (select author_id from Author where name = authorName);
end //
delimiter ;

call GetBooksByAuthor('Hejsa');

-- get author of book
delimiter //
create procedure GetAuthorByBookTitle (in bookTitle varchar(256)) 
begin
	select b.title as Title, a.name as Author
    from Author a
    join Book b on a.author_id = b.author
    where b.title = bookTitle;
end //
delimiter ;

call GetAuthorByBookTitle('Hej Bog');

-- get customer info by customer
delimiter //
create procedure GetCustomerInfoByCustomerName (in customerName varchar(256))
begin
	select c.name as Name, c.email as 'E-mail', c.road_and_number as Address, ci.name as City, p.postcode as Postcode
    from Customer c
    join Address a on c.address = a.address_id
    join City ci on a.city = ci.city_id
    join Postcode p on a.postcode = p.postcode_id
    where c.name = customerName;
end //
delimiter ;

call GetCustomerInfoByCustomerName('Sascha');

-- get orders by customer
delimiter //
create procedure GetOrdersByCustomer (in customerName varchar(256))
begin
	select o.order_id as 'Order ID', o.order_number as 'Order No.', c.name 
    from Purchase o
    join Customer c on o.customer = c.customer_id
    where o.name = customerName;
end //
delimiter ;

-- get book info by book
delimiter //
create procedure GetBookInfoByBookTitle (in bookTitle varchar(256))
begin
	select b.title as Title, a.name as Author, b.price as 'Price (kr.)', g.name as Genre
    from Book b
    join Author a on b.author = a.author_id
    join Genre g on b.genre = g.genre_id
    where title = bookTitle;
end //
delimiter ;

call GetBookInfoByBookTitle('Hej Bog');

-- STORED PROCEDURES