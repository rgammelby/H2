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