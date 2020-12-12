<?php
session_start();
//Checking User Logged in or not:
if(empty($_SESSION['user'])){
 header('location:index.php');
}

//Restrict User or Moderator to Access Admin.php page
if($_SESSION['user']['usertype']=='user'){
 header('location:user.php');
}
if($_SESSION['user']['usertype']=='moderator'){
 header('location:moderator.php');
}
?>

<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
	<h1>Logged in as <?php echo $_SESSION['user']['username'];?>.</h1>

<link rel="stylesheet" href="style.css" type="text/css"/>
<div id="profile">
<h2>User name is: <?php echo $_SESSION['user']['username'];?> and your 'role' is :<?php echo $_SESSION['user']['usertype'];?></h2>

<!-- Create logout link -->
<div id="logout"><a href="logout.php">Logout</a></div>
</div>

</body>
</html>
