<? php

DEFINE ('DB-USER', 'jorgfb_botler');
DEFINE('DB-PSWD', 'park12');
DEFINE('DB-HOST', 'mysql.stud.ntnu.no');
DEFINE('DB-NAME', 'jorgfb_botler_database');

$dbcon = mysqli_connect(DB_HOST, DB_USER, DB_PSWD, DB_NAME);

?>