<?php
include_once('C:\xampp\htdocs\myunidb\include.php');


$user = json_decode(file_get_contents("php://input"));

//validation whether user data is having name or not. similarly email, password etc.
if(!$user->name){
    sendResponse(400, [] , 'Name Required !');  
}else if(!$user->password){
    sendResponse(400, [] , 'Password Required !');        
}else{
    $conn=getConnection();
    if($conn==null){
        sendResponse(500, $conn, 'Server Connection Error !');
    }else{
        $sql="INSERT INTO user_login(username, password, usertype)";
        $sql .= "VALUES ('".$user->name."','".$user->email."','";
        $sql .= $password."','".$user->contact."')";

        $result = $conn->query($sql); //$result = true/false on success or error respectively.
        if ($result) {
            sendResponse(200, $result , 'User Registration Successful.');
        } else {
            sendResponse(404, [] ,'User not Registered');
        }
        //close connection
        $conn->close();
    }
}
?>