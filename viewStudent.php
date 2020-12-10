<?php 
include_once('C:\xampp\htdocs\myunidb\include.php');
$conn=getConnection();

if($conn==null){
    //send response if connection error occurred.
    sendResponse(500,$conn,'Server Connection Error');}

$resultViewStudent = mysqli_query($conn, "CALL view_student");

//loop the result set
while ($row = mysqli_fetch_array($resultViewStudent)){     
  echo $row[0] . " - " . + $row[1]; 
}

?>