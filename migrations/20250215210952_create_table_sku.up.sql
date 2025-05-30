
CREATE TABLE `sku` (
  `id` varchar(50) NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `uom` varchar(20) NOT NULL,
  `price` int NOT NULL,
  `variant` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT IGNORE INTO ecommerce.sku
(id, product_id, uom, price, variant, image, created_by, created_at, updated_by, updated_at, deleted_at)
VALUES('01950a76-db65-7b22-9258-1d08b582bbef', '01950a76-db4d-7665-9a97-f84b62e96212', 'renceng', 10000, 'wangi jeruk nipis', '', 'a5d44fd7-2f76-4abf-8880-818c63c4e94f', '2025-02-15 16:35:16', NULL, NULL, NULL);

INSERT IGNORE INTO ecommerce.sku
(id, product_id, uom, price, variant, image, created_by, created_at, updated_by, updated_at, deleted_at)
VALUES('502a7a6a-ef9a-46ce-b9ff-cb33b21fdbec', '7b8759d5-ebc0-440b-b7af-1c367bd12b60', 'Renceng', 12000, 'Gula Aren', NULL, 'a5d44fd7-2f76-4abf-8880-818c63c4e94f', '2025-02-13 03:39:13', NULL, '2025-02-15 16:31:56', NULL);

INSERT IGNORE INTO ecommerce.sku
(id, product_id, uom, price, variant, image, created_by, created_at, updated_by, updated_at, deleted_at)
VALUES('b32b86b0-aa0a-4bea-806c-61f0250a8c28', '7b8759d5-ebc0-440b-b7af-1c367bd12b60', 'Pack', 20000, 'Cappucino', NULL, 'a5d44fd7-2f76-4abf-8880-818c63c4e94f', '2025-02-13 04:02:20', NULL, '2025-02-15 16:31:56', NULL);
