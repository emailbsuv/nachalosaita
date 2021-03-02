<?php
require_once('db.php');

mysqli_query($link, "UPDATE operators SET day1 = day2,day2 = day3,day3 = day4,day4 = day5,day5 = day6,day6 = day7,day7 = 0");
mysqli_close($link );

?>