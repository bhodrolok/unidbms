-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2020 at 09:34 PM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_grade` (IN `Mark` FLOAT(4))  BEGIN
SELECT s.Student_id, g.Mark
	FROM  Student as S, Grade as g
	WHERE Mark =  g.Mark and s.Student_id = g.Student_id;
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
g.Department_id = d.Department_id) or (s.Student_id = u.Student_id) and
(u.Department_id = d.Department_id) and (d.Department_id = p.Department_id));

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_course_prof` (IN `CourseID` INT)  NO SQL
BEGIN

SELECT c.courseId, c.studentId 
	FROM  Course as c
	WHERE @CourseId =  c.courseId;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_course_student` (IN `CourseID` INT(22))  SELECT c.name, c.credit, p.name
	FROM  Course as c, Program as p
	WHERE @CourseId =  c.courseID and c.programID = p.programID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_student` (IN `StudentID` INT(11))  BEGIN
SELECT s.Name, s.Year_enrolled, s.Major
	FROM  Student as S
	WHERE StudentID =  s.Student_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_app` (IN `studentID` VARCHAR(45), IN `appStatus` VARCHAR(45))  BEGIN

UPDATE student
SET student.App_status = appStatus
WHERE student.Student_id = studentID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_grade` ()  BEGIN

SELECT s.GPA
	FROM  Student as s;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_prof` (IN `ProfID` INT(11))  BEGIN

SELECT p.Name, pr.Name
	FROM Prof as p, Program as pr
	WHERE (ProfID = p.Prof_id) and (p.Program_id = pr.Program_id);
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_student` (IN `StudentID` INT(11))  BEGIN 

SELECT s.Name, s.Year_enrolled, s.Major
	FROM Student as s
	WHERE StudentId = s.Student_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_student_app_status` (IN `StudentID` INT)  BEGIN

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
  `username` varchar(45) CHARACTER SET utf8 NOT NULL,
  `Salary` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Admin_id`, `username`, `Salary`) VALUES
(1, 'admin1', NULL),
(2, 'admin2', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `Course_id` int(11) NOT NULL,
  `Program_id` int(11) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `Name` varchar(29) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`Course_id`, `Program_id`, `Admin_id`, `Name`) VALUES
(1, 1, 1, 'Math100'),
(2, 1, 2, 'Math101'),
(3, 1, 1, 'Maths111');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Department_id` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`Department_id`, `Name`) VALUES
(1, 'Science'),
(2, 'Arts'),
(3, 'Law'),
(4, 'Medicine'),
(5, 'Business');

-- --------------------------------------------------------

--
-- Table structure for table `grade`
--

CREATE TABLE `grade` (
  `Admin_id` int(11) NOT NULL,
  `Course_id` int(11) NOT NULL,
  `Student_id` int(11) NOT NULL,
  `Grade_id` int(11) NOT NULL,
  `Mark` int(11) NOT NULL DEFAULT 18
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `grade`
--

INSERT INTO `grade` (`Admin_id`, `Course_id`, `Student_id`, `Grade_id`, `Mark`) VALUES
(1, 1, 1, 1, 18),
(1, 1, 2, 2, 18);

-- --------------------------------------------------------

--
-- Table structure for table `graduate`
--

CREATE TABLE `graduate` (
  `Student_id` int(11) NOT NULL,
  `Grad_id` int(11) NOT NULL,
  `Department_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `graduate`
--

