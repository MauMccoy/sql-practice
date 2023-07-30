CREATE TABLE restaurant (
    id integer PRIMARY KEY,
    name varchar(100),
    description text,
    rating INT,
    phone varchar(100),
    hours text
);
/*  */
SELECT
    constraint_name, column_name, table_name
FROM
    information_schema.key_column_usage
WHERE
    table_name = 'restaurant';
/*  */

CREATE TABLE address (
    address_id integer REFERENCES restaurant(id) UNIQUE,
    street_number varchar(10),
    street_name varchar(20),
    city varchar(20),
    state text,
    google_map_link varchar(50)
);

/*  */
SELECT
    constraint_name, column_name, table_name
FROM
    information_schema.key_column_usage
WHERE
    table_name = 'address';    
/*  */

CREATE TABLE category (
    id char(2) PRIMARY KEY,
    name varchar(20),
    description varchar(200)
);

/*  */
SELECT
    constraint_name, column_name, table_name
FROM
    information_schema.key_column_usage
WHERE
    table_name = 'category';    
/*  */

CREATE TABLE dish (
    id integer PRIMARY KEY,
    name varchar(50),
    price money,
    description varchar(200),
    hot_and_spicy boolean
);

/*  */
SELECT
    constraint_name, column_name, table_name
FROM
    information_schema.key_column_usage
WHERE
    table_name = 'dish';    
/*  */

CREATE TABLE review (
    id integer PRIMARY KEY,
    rating decimal,
    description varchar(100),
    date date,
    restaurant_id INT REFERENCES restaurant(id)
);

/*  */
SELECT
    constraint_name, column_name, table_name
FROM
    information_schema.key_column_usage
WHERE
    table_name = 'review';    
/*  */

CREATE TABLE categories_dishes (
    category_id char(2) REFERENCES category(id),
    dish_id integer REFERENCES dish(id),
    price money,
    PRIMARY KEY (dish_id, category_id)
);

/*  */
SELECT
    constraint_name,
    column_name,
    table_name
FROM
    information_schema.key_column_usage
WHERE
    table_name = 'categories_dishes';
/*  */

/* * * * * * * * * * * * * * * * * * * * * * */
/* 
*--------------------------------------------
Insert values for restaurant
*--------------------------------------------
*/
INSERT INTO restaurant VALUES (
1,
'China Bytes',
'Delectable Chinese Cuisine',
3.9,
'6175551212',
'Mon - Fri 9:00 am to 9:00 pm, Weekends 10:00 am to 11:00 pm'
);

/* 
*--------------------------------------------
Insert values for address
*--------------------------------------------
*/
INSERT INTO address (street_number, street_name, city, state, google_map_link, address_id) VALUES (
'2020',
'Busy Street',
'Chinatown',
'MA',
'http://bit.ly/ChinaBytes',
1
);

/* 
*--------------------------------------------
Insert values for review
*--------------------------------------------
*/
INSERT INTO review VALUES (
1,
5.0,
'Would love to host another birthday party at China Byte!',
'05-22-2020',
1
);

INSERT INTO review VALUES (
2,
4.5,
'Other than a small mix-up, I would give it a 5.0!',
'04-01-2020',
1
);

INSERT INTO review VALUES (
3,
3.9,
'A reasonable place to eat for lunch, if you are in a rush!',
'03-15-2020',
1
);

/* 
*--------------------------------------------
Insert values for category
*--------------------------------------------
*/
INSERT INTO category VALUES (
'C',
'Chicken',
null
);

INSERT INTO category VALUES (
'LS',
'Luncheon Specials',
'Served with Hot and Sour Soup or Egg Drop Soup and Fried or Steamed Rice  between 11:00 am and 3:00 pm from Monday to Friday.'
);

INSERT INTO category VALUES (
'HS',
'House Specials',
null
);

/* 
*--------------------------------------------
Insert values for dish
*--------------------------------------------
*/
INSERT INTO dish (id, name, price, description, hot_and_spicy) VALUES (
1,
'Chicken with Broccoli',
'$10.99',
'Diced chicken stir-fried with succulent broccoli florets',
false
);

