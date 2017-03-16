<?php
$conn = new mysqli('mysql.stud.ntnu.no', 'jorgfb_botler', 'park12', 'jorgfb_botler_database'); //Her kobler jeg meg til området mitt på nvselev.no. Jeg skriver inn server, brukernavn, passord og databsenavnet.
	if (!mysqli_set_charset($conn, "utf8")) { //Her sier jeg at hvis ikke tegnsettingen er satt til UTF-8, skal den "skrive ut" på siden Feil ved lasting av tegnsettet utf8. Brukeren vil også få en feilmelding.
		printf("Feil ved lasting av tegnsettet utf8: %s\n", mysqli_error($conn));
		printf('<BR>');
		} else { //Her sier jeg at hvis tegnsetting er satt til UTF-8, skal den ikke gjøre noe. 
		
	}

$records = array(); //Lager en array som informasjonen skal legges inn i.
	if(!empty($_POST)) //Hvis den informasjonen brukeren tastet inn i feltene fra login.php IKKE er tomme (fortsetter nedover)
	{
		$id = trim($_POST['id']);				
		$name = trim($_POST['name']); //Skal den trimme og legge $_POST brukernavn inn i variabelen $brukernavn slik at den informasjonen brukeren skrev inn enkelt kan hentes ut. 
		$description = trim($_POST['description']);	//Skal den trimme og legge $_POST passord inn i variabelen $passord slik at den informasjonen brukeren skrev inn enkelt kan hentes ut. 
		$deadline = trim($_POST['deadline']);

	}

$sql = "UPDATE assignments SET name='$name', description='$description', deadline='$deadline' WHERE id='$id'";

if ($conn->query($sql) === TRUE) {
    echo "The assignment has been updated";
    ?>
    <!DOCTYPE html>
	<html>
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