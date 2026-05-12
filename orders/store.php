<?php

header("Content-Type: application/json");

require_once "../config/database.php";

$data = json_decode(file_get_contents("php://input"), true);

$productId = $data['product_id'] ?? 0;
$qty       = $data['qty'] ?? 0;

// validation input order
if ($productId <= 0 || $qty <= 0) {
    http_response_code(400);
    echo json_encode([
        "message" => "Invalid input"
    ]);
    exit;
}

try {

    // begin transaction
    $conn->begin_transaction();

    // lock row product
    $stmt = $conn->prepare("SELECT * FROM products WHERE id = ? FOR UPDATE");
    $stmt->bind_param("i", $productId);
    $stmt->execute();
    $result = $stmt->get_result();
    $product = $result->fetch_assoc();

    // validation product not found
    if (!$product) {
        $conn->rollback();
        http_response_code(404);
        echo json_encode([
            "message" => "Product not found"
        ]);
        exit;
    }

    // check stock
    if ($product['stock'] < $qty) {
        $conn->rollback();
        http_response_code(400);
        echo json_encode([
            "message" => "Stock not enough"
        ]);
        exit;
    }

    // calculate total price
    $price = $product['price'];
    $subtotal = $price * $qty;
    $newStock = $product['stock'] - $qty;

    // prepare query update stock
    $updateStmt = $conn->prepare("UPDATE products SET stock = ? WHERE id = ?");
    $updateStmt->bind_param("ii", $newStock, $productId);
    $updateStmt->execute();

    // prepare insert order
    $orderStmt = $conn->prepare("INSERT INTO orders (total_price) VALUES (?)");
    $orderStmt->bind_param("d", $subtotal);
    $orderStmt->execute();

    $orderId = $conn->insert_id;

    // prepare insert order item
    $itemStmt = $conn->prepare("INSERT INTO order_items (order_id, product_id, qty, price, subtotal) VALUES (?, ?, ?, ?, ?)");
    $itemStmt->bind_param("iiidd", $orderId, $productId, $qty, $price, $subtotal);
    $itemStmt->execute();

    // save permanent transaction
    $conn->commit();

    // if order success
    http_response_code(201);
    echo json_encode([
        "message" => "Order created successfully",
        "order_id" => $orderId
    ]);
} catch (Exception $e) {

    // rollbackk if transactions error
    $conn->rollback();

    // if order failed
    http_response_code(500);
    echo json_encode([
        "message" => "Internal server error",
        "error" => $e->getMessage()
    ]);
}
