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

    $sql1 = "SELECT * FROM student";
    $result1 = $conn->query($sql1);
     
    if ($result1->num_rows > 0) {
        $students=array();
        while($row = $result->fetch_assoc()) {
            $student=array(
                "Student_ID" => $row["Student_ID"],
                "Username" => $row["Username"],
                "AdminID" => $row["AdminID"],
                "Year_enrolled" => $row["Year_enrolled"],
                "Major" => $row["Major"],
                "Name" => $row["Name"],
                "GPA" => $row["GPA"],
                "App_status" => $row["App_status"]
            );
            array_push($students,$student);
        }
        sendResponse(200,$students,'Student List');
    } else {
        sendResponse(404,[],'Student not available');
    }



    //closing connection
    $conn->close();
}
?>
