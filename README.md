# Проектирование базы данных для книжного магазина

![MySQL](https://img.shields.io/badge/MySQL-%2307405e.svg?style=for-the-badge&logo=MySQL&logoColor=E6882E)

## Описание

Для системы автоматизации деятельности книжного магазина необходимо спроектировать базу данных, которая будет содержать информацию о книгах, авторах, заказах, клиентах, сотрудниках и других сущностях, необходимых для управления бизнесом.



База данных будет состоять из следующих таблиц:

## Таблица "Books"

Содержит информацию о книгах, которые доступны для продажи. Она содержит уникальный идентификатор книги (BookID), название книги (Title), идентификатор автора (AuthorID), издательство (Publisher), год публикации (PublicationYear), цену (Price) и количество экземпляров на складе (StockQuantity).

| Поле      | Тип данных | Описание                               |
|-----------|------------|----------------------------------------|
|BookID	|int	|Идентификатор книги|
|Title	|varchar	|Название книги|
|AuthorID	|int	|Идентификатор автора книги|
|Publisher	|varchar	|Название издательства|
|PublicationYear	|int	|Год издания книги|
|Price	|decimal	|Цена книги|
|StockQuantity	|int	|Количество книг в наличии на складе магазина|

## Таблица "Authors"

Cодержит информацию об авторах книг. Она содержит уникальный идентификатор автора (AuthorID), имя (FirstName), фамилию (LastName) и отчество (MiddleName).

| Поле      | Тип данных | Описание                               |
|-----------|------------|----------------------------------------|
|AuthorID	|int	|Идентификатор автора
|FirstName	|varchar	|Имя автора
|LastName	|varchar	|Фамилия автора
|MiddleName	|varchar	|Отчество автора

## Таблица "Employees"

Cодержит информацию о сотрудниках магазина книг. Она содержит уникальный идентификатор сотрудника (EmployeeID), имя (FirstName), фамилию (LastName), отчество (MiddleName), должность (Position), зарплату (Salary), адрес (Address) и номер телефона (PhoneNumber).

| Поле      | Тип данных | Описание                               |
|-----------|------------|----------------------------------------|
|EmployeeID	|int	|Идентификатор сотрудника
|FirstName	|varchar	|Имя сотрудника
|LastName	|varchar	|Фамилия сотрудника
|MiddleName	|varchar	|Отчество сотрудника
|Position	|varchar	|Должность сотрудника
|Salary	|decimal	|Зарплата сотрудника
|Address	|varchar	|Адрес проживания сотрудника
|PhoneNumber	|varchar	|Номер телефона сотрудника

## Таблица "Orders"

Cодержит информацию о заказах на книги. Она содержит уникальный идентификатор заказа (OrderID), дату заказа (Date), идентификатор клиента (CustomerID) и идентификатор сотрудника (EmployeeID), который обрабатывает заказ.

| Поле      | Тип данных | Описание                               |
|-----------|------------|----------------------------------------|
|OrderID	|int	|Идентификатор заказа
|Date	|date	|Дата заказа
|CustomerID	|int	|Идентификатор заказчика
|EmployeeID	|int	|Идентификатор сотрудника, оформившего заказ

## Таблица "Customers"

Cодержит информацию о клиентах, которые делают заказы на книги. Она содержит уникальный идентификатор клиента (CustomerID), имя (FirstName), фамилию (LastName), отчество (MiddleName), адрес (Address) и номер телефона (PhoneNumber).

| Поле      | Тип данных | Описание                               |
|-----------|------------|----------------------------------------|
|CustomerID	|int	|Идентификатор заказчика
|FirstName	|varchar	|Имя заказчика
|LastName	|varchar	|Фамилия заказчика
|MiddleName	|varchar	|Отчество заказчика
|Address	|varchar	|Адрес заказчика
|PhoneNumber	|varchar	|Номер телефона заказчика

## Таблица "OrderDetails"

Cодержит информацию о деталях заказа на книги. Она содержит идентификатор заказа (OrderID), идентификатор книги (BookID), количество экземпляров (Quantity) и цену (Price) каждого экземпляра.

| Поле      | Тип данных | Описание                               |
|-----------|------------|----------------------------------------|
|OrderID	|int	|Идентификатор заказа
|BookID	|int	|Идентификатор книги
|Quantity	|int	|Количество заказанных
|Price   |decimal   |Цена




## Взаимосвязи:

![image](https://github.com/NeZorinEgor/Bookstore-DB/assets/92092053/ebb78708-5952-4b83-9bd7-8ac9fee2718d)


* Каждая книга имеет своего автора.
* Каждый заказ связан с клиентом и сотрудником, который обработал заказ.
* Каждый клиент может иметь несколько заказов.
* Каждый сотрудник может обрабатывать несколько заказов.
* Детали заказа связаны с заказом и книгой.

## Представления:

1. Список книг (BooksList):

Представление позволяет получить информацию о книгах в магазине, включая название, автора, издательство, год издания, цену и количество экземпляров на складе.

```sql
CREATE VIEW BooksList AS
SELECT b.Title, CONCAT(a.FirstName, ' ', a.LastName, ' ', a.MiddleName) AS AuthorFullName, b.Publisher, b.PublicationYear, b.Price, b.StockQuantity
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID;
```

2. Список заказов (OrdersList):

Представление позволяет получить информацию о всех заказах, сделанных в магазине, включая дату, имена и отчества клиентов и сотрудников, которые осуществляли заказ, а также сумму заказа.

```sql
CREATE VIEW OrdersList AS
SELECT o.OrderID, o.Date, CONCAT(c.FirstName, ' ', c.LastName, ' ', c.MiddleName) AS CustomerFullName, CONCAT(e.FirstName, ' ', e.LastName, ' ', e.MiddleName) AS EmployeeFullName, SUM(od.Quantity * od.Price) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID;
```

3. Детальный список заказа (OrderDetailsList):

Представление позволяет получить информацию о каждом конкретном заказе, включая название книги, количество заказанных книг, цену за каждую книгу и общую стоимость заказа.

```sql
CREATE VIEW OrderDetailsList AS
SELECT od.OrderID, b.Title, od.Quantity, od.Price, od.Quantity * od.Price AS Amount
FROM OrderDetails od
JOIN Books b ON od.BookID = b.BookID;
```


## Код SQL для создания таблиц:

```sql
CREATE TABLE Books (
BookID int NOT NULL PRIMARY KEY,
Title varchar(255),
AuthorID int,
Publisher varchar(255),
PublicationYear int,
Price decimal(10,2),
StockQuantity int
);

CREATE TABLE Authors (
AuthorID int NOT NULL PRIMARY KEY,
FirstName varchar(50),
LastName varchar(50),
MiddleName varchar(50)
);

CREATE TABLE Employees (
EmployeeID int NOT NULL PRIMARY KEY,
FirstName varchar(50),
LastName varchar(50),
MiddleName varchar(50),
Position varchar(255),
Salary decimal(10,2),
Address varchar(255),
PhoneNumber varchar(20)
);

CREATE TABLE Orders (
OrderID int NOT NULL PRIMARY KEY,
Date date,
CustomerID int,
EmployeeID int
);

CREATE TABLE Customers (
CustomerID int NOT NULL PRIMARY KEY,
FirstName varchar(50),
LastName varchar(50),
MiddleName varchar(50),
Address varchar(255),
PhoneNumber varchar(20)
);

CREATE TABLE OrderDetails (
OrderID int,
BookID int,
Quantity int,
Price decimal(10,2)
);
```

## Код SQL для создания связей между таблицами:

```sql
ALTER TABLE Books ADD FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID);
ALTER TABLE Orders ADD FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
ALTER TABLE Orders ADD FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);
ALTER TABLE OrderDetails ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
ALTER TABLE OrderDetails ADD FOREIGN KEY (BookID) REFERENCES Books(BookID);
```


# Примеры запросов SQL для типовых операций:

###  Создание записи в таблице Books

```sql
INSERT INTO Books (BookID, Title, AuthorID, Publisher, PublicationYear, Price, StockQuantity)
VALUES (1, 'The Great Gatsby', 1, 'Scribner', 1925, 10.99, 100);
```
Этот запрос создает запись с информацией о книге 'The Great Gatsby', автором которой является автор с идентификатором 1, издательством Scribner, годом публикации 1925, ценой 10.99 и количеством на складе 100. 

### Изменение записи в таблице Books

```sql
UPDATE Books
SET Publisher = 'Penguin',
    PublicationYear = 2021,
    Price = 12.99,
    StockQuantity = 50
WHERE BookID = 1;
```

Этот запрос изменяет издательство, год публикации, цену и количество на складе для книги с идентификатором 1.

### Удаление записи из таблицы Books

```sql
DELETE FROM Books
WHERE BookID = 1;
```

Этот запрос удаляет запись для книги с идентификатором 1.

### Создание записи в таблице Authors

```sql
INSERT INTO Authors (AuthorID, FirstName, LastName, MiddleName)
VALUES (1, 'F. Scott', 'Fitzgerald', 'Francis');
```

Этот запрос создает запись с информацией об авторе 'F. Scott Fitzgerald', у которого идентификатор 1, имя Scott, фамилия Fitzgerald и отчество Francis.

### Изменение записи в таблице Authors

```sql
UPDATE Authors
SET FirstName = 'Francis Scott'
WHERE AuthorID = 1;
```

Этот запрос изменяет имя автора с идентификатором 1 на Francis Scott.



### Удаление записи из таблицы Authors

```sql
DELETE FROM Authors
WHERE AuthorID = 1;
```

Этот запрос удаляет запись для автора с идентификатором 1.

### Создание записи в таблице Employees

```sql
INSERT INTO Employees (EmployeeID, FirstName, LastName, MiddleName, Position, Salary, Address, PhoneNumber)
VALUES (1, 'John', 'Doe', 'Smith', 'Sales Manager', 50000.00, '123 Main St', '555-1234');
```

### Изменение записи в таблице Employees

```sql
UPDATE Employees
SET Position = 'Senior Sales Manager',
    Salary = 60000.00,
    Address = '456 Main St',
    PhoneNumber = '555-5678'
WHERE EmployeeID = 1;
```

Этот запрос изменяет должность, зарплату, адрес и номер телефона для сотрудника с идентификатором 1.

### Удаление записи из таблицы Employees

```sql
DELETE FROM Employees
WHERE EmployeeID = 1;
```

Этот запрос удаляет запись для сотрудника с идентификатором 1.


### Создание записи в таблице Orders

```sql
INSERT INTO Orders (OrderID, Date, CustomerID, EmployeeID)
VALUES (1, '2023-05-10', 1, 1);
```

### Изменение записи в таблице Orders

```sql
UPDATE Orders
SET Date = '2023-05-11',
    CustomerID = 2,
    EmployeeID = 2
WHERE OrderID = 1;
```

### Удаление записи из таблицы Orders

```sql
DELETE FROM Orders
WHERE OrderID = 1;
```

Этот запрос удаляет запись для заказа с идентификатором 1.

Этот запрос создает запись с информацией о заказе с идентификатором 1, датой 2023-05-10, идентификатором заказчика 1 и идентификатором сотрудника 1.

### Создание записи в таблице Customers

```sql
INSERT INTO Customers (CustomerID, FirstName, LastName, MiddleName, Address, PhoneNumber)
VALUES (1, 'Jane', 'Doe', 'Smith', '456 Elm St', '555-4321');
```

### Изменение записи в таблице Customers

```sql
UPDATE Customers
SET Address = '789 Oak St',
    PhoneNumber = '555-8765'
WHERE CustomerID = 1;
```

### Удаление записи из таблицы Customers

```sql
DELETE FROM Customers
WHERE CustomerID = 1;
```

### Создание записи в таблице OrderDetails

```sql
INSERT INTO OrderDetails (OrderID, BookID, Quantity, Price)
VALUES (1, 1, 2, 14.99);
```

### Удаление записи из таблицы OrderDetails

```sql
DELETE FROM OrderDetails
WHERE OrderID = 1 AND BookID = 2;
``` 