INSERT INTO `graduate` (`Student_id`, `Grad_id`, `Department_id`) VALUES
(4, 1, 1),
(5, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `prof`
--

CREATE TABLE `prof` (
  `Prof_id` int(11) NOT NULL,
  `username` varchar(45) CHARACTER SET utf8 NOT NULL,
  `Program_id` int(11) NOT NULL,
  `Name` varchar(29) NOT NULL DEFAULT 'professor',
  `Salary` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prof`
--

INSERT INTO `prof` (`Prof_id`, `username`, `Program_id`, `Name`, `Salary`) VALUES
(1, 'prof1', 1, 'professor maths1', NULL),
(2, 'prof2', 1, 'professor2 maths1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `program`
--

CREATE TABLE `program` (
  `Program_id` int(11) NOT NULL,
  `Department_id` int(11) NOT NULL,
  `Name` varchar(29) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `program`
--

INSERT INTO `program` (`Program_id`, `Department_id`, `Name`) VALUES
(1, 1, 'Maths'),
(2, 1, 'CS');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Student_id` int(16) NOT NULL,
  `username` varchar(45) CHARACTER SET utf8 NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `Name` varchar(29) NOT NULL,
  `Major` varchar(29) NOT NULL,
  `Year_enrolled` int(11) DEFAULT NULL,
  `GPA` float DEFAULT 0,
  `App_status` varchar(29) NOT NULL DEFAULT 'Enrolled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`Student_id`, `username`, `Admin_id`, `Name`, `Major`, `Year_enrolled`, `GPA`, `App_status`) VALUES
(1, 'student1', 1, '', '', NULL, 0, 'Enrolled'),
(2, 'student2', 1, '', '', NULL, 0, 'Enrolled'),
(3, 'student3', 1, 'Student 3', 'Biological Sciences', NULL, 0, 'Awaiting'),
(4, 'student4', 2, 'Student 4', 'Computer Engineering', NULL, 0, 'Enrolled'),
(5, 'student5', 1, 'Student 5', 'Mathematics', NULL, 0, 'Enrolled'),
(6, 'student6', 1, 'Student 6', 'Doctor', NULL, 0, 'Enrolled');

-- --------------------------------------------------------

--
-- Table structure for table `ta`
--

CREATE TABLE `ta` (
  `TAGrad_id` int(11) NOT NULL,
  `Course_id` int(11) NOT NULL,
  `Salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `undergraduate`
--

INSERT INTO `undergraduate` (`Student_id`, `Department_id`) VALUES
(1, 1),
(2, 5),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `user_login`
--

CREATE TABLE `user_login` (
  `id` int(22) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `usertype` enum('admin','student','prof','') NOT NULL DEFAULT 'student'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_login`
--

INSERT INTO `user_login` (`id`, `username`, `password`, `usertype`) VALUES
(1, 'admin1', 'admin1', 'admin'),
(2, 'admin2', 'admin2', 'admin'),
(3, 'admin3', 'admin3', 'admin'),
(4, 'prof1', 'prof1', 'prof'),
(5, 'prof2', 'prof2', 'prof'),
(6, 'prof3', 'prof3', 'prof'),
(7, 'prof4', 'prof4', 'prof'),
(8, 'student1', 'student1', 'student'),
(9, 'student2', 'student2', 'student'),
(10, 'student3', 'student3', 'student'),
(11, 'student4', 'student4', 'student'),
(12, 'student5', 'student5', 'student'),
(13, 'student6', 'student6', 'student'),
(14, 'student7', 'student7', 'student'),
(15, 'student8', 'student8', 'student'),
(16, 'student9', 'student9', 'student');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Admin_id`,`username`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`Course_id`,`Program_id`,`Admin_id`),
  ADD UNIQUE KEY `UniqueKeys` (`Course_id`,`Program_id`,`Admin_id`),
  ADD KEY `Admin_id` (`Admin_id`),
  ADD KEY `Program_id` (`Program_id`);

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
  ADD PRIMARY KEY (`Admin_id`,`Course_id`,`Student_id`,`Grade_id`),
  ADD UNIQUE KEY `UniqueKeysGrade` (`Admin_id`,`Course_id`,`Student_id`,`Grade_id`),
  ADD KEY `Course_id` (`Course_id`),
  ADD KEY `Student_id` (`Student_id`);

--
-- Indexes for table `graduate`
--
ALTER TABLE `graduate`
  ADD PRIMARY KEY (`Grad_id`,`Student_id`,`Department_id`),
  ADD KEY `Department_id` (`Department_id`),
  ADD KEY `Student_id` (`Student_id`);

--
-- Indexes for table `prof`
--
ALTER TABLE `prof`
  ADD PRIMARY KEY (`Prof_id`,`Program_id`,`username`),
  ADD KEY `Program_id` (`Program_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`Program_id`),
  ADD UNIQUE KEY `unique` (`Department_id`,`Program_id`) USING BTREE;

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`Student_id`,`username`),
  ADD KEY `Admin_id` (`Admin_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `ta`
--
ALTER TABLE `ta`
  ADD PRIMARY KEY (`TAGrad_id`,`Course_id`),
  ADD UNIQUE KEY `UniqueKeysTA` (`TAGrad_id`),
  ADD KEY `Course_id` (`Course_id`);

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
  ADD UNIQUE KEY `UniqueKeys` (`Student_id`,`Department_id`),
  ADD KEY `Department_id` (`Department_id`);

--
-- Indexes for table `user_login`
--
ALTER TABLE `user_login`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `Username_UNIQUE` (`username`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `Admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `Course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `Department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `graduate`
--
ALTER TABLE `graduate`
  MODIFY `Grad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `prof`
--
ALTER TABLE `prof`
  MODIFY `Prof_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `program`
--
ALTER TABLE `program`
  MODIFY `Program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `Student_id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_login`
--
ALTER TABLE `user_login`
  MODIFY `id` int(22) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user_login` (`Username`);

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`),
  ADD CONSTRAINT `course_ibfk_2` FOREIGN KEY (`Program_id`) REFERENCES `program` (`Program_id`);

--
-- Constraints for table `grade`
--
ALTER TABLE `grade`
  ADD CONSTRAINT `grade_ibfk_1` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`),
  ADD CONSTRAINT `grade_ibfk_2` FOREIGN KEY (`Course_id`) REFERENCES `course` (`Course_id`),
  ADD CONSTRAINT `grade_ibfk_3` FOREIGN KEY (`Student_id`) REFERENCES `student` (`Student_id`);

--
-- Constraints for table `graduate`
--
ALTER TABLE `graduate`
  ADD CONSTRAINT `graduate_ibfk_1` FOREIGN KEY (`Department_id`) REFERENCES `department` (`Department_id`),
  ADD CONSTRAINT `graduate_ibfk_2` FOREIGN KEY (`Student_id`) REFERENCES `student` (`Student_id`);

--
-- Constraints for table `prof`
--
ALTER TABLE `prof`
  ADD CONSTRAINT `prof_ibfk_1` FOREIGN KEY (`Program_id`) REFERENCES `program` (`Program_id`),
  ADD CONSTRAINT `prof_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user_login` (`Username`);

--
-- Constraints for table `program`
--
ALTER TABLE `program`
  ADD CONSTRAINT `program_ibfk_1` FOREIGN KEY (`Department_id`) REFERENCES `department` (`Department_id`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`),
  ADD CONSTRAINT `student_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user_login` (`Username`);

--
-- Constraints for table `ta`
--
ALTER TABLE `ta`
  ADD CONSTRAINT `ta_ibfk_1` FOREIGN KEY (`Course_id`) REFERENCES `course` (`Course_id`);

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
  ADD CONSTRAINT `undergraduate_ibfk_1` FOREIGN KEY (`Department_id`) REFERENCES `department` (`Department_id`),
  ADD CONSTRAINT `undergraduate_ibfk_2` FOREIGN KEY (`Student_id`) REFERENCES `student` (`Student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
