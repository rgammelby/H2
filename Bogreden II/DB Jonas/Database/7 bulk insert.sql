-- -------------------- --
-- Bulk Insert from csv --
-- -------------------- --

LOAD DATA INFILE "D:\\Skole\\H2\\Database Prog\\postnumre.csv"
INTO TABLE br_city
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(city_postal_code,city_name);

-- ------------------------------- --
-- Create [CALL insert] procedures --
-- ------------------------------- --

-- Call insert_new_user procedure 10 times with sample data
CALL insert_new_user('John', 'Doe', 'johndoe', 'password123', 'password123', 'john@example.com', '1234567890');
CALL insert_new_user('Jane', 'Smith', 'janesmith', 'password456', 'password456', 'jane@example.com', '9876543210');
CALL insert_new_user('Alice', 'Johnson', 'alicej', 'password789', 'password789', 'alice@example.com', '5555555555');
CALL insert_new_user('Bob', 'Brown', 'bobb', 'passwordabc', 'passwordabc', 'bob@example.com', '7777777777');
CALL insert_new_user('Emma', 'White', 'emmaw', 'passwordxyz', 'passwordxyz', 'emma@example.com', '9999999999');
CALL insert_new_user('Michael', 'Lee', 'michaell', 'pass123word', 'pass123word', 'michael@example.com', '1111111111');
CALL insert_new_user('Sarah', 'Taylor', 'saraht', 'pass456word', 'pass456word', 'sarah@example.com', '2222222222');
CALL insert_new_user('David', 'Martinez', 'davidm', 'pass789word', 'pass789word', 'david@example.com', '3333333333');
CALL insert_new_user('Sophia', 'Garcia', 'sophiag', 'passabcword', 'passabcword', 'sophia@example.com', '4444444444');
CALL insert_new_user('Daniel', 'Lopez', 'daniell', 'passxyzword', 'passxyzword', 'daniel@example.com', '6666666666');

-- Call insert_new_pricing procedure 10 times with sample data
CALL insert_new_pricing(50.00, 75.00, 20.00, 10.00);
CALL insert_new_pricing(60.00, 90.00, 25.00, 15.00);
CALL insert_new_pricing(70.00, 100.00, 30.00, 20.00);
CALL insert_new_pricing(80.00, 110.00, 35.00, 25.00);
CALL insert_new_pricing(90.00, 120.00, 40.00, 30.00);
CALL insert_new_pricing(100.00, 130.00, 45.00, 35.00);
CALL insert_new_pricing(110.00, 140.00, 50.00, 40.00);
CALL insert_new_pricing(120.00, 150.00, 55.00, 45.00);
CALL insert_new_pricing(130.00, 160.00, 60.00, 50.00);
CALL insert_new_pricing(140.00, 170.00, 65.00, 55.00);

-- Call insert_new_genre procedure 10 times with sample data
CALL insert_new_genre('Horror');
CALL insert_new_genre('Fantasy');
CALL insert_new_genre('Mystery');
CALL insert_new_genre('Thriller');
CALL insert_new_genre('Romance');
CALL insert_new_genre('Science Fiction');
CALL insert_new_genre('Historical Fiction');
CALL insert_new_genre('Biography');
CALL insert_new_genre('Self-Help');
CALL insert_new_genre('Adventure');

-- Call insert_new_author procedure 10 times with sample data
CALL insert_new_author('Stephen King');
CALL insert_new_author('J.K. Rowling');
CALL insert_new_author('Agatha Christie');
CALL insert_new_author('Dan Brown');
CALL insert_new_author('Jane Austen');
CALL insert_new_author('George Orwell');
CALL insert_new_author('Harper Lee');
CALL insert_new_author('J.R.R. Tolkien');
CALL insert_new_author('Charles Dickens');
CALL insert_new_author('Leo Tolstoy');

-- Call insert_new_address procedure 10 times with sample data
CALL insert_new_address('4180', 1, 'Strandboulevarden 1', 'Denmark', TRUE);
CALL insert_new_address('4180', 2, 'Vesterbrogade 2', 'Denmark', FALSE);
CALL insert_new_address('4180', 3, 'Nørrebrogade 3', 'Denmark', TRUE);
CALL insert_new_address('4180', 4, 'Sønderboulevard 4', 'Denmark', FALSE);
CALL insert_new_address('4180', 5, 'Hovedvejen 5', 'Denmark', TRUE);
CALL insert_new_address('4180', 6, 'Strandvejen 6', 'Denmark', FALSE);
CALL insert_new_address('4180', 7, 'Parkvej 7', 'Denmark', TRUE);
CALL insert_new_address('4180', 8, 'Bakkevej 8', 'Denmark', FALSE);
CALL insert_new_address('4180', 9, 'Skovvej 9', 'Denmark', TRUE);
CALL insert_new_address('4180', 10, 'Engvej 10', 'Denmark', FALSE);

