-- Database schema for Warehouse Management System
CREATE DATABASE IF NOT EXISTS warehouse_db;
USE warehouse_db;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    phone VARCHAR(20),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    user_type ENUM('ADMINISTRATOR', 'MANAGER', 'STAFF') NOT NULL DEFAULT 'STAFF',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- User sessions/logs table
CREATE TABLE IF NOT EXISTS user_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    username VARCHAR(50) NOT NULL,
    login_time DATETIME NOT NULL,
    logout_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Suppliers table
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supp_code VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    phone VARCHAR(20),
    debit_amount DECIMAL(10,2) DEFAULT 0.00,
    credit_amount DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_code VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    phone VARCHAR(20),
    debit_amount DECIMAL(10,2) DEFAULT 0.00,
    credit_amount DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    prod_code VARCHAR(20) UNIQUE NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    cost_price DECIMAL(10,2) NOT NULL,
    sell_price DECIMAL(10,2) NOT NULL,
    quantity INT DEFAULT 0,
    min_stock_level INT DEFAULT 10,
    supplier_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL
);

-- Purchases table
CREATE TABLE IF NOT EXISTS purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    supplier_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    purchase_date DATE NOT NULL,
    received_by INT NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE CASCADE,
    FOREIGN KEY (received_by) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Sales table
CREATE TABLE IF NOT EXISTS sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_revenue DECIMAL(10,2) NOT NULL,
    sale_date DATE NOT NULL,
    sold_by INT NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (sold_by) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Stock movements/transactions
CREATE TABLE IF NOT EXISTS stock_movements (
    movement_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    transaction_type ENUM('PURCHASE', 'SALE', 'ADJUSTMENT', 'RETURN') NOT NULL,
    quantity_change INT NOT NULL,
    reference_id INT, -- links to purchase_id or sale_id
    notes TEXT,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Create initial admin user
INSERT INTO users (full_name, username, password, user_type) 
VALUES ('System Administrator', 'admin', SHA1('admin123'), 'ADMINISTRATOR')
ON DUPLICATE KEY UPDATE full_name = 'System Administrator';

-- Create indexes for better performance
CREATE INDEX idx_products_code ON products(prod_code);
CREATE INDEX idx_products_name ON products(product_name);
CREATE INDEX idx_suppliers_code ON suppliers(supp_code);
CREATE INDEX idx_customers_code ON customers(cust_code);
CREATE INDEX idx_purchases_date ON purchases(purchase_date);
CREATE INDEX idx_sales_date ON sales(sale_date);
