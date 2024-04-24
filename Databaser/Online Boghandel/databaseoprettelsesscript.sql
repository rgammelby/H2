-- drops db if it exists, if/when not, creates database
drop database if exists OnlineBookStore;
create database if not exists OnlineBookStore;

-- creates a database admin and grants all permissions
-- create user 'admin'@'localhost' identified by 'admin';
grant all privileges on OnlineBookStore.* to 'admin'@'localhost' with grant option;

-- ensures the rest of the script is applied to the correct database
use onlinebookstore;

-- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES 

-- starts creating tables with no outside references
create table Author (
	author_id smallint primary key auto_increment,  -- using smallints to conserve space, as i don't figure i'll have very many entries, otherwise int instead of smallint
    name varchar(256) not null  -- using varchar to accept any character in name
);
create index author_index on Author(name) using btree;

create table Genre (
	genre_id smallint primary key auto_increment,
    name varchar(256) not null
);
create index genre_index on Genre(name) using btree;

create table Book (
	book_id smallint primary key auto_increment,
    title varchar(256) not null,
    author smallint not null,
    price int not null,
    genre smallint not null,
    foreign key (author) references Author(author_id),
    foreign key (genre) references Genre(genre_id)
);
create index book_index on Book(title) using btree;
    
create table Address(
	address_id smallint primary key auto_increment,
    postcode varchar(4) not null,
    city varchar(50) not null
);
create index postcode_index on Address(postcode) using btree;
create index city_index on Address(city) using btree;
    
create table Customer (
	customer_id smallint primary key auto_increment,
    name varchar(256) not null,
    email varchar(256) not null,
    road_and_number varchar(256) not null,
    address smallint not null,
    foreign key (address) references Address(address_id)
);
create index customer_index on Customer(name) using btree;
    
-- name 'Order' unavailable
create table Purchase (
	order_id smallint primary key auto_increment,
    order_number int not null,
    customer smallint,
    foreign key (customer) references Customer(customer_id)
);
create index order_index on Purchase(order_number) using btree;

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
    change_type varchar(30),
    id_key smallint,
    table_name varchar(64),
    log_time timestamp not null default current_timestamp
);

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/postnumre.csv'
into table Address
fields terminated by ','
lines terminated by '\n'
ignore 1 lines (postcode, city);
    
show tables;

-- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES -- TABLES 

-- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS 

-- AUTHOR TRIGGERS
delimiter //
create trigger author_create_trigger
after insert
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.author_id, 'Insert successful. ', 'Author');
end;
//

create trigger author_update_trigger
after update
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.author_id, 'Update successful. ', 'Author');
end;
//

create trigger author_delete_trigger
after delete
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.author_id, 'Delete successful. ', 'Author');
end;//

-- BEFORE TRIGGERS

create trigger author_before_create_trigger
before insert
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.author_id, 'Attempting insert... ', 'Author');
end;
//

create trigger author_before_update_trigger
before update
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.author_id, 'Attempting update... ', 'Author');
end;
//

create trigger author_before_delete_trigger
before delete
on Author
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.author_id, 'Attempting delete... ', 'Author');
end;//
delimiter ;

-- GENRE TRIGGERS
delimiter //
create trigger genre_create_trigger
after insert
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.genre_id, 'Insert successful. ', 'Genre');
end;
//

create trigger genre_update_trigger
after update
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.genre_id, 'Update successful. ', 'Genre');
end;
//

create trigger genre_delete_trigger
after delete
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.genre_id, 'Delete successful. ', 'Genre');
end;//

-- BEFORE TRIGGERS
delimiter //
create trigger genre_before_create_trigger
before insert
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.genre_id, 'Attempting insert... ', 'Genre');
end;
//

create trigger genre_before_update_trigger
before update
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.genre_id, 'Attempting update... ', 'Genre');
end;
//

create trigger genre_before_delete_trigger
before delete
on Genre
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.genre_id, 'Attempting delete... ', 'Genre');
end;//
delimiter ;

