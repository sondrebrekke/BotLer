<?php

session_start();
	$username= $_SESSION['username'];
	$password = $_SESSION['password'];
	$b = $_SESSION['b'];

$conn = new mysqli('mysql.stud.ntnu.no', 'jorgfb_botler', 'park12', 'jorgfb_botler_database'); //Her kobler jeg meg til området mitt på nvselev.no. Jeg skriver inn server, brukernavn, passord og databsenavnet.
	if (!mysqli_set_charset($conn, "utf8")) { //Her sier jeg at hvis ikke tegnsettingen er satt til UTF-8, skal den "skrive ut" på siden Feil ved lasting av tegnsettet utf8. Brukeren vil også få en feilmelding.
		printf("Feil ved lasting av tegnsettet utf8: %s\n", mysqli_error($conn));
		printf('<BR>');
		} else { //Her sier jeg at hvis tegnsetting er satt til UTF-8, skal den ikke gjøre noe. 
		
	}

$records = array(); //Lager en array som informasjonen skal legges inn i.
	if(!empty($_POST)) //Hvis den informasjonen brukeren tastet inn i feltene fra login.php IKKE er tomme (fortsetter nedover)
	{		
		$id = trim($_POST['id']); //Skal den trimme og legge $_POST brukernavn inn i variabelen $brukernavn slik at den informasjonen brukeren skrev inn enkelt kan hentes ut.  
	}

$sql = "DELETE FROM assignments WHERE id='$id'";

$query = "SELECT assignments.id, assignments.name, subject, description, deadline, subject_code, lecturer.id, lecturer, username, password FROM assignments, lecturer, subjects WHERE assignments.subject = subjects.subject_code AND subjects.lecturer = lecturer.id AND username= '$username' AND password= '$password' AND assignments.id = '$id'";	

if(!in_array($id, $b)){
	echo "The ID you put does not match one of your assignments" . $conn->error;
	    ?>
    <!DOCTYPE html>
	<html>
    <center>
    <input type="button" onclick="location.href='http://folk.ntnu.no/marentno/homepage.php';" value="Return to homepage" />
    <input type="button" onclick="location.href='http://folk.ntnu.no/marentno/viewAssignment.php';" value="View Assignments" />
    </center>
    </html>
    <?php
}	


elseif ($res = mysqli_query($conn, $query)){
	while ($row = $res -> fetch_array()) {
		$id = $row[0];
		$name = $row[1];
		$subject = $row[2];
		$description = $row[3];
		$deadline = $row[4];
	}
	?>
	
	<!DOCTYPE html>	
	<html>
		<body>
			<h1>
			<center><img src ="Logo.png" width="30%" height="26%"></center>
			</h1>
			<form action="editedAssignments.php" method="post">
				<center>
					<input type="text" name ="id" placeholder="ID" style="text-align:center" readonly="readonly" value=<?php echo $id; ?>>
					<br>
					<br>
					<input type="text" name ="name" placeholder="Name" style="text-align:center" value=<?php echo $name; ?>>
					<br>
					<br>
					<input type="text" name ="description" placeholder="Description" style="text-align:center" value=<?php echo $description; ?>>
					<br>
					<br>
					<input type="text" name ="deadline" placeholder="Deadline" style="text-align:center" value=<?php echo $deadline; ?>>
					<br>
					<br>
					<br>
					<td colspan="2" style="text-align:center;"><input type="submit" value="Edit assignment"></td>
				</center>
			</form>
			<center>
			<br>
				<br>
				COPYRIGHT &#169; 2017 
			</center>
		</body>

    <center>
    <input type="button" onclick="location.href='http://folk.ntnu.no/marentno/homepage.php';" value="Return to homepage" />
    <input type="button" onclick="location.href='http://folk.ntnu.no/marentno/viewAssignment.php';" value="View Assignments" />
    </center>
    </html>
    
    <?php
} else {
    echo "Error updating record: " . $conn->error;
}

$conn->close();
?>