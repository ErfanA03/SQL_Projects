CREATE DATABASE db_library;

USE db_library;

CREATE TABLE library_branch (
	Branch_ID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	Branch_Name VARCHAR(255) NOT NULL,
	Branch_Address VARCHAR(255) NOT NULL
);

CREATE TABLE borrower (
	Card_No INT PRIMARY KEY NOT NULL IDENTITY(2000,1),
	Borrower_Name VARCHAR(50) NOT NULL,
	Borrower_Address VARCHAR(100) NOT NULL,
	Borrower_Phone VARCHAR(25) NOT NULL
);

CREATE TABLE publisher (
	Publisher_Name VARCHAR(255) PRIMARY KEY NOT NULL,
	Publisher_Address VARCHAR(255) NOT NULL,
	Publisher_Phone VARCHAR(25) NOT NULL
);

CREATE TABLE books (
	Book_ID INT PRIMARY KEY NOT NULL IDENTITY(5000,1),
	Title VARCHAR(255) NOT NULL,
	Publisher_Name VARCHAR(255),
	FOREIGN KEY (Publisher_Name) REFERENCES publisher(Publisher_Name)
);

CREATE TABLE book_copies (
	Book_ID INT,
	Branch_ID INT,
	Number_Of_Copies INT NOT NULL,
	FOREIGN KEY (Book_ID) REFERENCES books(Book_ID),
	FOREIGN KEY (Branch_ID) REFERENCES library_branch(Branch_ID)
);

CREATE TABLE authors (
	Book_ID INT,
	Author_Name VARCHAR(50) NOT NULL,
	FOREIGN KEY (Book_ID) REFERENCES books(Book_ID),
);

CREATE TABLE book_loans (
	Book_ID INT,
	Branch_ID INT,
	Card_No INT,
	Date_Out DATE NOT NULL,
	Date_Due DATE NOT NULL,
	FOREIGN KEY (Book_ID) REFERENCES books(Book_ID),
	FOREIGN KEY (Branch_ID) REFERENCES library_branch(Branch_ID),
	FOREIGN KEY (Card_No) REFERENCES borrower(Card_No)
);

INSERT INTO library_branch
	(Branch_Name, Branch_Address)
	VALUES
	('Gotham Library', '9765 Gotham Blvd, Gotham City, GC 54321'),
	('Springfield Library', '5824 Evergreen Terrace, Springfield, SP 12345'),
	('The Mouse Library', '1852 Mouse Street, Toontropolis, TP 98765 '),
	('The Looney Library', '2042 Acme Avenue, Toontown, TT 56789'),
	('The Bikini Library', '757 Pineapple Place, Bikini Bottom, BB 45678 '),
	('Sharpstown', '7660 Clarewood Dr, Houston, TX 77036')
;

INSERT INTO borrower
	(Borrower_Name, Borrower_Address, Borrower_Phone)
	VALUES
	('Bruce Wayne', 'Wayne Manor, 123 Gotham Blvd, Gotham City, GC 94563', '194-345-7456'),
	('Homer Simpson', '742 Evergreen Terrace, Springfield, SP 17593', '830-204-2031'),
	('Mickey Mouse', '5678 Mouse Street, Toontropolis, TP 42043', '801-345-7890'),
	('Bugs Bunny', '1234 Acme Avenue, Toontown, TT 30235', '702-542-8892'),
	('SpongeBob SquarePants', '9876 Pineapple Place, Bikini Bottom, BB 44935', '174-792-0193'),
	('Bob Dylan', '9364 Clarewood Dr, Houston, TX 01234', '102-394-2934'),
	('Scooby-Doo', '8765 Mystery Manor, Coolsville, CS 32109', '284-293-2891'),
	('Donald Duck', '2109 Duckburg Drive, Duckburg, DB 87654', '104-300-9721')
;

INSERT INTO publisher
	(Publisher_Name, Publisher_Address, Publisher_Phone)
	VALUES
	('The Gotham Press', '485 Gotham Blvd, Gotham City, GC 94883', '194-293-3921'),
	('Springfiel Publishing', '2183 Evergreen Terrace, Springfield, SP 12648', '830-928-3942'),
	('Imagination Imprints', '9000 Mouse Street, Toontropolis, TP 45092', '801-920-9821'),
	('Tooniverse Books', '3462 Acme Avenue, Toontown, TT 71058', '702-102-2901'),
	('The Bikini Press', '3531 Pineapple Place, Bikini Bottom, BB 63973', '174-019-8213'),
	('Sharpstown Publishing', '1952 Clarewood Dr, Houston, TX 82031', '102-019-8500'),
	('HauntedWritings Inc.', '4500 Mystery Manor, Coolsville, CS 23002', '284-830-2931'),
	('DuckWorth Press', '1520 Duckburg Drive, Duckburg, DB 61241', '104-192-8420'),
	('Marvel Entertainment', '135 W 50th St, New York, NY 10020', '190-872-9201'),
	('Disney Animation', '2100 W Riverside Dr, Burbank, CA 91506', '729-339-0210')
