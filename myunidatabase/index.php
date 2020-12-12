<?php

session_start();

 $dbhost = "localhost";
 $dbuser = "myuni_user";
 $dbpass = "root";
 $db = "myuni";

//connect to database
$conn = mysqli_connect($dbhost, $dbuser, $dbpass, $db);

if(!$conn){ 
  //basic error handling if connection fails...
  die("Connect failed: %s\n". $conn -> error);
 }

//Getting input values if 'Login' button clicked
if(isset($_POST['login'])){
  $username=mysqli_real_escape_string($conn,$_POST['username']);
  $password=mysqli_real_escape_string($conn,$_POST['password']);
  
  if(empty($username)&&empty($password)){$error= 'Fields cannot be empty.';}
  else{
 
 //Checking log-in credentials
 $loginquery = "SELECT * FROM user_login WHERE username='$username' AND password='$password'";
 // Attempt query execution
 $result = mysqli_query($conn,$loginquery);

 $row=mysqli_fetch_assoc($result);
 $count=mysqli_num_rows($result);
 if($count==1){
      $_SESSION['user']=array(
   'username'=>$row['username'],
   'password'=>$row['password'],
   'usertype'=>$row['usertype']
   );
   $role=$_SESSION['user']['usertype'];
   //Redirecting User based on their usertype!
    switch($role){
  case 'admin':
  header('location:admin.php');
  break;
  case 'student':
  header('location:student.php');
  break;
  case 'prof':
  header('location:prof.php');
  break;
 }
 }else{
 $error='You are not registered in the database!';
 }
}
}
?>

<!DOCTYPE html>
<html>
<head>
<title>Welcome!</title>
</head>
<div align="center">
  <h1> Welcome to MyUni! </h1>
<h4>Please log-in below:</h4>

<form method="POST" action="">
<table>
   <tr>
     <td>Username:</td>
  <td><input type="text" name="username"/></td>
   </tr>
   <tr>
     <td>Password:</td>
  <td><input type="text" name="password"/></td>
   </tr>
   <tr>
     <td></td>
  <td><input type="submit" name="login" value="Login"/></td>
   </tr>
</table>
</form>
<?php if(isset($error)){ echo $error; }?>
</div>
</html>


<!-- Source: https://megatech24.blogspot.com/2017/05/multi-user-role-based-login-in-php-and-mysql-with-session.html-->