-- Call insert_new_order procedure 10 times with sample data
CALL insert_new_order(1, '2024-04-25 12:00:00', 100.00, 'Shipped');
CALL insert_new_order(2, '2024-04-26 12:00:00', 150.00, 'Processed');
CALL insert_new_order(3, '2024-04-27 12:00:00', 200.00, 'Shipped');
CALL insert_new_order(4, '2024-04-28 12:00:00', 250.00, 'Delivered');
CALL insert_new_order(5, '2024-04-29 12:00:00', 300.00, 'Cancelled');
CALL insert_new_order(6, '2024-04-30 12:00:00', 350.00, 'Returned');
CALL insert_new_order(7, '2024-05-01 12:00:00', 400.00, 'Failed');
CALL insert_new_order(8, '2024-05-02 12:00:00', 450.00, 'On Hold');
CALL insert_new_order(9, '2024-05-03 12:00:00', 500.00, 'Shipped');
CALL insert_new_order(10, '2024-05-04 12:00:00', 550.00, 'Processed');

-- Call insert_new_book procedure 10 times with sample data
CALL insert_new_book(1, 'Sample Book 1', 0.5, 'This is a sample book description.', 'sample1.jpg');
CALL insert_new_book(2, 'Sample Book 2', 0.6, 'This is another sample book description.', 'sample2.jpg');
CALL insert_new_book(3, 'Sample Book 3', 0.7, 'Yet another sample book description.', 'sample3.jpg');
CALL insert_new_book(4, 'Sample Book 4', 0.8, 'One more sample book description.', 'sample4.jpg');
CALL insert_new_book(5, 'Sample Book 5', 0.9, 'Final sample book description.', 'sample5.jpg');
CALL insert_new_book(6, 'Sample Book 6', 1.0, 'Another final sample book description.', 'sample6.jpg');
CALL insert_new_book(7, 'Sample Book 7', 1.1, 'Almost final sample book description.', 'sample7.jpg');
CALL insert_new_book(8, 'Sample Book 8', 1.2, 'Nearly there sample book description.', 'sample8.jpg');
CALL insert_new_book(9, 'Sample Book 9', 1.3, 'Nearly there sample book description.', 'sample9.jpg');
CALL insert_new_book(10, 'Sample Book 10', 1.4, 'Nearly there sample book description.', 'sample10.jpg');

-- Call insert_new_book_author procedure 10 times with sample data
CALL insert_new_book_author(1, 'Stephen King');
CALL insert_new_book_author(2, 'J.K. Rowling');
CALL insert_new_book_author(3, 'Agatha Christie');
CALL insert_new_book_author(4, 'Dan Brown');
CALL insert_new_book_author(5, 'Jane Austen');
CALL insert_new_book_author(6, 'George Orwell');
CALL insert_new_book_author(7, 'Harper Lee');
CALL insert_new_book_author(8, 'J.R.R. Tolkien');
CALL insert_new_book_author(9, 'Charles Dickens');
CALL insert_new_book_author(10, 'Leo Tolstoy');

-- Call insert_new_book_genre procedure 10 times with sample data
CALL insert_new_book_genre(1, 'Horror');
CALL insert_new_book_genre(2, 'Fantasy');
CALL insert_new_book_genre(3, 'Mystery');
CALL insert_new_book_genre(4, 'Thriller');
CALL insert_new_book_genre(5, 'Romance');
CALL insert_new_book_genre(6, 'Science Fiction');
CALL insert_new_book_genre(7, 'Historical Fiction');
CALL insert_new_book_genre(8, 'Biography');
CALL insert_new_book_genre(9, 'Self-Help');
CALL insert_new_book_genre(10, 'Adventure');

-- Call insert_new_book_order procedure 10 times with sample data
CALL insert_new_book_order(1, 1);
CALL insert_new_book_order(2, 2);
CALL insert_new_book_order(3, 3);
CALL insert_new_book_order(4, 4);
CALL insert_new_book_order(5, 5);
CALL insert_new_book_order(6, 6);
CALL insert_new_book_order(7, 7);
CALL insert_new_book_order(8, 8);
CALL insert_new_book_order(9, 9);
CALL insert_new_book_order(10, 10);

-- Call insert_new_tax procedure 1 tax type
CALL insert_new_tax(25, "moms", TRUE);