INSERT INTO dish (id, name, price, description, hot_and_spicy) VALUES (
2,
'Sweet and Sour Chicken',
'$9.99',
'Marinated chicken with tangy sweet and sour sauce together with pineapples and green peppers',
false
);

INSERT INTO dish (id, name, price, description, hot_and_spicy) VALUES (
3,
'Chicken Wings',
'$8.99',
'Finger-licking mouth-watering entree to spice up any lunch or dinner',
true
);

INSERT INTO dish (id, name, price, description, hot_and_spicy) VALUES (
4,
'Beef with Garlic Sauce',
'$11.99',
'Sliced beef steak marinated in garlic sauce for that tangy flavor',
true
);

INSERT INTO dish (id, name, price, description, hot_and_spicy) VALUES (
5,
'Fresh Mushroom with Snow Peapods and Baby Corns',
'$9.49',
'Colorful entree perfect for vegetarians and mushroom lovers',
false
);

INSERT INTO dish (id, name, price, description, hot_and_spicy) VALUES (
6,
'Sesame Chicken',
'$10.49',
'Crispy chunks of chicken flavored with savory sesame sauce',
false
);

INSERT INTO dish (id, name, price, description, hot_and_spicy) VALUES (
7,
'Special Minced Chicken',
'$12.99',
'Marinated chicken breast sauteed with colorful vegetables topped with pine nuts and shredded lettuce.',
false
);

INSERT INTO dish (id, name, price, description, hot_and_spicy) VALUES (
8,
'Hunan Special Half & Half',
'$13.99',
'Shredded beef in Peking sauce and shredded chicken in garlic sauce',
true
);

/*
 *--------------------------------------------
 Insert valus for cross-reference table, categories_dishes
 *--------------------------------------------
 */
INSERT INTO categories_dishes VALUES (
  'C',
  1,
  6.95
);
INSERT INTO categories_dishes VALUES (
  'C',
  3,
  6.95
);
INSERT INTO categories_dishes VALUES (
  'LS',
  1,
  8.95
);
INSERT INTO categories_dishes VALUES (
  'LS',
  4,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  5,
  8.95
);
INSERT INTO categories_dishes VALUES (
  'HS',
  6,
  15.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  7,
  16.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  8,
  17.95
);
/*  */
SELECT * FROM restaurant;
SELECT * FROM address;
SELECT * FROM category;
SELECT * FROM dish;
SELECT * FROM review;
SELECT * FROM categories_dishes;
/*  */
SELECT
    MAX(rating) AS best_rating
FROM
    restaurant;

SELECT
    d.name AS dish_name,
    d.price AS price,
    c.name AS category
FROM
    dish d
JOIN
    categories_dishes cd ON d.id = cd.dish_id
JOIN
    category c ON cd.category_id = c.id
ORDER BY
    d.name;

SELECT
    c.name AS category,
    d.name AS dish_name,
    d.price AS price
FROM
    dish d
JOIN
    categories_dishes cd ON d.id = cd.dish_id
JOIN
    category c ON cd.category_id = c.id
ORDER BY
    c.name;

SELECT
    d.name AS spicy_dish_name,
    c.name AS category,
    d.price AS price
FROM
    dish d
JOIN
    categories_dishes cd ON d.id = cd.dish_id
JOIN
    category c ON cd.category_id = c.id
WHERE
    d.hot_and_spicy = true;

SELECT
    dish_id,
    COUNT(dish_id) AS dish_count
FROM
    categories_dishes
GROUP BY
    dish_id;

SELECT
    dish_id,
    COUNT(dish_id) AS dish_count
FROM
    categories_dishes
GROUP BY
    dish_id
HAVING
    COUNT(dish_id) > 1;

SELECT
    d.name AS dish_name,
    COUNT(cd.dish_id) AS dish_count
FROM
    dish d
JOIN
    categories_dishes cd ON d.id = cd.dish_id
GROUP BY
    d.name
HAVING
    COUNT(cd.dish_id) > 1;

SELECT
    rating AS best_rating,
    description
FROM
    restaurant
WHERE
    rating = (
        SELECT
            MAX(rating)
        FROM
            restaurant
    );
