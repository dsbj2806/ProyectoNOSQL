//Codigo para cargar base
// Crear nodos para personas
LOAD CSV WITH HEADERS FROM 'file:///datossimulados.csv' AS row
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
MERGE (t1:Transporte {Nombre: row.`Transporte1`}) // Crea nodos de transporte
MERGE (p)-[:REALIZA]->(v1)
MERGE (v1)-[:DESTINO]->(u)
MERGE (v1)-[:UTILIZA]->(t1) // Crea relación entre Viaje1 y Transporte1

WITH row
WHERE row.`Coord. Viaje2` IS NOT NULL
MERGE (p:Persona {ID: row.ID})
MERGE (v2:Viajedos {Coordenadas: row.`Coord. Viaje2`, Fecha: row.`Fecha Viaje 2`})
MERGE (t2:Transportedos {Nombre: row.`Transporte2`}) // Crea nodos de transporte
MERGE (v2)-[:DESTINO]->(u2)
MERGE (p)-[:REALIZADOS]->(v2)
MERGE (v2)-[:UTILIZADOS]->(t2) // Crea relación entre Viaje2 y Transporte2


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
MERGE (p1)-[:SIGUEDOS]->(p2)


