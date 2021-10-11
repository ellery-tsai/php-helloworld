<?php
$file = $_GET["file"];
$output = shell_exec("oscap xccdf generate report /var/www/html/$file");
echo "$output";
?>
