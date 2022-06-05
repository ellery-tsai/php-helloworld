<?php

$app = getenv("APP");
echo "<!-- $app -->";
if (!$app) {
  // APP is not specified.
  $app = "NoAPP";
}
$version = getenv("VERSION");
echo "<!-- $version -->";
if (!$version) {
  // VERSION is not specified.
  $version = "0.0.0";
}

$html = <<<EOD
<h1>$app</h1>
<p>
  <ul>
    <li>Name: $app</li>
    <li>Version: $version</li>
  </ul>
</p>
EOD;

echo $html;
