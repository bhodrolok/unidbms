-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2020 at 02:57 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `myuni`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_grade` (IN `Mark` INT)  NO SQL
BEGIN
SELECT s.studentid, g.mark
	FROM  Student as S, Grade as g
	WHERE Mark =  g.mark and s.studentId = g.studentId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_student` (IN `StudentUsername` VARCHAR(45), IN `Password` VARCHAR(45), IN `StudentName` VARCHAR(45), IN `StudentID` INT, IN `YearEnrolled` INT, IN `GPA` FLOAT, IN `AdminID` INT, IN `AppStatus` VARCHAR(45), IN `AdminUsername` VARCHAR(45), IN `AdminName` VARCHAR(45))  BEGIN

INSERT INTO user (Username, Name)
VALUE (StudentUsername, StudentName);
INSERT INTO user (Username, Name)
VALUE (AdminUsername, AdminName);
INSERT INTO admin (Admin_id, Username)
Value (AdminID, AdminUserName);
INSERT INTO student (Student_id, Username, Year_enrolled, GPA)
VALUE (StudentID, Username, YearEnrolled, GPA);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_student` (IN `studentID` INT)  BEGIN

SELECT s.Name, s.Year_enrolled, p.Name
FROM student as s JOIN program as p, department as d, graduate as g,
undergraduate as u
WHERE s.Student_id = studentID and ((s.Student_id = g.Student_id and
g.Department_id = d.Department_id) or s.Student_id = u.Student_id and
u.Department_id = d.Department_id) and d.Department_id = p.Department_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_course_prof` (IN `CourseID` INT)  NO SQL
BEGIN

SELECT c.courseId, c.studentId 
	FROM  Course as c
	WHERE @CourseId =  c.courseId;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_course_student` (IN `CourseID` INT)  NO SQL
SELECT c.name, c.credit, p.name
	FROM  Course as c, Program as p
	WHERE @CourseId =  c.courseID and c.programID = p.programID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_student` (IN `StudentID` INT)  NO SQL
BEGIN
SELECT s.Name, s.yearEnrolled, s.major
	FROM  Student as S
	WHERE StudentId =  s.Student_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_app` (IN `studentID` VARCHAR(45), IN `appStatus` VARCHAR(45))  BEGIN

UPDATE student
SET student.App_status = appStatus
WHERE student.Student_id = studentID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_grade` ()  NO SQL
    COMMENT 'Simply view a grade in a course'
BEGIN

SELECT s.GPA
	FROM  Student as s;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_prof` (IN `ProfID` INT)  NO SQL
BEGIN

SELECT pr.fname, pr.lname, p.name
	FROM Prof as pr, Program as p
	WHERE @ProfId = pr.profId and pr.programID = p.programID;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_student` (IN `StudentID` INT)  NO SQL
BEGIN 

SELECT s.Name, s.yearEnrolled, s.major
	FROM Student as s
	WHERE StudentId = s.studentId;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_student_app` (IN `StudentID` INT)  NO SQL
BEGIN

SELECT u.Name, s.Student_id, s.App_status
FROM user as u JOIN student as s
WHERE s.Student_id = StudentID;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `Admin_id` int(11) NOT NULL,
  `Username` varchar(45) NOT NULL,
  `Salary` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Admin_id`, `Username`, `Salary`) VALUES
(1, 'wut', 0),
(12, 'asdasdas', 0);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `Course_id` int(11) NOT NULL,
  `Program_id` int(11) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Credit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Department_id` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `grade`
--

CREATE TABLE `grade` (
  `Student_id` int(11) NOT NULL,
  `Course_id` int(11) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `Grade_id` int(11) NOT NULL,
  `Mark` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `graduate`
--

CREATE TABLE `graduate` (
  `Student_id` int(11) NOT NULL,
  `G_id` int(11) NOT NULL,
  `Department_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prof`
--

CREATE TABLE `prof` (
  `Prof_id` int(11) NOT NULL,
  `Username` varchar(45) NOT NULL,
  `Salary` double NOT NULL,
  `Program_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `program`
