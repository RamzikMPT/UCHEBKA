CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Добавление ролей
INSERT INTO roles (role_name)
VALUES ('Админ'), ('Пользователь'), ('Продавец');

CREATE TABLE us (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role_id INT REFERENCES roles(role_id)
);

-- Примеры добавления пользователей
INSERT INTO us (username, email, password, role_id)
VALUES 
    ('admin', 'admin@example.com', 'password', 1),
    ('user1', 'user1@example.com', 'password', 2),
    ('seller1', 'seller1@example.com', 'password', 3);


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    description TEXT,
    image_url VARCHAR(255) -- URL изображения продукта
);

-- Примеры добавления продуктов
INSERT INTO products (product_name, price, stock, description, image_url)
VALUES 
    ('Продукт 1', 500.00, 10, 'Описание продукта 1', 'http://example.com/image1.jpg'),
    ('Продукт 2', 750.00, 20, 'Описание продукта 2', 'http://example.com/image2.jpg');



CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES us(user_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL
);

-- Примеры добавления заказов
INSERT INTO orders (user_id, status)
VALUES 
    (2, 'Ожидает доставки'),
    (2, 'Доставлено');


CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL
);

-- Примеры добавления позиций заказа
INSERT INTO order_items (order_id, product_id, quantity, total_price)
VALUES 
    (1, 1, 2, 1000.00),
    (1, 2, 1, 750.00);

CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    shipment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL
);

-- Примеры добавления отгрузок
INSERT INTO shipments (order_id, status)
VALUES 
    (1, 'Отправлено'),
    (2, 'Ожидает отправки');


CREATE TABLE cart (
    cart_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES us(user_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL
);

-- Примеры добавления товаров в корзину
INSERT INTO cart (user_id, product_id, quantity)
VALUES 
    (2, 1, 1),
    (2, 2, 3);
CREATE TABLE couriers (
    courier_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

-- Примеры добавления курьеров
INSERT INTO couriers (name, phone)
VALUES 
    ('Курьер 1', '+1234567890'),
    ('Курьер 2', '+0987654321');
