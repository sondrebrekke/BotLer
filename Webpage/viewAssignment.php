
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<title>
			BotLer
		</title>
	</head>
	<body>
		<h1>
		<center><img src ="Logo.png" width="30%" height="26%"></center>
		</h1>


	</body>
</html>


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

	$query = "SELECT assignments.id, assignments.name, subject, description, deadline, subject_code, lecturer.id, lecturer, username, password FROM assignments, lecturer, subjects WHERE assignments.subject = subjects.subject_code AND subjects.lecturer = lecturer.id AND username= '$username' AND password= '$password'" ;
?>

<html>
	<head>
	<title>BotLer - Database</title>
	</head>
	<body>
	<h2 align="center">Lecturers</h2>
		<table align="center" border="1" cellspacing="0" width="700">
			<thread>
			<th>ID</th>
			<th>Assignment name</th>
			<th>Subject</th>
			<th>Description</th>
			<th>Deadline</th>
			</thread>
			
	<?php

	$b = array();

			
			if ($res = mysqli_query($conn, $query)){
				while ($row = $res -> fetch_array()) {
					$id = $row[0];
					array_push($b, $id);
					$name = $row[1];
					$subject = $row[2];
					$description = $row[3];
					$deadline = $row[4];

					echo "<tr>
							<td>$id</td>
							<td>$name</td>
							<td>$subject</td>
							<td>$description</td>
							<td>$deadline</td>
					</tr>";
				}	

			}
			session_start();
			$_SESSION['b'] = $b;
		
			?>

		</table>
	
	</body>

		<center>
		<br>
		<br>
		<center><form name = "Endre" action= "editAssignment.php" method="post"> 
		<input type="text" style="text-align:center" name="id" value="ID">
		<td colspan="2" style="text-align:center;"><input type="submit" value="Edit Assignment"></td>
		</form>
		<br>
		<center><form name = "Delete" action= "deleteAssignment.php" method="post"> 
		<input type="text" style="text-align:center" name="id" value="ID">
		<td colspan="2" style="text-align:center;"><input type="submit" value="Delete Assignment"></td>
		</form>
		<br> 
		<br>
		<input type="button" onclick="location.href='http://folk.ntnu.no/marentno/';" value="Log Out" />
		<input type="button" onclick="location.href='http://folk.ntnu.no/marentno/homepage.php';" value="Return to homepage" />
		<br>
			<br>
			COPYRIGHT &#169; 2017 
		</center>
	</body>
</html>