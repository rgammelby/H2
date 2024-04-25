-- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA 

USE OnlineBookStore;

-- Inserting dummy data into the Author table
INSERT INTO Author (first_name, last_name)
VALUES 
    ('J. R. R.', 'Tolkien'),
	('William', 'Shakespeare'),
	('George', 'Orwell'),
	('Leo', 'Tolstoy'),
	('C. S.', 'Lewis'),
	('Lewis', 'Carroll'),
	('Stephen', 'King'),
	('Stephanie', 'Meyer');
    
-- Inserting dummy data into the Genre table
INSERT INTO Genre (name)
VALUES 
    ('Fantasy'),
	('Science Fiction'),
	('Mystery'),
	('Novel'),
	('Poetry'),
	('Non-fiction'),
	('Thriller'),
	('Academic');
    
-- Inserting dummy data into the Book table
INSERT INTO Book (title, author, price, genre)
VALUES 
    ('The Lord of the Rings', 1, 640, 1),
	('1984', 3, 180, 1),
    ('War and Peace', 4, 250, 7),
    ('Hamlet', 2, 230, 5),
    ('The Hunting of the Snark', 6, 120, 3),
    ('Narnia', 5, 300, 1),
    ('It', 7, 150, 7),
    ('Twilight', 8, 120, 1);
    
-- default, name, mail, address, address_id
INSERT INTO Customer (first_name, last_name, email, road_and_number, address)
VALUES 
	('Sascha', 'Gammelby', 's@mail.dk', 'Søborg Hovedgade 9', (SELECT address_id FROM address WHERE postcode = '2870')),
	('Christine', 'Grindsted', 'c@mail.dk', 'Toftevej 20', (SELECT address_id FROM address WHERE postcode = '7700')),
	('Bo', 'Bjørnsson', 'bb@mail.dk', 'Vinkelvej 1', (SELECT address_id FROM address WHERE postcode = '4220')),
    ('Benjamin', 'Lohse', 'b@mail.dk', 'Jagtvej 139', (SELECT address_id FROM address WHERE postcode = '2200')),
    ('Henriette', 'Bjerregaard', 'h@mail.dk', 'Ved Klostret 10', (SELECT address_id FROM address WHERE postcode = '2100')),
    ('Markus', 'Åland', 'm@mail.dk', 'Elmegårdsvænget 19', (SELECT address_id FROM address WHERE postcode = '8210')),
    ('Mette', 'Måløv', 'mm@mail.dk', 'Asfaltvej 9', (SELECT address_id FROM address WHERE postcode = '9000')),
    ('Anne-Marie', 'Bisse', 'am@mail.dk', 'Nybro Vænge', (SELECT address_id FROM address WHERE postcode = '2800'));

-- Inserting dummy data into the Purchase table
SET @order1 = 0;
SET @order2 = 0;
SET @order3 = 0;
SET @order4 = 0;
SET @order5 = 0;
SET @order6 = 0;
SET @order7 = 0;
SET @order8 = 0;

CALL GenerateOrderNumber(@order1);
CALL GenerateOrderNumber(@order2);
CALL GenerateOrderNumber(@order3);
CALL GenerateOrderNumber(@order4);
CALL GenerateOrderNumber(@order5);
CALL GenerateOrderNumber(@order6);
CALL GenerateOrderNumber(@order7);
CALL GenerateOrderNumber(@order8);

INSERT INTO Purchase (order_number, customer)
VALUES 
    (@order1, 1),
	(@order2, 2),
    (@order3, 3),
    (@order4, 4),
    (@order5, 5),
    (@order6, 6),
    (@order7, 7),
    (@order8, 8);

-- Inserting dummy data into the BookOrder table
INSERT INTO BookOrder (order_number, book)
VALUES 
    (1, 1),
	(1, 2),
	(1, 7),
	(1, 5),
	(2, 7),
	(2, 8),
	(3, 4),
	(4, 8),
	(4, 4),
	(4, 1),
	(4, 2),
	(5, 5),
	(5, 4),
	(5, 6),
	(6, 3),
	(7, 3),
	(7, 8),
	(8, 8),
	(8, 3),
	(8, 4);

-- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA -- DUMMY DATA 
