# STUDENT_RECORD-DB
📌 Project Title
Student Records Database Management System

📝 Description
This project is a complete MySQL-based database system designed to manage:
✔ Student information (personal details, majors, enrollment)
✔ Course & department structures
✔ Instructor assignments
✔ Class enrollments & grading & class attendance

Key Features:
✅ Relational design (1:1, 1:M, M:N relationships)
✅ Constraints & validations (PK, FK, NOT NULL, UNIQUE)
✅ Sample dataset for testing
✅ Pre-built queries & stored procedures

Setup & Installation
Requirements
MySQL Server (8.0+)

MySQL Workbench (recommended for visualization)

Import Instructions
Create the database:

sql
CREATE DATABASE student_records_db;
USE student_records_db;
Import SQL file:

Via command line:

sh
mysql -u [username] -p student_records_db < student_records_db.sql
Via MySQL Workbench:
File → Open SQL Script → Execute

🔍 Entity-Relationship Diagram (ERD)
Visual representation of database structure:
a file with my erd

How to generate your own ERD:

In MySQL Workbench: Database → Reverse Engineer


📜 Sample Queries
sql
-- Find all Computer Science majors
SELECT * FROM students 
WHERE major_department_id = (SELECT department_id FROM departments 
                           WHERE department_name = 'Computer Science');

-- Get course enrollment counts
SELECT c.course_name, COUNT(e.student_id) as enrolled_students
FROM courses c
JOIN course_sections cs ON c.course_id = cs.course_id
LEFT JOIN enrollments e ON cs.section_id = e.section_id
GROUP BY c.course_name;
💡 Why This Database?
Educational use: Perfect for university record-keeping

Learning resource: Demonstrates proper database design

Extensible: Easy to add new features (attendance, payments, etc.)

📂 Files Included:

student_records_db.sql (Complete database schema + sample data)
STUDENT RECORD-ERD



License: MIT
Author: LING MUKIRI


