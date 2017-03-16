<?php

	session_start();

	$username= $_SESSION['username'];
	$password = $_SESSION['password'];
	
	$conn = new mysqli('mysql.stud.ntnu.no', 'jorgfb_botler', 'park12');
		if ($conn->connect_error){
			die("feil: " . $conn->connect_error);
		} else {

		}



	$db = mysqli_select_db($conn, 'jorgfb_botler_database');	
			$query = "SELECT subject_code FROM lecturer,subjects WHERE lecturer.id = subjects.lecturer AND  username= '$username' AND password= '$password'"  ;
			if ($res = mysqli_query($conn, $query)){
				while ($row = $res -> fetch_array()) {
					$subject_code = $row[0];

				}
			}	
			?>

<?php


$conn = new mysqli('mysql.stud.ntnu.no', 'jorgfb_botler', 'park12', 'jorgfb_botler_database'); //Her kobler jeg meg til området mitt på nvselev.no. Jeg skriver inn server, brukernavn, passord og databsenavnet.
	if (!mysqli_set_charset($conn, "utf8")) { //Her sier jeg at hvis ikke tegnsettingen er satt til UTF-8, skal den "skrive ut" på siden Feil ved lasting av tegnsettet utf8. Brukeren vil også få en feilmelding.
		printf("Feil ved lasting av tegnsettet utf8: %s\n", mysqli_error($conn));
		printf('<BR>');
		} else { //Her sier jeg at hvis tegnsetting er satt til UTF-8, skal den ikke gjøre noe. 
		
	}
	
	if(!empty($_POST)) //Hvis den informasjonen brukeren tastet inn i feltene fra login.php IKKE er tomme (fortsetter nedover)
	{
				
		$name = trim($_POST['name']); //Skal den trimme og legge $_POST brukernavn inn i variabelen $brukernavn slik at den informasjonen brukeren skrev inn enkelt kan hentes ut. 
		$description = trim($_POST['description']);	//Skal den trimme og legge $_POST passord inn i variabelen $passord slik at den informasjonen brukeren skrev inn enkelt kan hentes ut.
		$deadline = trim($_POST['deadline']); 
	}

$sql = "INSERT INTO assignments (name, subject, description, deadline) VALUES ('$name', '$subject_code', '$description', '$deadline')";

if ($conn->query($sql) === TRUE) {
    echo "New assignment added successfully";
    ?>
    <!DOCTYPE html>
	<html>
    <center>
    <input type="button" onclick="location.href='http://folk.ntnu.no/marentno/addAssignment.php';" value="Add Another Assignment" />
    <input type="button" onclick="location.href='http://folk.ntnu.no/marentno/homepage.php';" value="Return to homepage" />
    </center>
    </html>
    <?php
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();



?>
