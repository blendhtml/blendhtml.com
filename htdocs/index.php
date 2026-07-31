<?php

require dirname(__DIR__) . '/vendor/autoload.php';

use BlendHtml\Core\Application;

echo new Application()->render($_SERVER['REQUEST_URI']);
