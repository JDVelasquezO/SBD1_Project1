SELECT 'Actor' Nombre, COUNT(*) Cantidad FROM ACTOR
UNION
SELECT 'Categoría', COUNT(*) FROM CATEGORY
UNION
SELECT 'Ciudad', COUNT(*) FROM CITY
UNION
SELECT 'Clasificacion', COUNT(*) FROM CLASSIFICATION
UNION
SELECT 'Cliente', COUNT(*) FROM USER_STORE WHERE FK_IDROL = 'C'
UNION
SELECT 'Empleado', COUNT(*) FROM USER_STORE WHERE FK_IDROL = 'W'
UNION
SELECT 'Inventario', COUNT(*) FROM INVENTORY
UNION
SELECT 'Lenguaje', COUNT(*) FROM LANGUAJE
UNION
SELECT 'Pais', COUNT(*) FROM COUNTRY
UNION
SELECT 'Pelicula', COUNT(*) FROM MOVIE
UNION
SELECT 'Pelicula_Actor', COUNT(*) FROM MOV_ACT
UNION
SELECT 'Pelicula_Categoria', COUNT(*) FROM MOV_CATEGORY
UNION
SELECT 'Pelicula_Lenguaje', COUNT(*) FROM MOV_LANG
UNION
SELECT 'Renta', COUNT(*) FROM RENT
UNION
SELECT 'Tienda', COUNT(*) FROM STORE