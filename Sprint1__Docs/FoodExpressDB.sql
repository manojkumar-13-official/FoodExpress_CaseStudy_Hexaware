create database foodexpress_casestudy_db;
use foodexpress_casestudy_db;

create table customer(
    customerid int primary key auto_increment,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    phone varchar(20) unique,
    address varchar(200)
);

create table restaurant(
    restaurantid int primary key auto_increment,
    name varchar(100) not null,
    cuisine varchar(50) not null,
    city varchar(50) not null,
    capacityperhour int,
    constraint chk_restaurant_capacity check(capacityperhour > 0)
);

create table menuitem(
    itemid int primary key auto_increment,
    restaurantid int,
    itemname varchar(100) not null,
    price decimal(10,2),
    constraint chk_menuitem_price check(price >= 0),
    constraint fk_menuitem_restaurant foreign key(restaurantid) references restaurant(restaurantid)
);

create table rider(
    riderid int primary key auto_increment,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    vehicletype varchar(20),
    status varchar(20) default 'offline',
    constraint chk_rider_status check(status in ('online', 'offline', 'busy'))
);

create table `order`(
    orderid int primary key auto_increment,
    customerid int,
    restaurantid int,
    riderid int,
    orderdate timestamp default current_timestamp,
    status varchar(20) default 'placed',
    totalamount decimal(10,2),
    constraint chk_order_status check(status in ('placed', 'confirmed', 'preparing', 'out_for_delivery', 'delivered', 'cancelled')),
    constraint chk_order_amount check(totalamount >= 0),
    constraint fk_order_customer foreign key(customerid) references customer(customerid),
    constraint fk_order_restaurant foreign key(restaurantid) references restaurant(restaurantid),
    constraint fk_order_rider foreign key(riderid) references rider(riderid)
);

create table orderitem(
    orderitemid int primary key auto_increment,
    orderid int,
    itemid int,
    quantity int,
    constraint chk_orderitem_quantity check(quantity > 0),
    constraint fk_orderitem_order foreign key(orderid) references `order`(orderid),
    constraint fk_orderitem_menuitem foreign key(itemid) references menuitem(itemid)
);


-- 1. customer table

insert into customer (customerid, firstname, lastname, phone, address) values
(1, 'arun', 'kumar', '9876543210', 'chennai'),
(2, 'priya', 'sharma', '9876543211', 'coimbatore'),
(3, 'rahul', 'raj', '9876543212', 'madurai'),
(4, 'divya', 'lakshmi', '9876543213', 'trichy'),
(5, 'karthik', 'vel', '9876543214', 'salem'),
(6, 'sneha', 'devi', '9876543215', 'erode'),
(7, 'vijay', 'kumar', '9876543216', 'tirunelveli'),
(8, 'meena', 'rani', '9876543217', 'vellore'),
(9, 'sanjay', 'kumar', '9876543218', 'thanjavur'),
(10, 'anitha', 'bala', '9876543219', 'nagercoil');


-- 2. restaurant table

insert into restaurant (restaurantid, name, cuisine, city, capacityperhour) values
(1, 'spice garden', 'south indian', 'chennai', 50),
(2, 'tandoori house', 'north indian', 'coimbatore', 40),
(3, 'pizza corner', 'italian', 'madurai', 35),
(4, 'dragon wok', 'chinese', 'trichy', 45),
(5, 'chettinad kitchen', 'chettinad', 'salem', 30),
(6, 'burger hub', 'fast food', 'erode', 60),
(7, 'royal biryani', 'biryani', 'tirunelveli', 50),
(8, 'green leaf', 'vegetarian', 'vellore', 40),
(9, 'coastal treats', 'seafood', 'thanjavur', 25),
(10, 'cafe delight', 'continental', 'nagercoil', 35);


-- 3. menuitem table

insert into menuitem (itemid, restaurantid, itemname, price) values
(1, 1, 'masala dosa', 80.00),
(2, 2, 'paneer butter masala', 220.00),
(3, 3, 'margherita pizza', 250.00),
(4, 4, 'veg fried rice', 150.00),
(5, 5, 'chettinad chicken curry', 280.00),
(6, 6, 'classic burger', 120.00),
(7, 7, 'chicken biryani', 200.00),
(8, 8, 'paneer fried rice', 160.00),
(9, 9, 'fish curry', 240.00),
(10, 10, 'white sauce pasta', 190.00);


