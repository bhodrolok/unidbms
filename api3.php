<?php
include_once('C:\xampp\htdocs\myunidb\include.php');
//get connection from database.php
$conn=getConnection();

if($conn==null){
    //send response if connection error occurred.
    sendResponse(500,$conn,'Server Connection Error');
}else{
    $sql = "SELECT username, usertype FROM user_login";
    $result = $conn->query($sql);
    
    //check if user list available 
    if ($result->num_rows > 0) {
        $users=array();
        while($row = $result->fetch_assoc()) {
            $user=array(
                "username" => $row["username"],
                "usertype" => $row["usertype"]
            );
            array_push($users,$user);
        }
        sendResponse(200,$users,'User List');
    } else {
        sendResponse(404,[],'User not available');
    }

    $resultAddStudent = mysqli_query($connection, "CALL view_student");
    return 
    
    //closing connection
    $conn->close();
}
?>
