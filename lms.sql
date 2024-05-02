CREATE TABLE `authentication` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) DEFAULT NULL,
  `PasswordHash` varchar(255) DEFAULT NULL,
  `Role` enum('Admin','Librarian','User') DEFAULT 'User',
  `LastLogin` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsActive` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`)
);
SELECT*FROM aunthentication;

CREATE TABLE `author` (
  `AuthorID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `Nationality` varchar(100) DEFAULT NULL,
  `Biography` text,
  PRIMARY KEY (`AuthorID`)
);
SELECT*FROM author;

CREATE TABLE `book` (
  `BookID` int NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `YearPublished` int DEFAULT NULL,
  `Genre` varchar(50) DEFAULT NULL,
  `AvailabilityStatus` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`BookID`)
);
SELECT*FROM book;

CREATE TABLE `librarybook` (
  `LibraryBookID` int NOT NULL AUTO_INCREMENT,
  `BookID` int DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `ShelfNumber` varchar(50) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`LibraryBookID`),
  KEY `BookID` (`BookID`),
  CONSTRAINT `librarybook_ibfk_1` FOREIGN KEY (`BookID`) REFERENCES `book` (`BookID`)
);
SELECT*FROM librarybook;

CREATE TABLE `staff` (
  `StaffID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Position` varchar(50) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE KEY `Email` (`Email`)
);
SELECT*FROM staff;

CREATE TABLE `transaction` (
  `TransactionID` int NOT NULL,
  `UserID` int DEFAULT NULL,
  `BookID` int DEFAULT NULL,
  `IssueDate` date DEFAULT NULL,
  `DueDate` date DEFAULT NULL,
  `ReturnDate` date DEFAULT NULL,
  `FineAmount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `UserID` (`UserID`),
  KEY `BookID` (`BookID`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `book` (`BookID`)
);
SELECT*FROM transaction;

CREATE TABLE `user` (
  `UserID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `MembershipType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UserID`)
);
SELECT*FROM user;

INSERT INTO Book (BookID, Title, Author, ISBN, Publisher, YearPublished, Genre, AvailabilityStatus)
VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', '9780061120084', 'HarperCollins', 1960, 'Fiction', true),
(2, '1984', 'George Orwell', '9780451524935', 'Signet Classics', 1949, 'Dystopian', true),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 'Scribner', 1925, 'Classic', false),
(4, 'Pride and Prejudice', 'Jane Austen', '9780679783268', 'Modern Library', 1813, 'Romance', true),
(5, 'The Catcher in the Rye', 'J.D. Salinger', '9780316769488', 'Little, Brown and Company', 1951, 'Coming-of-age', true);
SELECT*FROM book;

INSERT INTO User (UserID, Name, Email, Address, PhoneNumber, MembershipType)
VALUES
(1, 'John Doe', 'johndoe@example.com', '123 Main St, Anytown', '123-456-7890', 'Student'),
(2, 'Jane Smith', 'janesmith@example.com', '456 Elm St, Anycity', '987-654-3210', 'Faculty'),
(3, 'Alice Johnson', 'alicejohnson@example.com', '789 Oak St, Anyville', '555-123-4567', 'Guest');
SELECT*FROM user;

INSERT INTO Transaction (TransactionID, UserID, BookID, IssueDate, DueDate, ReturnDate, FineAmount)
VALUES
(1, 1, 1, '2024-04-01', '2024-04-15', '2024-04-20', 0.00),
(2, 2, 2, '2024-04-02', '2024-04-16', '2024-04-18', 0.00),
(3, 1, 3, '2024-04-03', '2024-04-17', NULL, 0.00),
(4, 3, 4, '2024-04-04', '2024-04-18', '2024-04-23', 1.50),
(5, 2, 5, '2024-04-05', '2024-04-19', NULL, 0.00);

SELECT*FROM transaction;

INSERT INTO Author (FirstName, LastName, BirthDate, Nationality, Biography)
VALUES
('Harper', 'Lee', '1926-04-28', 'American', 'Harper Lee was an American novelist best known for her novel "To Kill a Mockingbird."'),
('George', 'Orwell', '1903-06-25', 'British', 'George Orwell was an English writer and journalist known for his dystopian novel "1984."'),
('F. Scott', 'Fitzgerald', '1896-09-24', 'American', 'F. Scott Fitzgerald was an American novelist famous for "The Great Gatsby."'),
('Jane', 'Austen', '1775-12-16', 'British', 'Jane Austen was an English novelist known for her classic works such as "Pride and Prejudice."'),
('J.D.', 'Salinger', '1919-01-01', 'American', 'J.D. Salinger was an American author renowned for "The Catcher in the Rye."');

SELECT*FROM author;

INSERT INTO LibraryBook (BookID, Location, ShelfNumber, Quantity)
VALUES
(1, 'Fiction Section', 'A1', 5),
(2, 'Classics Section', 'B3', 3),
(3, 'Drama Section', 'C2', 2),
(4, 'Romance Section', 'A5', 4),
(5, 'Young Adult Section', 'D1', 6);
SELECT*FROM LibraryBook;

INSERT INTO Staff (FirstName, LastName, Email, Phone, Position, Department, HireDate, Salary)
VALUES
('John', 'Doe', 'johndoe@example.com', '123-456-7890', 'Librarian', 'Library Services', '2020-01-15', 50000.00),
('Jane', 'Smith', 'janesmith@example.com', '987-654-3210', 'Library Assistant', 'Acquisitions', '2021-03-10', 35000.00),
('Alice', 'Johnson', 'alicejohnson@example.com', '555-123-4567', 'IT Specialist', 'Information Technology', '2019-07-22', 45000.00);
SELECT*FROM staff;
	
INSERT INTO Book (Title, Author, ISBN, Publisher, YearPublished, Genre, AvailabilityStatus)
VALUES
('The Hobbit', 'J.R.R. Tolkien', '9780547928227', 'Houghton Mifflin Harcourt', 1937, 'Fantasy', true),
('The Da Vinci Code', 'Dan Brown', '9780307474278', 'Anchor Books', 2003, 'Mystery', true),
('The Hunger Games', 'Suzanne Collins', '9780439023481', 'Scholastic Corporation', 2008, 'Young Adult', true),
('The Lord of the Rings', 'J.R.R. Tolkien', '9780618640157', 'Houghton Mifflin Harcourt', 1954, 'Fantasy', true),
('The Catcher in the Rye', 'J.D. Salinger', '9780316769488', 'Little, Brown and Company', 1951, 'Coming-of-age', true);

CREATE VIEW AvailableBooksView AS
SELECT * FROM Book WHERE AvailabilityStatus = true;


CREATE VIEW FineSummaryView AS
SELECT UserID, SUM(FineAmount) AS TotalFineAmount
FROM Transaction
GROUP BY UserID;

CREATE VIEW OverdueTransactionsView AS
SELECT * FROM Transaction WHERE ReturnDate IS NULL AND DueDate < CURDATE();

CREATE VIEW PopularBooksView AS
SELECT Book.*, COUNT(TransactionID) AS TransactionCount
FROM Book
JOIN Transaction ON Book.BookID = Transaction.BookID
GROUP BY Book.BookID
ORDER BY TransactionCount DESC;


CREATE VIEW UserDetailsView AS
SELECT User.*, Transaction.*
FROM User
LEFT JOIN Transaction ON User.UserID = Transaction.UserID;


UPDATE LibraryBook SET Quantity = 5 WHERE BookID = 1; 
UPDATE LibraryBook SET Quantity = 7 WHERE BookID = 2; 
UPDATE LibraryBook SET Quantity = 3 WHERE BookID = 3; 
UPDATE LibraryBook SET Quantity = 6 WHERE BookID = 5; 
INSERT INTO LibraryBook (BookID, Location, ShelfNumber, Quantity)
VALUES
(4, 'Fantasy Section', 'B2', 4), 
(6, 'Mystery Section', 'C4', 7); 

SELECT*FROM LibraryBook