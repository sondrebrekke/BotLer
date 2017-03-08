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
				
		$username = trim($_POST['username']); //Skal den trimme og legge $_POST brukernavn inn i variabelen $brukernavn slik at den informasjonen brukeren skrev inn enkelt kan hentes ut. 
		$password = trim($_POST['password']);	//Skal den trimme og legge $_POST passord inn i variabelen $passord slik at den informasjonen brukeren skrev inn enkelt kan hentes ut. 
		session_start();
		$_SESSION['username'] = $username;
		$_SESSION['password'] = $password;

		if($results = $conn->query("SELECT * FROM lecturer WHERE username= '$username' AND password= '$password'")) //Hvis resultatene stemmer med en bruker fra databasen min og tabellen prosjekt_info, skal den hente ut alle feltene. 
		{
			if($results->num_rows) { //hvis det er noen rader som stemmer
				while($row = $results->fetch_array()) { //Gjør klar og henter ut informasjonen
					$records[] = $row; //Legger informasjonen inn i variabelen $records
				}

				$results->free();
			}
			else{ //Hvis det ikke er noen rader som stemmer overens med det brukeren tastet inn, skal den:
				header("Location: feillogin.php"); //redirecte brukeren til siden som er skrevet inn. 
			}
		}
		
	}

	
	$conn->close();



?>
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
			$query = "SELECT id,name,subject_code, subject_name FROM lecturer,subjects WHERE lecturer.id = subjects.lecturer AND  username= '$username' AND password= '$password'"  ;
			if ($res = mysqli_query($conn, $query)){
				while ($row = $res -> fetch_array()) {
					$id = $row[0];
					$name = $row[1];
					$subject_code = $row[2];
					$subject_name = $row[3];

				}
			}	
			?>

<!DOCTYPE html>
<html>
<header>
<h1>
<a href = "http://folk.ntnu.no/marentno/login.php">
		<center><img src ="Logo.png" width="30%" height="22%"></center>
		</h1>
	</a>
</header>
<center><h2><?php echo "Velkommen, $name!";?></h2>

<h4><?php echo "Du er faglærer i $subject_code - $subject_name";?></h4></center>

<center><form name = "Oppdater" action= "endrePassord.php" method="post"> 
<input type="text" style="text-align:center" name="username" readonly="readonly" value=<?php echo $username; ?>>
<br> 

<input type="password" style="text-align:center" name="password" value=<?php echo $password; ?>> <!-- Her lager jeg et tekstfelt hvor all skrift som ligger inni felten skal sentreres og feltet heter "brukernavn". Feltet skal også hente ut brukernavnet til brukeren hvor brukernavnet og passordet stemmer -->
<br>
<td colspan="2" style="text-align:center;"><input type="submit" value="Change Password"></td>
<br>
<br>
</form>
<input type="button" onclick="location.href='http://folk.ntnu.no/marentno/addAssignment.php';" value="Add Assignment" />
<input type="button" onclick="location.href='http://folk.ntnu.no/marentno/';" value="Logg ut" />
</center>
<center>
	<br>
	COPYRIGHT &#169; 2017 
	</center>
</html>



