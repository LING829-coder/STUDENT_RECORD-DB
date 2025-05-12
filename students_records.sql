 CREATE DATABASE IF NOT EXISTS student_records_db;
USE student_records_db;
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_head VARCHAR(100),
    building VARCHAR(50),
    budget DECIMAL(12,2),
    established_date DATE
);
 INSERT INTO departments (department_name, department_head, building, budget, established_date)
VALUES 
('Computer Science', 'Dr. Smith', 'Engineering', 1500000.00, '1990-05-15'),
('Mathematics', 'Dr. Johnson', 'Science', 1200000.00, '1985-08-20'),
('Physics', 'Dr. Williams', 'Science', 1100000.00, '1988-03-10'),
('English', 'Dr. Brown', 'Humanities', 900000.00, '1975-09-01'),
('History', 'Dr. Davis', 'Humanities', 850000.00, '1978-11-05');
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    admission_date DATE NOT NULL,
    major_department_id INT,
    graduation_year INT,
    FOREIGN KEY (major_department_id) REFERENCES departments(department_id)
);
INSERT INTO students (first_name, last_name, date_of_birth, gender, email, phone, address, admission_date, major_department_id, graduation_year)
VALUES
('Ling', 'mukiri', '2000-05-15', 'Female', 'ling.mukiri@university.edu', '1234567890', '123 Main St, Cityville', '2020-08-20', 1, 2024),
('Jane', 'kendi', '2001-02-28', 'Female', 'jane.kendi@university.edu', '2345678901', '456 Oak Ave, Townsville', '2021-01-15', 2, 2025),
('Michael', 'Mwenda', '1999-11-10', 'Male', 'michael.m@university.edu', '3456789012', '789 Pine Rd, Villageton', '2019-08-25', 1, 2023),
('Emily', 'Williams', '2000-07-22', 'Female', 'emily.w@university.edu', '4567890123', '321 Elm Blvd, Hamletown', '2020-08-20', 3, 2024),
('David', 'Brown', '2001-04-05', 'Male', 'david.b@university.edu', '5678901234', '654 Cedar Ln, Boroughburg', '2021-01-15', 4, 2025);
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0 AND credits <= 6),
    department_id INT NOT NULL,
    description TEXT,
    prerequisite_course_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (prerequisite_course_id) REFERENCES courses(course_id)
);
INSERT INTO courses (course_code, course_name, credits, department_id, description)
VALUES
('CS101', 'Introduction to Programming', 4, 1, 'Fundamentals of programming using Python'),
('CS201', 'Data Structures', 4, 1, 'Study of common data structures and algorithms'),
('MATH201', 'Calculus I', 4, 2, 'Differential and integral calculus'),
('PHYS101', 'General Physics', 4, 3, 'Fundamentals of mechanics and thermodynamics'),
('ENG101', 'Composition I', 3, 4, 'Introduction to academic writing'),
('HIST101', 'World History', 3, 5, 'Survey of world civilizations');
UPDATE courses SET prerequisite_course_id = 1 WHERE course_id = 2;
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    office_location VARCHAR(50),
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO instructors (first_name, last_name, email, phone, office_location, department_id, hire_date, salary)
VALUES
('Robert', 'Wilson', 'r.wilson@university.edu', '6789012345', 'ENG-201', 1, '2010-07-15', 85000.00),
('Sarah', 'Miller', 's.miller@university.edu', '7890123456', 'SCI-105', 2, '2012-03-10', 78000.00),
('Thomas', 'Taylor', 't.taylor@university.edu', '8901234567', 'SCI-210', 3, '2015-08-20', 82000.00),
('Jennifer', 'Anderson', 'j.anderson@university.edu', '9012345678', 'HUM-302', 4, '2008-01-05', 75000.00),
('James', 'Thomas', 'j.thomas@university.edu', '0123456789', 'HUM-305', 5, '2013-06-15', 76000.00);
CREATE TABLE course_sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    instructor_id INT NOT NULL,
    semester ENUM('Fall', 'Spring', 'Summer', 'Winter') NOT NULL,
    year INT NOT NULL,
    classroom VARCHAR(20),
    schedule VARCHAR(100),
    max_capacity INT DEFAULT 30,
    current_enrollment INT DEFAULT 0,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id),
    UNIQUE (course_id, section_id, semester, year)
);
INSERT INTO course_sections (course_id, instructor_id, semester, year, classroom, schedule, max_capacity)
VALUES
(1, 1, 'Fall', 2023, 'ENG-101', 'MWF 10:00-10:50', 30),
(1, 1, 'Spring', 2024, 'ENG-102', 'MWF 11:00-11:50', 30),
(2, 1, 'Fall', 2023, 'ENG-201', 'TTH 13:00-14:15', 25),
(3, 2, 'Fall', 2023, 'SCI-105', 'MWF 09:00-09:50', 35),
(4, 3, 'Spring', 2024, 'SCI-205', 'TTH 10:30-11:45', 30),
(5, 4, 'Fall', 2023, 'HUM-101', 'MWF 13:00-13:50', 40),
(6, 5, 'Spring', 2024, 'HUM-102', 'TTH 14:00-15:15', 35);
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    withdrawal_date DATE,
    status ENUM('Active', 'Withdrawn', 'Completed') DEFAULT 'Active',
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (section_id) REFERENCES course_sections(section_id),
    UNIQUE (student_id, section_id)
);
INSERT INTO enrollments (student_id, section_id, enrollment_date, status)
VALUES
(1, 1, '2023-08-15', 'Completed'),
(1, 3, '2023-08-15', 'Completed'),
(2, 1, '2023-08-15', 'Completed'),
(2, 4, '2023-08-15', 'Completed'),
(3, 1, '2023-08-15', 'Completed'),
(3, 6, '2023-08-15', 'Completed'),
(4, 1, '2023-08-15', 'Completed'),
(4, 5, '2024-01-10', 'Active'),
(5, 2, '2024-01-10', 'Active'),
(5, 7, '2024-01-10', 'Active');
CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL UNIQUE,
    midterm_grade DECIMAL(5,2) CHECK (midterm_grade BETWEEN 0 AND 100),
    final_grade DECIMAL(5,2) CHECK (final_grade BETWEEN 0 AND 100),
    assignment_grade DECIMAL(5,2) CHECK (assignment_grade BETWEEN 0 AND 100),
    letter_grade CHAR(2),
    comments TEXT,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);
