CREATE TABLE VerseCategory(
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    globalId VARCHAR(255),
    name VARCHAR(255),
    description TEXT
)

CREATE TABLE Verse(
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    globalId VARCHAR(255),
    content TEXT,
    quotation VARCHAR(100),
    isFaved TINYINT DEFAULT 0,
    categoryId INTEGER,
    dateAdded DATETIME default current_timestamp
)

CREATE TABLE BibleBook(
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    testament TINYINT NOT NULL CHECK(testament == 1 OR testament == 2),
    chapters TINYINT DEFAULT 0,
    maxVerse TINYINT DEFAULT 0
)