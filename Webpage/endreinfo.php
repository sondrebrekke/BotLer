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
<!DOCTYPE html>
<html>

<h1>Du er logget inn.</h1>


<center><form name = "Oppdater" action= "endrePassord.php" method="post"> <input type="text" style="text-align:center" name="username" readonly="readonly" value=<?php echo $username; ?>>
<br> 

<input type="password" style="text-align:center" name="password" value=<?php echo $password; ?>> <!-- Her lager jeg et tekstfelt hvor all skrift som ligger inni felten skal sentreres og feltet heter "brukernavn". Feltet skal også hente ut brukernavnet til brukeren hvor brukernavnet og passordet stemmer -->
<br>
<td colspan="2" style="text-align:center;"><input type="submit" value="Endre Passord"></td>

</form>
</center>
</html>

