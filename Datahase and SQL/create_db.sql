create database kulina_db;

--- table ku_user_status ---
create table ku_user_status (
	id SERIAL primary key,
	name VARCHAR(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp
);

--- table ku_user_location_type
create table ku_user_location_type (
	id SERIAL primary key,
	name VARCHAR(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp
);

--- table ku_user_location_status 
create table ku_user_location_status(
	id SERIAL primary key,
	name VARCHAR(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp
);

--- table ku_user
create table ku_user (
	id SERIAL primary key,
	name VARCHAR(255) not null,
	email VARCHAR(255) unique not null,
	phone VARCHAR(50) unique not null,
	password_hash VARCHAR(255) not null,
	salt VARCHAR(255),
	photo VARCHAR(255),
	status INTEGER,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp,
	foreign key (status) references ku_user_status(id) on delete set null
);

--- table ku_order_status
create table ku_order_status ( 
	id SERIAL primary key,
	name VARCHAR(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp
);

--- table ku_product_status
create table ku_product_status ( 
	id SERIAL primary key,
	name VARCHAR(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp
);

--- table ku_user_location
create table ku_user_location (
	id SERIAL primary key,
	type INTEGER,
	status INTEGER,
	user_id INTEGER,
	location VARCHAR(255) not null,
	address VARCHAR(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp,
	foreign key (type) references ku_user_location_type(id) on delete set null,
	foreign key (status) references ku_user_location_status(id) on delete set null,
	foreign key (user_id) references ku_user(id) on delete cascade
);

--- table ku_order
create table ku_order (
	id SERIAL primary key,
	user_id INTEGER,
	status INTEGER,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp,
	foreign key (user_id) references ku_user(id) on delete set null,
	foreign key (status) references ku_order_status(id) on delete set null
);

--- table ku_product 
create table ku_product(
	id SERIAL primary key,
	name VARCHAR(255) not null,
	effective_date DATE,
	effective_until DATE,
	photo VARCHAR(255),
	price DECIMAL(15, 2),
	status INTEGER,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp,
	foreign key (status) references ku_product_status(id) on delete set null
);

--- table ku_category
create table ku_category (
	id SERIAL primary key,
	name VARCHAR(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp
);

--- table ku_order_detail_status
create table ku_order_detail_status (
	id SERIAL primary key,
	name VARCHAR(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp
);

--- table ku_product_category
create table ku_product_category(
	id SERIAL primary key,
	product_id INTEGER,
	category_id INTEGER,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp,
	foreign key (product_id) references ku_product(id) on delete cascade,
	foreign key (category_id) references ku_category(id) on delete cascade
);

--- table ku_order_detail
create table ku_order_detail(
	id SERIAL primary key,
	user_location_id INTEGER,
	order_id INTEGER,
	product_id INTEGER,
	quantity INTEGER not null,
	delivery_date DATE,
	status INTEGER,
	created_at timestamp default current_timestamp,
	updated_at timestamp default current_timestamp,
	foreign key (user_location_id) references ku_user_location(id),
	foreign key (order_id) references ku_order(id) on delete cascade,
	foreign key (product_id) references ku_product(id) on delete set null,
	foreign key (status) references ku_order_detail_status(id) on delete set null
);