-- BOOK TRIGGERS
delimiter //
create trigger book_create_trigger
after insert
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.book_id, 'Insert successful. ', 'Book');
end;
//

create trigger book_update_trigger
after update
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.book_id, 'Update successful. ', 'Book');
end;
//

create trigger book_delete_trigger
after delete
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.book_id, 'Delete successful. ', 'Book');
end;//

-- BEFORE TRIGGERS:
delimiter //
create trigger book_before_create_trigger
before insert
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.book_id, 'Attempting insert... ', 'Book');
end;
//

create trigger book_before_update_trigger
before update
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.book_id, 'Attempting update... ', 'Book');
end;
//

create trigger book_before_delete_trigger
before delete
on book
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.book_id, 'Attempting delete... ', 'Book');
end;//
delimiter ;

-- ADDRESS TRIGGERS
delimiter //
create trigger address_create_trigger
after insert
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.address_id, 'Insert successful. ', 'Address');
end;
//

create trigger address_update_trigger
after update
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.address_id, 'Update successful. ', 'Address');
end;
//

create trigger address_delete_trigger
after delete
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.address_id, 'Delete successful. ', 'Address');
end;//

-- BEFORE TRIGGERS:
delimiter //
create trigger address_before_create_trigger
before insert
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.address_id, 'Attempting insert... ', 'Address');
end;
//

create trigger address_before_update_trigger
before update
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.address_id, 'Attempting update... ', 'Address');
end;
//

create trigger address_before_delete_trigger
before delete
on address
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.address_id, 'Attempting delete... ', 'Address');
end;//
delimiter ;

-- CUSTOMER TRIGGERS
delimiter //
create trigger customer_create_trigger
after insert
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.customer_id, 'Insert successful. ', 'Customer');
end;
//

create trigger customer_update_trigger
after update
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.customer_id, 'Update successful. ', 'Customer');
end;
//

create trigger customer_delete_trigger
after delete
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.customer_id, 'Delete successful. ', 'Customer');
end;//

-- BEFORE TRIGGERS: 
delimiter //
create trigger customer_before_create_trigger
before insert
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.customer_id, 'Attempting insert... ', 'Customer');
end;
//

create trigger customer_before_update_trigger
before update
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.customer_id, 'Attempting update... ', 'Customer');
end;
//

create trigger customer_before_delete_trigger
before delete
on customer
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.customer_id, 'Attempting delete... ', 'Customer');
end;//
delimiter ;

-- PURCHASE TRIGGERS
delimiter //
create trigger purchase_create_trigger
after insert
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'Insert successful. ', 'Purchase');
end;
//

create trigger purchase_update_trigger
after update
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'Update successful. ', 'Purchase');
end;
//

create trigger purchase_delete_trigger
after delete
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.order_id, 'Delete successful. ', 'Purchase');
end;//

-- BEFORE TRIGGERS:
delimiter //
create trigger purchase_before_create_trigger
before insert
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'Attempting insert... ', 'Purchase');
end;
//

create trigger purchase_before_update_trigger
before update
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'Attempting update... ', 'Purchase');
end;
//

create trigger purchase_before_delete_trigger
before delete
on purchase
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.order_id, 'Attempting delete... ', 'Purchase');
end;//
delimiter ;

-- BOOKORDER TRIGGERS
delimiter //
create trigger bookorder_create_trigger
after insert
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'Insert successful. ', 'BookOrder');
end;
//

create trigger bookorder_update_trigger
after update
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'Update successful. ', 'BookOrder');
end;
//

create trigger bookorder_delete_trigger
after delete
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.order_id, 'Delete successful. ', 'BookOrder');
end;//

-- BEFORE TRIGGERS:
delimiter //
create trigger bookorder_before_create_trigger
before insert
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'Attempting insert... ', 'BookOrder');
end;
//

create trigger bookorder_before_update_trigger
before update
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (new.order_id, 'Attempting update... ', 'BookOrder');
end;
//

