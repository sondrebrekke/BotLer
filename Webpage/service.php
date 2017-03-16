<?php

$conn = new mysqli('mysql.stud.ntnu.no', 'jorgfb_botler', 'park12');
        if ($conn->connect_error){
            die("feil: " . $conn->connect_error);
        } else {

        }

    $db = mysqli_select_db($conn, 'jorgfb_botler_database');

$return_arr = array();

$fetch = mysql_query("SELECT * FROM assignments"); 

if ($res = mysqli_query($conn, $query)){
    while ($row = $res -> fetch_array()) {
        $id = $row[0];
        $name = $row[1];

    array_push($return_arr,$name);
}
}

echo json_encode($return_arr);

?>