-- 4. rider table

insert into rider (riderid, firstname, lastname, vehicletype, status) values
(1, 'ramesh', 'kumar', 'bike', 'online'),
(2, 'suresh', 'raj', 'scooter', 'online'),
(3, 'mohan', 'das', 'bike', 'offline'),
(4, 'ganesh', 'vel', 'cycle', 'online'),
(5, 'prakash', 'raj', 'bike', 'busy'),
(6, 'vignesh', 'kumar', 'scooter', 'online'),
(7, 'deepak', 'sharma', 'bike', 'busy'),
(8, 'ajay', 'kumar', 'cycle', 'offline'),
(9, 'bharath', 'raj', 'bike', 'online'),
(10, 'santhosh', 'vel', 'scooter', 'online');


-- 5. order table

insert into `order` (orderid, customerid, restaurantid, riderid, orderdate, status, totalamount) values
(1, 1, 1, 1, '2026-11-20 10:00:00', 'delivered', 160.00),
(2, 2, 2, 2, '2026-11-20 10:30:00', 'delivered', 440.00),
(3, 3, 3, 3, '2026-11-20 11:00:00', 'placed', 500.00),
(4, 4, 4, 4, '2026-11-20 11:30:00', 'delivered', 300.00),
(5, 5, 5, 5, '2026-11-20 12:00:00', 'preparing', 560.00),
(6, 6, 6, 6, '2026-11-20 12:30:00', 'delivered', 240.00),
(7, 7, 7, 7, '2026-11-20 13:00:00', 'out_for_delivery', 400.00),
(8, 8, 8, 8, '2026-11-20 13:30:00', 'cancelled', 320.00),
(9, 9, 9, 9, '2026-11-20 14:00:00', 'delivered', 480.00),
(10, 10, 10, 10, '2026-11-20 14:30:00', 'preparing', 380.00);

-- 6. orderitem table

insert into orderitem (orderitemid, orderid, itemid, quantity) values
(1, 1, 1, 2),
(2, 2, 2, 2),
(3, 3, 3, 2),
(4, 4, 4, 2),
(5, 5, 5, 2),
(6, 6, 6, 2),
(7, 7, 7, 2),
(8, 8, 8, 2),
(9, 9, 9, 2),
(10, 10, 10, 2);

select * from customer;
select * from `order`;
select * from restaurant;
select * from orderitem;
select * from rider;
select * from menuitem;

select 'customer' as table_name, count(*) as total_records from customer;
select 'restaurant', count(*) from restaurant;
select 'menuitem', count(*) from menuitem;
select 'rider', count(*) from rider;
select 'order', count(*) from `order`;
select 'orderitem', count(*) from orderitem;


drop procedure if exists InsertSampleOrders;

delimiter //

create procedure InsertSampleOrders()
begin
    declare i int default 1;
    declare v_customer_id int;
    declare v_restaurant_id int;
    declare v_rider_id int;
    declare v_item_id int;
    declare v_order_id int;
    declare v_quantity int;
    declare v_item_price decimal(10,2);

    while i <= 200 do

        set v_customer_id = mod(i - 1, 10) + 1;
        set v_restaurant_id = mod(i - 1, 10) + 1;
        set v_rider_id = mod(i - 1, 10) + 1;
        set v_quantity = mod(i, 3) + 1;

        select itemid, price
        into v_item_id, v_item_price
        from menuitem
        where restaurantid = v_restaurant_id
        order by itemid
        limit 1;

        insert into `order`
        (customerid, restaurantid, riderid, orderdate, status, totalamount)
        values
        (
            v_customer_id,
            v_restaurant_id,
            v_rider_id,
            date_add('2026-11-20 10:00:00', interval i minute),
            case
                when mod(i, 6) = 0 then 'delivered'
                when mod(i, 6) = 1 then 'placed'
                when mod(i, 6) = 2 then 'confirmed'
                when mod(i, 6) = 3 then 'preparing'
                when mod(i, 6) = 4 then 'out_for_delivery'
                else 'cancelled'
            end,
            v_item_price * v_quantity
        );

        set v_order_id = last_insert_id();

        insert into orderitem
        (orderid, itemid, quantity)
        values
        (v_order_id, v_item_id, v_quantity);

        set i = i + 1;

    end while;
end //

delimiter ;

call InsertSampleOrders();
