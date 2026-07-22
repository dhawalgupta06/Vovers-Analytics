-- Consumers Table
create table customers (
    customer_id int auto_increment primary key not null,
    customer_name varchar(100) not null,
    gender enum('Male', 'Female', 'Others') not null,
    age tinyint check(age >= 18) not null,
    customer_type enum('Individual', 'Business', 'Government') not null,
    city varchar(50) not null,
    state varchar(50) not null,
    region enum('North', 'South', 'East', 'West', 'Central') not null,
    join_date date not null
);

--Suppliers Table
create table suppliers(
    supplier_id int auto_increment primary key,
    supplier_name varchar(100) not null,
    contact_person varchar(100) not null,
    phone_number varchar(15) unique not null,
    email varchar(100) unique not null,
    city varchar(50) not null,
    state varchar(50) not null
);

--Warehouses Table
create table warehouses(
    warehouse_id int auto_increment primary key,
    city varchar(50) not null,
    state varchar(50) not null,
    region enum("North", "South", "East", "West", "Central") not null,
    storage_capacity int check(storage_capacity > 0) not null
);

-- Products Table
create table products (
    product_id int auto_increment primary key,
    product_name varchar(150) not null,
    supplier_id int not null,
    brand varchar(50) not null,
    category enum(
        'Smartphones',
        'Laptops',
        'Tablets',
        'Televisions',
        'Audio Devices',
        'Smart Watches',
        'Home Appliances',
        'Kitchen Appliances',
        'Gaming',
        'Accessories'
    ) not null,
    cost_price decimal(10, 2) check(cost_price > 0) not null,
    selling_price decimal(10, 2) not null check(selling_price>0),
    foreign key (supplier_id) references suppliers(supplier_id)
);

--Stores Table
create table stores (
    store_id int auto_increment primary key,
    city varchar(50) not null,
    state varchar(50) not null,
    region enum("North", "South", "East", "West", "Central") not null,
    warehouse_id int not null,
    store_type enum("Mall", "Standalone", "Airport") not null,
    opening_date date not null,
    foreign key (warehouse_id) references warehouses(warehouse_id)
);

-- Employees Table
create table employees (
    employee_id int auto_increment primary key,
    employee_name varchar(100) not null,
    gender enum('Male', 'Female', 'Other') not null,
    age tinyint not null check(age >= 18),
    department enum(
        'Sales',
        'Warehouse',
        'Finance',
        'HR',
        'IT',
        'Operations',
        'Marketing'
    ) not null,
    designation enum(
        'Store Manager',
        'Sales Executive',
        'Cashier',
        'Warehouse Manager',
        'Warehouse Executive',
        'Finance Manager',
        'Finance Executive',
        'HR Manager',
        'HR Executive',
        'IT Manager',
        'IT Executive',
        'Operations Manager',
        'Operations Executive',
        'Marketing Manager',
        'Marketing Executive'
    ) not null,
    store_id int,
    warehouse_id int,
    join_date date not null,
    salary decimal(10, 2) not null check(salary > 0),
    foreign key (store_id) references stores(store_id),
    foreign key (warehouse_id) references warehouses(warehouse_id)
);

-- Orders Table
create table orders (
    order_id int auto_increment primary key,
    customer_id int not null,
    store_id int not null,
    order_datetime timestamp default current_timestamp not null,
    sales_channel enum(
        "Offline Store",
        "Website",
        "Mobile App",
        "Amazon",
        "Flipkart"
    ) not null,
    payment_method enum("Cash", "Card", "UPI", "Net Banking") not null,
    foreign key (customer_id) references customers(customer_id),
    foreign key (store_id) references stores(store_id)
);

-- Order Details Table
create table order_details(
    order_detail_id int auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null default 1 check (quantity >= 1),
    discount_percentage decimal(5, 2) default 0 check(
        discount_percentage >= 0
        and discount_percentage <= 50
    ),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

-- Inventory Table
create table inventory(
    inventory_id int auto_increment primary key,
    location_type enum("Store", "Warehouse") not null,
    store_id int,
    warehouse_id int,
    product_id int not null,
    quantity int not null default 0 check(quantity >= 0),
    foreign key (store_id) references stores(store_id),
    foreign key (product_id) references products(product_id),
    foreign key (warehouse_id) references warehouses(warehouse_id)
);

-- Returns Table
create table returns(
    return_id int auto_increment primary key,
    order_detail_id int not null,
    return_datetime timestamp default current_timestamp not null,
    returned_quantity int not null default 1 check(returned_quantity > 0),
    return_status enum(
        "Requested",
        "Approved",
        "Rejected",
        "Refunded",
        "Replaced"
    ) not null default "Requested",
    foreign key (order_detail_id) references order_details(order_detail_id)
);

-- Purchase Orders Table
create table purchase_orders (
    purchase_order_id int auto_increment primary key,
    supplier_id int not null,
    warehouse_id int not null,
    purchase_datetime timestamp default current_timestamp not null,
    foreign key (supplier_id) references suppliers(supplier_id),
    foreign key (warehouse_id) references warehouses(warehouse_id)
);

-- Purchase Order Details Table
create table purchase_order_details(
    purchase_order_detail_id int auto_increment primary key,
    purchase_order_id int not null,
    product_id int not null,
    quantity int not null default 1 check (quantity > 0),
    foreign key (purchase_order_id) references purchase_orders(purchase_order_id),
    foreign key (product_id) references products(product_id)
);