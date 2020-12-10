<?php 
include_once('C:\xampp\htdocs\myunidb\include.php');

$resultAddGrade = mysqli_query($connection, "CALL addGrade");

//loop the result set
while ($row = mysqli_fetch_array($resultAddGrade)){     
  echo $row[0] . " - " . + $row[1]; 
}

?>