create trigger bookorder_before_delete_trigger
before delete
on bookorder
for each row
begin
	insert into bogreden_log (id_key, change_type , table_name)
    values (old.order_id, 'Attempting delete... ', 'BookOrder');
end;//
delimiter ;

-- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS -- TRIGGERS 

-- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA 

insert into Author
values (default, "J. R. R. Tolkien"),
	(default, "William Shakespeare"),
	(default, "George Orwell"),
	(default, "Leo Tolstoy"),
	(default, "C. S. Lewis"),
	(default, "Lewis Carroll"),
	(default, "Stephen King"),
	(default, "Stephanie Meyer");
    
insert into Genre
values (default, "Fantasy"),
	(default, "Science Fiction"),
	(default, "Mystery"),
	(default, "Novel"),
	(default, "Poetry"),
	(default, "Non-fiction"),
	(default, "Thriller"),
	(default, "Academic");
    
insert into Book
values (default, 'The Lord of the Rings', 1, 640, 1),
	(default, '1984', 3, 180, 1),
    (default, 'War and Peace', 4, 250, 7),
    (default, 'Hamlet', 2, 230, 5),
    (default, 'The Hunting of the Snark', 6, 120, 3),
    (default, 'Narnia', 5, 300, 1),
    (default, 'It', 7, 150, 7),
    (default, 'Twilight', 8, 120, 1);
    
-- default, name, mail, address, address_id
insert into Customer
values (default, 'Sascha G', 's@mail.dk', 'Søborg Hovedgade 9', (select address_id from address where postcode = '2870')),
	(default, 'Christine G', 'c@mail.dk', 'Toftevej 20', (select address_id from address where postcode = '7700')),
	(default, 'Bo B', 'bb@mail.dk', 'Vinkelvej 1', (select address_id from address where postcode = '4220')),
    (default, 'Benjamin L', 'b@mail.dk', 'Jagtvej 139', (select address_id from address where postcode = '2200')),
    (default, 'Henriette B', 'h@mail.dk', 'Ved Klostret 10', (select address_id from address where postcode = '2100')),
    (default, 'Markus Å', 'm@mail.dk', 'Elmegårdsvænget 19', (select address_id from address where postcode = '8210')),
    (default, 'Mette M', 'mm@mail.dk', 'Asfaltvej 9', (select address_id from address where postcode = '9000')),
    (default, 'Anne-Marie B', 'am@mail.dk', 'Nybro Vænge', (select address_id from address where postcode = '2800'));
    
-- def order_number int customer fk
insert into Purchase
values (default, 19825, 1),
	(default, 19623, 2),
    (default, 85263, 3),
    (default, 82612, 4),
    (default, 20631, 5),
    (default, 72153, 6),
    (default, 52015, 7),
    (default, 88221, 8);
	
-- default, order_number (fk order_id), book (fk book_id)
insert into BookOrder
values (default, 1, 1),
	(default, 1, 2),
	(default, 1, 7),
	(default, 1, 5),
	(default, 2, 7),
	(default, 2, 8),
	(default, 3, 4),
	(default, 4, 8),
	(default, 4, 4),
	(default, 4, 1),
	(default, 4, 2),
	(default, 5, 5),
	(default, 5, 4),
	(default, 5, 6),
	(default, 6, 3),
	(default, 7, 3),
	(default, 7, 8),
	(default, 8, 8),
	(default, 8, 3),
	(default, 8, 4);

-- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA 

-- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES

-- fetches logs made in a span of dates 
drop procedure if exists GetLogsBetweenDates;

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
drop procedure if exists GetBooksByAuthor;

delimiter //
create procedure GetBooksByAuthor (in authorName varchar(256))
begin 
	select title as Title, price as 'Price (kr.)', a.name as Author 
    from Book b
    join Author a 
    on b.author = a.author_id
    where b.author = (select author_id from Author where name like concat('%', authorName, '%'));
end //
delimiter ;

call GetBooksByAuthor('tolk');

-- get author of book
drop procedure if exists GetAuthorByBookTitle;