--

CREATE TABLE `program` (
  `Program_id` int(11) NOT NULL,
  `Department_id` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Student_id` int(11) NOT NULL,
  `Username` varchar(45) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `Year_enrolled` int(11) NOT NULL,
  `Name` varchar(42) NOT NULL DEFAULT 'JohnDoe',
  `GPA` float NOT NULL,
  `App_status` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `student021010012`
--

CREATE TABLE `student021010012` (
  `Student_id` int(11) NOT NULL,
  `Username` varchar(42) NOT NULL,
  `Fname` varchar(42) NOT NULL,
  `Lname` varchar(42) NOT NULL,
  `GPA` float NOT NULL,
  `yearEnrolled` int(4) NOT NULL,
  `Major` varchar(42) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ta`
--

CREATE TABLE `ta` (
  `G_id` int(11) NOT NULL,
  `Course_id` int(11) NOT NULL,
  `Salary` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `teaches`
--

CREATE TABLE `teaches` (
  `Prof_id` int(11) NOT NULL,
  `Course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `undergraduate`
--

CREATE TABLE `undergraduate` (
  `Student_id` int(11) NOT NULL,
  `Department_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Username` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Username`, `Password`, `Name`) VALUES
('', '', ''),
('asd', '', 'dasdasd'),
('asdasdas', '', 'asdasd'),
('omegalol', '', 'intense'),
('wut', '', 'wutt');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Admin_id`,`Username`),
  ADD UNIQUE KEY `Admin_id_UNIQUE` (`Admin_id`),
  ADD UNIQUE KEY `Username_UNIQUE` (`Username`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`Course_id`,`Program_id`,`Admin_id`),
  ADD UNIQUE KEY `Course_id_UNIQUE` (`Course_id`),
  ADD UNIQUE KEY `Program_id_UNIQUE` (`Program_id`),
  ADD UNIQUE KEY `Admin_id_UNIQUE` (`Admin_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Department_id`),
  ADD UNIQUE KEY `Department_id_UNIQUE` (`Department_id`);

--
-- Indexes for table `grade`
--
ALTER TABLE `grade`
  ADD PRIMARY KEY (`Student_id`,`Course_id`,`Admin_id`,`Grade_id`),
  ADD UNIQUE KEY `Student_id_UNIQUE` (`Student_id`),
  ADD UNIQUE KEY `Course_id_UNIQUE` (`Course_id`),
  ADD UNIQUE KEY `Admin_id_UNIQUE` (`Admin_id`),
  ADD UNIQUE KEY `Grade_id_UNIQUE` (`Grade_id`);

--
-- Indexes for table `graduate`
--
ALTER TABLE `graduate`
  ADD PRIMARY KEY (`Student_id`,`G_id`,`Department_id`),
  ADD UNIQUE KEY `Student_id_UNIQUE` (`Student_id`),
  ADD UNIQUE KEY `G_id_UNIQUE` (`G_id`),
  ADD UNIQUE KEY `Department_id_UNIQUE` (`Department_id`);

--
-- Indexes for table `prof`
--
ALTER TABLE `prof`
  ADD PRIMARY KEY (`Prof_id`,`Username`,`Program_id`),
  ADD UNIQUE KEY `Prof_id_UNIQUE` (`Prof_id`),
  ADD UNIQUE KEY `Username_UNIQUE` (`Username`),
  ADD UNIQUE KEY `Program_id_UNIQUE` (`Program_id`);

--
-- Indexes for table `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`Program_id`,`Department_id`),
  ADD UNIQUE KEY `Program_id_UNIQUE` (`Program_id`),
  ADD UNIQUE KEY `Department_id_UNIQUE` (`Department_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`Student_id`,`Username`,`Admin_id`),
  ADD UNIQUE KEY `Student_id_UNIQUE` (`Student_id`),
  ADD UNIQUE KEY `Username_UNIQUE` (`Username`),
  ADD UNIQUE KEY `Admin_id_UNIQUE` (`Admin_id`);

--
-- Indexes for table `student021010012`
--
ALTER TABLE `student021010012`
  ADD PRIMARY KEY (`Student_id`,`Username`);

--
-- Indexes for table `ta`
--
ALTER TABLE `ta`
  ADD PRIMARY KEY (`G_id`,`Course_id`),
  ADD UNIQUE KEY `G_id_UNIQUE` (`G_id`),
  ADD UNIQUE KEY `Course_id_UNIQUE` (`Course_id`);

--
-- Indexes for table `teaches`
--
ALTER TABLE `teaches`
  ADD PRIMARY KEY (`Prof_id`,`Course_id`),
  ADD UNIQUE KEY `Prof_id_UNIQUE` (`Prof_id`),
  ADD UNIQUE KEY `Course_id_UNIQUE` (`Course_id`);

--
-- Indexes for table `undergraduate`
--
ALTER TABLE `undergraduate`
  ADD PRIMARY KEY (`Student_id`,`Department_id`),
  ADD UNIQUE KEY `Student_id_UNIQUE` (`Student_id`),
  ADD UNIQUE KEY `Department_id_UNIQUE` (`Department_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`Username`),
  ADD UNIQUE KEY `Username_UNIQUE` (`Username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `Username_admin` FOREIGN KEY (`Username`) REFERENCES `user` (`Username`);

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `Admin_id_course` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`),
  ADD CONSTRAINT `Program_id_course` FOREIGN KEY (`Program_id`) REFERENCES `program` (`Program_id`);

--
-- Constraints for table `grade`
--
ALTER TABLE `grade`
  ADD CONSTRAINT `Admin_id_grade` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`),
  ADD CONSTRAINT `Course_id_grade` FOREIGN KEY (`Course_id`) REFERENCES `course` (`Course_id`),
  ADD CONSTRAINT `Student_id_grade` FOREIGN KEY (`Student_id`) REFERENCES `student021010012` (`Student_id`);

--
-- Constraints for table `graduate`
--
ALTER TABLE `graduate`
  ADD CONSTRAINT `Department_id_grad` FOREIGN KEY (`Department_id`) REFERENCES `department` (`Department_id`),
  ADD CONSTRAINT `Student_id_grad` FOREIGN KEY (`Student_id`) REFERENCES `student021010012` (`Student_id`);

--
-- Constraints for table `prof`
--
ALTER TABLE `prof`
  ADD CONSTRAINT `Program_id_prof` FOREIGN KEY (`Program_id`) REFERENCES `program` (`Program_id`),
  ADD CONSTRAINT `Username_prof` FOREIGN KEY (`Username`) REFERENCES `user` (`Username`);

--
-- Constraints for table `program`
--
ALTER TABLE `program`
  ADD CONSTRAINT `Department_id_prog` FOREIGN KEY (`Department_id`) REFERENCES `department` (`Department_id`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `Admin_id_student` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`),
  ADD CONSTRAINT `Username_student` FOREIGN KEY (`Username`) REFERENCES `user` (`Username`);

--
-- Constraints for table `ta`
--
ALTER TABLE `ta`
  ADD CONSTRAINT `Course_id_ta` FOREIGN KEY (`Course_id`) REFERENCES `course` (`Course_id`),
  ADD CONSTRAINT `G_id_ta` FOREIGN KEY (`G_id`) REFERENCES `graduate` (`G_id`);

--
-- Constraints for table `teaches`
--
ALTER TABLE `teaches`
  ADD CONSTRAINT `Course_id_teaches` FOREIGN KEY (`Course_id`) REFERENCES `course` (`Course_id`),
  ADD CONSTRAINT `Prof_id_teaches` FOREIGN KEY (`Prof_id`) REFERENCES `prof` (`Prof_id`);

--
-- Constraints for table `undergraduate`
--
ALTER TABLE `undergraduate`
  ADD CONSTRAINT `Department_id_ugrad` FOREIGN KEY (`Department_id`) REFERENCES `department` (`Department_id`),
  ADD CONSTRAINT `Student_id_ugrad` FOREIGN KEY (`Student_id`) REFERENCES `student021010012` (`Student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
