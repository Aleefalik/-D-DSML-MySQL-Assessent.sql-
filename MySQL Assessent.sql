CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch (Branch_no INT PRIMARY KEY,Manager_id INT,Branch_address VARCHAR(100),Contact_no INT);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES 
    (1, 101, '123 Main Street', 5551234),
    (2, 102, '456 Oak Avenue', 5555678),
    (3, 103, '789 Pine Lane', 5559876),
    (4, 104, '987 Elm Road', 5554321),
    (5, 105, '654 Maple Drive', 5558765),
    (6, 106, '321 Cedar Court', 5552345),
    (7, 107, '876 Birch Lane', 5557890),
    (8, 108, '543 Pinecrest Avenue', 5553456),
    (9, 109, '210 Oakwood Street', 5558901),
    (10, 110, '789 Redwood Lane', 5556789);
    SELECT * FROM Branch;
    
    CREATE TABLE Employee ( Emp_id INT PRIMARY KEY, Emp_name VARCHAR(20), Position VARCHAR(20), Salary INT, Branch_no INT REFERENCES Branch(Branch_no));
    INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
    (1, 'John Doe', 'Manager', 60000, 1),
    (2, 'Jane Smith', 'Assistant Manager', 50000, 1),
    (3, 'Bob Johnson', 'Sales Associate', 40000, 3),
    (4, 'Alice Williams', 'Customer Service', 35000, 4),
    (5, 'Charlie Brown', 'Accountant', 55000, 1),
    (6, 'Eva Davis', 'Marketing Specialist', 48000, 1),
    (7, 'Frank Miller', 'IT Specialist', 52000, 1),
    (8, 'Grace Taylor', 'HR Coordinator', 45000, 4),
    (9, 'Henry Wilson', 'Warehouse Supervisor', 48000, 1),
    (10, 'Ivy Anderson', 'Financial Analyst', 60000, 2);
    SELECT * FROM Employee;
    
    CREATE TABLE Customer (Customer_id INT PRIMARY KEY,Customer_name VARCHAR(50),Customer_address VARCHAR(50),Reg_date DATE);
    INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
    (1, 'John Smith', '123 Main Street, Cityville', '2021-09-01'),
    (2, 'Alice Johnson', '456 Oak Avenue, Townsville', '2022-02-15'),
    (3, 'Bob Davis', '789 Pine Lane, Villagetown', '2022-03-10'),
    (4, 'Eva Miller', '987 Elm Road, Hamletville', '2022-04-05'),
    (5, 'Charlie Wilson', '654 Maple Drive, Countryside', '2022-05-20'),
    (6, 'Grace Taylor', '321 Cedar Court, Suburbia', '2022-06-15'),
    (7, 'Henry Anderson', '876 Birch Lane, Ruralville', '2022-07-01'),
    (8, 'Ivy Brown', '543 Pinecrest Avenue, Farmland', '2022-08-12'),
    (9, 'Frank Williams', '210 Oakwood Street, Meadowtown', '2022-09-25'),
    (10, 'Jane Martin', '789 Redwood Lane, Hillside', '2022-10-10');
    SELECT * FROM Customer;
    
    CREATE TABLE IssueStatus ( Issue_id INT PRIMARY KEY, Issued_cust INT REFERENCES Customer(Customer_id),Issued_book_name VARCHAR(50),Issue_date DATE, Isbn_book BIGINT );
    INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
    (1, 3, 'The Great Gatsby', '2023-06-05', '9783161484100'),
    (2, 7, 'To Kill a Mockingbird', '2022-02-10', '9780061120084'),
    (3, 2, '1984', '2022-03-15', '9780455284234'),
    (4, 5, 'Pride and Prejudice', '2022-04-20', '9780141439518'),
    (5, 9, 'The Catcher in the Rye', '2022-05-25', '9780316769480');
    SELECT * FROM IssueStatus;
    
    
CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY, Return_cust VARCHAR(50),Return_book_name VARCHAR(50),Return_date DATE, Isbn_book2 BIGINT);
INSERT INTO ReturnStatus VALUES
	(9, 'Frank Williams', 'The Great Gatsby', '2022-03-05', '9783161484100'),
    (2, 'Alice Johnson', 'To Kill a Mockingbird', '2022-04-10', '9780061120084'),
    (3, 'Eva Miller', '1984', '2022-03-15', '9780455284234'),
    (4, 'Grace Taylor', 'Pride and Prejudice', '2022-04-20', '9780141439518'),
    (5, 'Jane Martin', 'The Catcher in the Rye', '2022-05-25', '9780316769480');
    SELECT * FROM ReturnStatus;

CREATE TABLE Books(ISBN BIGINT PRIMARY KEY,Book_title VARCHAR(100),Category VARCHAR(50),Rental_Price DECIMAL(10,2),Status BOOLEAN,Author VARCHAR(50),Publisher VARCHAR(50));
INSERT INTO Books VALUES
(9783161484100, 'The Great Gatsby', 'Classic', 298.00, FALSE, 'F. Scott Fitzgerald', 'Charles Scribner'),
(9780061120084, 'To Kill a Mockingbird', 'Fiction', 654.00, FALSE, 'Harper Lee', 'J.B. Lippincott & Co.'),
(9780455284234, '1984', 'Dystopian', 600.00, TRUE, 'George Orwell', 'Penguin Books'),
(9780141439518, 'Pride and Prejudice', 'Romance', 500.00, TRUE, 'Jane Austen', 'Penguin Classics'),
(9780316769480, 'The Catcher in the Rye', 'Coming-of-Ag', 432.00, TRUE, 'J.D. Salinger', 'Little, Brown and Company'),
(2345697869708,'The Communist Manifesto','History',235.00,TRUE,'Karl Marx','DC BOOKS');
SELECT * FROM Books;

#1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_price FROM Books;

#2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

#3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT  IssueStatus.Issued_book_name, Customer.Customer_name FROM IssueStatus JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_id;

#4. Display the total count of books in each category.
SELECT Category,COUNT(*) AS Total_Books_Count FROM Books GROUP BY Category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT Emp_name, Position, Salary FROM Employee WHERE Salary>50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT C.Customer_name FROM Customer C LEFT JOIN IssueStatus I ON C.Customer_id = I.Issued_cust WHERE C.Reg_date < '2022-01-01' AND I.Issued_cust IS NULL;


#7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees_Count FROM Employee GROUP BY Branch_no;


#8. Display the names of customers who have issued books in the month of June 2023.
SELECT C.Customer_name FROM Customer C JOIN IssueStatus I ON C.Customer_id = I.Issued_cust WHERE MONTH(I.Issue_date)=6 AND YEAR(I.Issue_date)=2023;


#9.Retrieve book_title from book table containing history.
SELECT Book_title FROM Books WHERE Category='History';


#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no,COUNT(*) AS Total_Employees_Count FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

DROP DATABASE Library