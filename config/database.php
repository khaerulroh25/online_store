<?php

$conn = new mysqli("localhost", "root", "", "online_store");

if ($conn->connect_error) {
    die("Connection failed".$conn->connect_error);
}
