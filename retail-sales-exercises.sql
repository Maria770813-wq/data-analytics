# Muestra todos los autores con su nombre y apellido de Argentina 
SELECT FirstName, LastName
FROM `gcp-mgs.sampledata.authors` 
WHERE Nationality = ""Argentina"""

# Lista los nombres de todos los productos (libros)   
SELECT  
ProductName, CategoryName
FROM `gcp-mgs.sampledata.products` product
INNER JOIN `gcp-mgs.sampledata.product_categories` categ
ON product.CategoryId = categ.CategoryID
WHERE CategoryName IN('Literatura y Ficción','No Ficción','Cómics y Manga', 
'Libros de Texto y Estudio', 'eBooks')"

# ¿Cuántos clientes hay en la base de datos?  
SELECT COUNT(*) AS total_customers
FROM `gcp-mgs.sampledata.customers`;"

# Muestra el nombre y correo electrónico de todos los clientes.   
SELECT name, email
FROM `gcp-mgs.sampledata.customers`;"

# Lista los nombres de todas las categorías de productos. 
SELECT categoryName 
FROM `gcp-mgs.sampledata.product_categories`;"

# Muestra los nombres de los productos junto con el nombre de su categoría (JOIN).    
SELECT  
ProductName, CategoryName
FROM `gcp-mgs.sampledata.products` product
INNER JOIN `gcp-mgs.sampledata.product_categories` categ
ON product.CategoryId = categ.CategoryID;"

# Lista los nombres de los clientes y la ciudad en la que viven (JOIN con cities).    
SELECT customers AS client_name, ci.city_name
FROM customers
JOIN cities ci ON c.city_id = ci.id;"

# ¿Cuántos productos hay en cada categoría?   
SELECT category_id, COUNT(*) AS total_products
FROM products
GROUP BY category_id;"

# Muestra todos los productos cuyo precio es mayor a 20 euros.    
SELECT *
FROM products
WHERE price > 20;"

# Muestra los nombres de las tiendas y la ciudad donde están ubicadas (JOIN con cities).  
SELECT s.name AS store_name, ci.city_name
FROM stores s
JOIN cities ci ON s.city_id = ci.id;"

# Muestra el número total de ventas (sales_orders) realizadas por cada tienda.    
SELECT store_id, COUNT(*) AS total_sales
FROM sales_orders
GROUP BY store_id;"

# Calcula el stock actual total por producto sumando el inventario de todas las tiendas.  
SELECT product_id, SUM(stock) AS total_stock
FROM inventory
GROUP BY product_id;"

# Muestra los nombres de los autores y cuántos productos (libros) tiene cada uno. 
SELECT a.name AS author_name, COUNT(p.id) AS total_books
FROM authors a
JOIN products p ON p.author_id = a.id
GROUP BY a.name;"

# Lista los productos que no tienen subcategoría asignada.    
SELECT *
FROM `gcp-mgs.product_subcategories`
WHERE Subcategory_ID IS NULL;"

# Muestra los descuentos activos hoy (entre StartDate y EndDate). 
SELECT *
FROM `gcp-mgs.sampledata.discounts`
WHERE CURRENT_DATE BETWEEN StartDate AND EndDate;"

# Muestra los productos vendidos (sales_order_items) junto con su autor y formato.    
SELECT p.name AS product_name,
       a.name AS author_name,
       f.name AS format_name
FROM sales_order_items soi
JOIN products p ON soi.product_id = p.id
JOIN authors a ON p.author_id = a.id
JOIN formats f ON p.format_id = f.id;"

# ¿Cuál es el producto más caro de cada categoría?    
SELECT p.*
FROM productos p
JOIN (
    SELECT categoria_id, MAX(precio) AS max_precio
    FROM productos
    GROUP BY categoria_id
) AS maximos
ON p.categoria_id = maximos.categoria_id
AND p.precio = maximos.max_precio;"

# Muestra los clientes que han realizado más de un pedido.    
SELECT cliente_id, COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY cliente_id
HAVING COUNT(*) > 1;"

# Lista los productos que nunca han sido vendidos (subconsulta con sales_order_items).    
SELECT *
FROM productos
WHERE id NOT IN (
    SELECT producto_id
    FROM sales_order_items
);"

# Muestra los nombres de los productos y el total de unidades vendidas de cada uno.   
SELECT p.nombre, SUM(s.cantidad) AS total_unidades_vendidas
FROM productos p
JOIN sales_order_items s ON p.id = s.producto_id
GROUP BY p.id, p.nombre;"

# Muestra los 5 clientes que más han gastado en total (suma de TotalAmount en sales_orders).  

# Lista los productos cuyo precio está por encima del precio promedio de su categoría.    

# Muestra el importe total de ventas por año de publicación de los productos vendidos.    

# Encuentra las tiendas con el mayor número de productos en inventario.   

# Muestra los autores cuyos libros han generado más de 1000 euros en ventas totales.  

# Usando una CTE, muestra el crecimiento mensual de ventas (TotalAmount) en el último año.    

# Calcula el porcentaje de productos vendidos por categoría respecto al total de productos vendidos.  

# Muestra los clientes que han comprado productos de más de una categoría diferente.  

# Genera un ranking de los 10 productos más vendidos por unidades, junto con su autor y editorial.    
Crea un informe que muestre, para cada campaña 
# de marketing, el número de pedidos y el importe total generado por pedidos asociados a esa campaña.  