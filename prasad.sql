create database management;
use management;

CREATE TABLE customers (
customerid INT PRIMARY KEY,
name VARCHAR(30),
phone_no VARCHAR(20)
);

INSERT INTO customers(customerid, name, phone_no) VALUES
(1, 'Prasad', '9150320977'),
(2, 'Kumar', '9168475207'),
(3, 'Lokesh', '8851426340'),
(4, 'Kishore', '9875456512'),
(5, 'Ganesh', '9945546517'),
(6, 'Mani', '9877455612'),
(7, 'Gokul', '9845266517'),
(8, 'Monisha', '9945532146'),
(9, 'Kreethi', '8812034854'),
(10, 'Punitha', 9626463212),
(11, 'Nataraj', '8754631288'),
(12, 'Priya', '6381918492'),
(13, 'Annamalai', '9176846207'),
(14, 'Sandy', '8645779814'),
(15, 'Pradeep', '8800233212');

CREATE TABLE menu_items (
itemid INT PRIMARY KEY,
name VARCHAR(50),
price INT
);

INSERT INTO menu_items(itemid, name, price) VALUES
(1, 'Idli', 50),
(2, 'Dosa', 100),
(3, 'Poori', 100),
(4, 'Pongal', 50),
(5, 'Vada', 20),
(6, 'Veg Rice', 50),
(7, 'Biryani', 100),
(8, 'Juice', 50),
(9, 'Ice Cream', 40),
(10, 'Curd rice', 40),
(11, 'Leman rice', 60),
(12, 'Chicken 65', 80),
(13, 'Chicken rice', 40),
(14, 'Gopimanchurian', 100),
(15, 'Naan', 100),
(16, 'Carret rice', 40),
(17, 'Geerost', 60),
(18, 'Vadagari', 80),
(19, '7up', 40),
(20, 'Sweet', 70);

CREATE TABLE orders (
orderid INT AUTO_INCREMENT PRIMARY KEY,
customerid INT,
orderdate DATE,
totalamount DECIMAL(10,2),
status ENUM('pending', 'shipped', 'delivered') DEFAULT 'pending',
FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

INSERT INTO orders(customerid, orderdate, totalamount, status) VALUES
(1, '2025-02-01', 99, 'shipped'),
(2, '2025-02-04', 59, 'delivered'),
(3, '2025-02-06', 50, 'pending'),
(4, '2025-02-03', 59, 'delivered'),
(5, '2025-02-03', 100, 'delivered'),
(6, '2025-02-03', 99, 'delivered'),
(7, '2025-02-03', 49, 'pending'),
(8, '2025-02-03', 99, 'pending'),
(9, '2025-02-03', 59, 'delivered'),
(10, '2025-02-03', 100, 'pending'),
(11, '2025-02-03', 100, 'delivered'),
(12, '2025-02-03', 50, 'pending'),
(13, '2025-02-03', 40, 'delivered'),
(14, '2025-02-03', 50, 'shipped'),
(15, '2025-02-03', 60, 'delivered'),
(16, '2025-02-03', 100, 'shipped'),
(17, '2025-02-03', 50, 'delivered'),
(18, '2025-02-03', 40, 'pending'),
(19, '2025-02-03', 60, 'delivered'),
(20, '2025-02-08', 100, 'shipped');

CREATE TABLE reservations (
reservationid INT PRIMARY KEY,
customerid INT NOT NULL,
reservationdate DATE NOT NULL,
reservationtime TIME NOT NULL,
numberofpeople INT NOT NULL,
specialrequests VARCHAR(255),
status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

INSERT INTO reservations(reservationid, customerid, reservationdate, reservationtime, numberofpeople, specialrequests, status) VALUES
(1, 1, '2025-02-05', '18:30:00', 4, 'Pongal', 'confirmed'),
(2, 2, '2025-02-06', '19:00:00', 3, 'Ice Cream', 'cancelled'),
(3, 3, '2025-02-07', '20:10:00', 8, 'Dosa', 'pending'),
(4, 4, '2025-02-08', '17:30:00', 7, 'Idli', 'confirmed'),
(5, 5, '2025-02-08', '18:20:00', 7, 'Biryani', 'pending'),
(6, 6, '2025-02-07', '18:40:00', 7, 'Curd rice', 'cancelled'),
(7, 7, '2025-02-09', '19:20:00', 7, 'Chicken 65', 'confirmed'),
(8, 8, '2025-02-01', '19:10:00', 7, 'Biryani', 'pending'),
(9, 9, '2025-02-02', '20:50:00', 7, 'Chicken 65', 'confirmed'),
(10, 10, '2025-02-07', '17:40:00', 7, 'Curd rice', 'cancelled'),
(11, 11, '2025-02-08', '22:00:00', 7, 'Idli', 'confirmed'),
(12, 12, '2025-02-02', '21:20:00', 7, 'Biryani', 'confirmed'),
(13, 13, '2025-02-01', '13:40:00', 7, 'Curd rice', 'pending'),
(14, 14, '2025-02-03', '11:30:00', 7, 'Chicken 65', 'confirmed'),
(15, 15, '2025-02-04', '21:00:00', 5, 'Poori', 'pending');

SELECT
o.orderid,
o.customerid,
c.name AS customer_name,
o.totalamount,
o.orderdate,
c.phone_no AS phone_number,
o.status
FROM orders AS o
INNER JOIN customers AS c ON o.customerid = c.customerid;      


CREATE TABLE orderitems (
    orderitemid INT AUTO_INCREMENT PRIMARY KEY, 
    orderid INT, 
    menuitemid INT, 
    quantity INT NOT NULL CHECK (quantity > 0),
    totalprice DECIMAL(10,2) GENERATED ALWAYS AS (quantity * (SELECT price FROM menu_items WHERE menu_items.itemid = orderitems.menuitemid)) STORED,
    FOREIGN KEY (orderid) REFERENCES orders(orderid) ON DELETE CASCADE,
    FOREIGN KEY (menuitemid) REFERENCES menu_items(itemid) ON DELETE CASCADE
);



SELECT orderid, SUM(totalprice) AS total_bill 
FROM orderitems 
WHERE orderid = 1 
GROUP BY orderid;


UPDATE orders 
SET status = 'delivered' 
WHERE orderid = 1;


UPDATE reservations 
SET status = 'cancelled' 
WHERE reservationid = 1;



DELETE FROM orderitems 
WHERE orderitemid = 1;



SELECT 
    r.reservationid AS reservation_id, 
    c.name AS customer,
    t.table_number, 
    r.reservationtime, 
    r.status 
FROM reservations r 
JOIN customers c ON r.customerid = c.customerid 
JOIN tables t ON r.table_id = t.tableid 
ORDER BY r.reservationtime;