;

INSERT INTO books
	(Title, Publisher_Name)
	VALUES
	('The Lost Tribe', 'The Gotham Press'),
	('War and Peace', 'Springfiel Publishing'),
	('Pride and Prejudice', 'Imagination Imprints'),
	('1984', 'Tooniverse Books'),
	('To Kill a Mockingbird', 'The Bikini Press'),
	('The Great Gatsby', 'Sharpstown Publishing'),
	('Moby-Dick', 'HauntedWritings Inc.'),
	('One Hundred Years of Solitude', 'DuckWorth Press'),
	('The Catcher in the Rye', 'Marvel Entertainment'),
	('Ulysses', 'Disney Animation'),
	('The Lord of the Rings', 'The Gotham Press'),
	('The Odyssey', 'Springfiel Publishing'),
	('The Brothers Karamazov', 'Imagination Imprints'),
	('Anna Karenina', 'Tooniverse Books'),
	('Brave New World', 'The Bikini Press'),
	('Crime and Punishment', 'Sharpstown Publishing'),
	('The Divine Comedy', 'HauntedWritings Inc.'),
	('Wuthering Heights', 'DuckWorth Press'),
	('The Grapes of Wrath', 'Marvel Entertainment'),
	('The Adventures of Huckleberry Finn', 'Disney Animation')
;

INSERT INTO authors
	(Author_Name, Book_ID)
	VALUES
	('Harper Lee', 5004),
	('Leo Tolstoy', 5001 ),
	('Jane Austen', 5002),
	('Aldous Huxley', 5014),
	('Fyodor Dostoevsky', 5012),
	('J.R.R. Tolkien', 5010),
	('J.D. Salinger', 5008),
	('Dante Alighieri', 5016),
	('Aldous Huxley', 5007),
	('Leo Tolstoy', 5013)
;


INSERT INTO book_copies (Book_ID, Branch_ID, Number_Of_Copies)
SELECT b.Book_ID, lb.Branch_ID, 2
FROM books b
CROSS JOIN library_branch lb
LEFT JOIN book_copies bc ON b.Book_ID = bc.Book_ID AND lb.Branch_ID = bc.Branch_ID
WHERE bc.Book_ID IS NULL;

INSERT INTO book_loans (Book_ID, Branch_ID, Card_No, Date_Out, Date_Due)
SELECT TOP 10
    b.Book_ID,
    lb.Branch_ID,
    br.Card_No,
    DATEADD(DAY, -FLOOR(RAND()*(30-1)+1), GETDATE()) AS Date_Out,
    DATEADD(DAY, FLOOR(RAND()*(21-7)+7), GETDATE()) AS Date_Due
FROM books b
CROSS JOIN library_branch lb
CROSS JOIN borrower br
ORDER BY NEWID();

SELECT * FROM ((book_loans FULL OUTER JOIN borrower ON book_loans.Card_No =
borrower.Card_No) FULL OUTER JOIN books ON book_loans.Book_ID = books.Book_ID);

CREATE PROCEDURE GetLostTribeCopiesAtBranch
AS
BEGIN
    SELECT bc.Number_Of_Copies
    FROM book_copies bc
    INNER JOIN books b ON bc.Book_ID = b.Book_ID
    INNER JOIN library_branch lb ON bc.Branch_ID = lb.Branch_ID
    WHERE b.Title = 'The Lost Tribe' AND lb.Branch_Name = 'Sharpstown';
END;

CREATE PROCEDURE GetAllLostTribeCopiesByBranch
AS
BEGIN
    SELECT lb.Branch_Name, COALESCE(bc.Number_Of_Copies, 0) AS Number_Of_Copies
    FROM library_branch lb
    LEFT JOIN book_copies bc ON lb.Branch_ID = bc.Branch_ID
    LEFT JOIN books b ON bc.Book_ID = b.Book_ID AND b.Title = 'The Lost Tribe';
END;

CREATE PROCEDURE GetBorrowersWithNoBooksCheckedOut
AS
BEGIN
    SELECT b.Borrower_Name
    FROM borrower b
    LEFT JOIN book_loans bl ON b.Card_No = bl.Card_No
    WHERE bl.Card_No IS NULL;
END;
