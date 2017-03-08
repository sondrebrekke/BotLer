
<?php

	
	$conn = new mysqli('mysql.stud.ntnu.no', 'jorgfb_botler', 'park12');
		if ($conn->connect_error){
			die("feil: " . $conn->connect_error);
		} else {

		}

	$db = mysqli_select_db($conn, 'jorgfb_botler_database');

	$query = "SELECT * FROM lecturer";
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
			<th>Username</th>
			<th>Passord</th>
			</thread>
			
			<?php
			if ($res = mysqli_query($conn, $query)){
				while ($row = $res -> fetch_array()) {
					$id = $row[0];
					$username = $row[1];
					$password = $row[2];

					echo "<tr>
							<td>$id</td>
							<td>$username</td>
							<td>$password</td>
					</tr>";
				}
			}	
			?>

		</table>
	
	</body>

</html>