delimiter //
create procedure GetAuthorByBookTitle (in bookTitle varchar(256)) 
begin
	select b.title as Title, a.name as Author
    from Author a
    join Book b on a.author_id = b.author
    where b.title like concat('%', bookTitle, '%');
end //
delimiter ;

call GetAuthorByBookTitle('rings');

-- get customer info by customer
drop procedure if exists GetCustomerInfoByCustomerName;

delimiter //
create procedure GetCustomerInfoByCustomerName (in customerName varchar(256))
begin
	select c.name as Name, c.email as 'E-mail', c.road_and_number as Address, a.postcode as 'Zip Code', a.city as City
    from Customer c
    join Address a on c.address = a.address_id
    where c.name like concat('%', customerName, '%');
end //
delimiter ;

call GetCustomerInfoByCustomerName('G');

-- get orders by customer
drop procedure if exists GetOrdersByCustomer;

delimiter //
create procedure GetOrdersByCustomer (in customerName varchar(256))
begin
	select p.order_number, b.title, c.name from bookorder o
    join purchase p on o.order_number = p.order_id
    join customer c on p.customer = c.customer_id
    join book b on o.book = b.book_id
    where c.name like concat('%', customerName, '%');
end //
delimiter ;

call GetOrdersByCustomer('Sascha');

-- get book info by book
drop procedure if exists GetBookInfoByBookTitle;

delimiter //
create procedure GetBookInfoByBookTitle (in bookTitle varchar(256))
begin
	select b.title as Title, a.name as Author, b.price as 'Price (kr.)', g.name as Genre
    from Book b
    join Author a on b.author = a.author_id
    join Genre g on b.genre = g.genre_id
    where title like concat('%', bookTitle, '%');
end //
delimiter ;

call GetBookInfoByBookTitle('the');
/*
delimiter //
create procedure
begin
	
end //
delimiter;
*/

delimiter //
create procedure CreateNewUser (in customerName varchar(256), in customerMail varchar(256), in customerAddress varchar(256), in addressIdFromPostcode smallint)
begin
	insert into Customer
    values (default, customerName, customerMail, customerAddress, (select address_id from Address where postcode = addressIdFromPostcode));
end //
delimiter ;

call CreateNewUser('Peter Jensen', 'pj@mail.dk', 'Duevænget 12', 7700);

delimiter //
create procedure CreateNewAuthor (in authorName varchar(256))
begin
	insert into Author
    values(default, authorName);
end //
delimiter ;

delimiter //
create procedure CreateNewGenre (in genreName varchar(50))
begin
	insert into Genre
    values (default, genreName);
end //
delimiter ;

delimiter //
create procedure CreateNewBook (in bookTitle varchar(256), in bookAuthor varchar(256), in bookPrice smallint, in bookGenre varchar(50))
begin
	-- declare author and genre ids to ensure the book gets created even if the author or genre is not currently in the database
	declare authorId smallint;
    declare genreId smallint;
    
    -- checks validity of author and genre in procedure call
    select author_id into authorId from Author where name like concat('%', bookAuthor, '%');
    select genre_id into genreId from Genre where name like concat('%', bookGenre, '%');
    
    -- if author or genre from procedure call does not exist, create record for that author or genre
    if authorId is null then
		call CreateNewAuthor(bookAuthor);
        select LAST_INSERT_ID() into authorId;
    end if;
    
    if genreId is null then
		call CreateNewGenre(bookGenre);
        select LAST_INSERT_ID() into genreId;
    end if;
    
	insert into Book
    values (default, bookTitle, authorId, bookPrice, genreId);
end //
delimiter ;

call CreateNewBook('A Game of Thrones', 'George R. R. Martin', 100, 'Fantasy');
/*
delimiter //
create procedure CreateNewOrder ()
begin
	
end //
delimiter ;

delimiter //
create procedure CreateNewBookOrder ()
begin
	
end //
delimiter ; */

-- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES -- STORED PROCEDURES