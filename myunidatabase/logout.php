<?php
session_start();							// Initialize the session
session_destroy();							// Destroy the session
header('location:index.php');				// Redirect to the login page
exit;
?>

<!--Source: https://www.tutorialrepublic.com/php-tutorial/php-mysql-login-system.php-->