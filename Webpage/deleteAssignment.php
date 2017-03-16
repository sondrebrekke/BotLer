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
    echo '<pre>'; print_r($b); echo '</pre>';
}

elseif ($conn->query($sql) === TRUE) {
    echo "The entry has been deleted";
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

else {
    echo "Error updating record: " . $conn->error;
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

$conn->close();
?>