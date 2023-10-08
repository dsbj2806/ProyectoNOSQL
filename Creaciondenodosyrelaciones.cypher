// Cargar el archivo,  WITH HEADERS quiere decir que la primera fila del archivo tiene el nombre de las columnas
// Crear nodos para personas
LOAD CSV WITH HEADERS FROM 'file:///csvpequeño.csv' AS row
CREATE (:Persona {ID: row.ID, Nombre: row.Nombre, Edad: row.Edad, ViveEn: row.`Vive en`})


// Crear nodos para ubicaciones
WITH DISTINCT row.`Vive en` AS ubicacion, row
MERGE (:Ubicacion {Nombre: ubicacion})


// Crear nodos para viajes y relaciones
WITH row
WHERE row.`Coord. Viaje1` IS NOT NULL
MERGE (p:Persona {ID: row.ID})
MERGE (u:Ubicacion {Nombre: row.`Vive en`})
MERGE (v1:Viaje {Coordenadas: row.`Coord. Viaje1`, Fecha: row.`Fecha Viaje 1`})
MERGE (p)-[:REALIZA]->(v1)
MERGE (v1)-[:DESTINO]->(u)


WITH row
WHERE row.`Coord. Viaje2` IS NOT NULL
MERGE (v2:Viaje {Coordenadas: row.`Coord. Viaje2`, Fecha: row.`Fecha Viaje 2`})
MERGE (p)-[:REALIZA]->(v2)

// Agregar relaciones sigue1 y sigue2
WITH row
WHERE row.`ID sigue1` IS NOT NULL
MATCH (p1:Persona {ID: row.ID})
MATCH (p2:Persona {ID: row.`ID sigue1`})
MERGE (p1)-[:SIGUE]->(p2)

WITH row
WHERE row.`ID sigue2` IS NOT NULL
MATCH (p1:Persona {ID: row.ID})
MATCH (p2:Persona {ID: row.`ID sigue2`})
MERGE (p1)-[:SIGUE]->(p2)