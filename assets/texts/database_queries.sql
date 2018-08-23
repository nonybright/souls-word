CREATE TABLE VerseCategory(
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    globalId VARCHAR(255),
    name VARCHAR(255),
    description TEXT,
    dateAdded DATETIME NOT NULL default current_timestamp
);

CREATE TABLE Verse(
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    globalId VARCHAR(255),
    content TEXT,
    quotation VARCHAR(100),
    isFaved TINYINT DEFAULT 0,
    categoryId INTEGER,
    dateAdded DATETIME NOT NULL default current_timestamp,
    FOREIGN KEY(categoryId) REFERENCES VerseCategory(id)
);

CREATE TABLE BibleBook(
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    shortName VARCHAR(10),
    testament TINYINT NOT NULL CHECK(testament == 1 OR testament == 2),
    chapters TINYINT DEFAULT 0,
    maxVerse TINYINT DEFAULT 0
);

--Mock Values

INSERT INTO  VerseCategory(globalId, name, description) VALUES('a','Commands', 'Commands 10'),
('b','Jesus', 'This is about jesus'),
('c','Love', 'This is about love'),
('d','Peace', 'This is about peace');

INSERT INTO Verse(globalId, content, quotation, categoryId) VALUES 
('a', 'Do not kill', 'Exodus 20:10', 1),
('b', 'Do not bang', 'Exodus 20:11', 1),
('c', 'Do not covert', 'Exodus 20:12', 1),
('d', 'Jesus wept', 'John 11:35', 2),
('e', 'Jesus talks about end time', 'Mathew 24:4', 2);

INSERT INTO BibleBook(name, shortName, testament, chapters, maxVerse) VALUES 
('Genesis', 'Gen', 1, 44,60),
('Exodus', 'Exo', 1, 30, 27),
('Levinticus', 'Lev', 1, 55, 19),
('Mathew', 'Mat', 2, 48,21),
('Mark', 'Mark', 2, 38,29),
('Luke', 'Luke', 2, 30,55),
('John', 'John', 2, 20,22);

--query
SELECT * FROM VerseCategory;