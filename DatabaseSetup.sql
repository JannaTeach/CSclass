-- DatabaseSetup.sql
-- Run this script once to create the example database and table

-- Create the database (run separately if needed)
-- CREATE DATABASE SchoolDB;
-- GO
-- USE SchoolDB;
-- GO

-- Create Students table (safe to run multiple times)
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
BEGIN
    CREATE TABLE Students (
        Id       INT           PRIMARY KEY IDENTITY(1,1),
        Name     NVARCHAR(100) NOT NULL,
        Grade    INT           NOT NULL,
        Email    NVARCHAR(150)
    );

    -- Insert sample data
    INSERT INTO Students (Name, Grade, Email) VALUES ('Alice Cohen',   90, 'alice@example.com');
    INSERT INTO Students (Name, Grade, Email) VALUES ('Bob Levi',      85, 'bob@example.com');
    INSERT INTO Students (Name, Grade, Email) VALUES ('Carol Mizrahi', 78, 'carol@example.com');
    INSERT INTO Students (Name, Grade, Email) VALUES ('Dan Shapiro',   95, 'dan@example.com');
END
GO

-- Example queries

-- SELECT all students
SELECT * FROM Students;

-- SELECT students with grade above 80
SELECT Name, Grade FROM Students WHERE Grade > 80 ORDER BY Grade DESC;

-- UPDATE a student's grade
-- UPDATE Students SET Grade = 92 WHERE Name = 'Bob Levi';

-- DELETE a student
-- DELETE FROM Students WHERE Id = 3;
