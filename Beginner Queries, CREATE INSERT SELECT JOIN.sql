-- @block CREATE Users table
CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    bio TEXT,
    country VARCHAR(2)
);

-- @block INSERT example
INSERT INTO Users(email, bio, country)
VALUES 
    ('yo@kgoomail.com', 'nihao', 'US'),
    ('greet@mail.com', 'howdy', 'CN');

-- @block SELECT sequence with LIKE (REGEX?)
SELECT email,id,country FROM Users
WHERE country = 'US'
AND email LIKE '%kgoo%'
ORDER BY id DESC
LIMIT 2;

-- @block Indexing
CREATE INDEX email_index ON Users(email);

-- @block CREATE Rooms table
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT,
    street VARCHAR(255),
    owner_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

-- @block INSERT example
INSERT INTO Rooms(owner_id, street)
VALUES 
    (1, 'san diego'),
    (1, 'sembawang'),
    (1, 'woodlands');



-- @block LEFT JOIN example
SELECT 
    Users.id AS User_Id,
    Users.email, 
    Rooms.owner_id,
    Rooms.id AS Room_Id
FROM Users
LEFT JOIN Rooms
ON Rooms.owner_id = Users.id;

-- @block Create Bookings Table
CREATE TABLE Bookings (
    id INT AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (guest_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Rooms(id)
)

-- @block Rooms a user has booked
SELECT
    guest_id,
    street,
    check_in
FROM Bookings
INNER JOIN Rooms ON Rooms.owner_id = guest_id
WHERE guest_id = 1;

-- @block Guests who stayed in a room
SELECT
    room_id,
    guest_id,
    email,
    bio
FROM Bookings
INNER JOIN Users ON Users.id = guest_id
WHERE room_id = 2;