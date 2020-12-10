<?php
    function getConnection()
    {
        $host = 'localhost';
        $db_name = 'myuni';
        $username = 'myuni_user';
        $password = 'root';
        $conn= new mysqli($host, $username, $password, $db_name);
        if ($conn->connect_error) {
            $conn= null;
        }
        return $conn;
    }
?>
