Create table Books(
	Book_ID	SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author	VARCHAR(100),
	Genre	VARCHAR(50),
	Published_Year INT,
	Price NUMERIC(10,2),
	Stock INT 
);
SELECT * FROM Books;
Create table customers(
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);
SELECT * FROM customers;
create table orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES customers(customer_ID),
	Book_ID INT  REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity	INT ,
	Total_Amount NUMERIC(10,2)

);
SELECT * FROM orders;

--import data into book table 
\copy Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'C:\Users\sonu singh\Desktop\sql\All Excel Practice Files\Books.csv'
CSV HEADER

/copy orders(Order_ID,	Customer_ID,	Book_ID	,Order_Date,	Quantity,	Total_Amount
) FROM 'C:\Users\sonu singh\Desktop\sql\All Excel Practice Files\Orders.csv' WITH (FORMAT csv, HEADER);

--1) Retrive all books in the "fiction" table
select * from Books where genre='Fiction';

--2)find books published after the year 1950;
select * from Books where published_year >1950;

--3)List all customers from the canada;
select * from  customers where country='Canada';

--4)show orders placed in november 2023;
select * from orders where order_date between '2023-11-01' and '2023-11-30';


--5) Retrive the total stock of books available
select sum(stock) AS Total_stock 
from Books ;


--6)find the details of the most expensive book;

select * from Books order by price desc limit 1;

--7)show all customers who ordered more than 1 Quantity of a books ;
select * from orders where quantity>1;

--8)Retrieve all orders where the total amount exceed $20;
select * from orders where total_amount>20;

--9)list all genres available in the book table;
select distinct genre from Books;

--10)find the book with the lowest stock;
select * from Books;
select * from Books order by stock limit 1 ;


--11)calculate the total revenue generated from all orders;
select sum(total_amount) as total_revenue from orders;


--12)Retrieve the total number of books sold for each genre
select * from  orders;
select * from  Books;

select b.genre, sum(o.quantity) as total_book_sold
from orders o
join Books b on o.book_id = b.book_id
group by b.genre;

--13) find the avgerage price of books in the "fantasy" genre;
select Avg(price) AS Average_price
from Books
where genre='Fantasy';

--14)list customers who have placed at least 2 orders;

select  customer_id, count(order_id) AS order_count
from  orders
group by customer_id
having count(order_id)>=2;








