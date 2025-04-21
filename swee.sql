-- CREATE DATABASE
CREATE DATABASE e_commerce;
USE e_commerce;

-- PRODUCT IMAGE TABLE
CREATE TABLE product_image (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  url TEXT NOT NULL UNIQUE
);

INSERT INTO product_image (url) VALUES
  ('https://example.com/images/1.jpg'),
  ('https://example.com/images/2.jpg'),
  ('https://example.com/images/3.jpg'),
  ('https://example.com/images/4.jpg'),
  ('https://example.com/images/5.jpg');

-- COLOR TABLE
CREATE TABLE color (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
);

INSERT INTO color (name) VALUES
  ('Red'),
  ('Blue'),
  ('Green'),
  ('Black'),
  ('White');

-- PRODUCT CATEGORY TABLE
CREATE TABLE category (
  id SMALLINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
);

INSERT INTO category (name) VALUES
  ('Clothing'),
  ('Electronics'),
  ('Footwear'),
  ('Accessories'),
  ('Home Decor');

-- PRODUCT TABLE
CREATE TABLE product (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  categoryId SMALLINT,
  name TEXT NOT NULL,
  basePrice DECIMAL(10,2),
  FOREIGN KEY (categoryId) REFERENCES category (id)
    ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO product (categoryId, name, basePrice) VALUES
  (1, 'T-Shirt Classic', 19.99),
  (2, 'Bluetooth Speaker', 49.99),
  (3, 'Running Shoes', 89.95),
  (4, 'Leather Wallet', 29.99),
  (5, 'Wall Clock', 34.50);

-- PRODUCT ITEM TABLE
CREATE TABLE item (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  productId BIGINT,
  colorId BIGINT,
  imageId BIGINT,
  FOREIGN KEY (productId) REFERENCES product (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (colorId) REFERENCES color (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (imageId) REFERENCES product_image (id)
    ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO item (productId, colorId, imageId) VALUES
  (1, 1, 1),
  (2, 2, 2),
  (3, 3, 3),
  (4, 4, 4),
  (5, 5, 5);

-- BRAND TABLE
CREATE TABLE brand (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  productId BIGINT,
  origin_country VARCHAR(100),
  FOREIGN KEY (productId) REFERENCES product (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO brand (productId, origin_country) VALUES
  (1, 'USA'),
  (2, 'China'),
  (3, 'Germany'),
  (4, 'India'),
  (5, 'Italy');

-- PRODUCT VARIATIONS TABLE
CREATE TABLE variation (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  productId BIGINT,
  colorId BIGINT,
  stockQty SMALLINT,
  FOREIGN KEY (productId) REFERENCES product (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (colorId) REFERENCES color (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO variation (productId, colorId, stockQty) VALUES
  (1, 1, 50),
  (2, 2, 30),
  (3, 3, 60),
  (4, 4, 40),
  (5, 5, 25);

-- SIZE CATEGORY TABLE
CREATE TABLE size_group (
  id INT PRIMARY KEY AUTO_INCREMENT,
  categoryId SMALLINT,
  productId BIGINT,
  clothingType VARCHAR(50),
  shoeType VARCHAR(50),
  electronType VARCHAR(50),
  FOREIGN KEY (categoryId) REFERENCES category (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (productId) REFERENCES product (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO size_group (categoryId, productId, clothingType, shoeType, electronType) VALUES
  (1, 1, 'Men Shirt', NULL, NULL),
  (2, 2, NULL, NULL, 'Speaker'),
  (3, 3, NULL, 'Running', NULL),
  (4, 4, NULL, NULL, NULL),
  (5, 5, NULL, NULL, NULL);

-- SIZE OPTION TABLE
CREATE TABLE size_option (
  id INT PRIMARY KEY AUTO_INCREMENT,
  groupId INT,
  label VARCHAR(50) NOT NULL,
  FOREIGN KEY (groupId) REFERENCES size_group (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO size_option (groupId, label) VALUES
  (1, 'S'),
  (1, 'M'),
  (1, 'L'),
  (3, '42'),
  (3, '44');

-- ATTRIBUTE TABLE
CREATE TABLE attribute (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  productId BIGINT,
  colorId BIGINT,
  sizeOptionId INT,
  material VARCHAR(100),
  weight DECIMAL(10,3),
  FOREIGN KEY (productId) REFERENCES product (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (colorId) REFERENCES color (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (sizeOptionId) REFERENCES size_option (id)
    ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO attribute (productId, colorId, sizeOptionId, material, weight) VALUES
  (1, 1, 1, 'Cotton', 0.250),
  (2, 2, NULL, 'Plastic', 0.900),
  (3, 3, 4, 'Leather', 0.750),
  (4, 4, NULL, 'Genuine Leather', 0.400),
  (5, 5, NULL, 'Wood', 1.200);

-- ATTRIBUTE CATEGORY TABLE
CREATE TABLE attribute_group (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  attributeId BIGINT,
  variationId BIGINT,
  specs TEXT,
  FOREIGN KEY (attributeId) REFERENCES attribute (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (variationId) REFERENCES variation (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO attribute_group (attributeId, variationId, specs) VALUES
  (1, 1, 'Soft and breathable'),
  (2, 2, 'Waterproof and compact'),
  (3, 3, 'Comfort soles'),
  (4, 4, 'RFID protected'),
  (5, 5, 'Silent ticking');

-- ATTRIBUTE TYPE TABLE
CREATE TABLE attribute_type (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  attributeId BIGINT,
  groupId BIGINT,
  typeName VARCHAR(100),
  FOREIGN KEY (attributeId) REFERENCES attribute (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (groupId) REFERENCES attribute_group (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO attribute_type (attributeId, groupId, typeName) VALUES
  (1, 1, 'text'),
  (2, 2, 'text'),
  (3, 3, 'number'),
  (4, 4, 'boolean'),
  (5, 5, 'text');
