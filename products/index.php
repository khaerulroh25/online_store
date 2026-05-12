<?php

header("Content-Type: application/json");

require_once "../config/database.php";

// prepare query select all product
$stmt = $conn->prepare("SELECT * FROM products ORDER BY id DESC ");
$stmt->execute();
$result = $stmt->get_result();

// Initialize products array
$products = [];

// Store query results into array
while ($row = $result->fetch_assoc()) {
    $products[] = $row;
}
http_response_code(200);
echo json_encode([
    "data" => $products
]);
