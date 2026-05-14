# Muestra todos los autores con su nombre y apellido de Argentina 
SELECT FirstName, LastName
FROM `gcp-mgs.sampledata.authors` 
WHERE Nationality = "Argentina";

# Lista los nombres de todos los productos (libros)   
SELECT  
ProductName, CategoryName
FROM `gcp-mgs.sampledata.products` product
INNER JOIN `gcp-mgs.sampledata.product_categories` categ
ON product.CategoryId = categ.CategoryID
WHERE CategoryName IN('Literatura y Ficción','No Ficción','Cómics y Manga', 
'Libros de Texto y Estudio', 'eBooks');

# ¿Cuántos clientes hay en la base de datos?  
SELECT COUNT(*) AS total_customers
FROM `gcp-mgs.sampledata.customers`;

# Muestra el nombre y correo electrónico de todos los clientes.   
SELECT name, email
FROM `gcp-mgs.sampledata.customers`;

# Lista los nombres de todas las categorías de productos. 
SELECT categoryName 
FROM `gcp-mgs.sampledata.product_categories`;

# Muestra los nombres de los productos junto con el nombre de su categoría (JOIN).    
SELECT  DISTINCT ProductName, CategoryName
FROM `gcp-mgs.sampledata.products` product
INNER JOIN `gcp-mgs.sampledata.product_categories` categ
ON product.CategoryId = categ.CategoryID;

# Lista los nombres de los clientes y la ciudad en la que viven (JOIN con cities).    
SELECT customers AS client_name, ci.city_name
FROM `gcp-mgs.sampledata.customers`
JOIN cities ci ON c.city_id = ci.id;

# ¿Cuántos productos hay en cada categoría?   
SELECT category_id, COUNT(*) AS total_products
FROM `gcp-mgs.sampledata.products` product
GROUP BY category_id;

# Muestra todos los productos cuyo precio es mayor a 20 euros.    
SELECT *
FROM `gcp-mgs.sampledata.products` product
WHERE price > 20;

# Muestra los nombres de las tiendas y la ciudad donde están ubicadas (JOIN con cities).  
SELECT s.name AS store_name, ci.city_name
FROM `gcp-mgs.sampledata.stores` s
JOIN cities ci ON s.city_id = ci.id;

# Muestra el número total de ventas (sales_orders) realizadas por cada tienda.    
SELECT store_id, COUNT(*) AS total_sales
FROM `gcp-mgs.sampledata.sales_orders`
GROUP BY store_id;

# Calcula el stock actual total por producto sumando el inventario de todas las tiendas.  
SELECT product_id, SUM(stock) AS total_stock
FROM inventory
GROUP BY product_id;

# Muestra los nombres de los autores y cuántos productos (libros) tiene cada uno. 
SELECT a.name AS author_name, COUNT(p.id) AS total_books
FROM `gcp-mgs.sampledata.authors` a
JOIN `gcp-mgs.sampledata.products` p ON p.author_id = a.id
GROUP BY a.name;

# Lista los productos que no tienen subcategoría asignada.    
SELECT *
FROM `gcp-mgs.product_subcategories`
WHERE Subcategory_ID IS NULL;

# Muestra los descuentos activos hoy (entre StartDate y EndDate). 
SELECT *
FROM `gcp-mgs.sampledata.discounts`
WHERE CURRENT_DATE BETWEEN StartDate AND EndDate;

# Muestra los productos vendidos (sales_order_items) junto con su autor y formato.    
SELECT p.name AS product_name,
       a.name AS author_name,
       f.name AS format_name
FROM `gcp-mgs.sampledata.sales_order_items` soi
JOIN `gcp-mgs.sampledata.products` p ON soi.product_id = p.id
JOIN `gcp-mgs.sampledata.authors` a ON p.author_id = a.id
JOIN formats f ON p.format_id = f.id;

# ¿Cuál es el producto más caro de cada categoría?    
SELECT p.*
FROM `gcp-mgs.sampledata.products`  p
JOIN (
    SELECT categoria_id, MAX(precio) AS max_precio
    FROM `gcp-mgs.sampledata.products` 
    GROUP BY categoria_id
) AS maximos
ON p.categoria_id = maximos.categoria_id
AND p.precio = maximos.max_precio;

# Muestra los clientes que han realizado más de un pedido.    
SELECT cliente_id, COUNT(*) AS total_pedidos
FROM `gcp-mgs.sampledata.sales_orders_items`
GROUP BY cliente_id
HAVING COUNT(*) > 1;

# Lista los productos que nunca han sido vendidos (subconsulta con sales_order_items).    
SELECT *
FROM `gcp-mgs.sampledata.products` product
WHERE id NOT IN (
    SELECT product_id
    FROM `gcp-mgs.sampledata.sales_orders`
);

# Muestra los nombres de los productos y el total de unidades vendidas de cada uno.   
SELECT p.nombre, SUM(s.cantidad) AS total_unidades_vendidas
FROM `gcp-mgs.sampledata.products` p
JOIN `gcp-mgs.sampledata.sales_order_items` s ON p.id = s.producto_id
GROUP BY p.id, p.nombre;
