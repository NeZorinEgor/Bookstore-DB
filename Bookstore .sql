-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3308
-- Время создания: Май 10 2023 г., 17:31
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `Bookstore`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Authors`
--

CREATE TABLE `Authors` (
  `AuthorID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `MiddleName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Authors`
--

INSERT INTO `Authors` (`AuthorID`, `FirstName`, `LastName`, `MiddleName`) VALUES
(1, 'F. Scott', 'Fitzgerald', 'Francis');

-- --------------------------------------------------------

--
-- Структура таблицы `Books`
--

CREATE TABLE `Books` (
  `BookID` int NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `AuthorID` int DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `PublicationYear` int DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `StockQuantity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `bookslist`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `bookslist` (
`Title` varchar(255)
,`AuthorFullName` varchar(152)
,`Publisher` varchar(255)
,`PublicationYear` int
,`Price` decimal(10,2)
,`StockQuantity` int
);

-- --------------------------------------------------------

--
-- Структура таблицы `Customers`
--

CREATE TABLE `Customers` (
  `CustomerID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `MiddleName` varchar(50) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Customers`
--

INSERT INTO `Customers` (`CustomerID`, `FirstName`, `LastName`, `MiddleName`, `Address`, `PhoneNumber`) VALUES
(1, 'Jane', 'Doe', 'Smith', '456 Elm St', '555-4321');

-- --------------------------------------------------------

--
-- Структура таблицы `Employees`
--

CREATE TABLE `Employees` (
  `EmployeeID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `MiddleName` varchar(50) DEFAULT NULL,
  `Position` varchar(255) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Employees`
--

INSERT INTO `Employees` (`EmployeeID`, `FirstName`, `LastName`, `MiddleName`, `Position`, `Salary`, `Address`, `PhoneNumber`) VALUES
(1, 'John', 'Doe', 'Smith', 'Sales Manager', '50000.00', '123 Main St', '555-1234');

-- --------------------------------------------------------

--
-- Структура таблицы `OrderDetails`
--

CREATE TABLE `OrderDetails` (
  `OrderID` int DEFAULT NULL,
  `BookID` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `orderdetailslist`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `orderdetailslist` (
`OrderID` int
,`Title` varchar(255)
,`Quantity` int
,`Price` decimal(10,2)
,`Amount` decimal(20,2)
);

-- --------------------------------------------------------

--
-- Структура таблицы `Orders`
--

CREATE TABLE `Orders` (
  `OrderID` int NOT NULL,
  `Date` date DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `EmployeeID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `Orders`
--

INSERT INTO `Orders` (`OrderID`, `Date`, `CustomerID`, `EmployeeID`) VALUES
(1, '2023-05-10', 1, 1);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `orderslist`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `orderslist` (
`OrderID` int
,`Date` date
,`CustomerFullName` varchar(152)
,`EmployeeFullName` varchar(152)
,`TotalAmount` decimal(42,2)
);

-- --------------------------------------------------------

--
-- Структура для представления `bookslist`
--
DROP TABLE IF EXISTS `bookslist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `bookslist`  AS SELECT `b`.`Title` AS `Title`, concat(`a`.`FirstName`,' ',`a`.`LastName`,' ',`a`.`MiddleName`) AS `AuthorFullName`, `b`.`Publisher` AS `Publisher`, `b`.`PublicationYear` AS `PublicationYear`, `b`.`Price` AS `Price`, `b`.`StockQuantity` AS `StockQuantity` FROM (`books` `b` join `authors` `a` on((`b`.`AuthorID` = `a`.`AuthorID`)))  ;

-- --------------------------------------------------------

--
-- Структура для представления `orderdetailslist`
--
DROP TABLE IF EXISTS `orderdetailslist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `orderdetailslist`  AS SELECT `od`.`OrderID` AS `OrderID`, `b`.`Title` AS `Title`, `od`.`Quantity` AS `Quantity`, `od`.`Price` AS `Price`, (`od`.`Quantity` * `od`.`Price`) AS `Amount` FROM (`orderdetails` `od` join `books` `b` on((`od`.`BookID` = `b`.`BookID`)))  ;

-- --------------------------------------------------------

--
-- Структура для представления `orderslist`
--
DROP TABLE IF EXISTS `orderslist`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `orderslist`  AS SELECT `o`.`OrderID` AS `OrderID`, `o`.`Date` AS `Date`, concat(`c`.`FirstName`,' ',`c`.`LastName`,' ',`c`.`MiddleName`) AS `CustomerFullName`, concat(`e`.`FirstName`,' ',`e`.`LastName`,' ',`e`.`MiddleName`) AS `EmployeeFullName`, sum((`od`.`Quantity` * `od`.`Price`)) AS `TotalAmount` FROM (((`orders` `o` join `customers` `c` on((`o`.`CustomerID` = `c`.`CustomerID`))) join `employees` `e` on((`o`.`EmployeeID` = `e`.`EmployeeID`))) join `orderdetails` `od` on((`o`.`OrderID` = `od`.`OrderID`))) GROUP BY `o`.`OrderID``OrderID`  ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Authors`
--
ALTER TABLE `Authors`
  ADD PRIMARY KEY (`AuthorID`);

--
-- Индексы таблицы `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`BookID`),
  ADD KEY `AuthorID` (`AuthorID`);

--
-- Индексы таблицы `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Индексы таблицы `Employees`
--
ALTER TABLE `Employees`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Индексы таблицы `OrderDetails`
--
ALTER TABLE `OrderDetails`
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `BookID` (`BookID`);

--
-- Индексы таблицы `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Books`
--
ALTER TABLE `Books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`AuthorID`) REFERENCES `Authors` (`AuthorID`);

--
-- Ограничения внешнего ключа таблицы `OrderDetails`
--
ALTER TABLE `OrderDetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`),
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `Books` (`BookID`);

--
-- Ограничения внешнего ключа таблицы `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
