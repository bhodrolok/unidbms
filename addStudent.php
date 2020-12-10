<?php 
include_once('C:\xampp\htdocs\myunidb\include.php');

$resultAddStudent = mysqli_query($connection, "CALL addStudent");

//loop the result set
while ($row = mysqli_fetch_array($resultAddStudent)){     
  echo $row[0] . " - " . + $row[1]; 
}

?>