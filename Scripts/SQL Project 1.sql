--Creating the data:
DROP TABLE IF EXISTS Customers;
CREATE TABLE Books (
		Book_ID int PRIMARY KEY,
		Title varchar(100),
		Author varchar(100),
		Genre varchar(100),
		Published_Year int,
		Price numeric(10,2),
		Stock int
);

CREATE TABLE Customers(
		Customer_ID int PRIMARY KEY,
		Name varchar(50),	
		Email varchar(100),	
		Phone varchar(50),	
		City varchar(50),	
		Country varchar(50)
)

ALTER TABLE Customers
ALTER COLUMN City TYPE varchar(100),
ALTER COLUMN Country TYPE varchar(100),
ALTER COLUMN Name TYPE varchar(100);


CREATE TABLE Orders (
		Order_ID int PRIMARY KEY,	
		Customer_ID int REFERENCES Customers(Customer_ID),
		Book_ID int REFERENCES Books(Book_ID),
		Order_Date date,
		Quantity int,
		Total_Amount numeric(10,2)
)

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

--Importing the data:
COPY Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
FROM 'C:/Users/Pushkal/Downloads/SQL Data FIles/Books.csv'
DELIMITER ','
CSV HEADER;

COPY Customers(Customer_ID,Name,Email,Phone,City,Country)
FROM 'C:\Users\Pushkal\Downloads\SQL Data FIles\Customers.csv'
DELIMITER ','
CSV HEADER;

COPY Orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'C:\Users\Pushkal\Downloads\SQL Data FIles\Orders.csv'
DELIMITER ','
CSV HEADER;



-- **PROJECT QUESTIONS**:
-- 1) Retrieve all books in the "Fiction" genre:
SELECT b.title AS Book_Name, b.genre AS Fiction_Genre
FROM Books b
WHERE b.genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE published_year > 1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS Total_Stock
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT c.name, o.quantity
FROM Orders o
LEFT JOIN
Customers c
ON o.customer_id = c.customer_id
WHERE o.Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM orders
WHERE total_amount > 20.00;

-- 9) List all genres available in the Books table:
SELECT DISTINCT(genre) as Genre_All
FROM books;

-- 10) Find the book with the lowest stock:
SELECT * FROM books
ORDER BY stock DESC
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Orders;

-- 12) Retrieve the total number of books sold for each genre:
SELECT b.genre, SUM(o.Quantity) as Total_Sold
FROM Orders o
JOIN Books b
ON o.Book_ID=b.Book_ID
GROUP BY b.genre;

-- 13) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) as Average_Price
FROM Books
GROUP BY Genre
HAVING Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT c.customer_id, c.name, COUNT(o.quantity)
FROM Orders o
INNER JOIN Customers c
ON c.customer_id = o.customer_id
GROUP BY c.name, c.customer_id
HAVING COUNT(Quantity) >= 2;

SELECT Customer_ID, COUNT(Order_ID)
FROM Orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID) >= 2;

-- 4) Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS Order_Count
FROM orders o
JOIN books b
ON b.book_id=o.book_id
GROUP BY o.Book_id, b.title
ORDER BY COUNT(order_id) DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT title, genre, price
FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.author, COALESCE(SUM(o.Quantity), 0) AS Quantity_of_book_sold
FROM Books b
LEFT JOIN orders o
ON o.book_id=b.book_id
GROUP BY b.author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT(c.City)
FROM Customers c
JOIN Orders o
ON o.Customer_ID=c.Customer_ID
WHERE total_amount >=30

-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.Total_Amount) AS Total_Amount_Spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY SUM(o.Total_Amount) DESC
LIMIT 1;

--9) Calculate the stock remaining after fulfilling all orders:





