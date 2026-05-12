<?php

header("Content-Type: application/json");

require_once "../config/database.php";

// get datta JSON from request body
$data = json_decode(file_get_contents("php://input"), true);

// get input from request
$name  = trim($data['name'] ?? '');
$price = $data['price'] ?? 0;
$stock = $data['stock'] ?? 0;

// validation input product
if (empty($name) || $price <= 0 || $stock < 0) {

    // response if input invalid
    http_response_code(400);
    echo json_encode([
        "message" => "Invalid input"
    ]);
    exit;
}

// prepare query insert product
$stmt = $conn->prepare("INSERT INTO products (name, price, stock) VALUES (?, ?, ?)");
$stmt->bind_param("sdi", $name, $price, $stock);
if ($stmt->execute()) {

    // response success
    http_response_code(201);
    echo json_encode([
        "message" => "Product created successfully",
        "product_id" => $conn->insert_id
    ]);
} else {

    // response failed
    http_response_code(500);
    echo json_encode([
        "message" => "Failed to create product"
    ]);
}