INSERT INTO grades (enrollment_id, midterm_grade, final_grade, assignment_grade, letter_grade, comments)
VALUES
(1, 85.5, 92.0, 88.0, 'A', 'Excellent performance'),
(2, 78.0, 82.5, 80.0, 'B', 'Good work'),
(3, 92.5, 95.0, 94.0, 'A', 'Outstanding student'),
(4, 65.0, 70.0, 68.0, 'C', 'Needs improvement in assignments'),
(5, 88.0, 85.0, 90.0, 'A', 'Consistent performance'),
(6, 72.0, 75.0, 74.0, 'B', 'Good participation'),
(7, 95.0, 98.0, 96.0, 'A', 'Top of the class');
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') DEFAULT 'Present',
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id),
    UNIQUE (enrollment_id, date)
);
INSERT INTO attendance (enrollment_id, date, status)
VALUES
(1, '2023-08-20', 'Present'),
(1, '2023-08-22', 'Present'),
(1, '2023-08-24', 'Absent'),
(2, '2023-08-20', 'Present'),
(2, '2023-08-22', 'Late'),
(2, '2023-08-24', 'Present'),
(3, '2023-08-20', 'Present'),
(3, '2023-08-22', 'Present'),
(4, '2024-01-10', 'Present'),
(5, '2024-01-10', 'Absent');









Procedure to calculate final grades
DELIMITER //
CREATE PROCEDURE calculate_final_grades(
    IN p_section_id INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_enrollment_id INT;
    DECLARE v_midterm, v_final, v_assignment DECIMAL(5,2);
    DECLARE v_letter_grade CHAR(2);
    
    -- Cursor for all enrollments in the section
    DECLARE cur CURSOR FOR 
        SELECT e.enrollment_id, g.midterm_grade, g.final_grade, g.assignment_grade
        FROM enrollments e
        LEFT JOIN grades g ON e.enrollment_id = g.enrollment_id
        WHERE e.section_id = p_section_id AND e.status = 'Active';
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO v_enrollment_id, v_midterm, v_final, v_assignment;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate letter grade based on final grade (simplified logic)
        IF v_final >= 90 THEN
            SET v_letter_grade = 'A';
        ELSEIF v_final >= 80 THEN
            SET v_letter_grade = 'B';
        ELSEIF v_final >= 70 THEN
            SET v_letter_grade = 'C';
        ELSEIF v_final >= 60 THEN
            SET v_letter_grade = 'D';
        ELSE
            SET v_letter_grade = 'F';
        END IF;
        
        -- Update or insert grade record
        IF EXISTS (SELECT 1 FROM grades WHERE enrollment_id = v_enrollment_id) THEN
            UPDATE grades
            SET letter_grade = v_letter_grade
            WHERE enrollment_id = v_enrollment_id;
        ELSE
            INSERT INTO grades (enrollment_id, midterm_grade, final_grade, assignment_grade, letter_grade)
            VALUES (v_enrollment_id, v_midterm, v_final, v_assignment, v_letter_grade);
        END IF;
    END LOOP;
    
    CLOSE cur;
END //
DELIMITER ;






-- Student academic summary view
CREATE VIEW student_academic_summary AS
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.department_name AS major,
    COUNT(e.enrollment_id) AS courses_taken,
    AVG(g.final_grade) AS average_grade
FROM 
    students s
LEFT JOIN 
    departments d ON s.major_department_id = d.department_id
LEFT JOIN 
    enrollments e ON s.student_id = e.student_id
LEFT JOIN 
    grades g ON e.enrollment_id = g.enrollment_id
WHERE 
    e.status = 'Completed'
GROUP BY 
    s.student_id, student_name, major;

-- Course enrollment statistics view
CREATE VIEW course_enrollment_stats AS
SELECT 
    c.course_code,
    c.course_name,
    cs.semester,
    cs.year,
    COUNT(e.student_id) AS enrolled_students,
    cs.max_capacity,
    CONCAT(i.first_name, ' ', i.last_name) AS instructor
FROM 
    course_sections cs
JOIN 
    courses c ON cs.course_id = c.course_id
JOIN 
    instructors i ON cs.instructor_id = i.instructor_id
LEFT JOIN 
    enrollments e ON cs.section_id = e.section_id AND e.status = 'Active'
GROUP BY 
    cs.section_id, c.course_code, c.course_name, cs.semester, cs.year, cs.max_capacity, instructor;