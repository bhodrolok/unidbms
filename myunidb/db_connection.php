<?php

function OpenCon()
 {
 $dbhost = "localhost";
 $dbuser = "myuni_user";
 $dbpass = "root";
 $db = "myuni";

 $conn = new mysqli($dbhost, $dbuser, $dbpass,$db); 
 

 if(!$conn){ 
 	die("Connect failed: %s\n". $conn -> error);
 }
 
 return $conn;
 }
 
function CloseCon($conn)
 {
 $conn -> close();
 }
   
?>