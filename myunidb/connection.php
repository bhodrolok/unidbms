<?php 
 $dbhost = "localhost";
 $dbuser = "myuni_user";
 $dbpass = "root";
 $db = "myuni";

// enable error reporting
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

//connect to database
$con = mysqli_connect($dbhost, $dbuser, $dbpass, $db) or die($con);
?>