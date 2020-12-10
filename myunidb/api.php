<?php

header("Content-Type:application/json");

include 'addStudent.php'
include 'viewStudentApplication.php'
include 'searchStudent.php'
include 'viewStudent.php'
include 'selectCourseProf.php'
include 'selectStudent.php'
include 'addGrade.php'
include 'viewProf.php'
include 'selectCourseStudent.php'
include 'viewGrade.php'

 $dbhost = "localhost";
 $dbuser = "myuni_user";
 $dbpass = "root";
 $db = "myuni";

// enable error reporting
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

//connect to database
$connection = mysqli_connect($dbhost, $dbuser, $dbpass, $db) or die($connection);



?>