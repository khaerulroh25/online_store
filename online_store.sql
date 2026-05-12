-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2026 at 08:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `online_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `status` enum('SUCCESS','FAILED') DEFAULT 'SUCCESS',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `total_price`, `status`, `created_at`) VALUES
(1, 15000000.00, 'SUCCESS', '2026-05-12 06:11:53'),
(2, 15000000.00, 'SUCCESS', '2026-05-12 06:13:05'),
(3, 15000000.00, 'SUCCESS', '2026-05-12 06:13:09'),
(4, 15000000.00, 'SUCCESS', '2026-05-12 06:13:12'),
(5, 15000000.00, 'SUCCESS', '2026-05-12 06:13:14'),
(6, 40000000.00, 'SUCCESS', '2026-05-12 06:22:39'),
(7, 15000000.00, 'SUCCESS', '2026-05-12 06:39:01'),
(8, 15000000.00, 'SUCCESS', '2026-05-12 06:39:01'),
(9, 15000000.00, 'SUCCESS', '2026-05-12 06:39:01'),
(10, 15000000.00, 'SUCCESS', '2026-05-12 06:39:01'),
(11, 15000000.00, 'SUCCESS', '2026-05-12 06:39:01');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `qty`, `price`, `subtotal`, `created_at`) VALUES
(1, 1, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:11:53'),
(2, 2, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:13:05'),
(3, 3, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:13:09'),
(4, 4, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:13:12'),
(5, 5, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:13:14'),
(6, 6, 2, 2, 20000000.00, 40000000.00, '2026-05-12 06:22:39'),
(7, 7, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:39:01'),
(8, 8, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:39:01'),
(9, 9, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:39:01'),
(10, 10, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:39:01'),
(11, 11, 1, 1, 15000000.00, 15000000.00, '2026-05-12 06:39:01');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `stock`, `created_at`, `updated_at`) VALUES
(1, 'Iphone 15', 15000000.00, 5, '2026-05-12 05:36:27', '2026-05-12 06:41:11'),
(2, 'Gaming Laptop', 20000000.00, 1, '2026-05-12 05:36:27', '2026-05-12 06:22:39'),
(3, 'Mechanical Keyboard', 850000.00, 10, '2026-05-12 05:36:27', '2026-05-12 05:36:27'),
(4, 'Flash Sale Iphone', 10000000.00, 5, '2026-05-12 05:48:38', '2026-05-12 05:48:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_items_order` (`order_id`),
  ADD KEY `fk_order_items_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
