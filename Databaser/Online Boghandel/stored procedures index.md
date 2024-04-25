# Stored Procedure Index

## The database script contains several Stored Procedures for inserting and extracting data, outlined below:

### GenerateOrderNumber (OUT orderNumber INT)

This procedure generates and returns a random order number 6 characters long. 
It is used when creating a new order when a customer makes a purchase. 

The order number is unique and all purchased books in a single order is related to one order number.


### CreateNewOrder (IN customerName VARCHAR(256))

This procedure inserts a new order with a randomly generated order number.


### GetLogsBetweenDates (
    IN firstDay INT,
    IN firstMonth INT,
    IN firstYear VARCHAR(4),
    IN lastDay INT,
    IN lastMonth INT,
    IN lastYear VARCHAR(4)
)

This procedure displays all log entries logged between a set of days.

Variables for year are optional. If no year variable is entered, the procedure will automatically display the logs for a given span of dates in the current year.

Day & month inputs are not optional.


### GetBooksByAuthor (IN authorName VARCHAR(256))

This procedure displays all books written by a certain author.

The authorName variable can contain either a first or a last name, if any match, it will display books associated with that author.


### GetAuthorByBookTitle (IN bookTitle VARCHAR(256))

This procedure displays the author associated with a specific book that exists in the database.


### GetCustomerInfoByCustomerName (IN customerName VARCHAR(256))

This procedure displays all stored information regarding a specific user/customer.

The customerName variable must contain the user's name.


### GetOrdersByCustomer (IN customerName VARCHAR(256))

This procedure displays all orders made by a specific customer.

The customerName variable must contain the user's name.


### GetBookInfoByBookTitle (IN bookTitle VARCHAR(256))

This procedure displays all information associated with a particular book title (author, price, genre).

The bookTitle variable must contain the book's title.


### CreateNewUser (
   IN customerName VARCHAR(256),
   IN customerMail VARCHAR(256),
   IN customerAddress VARCHAR(256),
   IN addressIdFromPostcode SMALLINT
)

This procedure inserts a new user/customer into the database.

The procedure takes the user's name, e-mail address, actual address and city associated with the user's postcode as arguments. 

A relation is automatically created to the Address table; when the procedure is called with a postcode, the procedure will assign the new user an address_id which contains a postcode and city.


### CreateNewAuthor (IN authorName VARCHAR(256), IN authorLastName varchar(256))

This procedure inserts a new author into the database. It takes the author's first and last names as parameters.

It is not necessary to add a trailing space after the first name; this is automatically handled in the procedure.

The new author will not be created if it already exists in the database.


### CreateNewGenre (IN genreName VARCHAR(50))

This procedure inserts a new genre into the database with the genre's name as a parameter.

The new genre will not be created if it already exists in the database.


### CreateNewBook (
   IN bookTitle VARCHAR(256),
   IN bookAuthor VARCHAR(256),
   IN bookAuthorLastName VARCHAR(256),
   IN bookPrice SMALLINT,
   IN bookGenre VARCHAR(50)
)

This procedure inserts a new book into the database, taking title, author first & last names, price and genre as arguments.

If the author and/or genre does not exist in the database, they will be created automatically.

The new book will not be created if it already exists in the database.


### CreateNewBookOrder (IN orderNumber SMALLINT, IN orderedBook SMALLINT)

This procedure is meant to be called once per book when a customer places a new order.

The procedure will create a new BookOrder item; a purchased book associated with the relevant order number.