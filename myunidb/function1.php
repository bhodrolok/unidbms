<?php 
 $dbhost = "localhost";
 $dbuser = "myuni_user";
 $dbpass = "root";
 $db = "myuni";

// enable error reporting
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

//connect to database
$connection = mysqli_connect($dbhost, $dbuser, $dbpass, $db);


//run the store proc
$result = mysqli_query($connection, "CALL StoreProcName");

//loop the result set
while ($row = mysqli_fetch_array($result)){     
  echo $row[0] . " - " . + $row[1]; 
}