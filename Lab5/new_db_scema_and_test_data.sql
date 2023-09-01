CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Post (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    post_text VARCHAR(MAX),
    post_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Comment (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT,
    user_id INT,
    comment_text VARCHAR(MAX),
    comment_date DATETIME,
    parent_comment_id INT, -- new column added
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (parent_comment_id) REFERENCES Comment(id) -- self-referencing foreign key
);

CREATE TABLE Likes (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT,
    user_id INT,
    like_date DATETIME,
    FOREIGN KEY (post_id) REFERENCES Post(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Friendships (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id_1 INT,
    user_id_2 INT,
    frendship_date DATETIME,
    FOREIGN KEY (user_id_1) REFERENCES Users(id),
    FOREIGN KEY (user_id_2) REFERENCES Users(id)
);

CREATE TABLE Messages (
    id INT PRIMARY KEY IDENTITY(1,1),
    SenderId INT,
    ReceiverId INT,
    message_text VARCHAR(MAX),
    message_date DATETIME,
    FOREIGN KEY (SenderId) REFERENCES Users(id),
    FOREIGN KEY (ReceiverId) REFERENCES Users(id)
);

CREATE TABLE UserLocation (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    location geography,
    last_updated DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

drop table UserLocation;
drop table Messages;
drop table Friendships;
drop table Likes;
drop table Comment;
drop table Post;
drop table Users;

-- Users table
INSERT INTO Users (first_name, last_name, email)
VALUES ('John', 'Doe', 'johndoe@example.com'),
       ('Jane', 'Doe', 'janedoe@example.com'),
       ('Bob', 'Smith', 'bobsmith@example.com');

-- Post table
INSERT INTO Post (user_id, post_text, post_date)
VALUES (1, 'This is my first post', '2022-01-01 10:00:00'),
       (2, 'Hello world!', '2022-01-02 12:00:00'),
       (1, 'My second post', '2022-01-03 15:00:00');

-- Comment table
INSERT INTO Comment (post_id, user_id, comment_text, comment_date, parent_comment_id)
VALUES (1, 2, 'Great post!', '2022-01-01 11:00:00', NULL),
       (1, 1, 'Thanks, glad you liked it!', '2022-01-01 12:00:00', 1),
       (1, 3, 'Interesting topic', '2022-01-01 13:00:00', NULL),
       (3, 1, 'Nice post', '2022-01-03 16:00:00', NULL),
       (3, 2, 'Thanks!', '2022-01-03 17:00:00', 4),
       (3, 1, 'Glad you liked it', '2022-01-03 18:00:00', 5);

-- Likes table
INSERT INTO Likes (post_id, user_id, like_date)
VALUES (1, 2, '2022-01-01 11:00:00'),
       (2, 1, '2022-01-02 12:30:00'),
       (1, 3, '2022-01-02 13:00:00'),
       (3, 2, '2022-01-03 16:30:00');

-- Friendships table
INSERT INTO Friendships (user_id_1, user_id_2, frendship_date)
VALUES (1, 2, '2022-01-01 10:30:00'),
       (2, 3, '2022-01-02 11:00:00'),
       (1, 3, '2022-01-03 14:00:00');

-- Messages table
INSERT INTO Messages (SenderId, ReceiverId, message_text, message_date)
VALUES (1, 2, 'Hello, how are you?', '2022-01-01 11:30:00'),
       (2, 1, 'I am good, thanks!', '2022-01-01 12:00:00'),
       (1, 3, 'Do you want to grab lunch?', '2022-01-03 13:00:00'),
       (3, 1, 'Sure, where do you want to go?', '2022-01-03 14:00:00');

-- UserLocation table
INSERT INTO UserLocation (user_id, location, last_updated)
VALUES (1, geography::Point(47.6062, -122.3321, 4326), '2022-01-01 10:30:00'),
       (2, geography::Point(40.7128, -74.0060, 4326), '2022-01-02 12:00:00'),
       (3, geography::Point(51.5074, -0.1278, 4326), '2022-01-03 14:00:00');
