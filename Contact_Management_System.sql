create database contact_management_sys;
use contact_management_sys;

-- Creating table for admins
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

INSERT INTO admins (admin_name, email, password) 
VALUES 
('Admin 1', 'admin1@example.com', 'password1'),
('Admin 2', 'admin2@example.com', 'password2'),
('Admin 3', 'admin3@example.com', 'password3'),
('Admin 4', 'admin4@example.com', 'password4'),
('Admin 5', 'admin5@example.com', 'password5');


-- Creating table for users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

INSERT INTO users (username, email, password) 
VALUES 
('user1', 'user1@example.com', 'userpassword1'),
('user2', 'user2@example.com', 'userpassword2'),
('user3', 'user3@example.com', 'userpassword3'),
('user4', 'user4@example.com', 'userpassword4'),
('user5', 'user5@example.com', 'userpassword5');

-- Creating table for contacts
CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO contacts (user_id, name, email, phone, address) 
VALUES 
(1, 'Contact 1', 'contact1@example.com', '1234567890', '123 Main St, City'),
(2, 'Contact 2', 'contact2@example.com', '2345678901', '456 Elm St, Town'),
(3, 'Contact 3', 'contact3@example.com', '3456789012', '789 Oak St, Village'),
(4, 'Contact 4', 'contact4@example.com', '4567890123', '987 Pine St, County'),
(5, 'Contact 5', 'contact5@example.com', '5678901234', '654 Maple St, District');

-- Creating table for logs
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO logs (action, user_id) 
VALUES 
('Login', 1),
('Logout', 2),
('Login', 3),
('Logout', 4),
('Login', 5);

select * from admins;
select * from users;
select * from contacts;
select * from logs;

-- query1
SELECT c.name, c.email, c.phone, c.address
FROM contacts c 
JOIN users u ON c.user_id = u.id 
WHERE u.username = 'user1';

-- query2
UPDATE users 
SET password = 'newSecurePassword123' 
WHERE username = 'user3';

-- query3
SELECT * 
FROM logs 
WHERE action = 'Login';

-- query4
DELETE FROM contacts 
WHERE email = 'contact5@example.com';


-- creating views
-- view1
CREATE VIEW UserContacts AS
SELECT u.username, u.email AS user_email, c.name AS contact_name, c.email AS contact_email, c.phone
FROM users u
JOIN contacts c ON u.id = c.user_id;

-- view2
CREATE VIEW UserLoginLogs AS
SELECT u.username, l.action, l.created_at
FROM users u
JOIN logs l ON u.id = l.user_id
WHERE l.action = 'Login';

-- view3
CREATE VIEW RecentUserActivity AS
SELECT u.username, l.action, l.created_at
FROM users u
JOIN logs l ON u.id = l.user_id
ORDER BY l.created_at DESC;

-- view4
CREATE VIEW UsersMultipleContacts AS
SELECT u.username, COUNT(c.id) AS contact_count
FROM users u
JOIN contacts c ON u.id = c.user_id
GROUP BY u.id
HAVING COUNT(c.id) > 1;

-- view5
CREATE VIEW AdminDetails AS
SELECT admin_name, email, 
       CASE WHEN password IS NOT NULL THEN 'Set' ELSE 'Not Set' END AS password_status
FROM admins;

-- displaying views
SELECT * FROM UserContacts;
SELECT * FROM UserLoginLogs;
SELECT * FROM RecentUserActivity;
SELECT * FROM UsersMultipleContacts;
SELECT * FROM AdminDetails;









