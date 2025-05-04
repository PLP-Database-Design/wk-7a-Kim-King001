--Question 1
/* To transform the given ProductDetail table into First Normal Form (1NF), 
you need to ensure that each row contains atomic values, 
meaning each product should be listed in a separate row rather than as a comma-separated list. */

/* Its resulting normalized table is shared as csv (Question 1 csv) */
SELECT 
    OrderID,
    CustomerName,
    LTRIM(RTRIM(value)) AS Product
FROM 
    ProductDetail
    CROSS APPLY STRING_SPLIT(Products, ',');

-- question 2
/* To transform the OrderDetails table into Second Normal Form (2NF) and remove partial dependencies, 
you should decompose the table into two separate tables:

One table for orders and products (where the composite key is OrderID + Product)

One table for customers (with OrderID as the key and CustomerName as the attribute) */

/* Its resulting normalized  table is shared as csv (Question 2 csv) */

--step 1: Customers table

CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
-- step 2 OrderProducts table
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

-- step 3 Populate tables

INSERT INTO Customers (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderProducts (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

