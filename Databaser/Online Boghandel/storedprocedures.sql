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