-- Insert statements for sample data in each table
-- 1. Sample data for Member table
INSERT INTO Member (first_name, last_name, home_address, phone_number, email, user_password, date_of_birth, gender, height_CM, weight_KG, bmi, body_fat_percentage, last_login, active) 
VALUES 
('John', 'Doe', '123 Main St', '123-456-7890', 'john@example.com', 'password123', '1990-05-15', 'Male', '180', '80', '24', '15', '2024-04-12', true),
('Jane', 'Smith', '456 Elm St', '987-654-3210', 'jane@example.com', 'password456', '1988-10-20', 'Female', '165', '65', '23.8', '20', '2024-04-11', true);

-- 2. Sample data for Trainer table
INSERT INTO Trainer (first_name, last_name, phone_number, email, user_password, certification, specialization, last_login, active) 
VALUES 
('Mike', 'Johnson', '555-123-4567', 'mike@example.com', 'trainerpass', 'ACE', 'Weightlifting', '2024-04-10', true),
('Sarah', 'Brown', '555-987-6543', 'sarah@example.com', 'trainerpass', 'NASM', 'Yoga', '2024-04-09', true);

-- 3. Sample data for Admin_Staff table
INSERT INTO Admin_Staff (first_name, last_name, phone_number, email, user_password, title, last_login, active) 
VALUES 
('Emily', 'Davis', '555-111-2222', 'emily@example.com', 'adminpass', 'Manager', '2024-04-08', true),
('David', 'Wilson', '555-333-4444', 'david@example.com', 'adminpass', 'Receptionist', '2024-04-07', true);

-- 4. Sample data for Fitness_Goal table
INSERT INTO Fitness_Goal (metric_type, begin_date, end_date, start_value, target_value, current_value, member_ID) 
VALUES 
('Weight Loss', '2024-01-01', '2024-12-31', '80', '70', '78', 1),
('Muscle Gain', '2024-01-01', '2024-12-31', '50', '60', '55', 2);

-- 5. Sample data for Schedule table
INSERT INTO Schedule (member_ID, trainer_ID, room_ID) 
VALUES 
(1, 1, 1),
(2, 2, 2);

-- 6. Sample data for Timeslot table
INSERT INTO Timeslot (start_time, end_time, duration_minutes, schedule_ID) 
VALUES 
('08:00', '09:00', 60, 1),
('10:00', '11:00', 60, 2);

-- 7. Sample data for Room table
INSERT INTO Room (room_number, room_description, schedule_ID) 
VALUES 
(101, 'Weight Room', 1),
(201, 'Yoga Studio', 2);

-- 8. Sample data for Equipment table
INSERT INTO Equipment (equipment_name, condition, room_ID) 
VALUES 
('Treadmill', 'Good', 1),
('Yoga Mats', 'New', 2);

-- 9. Sample data for Personal_Training_Session table
INSERT INTO Personal_Training_Session (session_date, member_ID, trainer_ID, room_ID, timeslot_ID) 
VALUES 
('2024-04-13', 1, 1, 1, 1),
('2024-04-14', 2, 2, 2, 2);

-- 10. Sample data for Group_Fitness_Class table
INSERT INTO Group_Fitness_Class (session_date, difficulty_level, capacity, trainer_ID, room_ID, timeslot_ID) 
VALUES 
('2024-04-15', 'Intermediate', 10, 1, 1, 1),
('2024-04-16', 'Beginner', 15, 2, 2, 2);

-- 11. Sample data for Bill table
INSERT INTO Bill (amount, bill_description, bill_date, member_ID) 
VALUES 
(50.00, 'Membership Fee', '2024-04-01', 1),
(25.00, 'Personal Training Session', '2024-04-01', 2);

-- 12. Sample data for Payment table
INSERT INTO Payment (amount, payment_description, payment_date, member_ID) 
VALUES 
(50.00, 'Membership Fee Payment', '2024-04-02', 1),
(25.00, 'Personal Training Payment', '2024-04-02', 2);

-- Queries demonstrating different functionalities of the database
-- 1. Basic Query: Retrieve all members' first names and email addresses.
SELECT first_name, email FROM Member;

-- 2. First name of members along with the start time of their scheduled sessions.
SELECT m.first_name, t.start_time
FROM Member m
JOIN Schedule s ON m.ID = s.member_ID
JOIN Timeslot t ON s.ID = t.schedule_ID;

-- 3. Average BMI of all members
SELECT AVG(CAST(bmi AS FLOAT)) AS average_bmi FROM Member;

-- 4. All members who have a BMI greater than the average BMI
SELECT first_name
FROM Member
WHERE CAST(bmi AS FLOAT) > (SELECT AVG(CAST(bmi AS FLOAT)) FROM Member);

-- 5. Members who have not logged in since the beginning of the current year.
SELECT first_name
FROM Member
WHERE last_login < DATE_TRUNC('year', CURRENT_DATE);

-- 6. Members who have personal training sessions scheduled in the yoga studio.
SELECT m.first_name
FROM Member m
JOIN Personal_Training_Session pts ON m.ID = pts.member_ID
JOIN Room r ON pts.room_ID = r.ID
WHERE r.room_description = 'Yoga Studio';

-- 7. Find how many ersonal training sessions each member has; display only those with more than 1 session.
SELECT m.first_name, COUNT(pts.ID) AS session_count
FROM Member m
LEFT JOIN Personal_Training_Session pts ON m.ID = pts.member_ID
GROUP BY m.first_name
HAVING COUNT(pts.ID) > 1;

-- 8. Names of all members and Trainers
SELECT first_name FROM Member
UNION
SELECT first_name FROM Trainer;
