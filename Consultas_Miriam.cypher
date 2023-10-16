USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM 'file:///datossimulados.csv' AS row
CREATE (p:Persona {
  ID: toInteger(row.ID),
  Nombre: row.Nombre,
  Edad: toInteger(row.Edad),
  `Vive en`: row.`Vive en`,
  `ID sigue1`: toInteger(row.`ID sigue1`),
  `ID sigue2`: toInteger(row.`ID sigue2`),
  `Coord. Viaje1`: point({latitude: toFloat(row.`Coord. Viaje1.latitude`), longitude: toFloat(row.`Coord. Viaje1.longitude`)}),
  `Fecha Viaje 1`: date(datetime({s: row.`Fecha Viaje 1`, format: 'dd/MM/yyyy'})),
  Transporte1: row.Transporte1,
  `Coord. Viaje2`: point({latitude: toFloat(row.`Coord. Viaje2.latitude`), longitude: toFloat(row.`Coord. Viaje2.longitude`)}),
  `Fecha Viaje 2`: date(datetime({s: row.`Fecha Viaje 2`, format: 'dd/MM/yyyy'})),
  Transporte2: row.Transporte2
})

\\Personas que más viajaron
MATCH (p:Persona)
WITH p, p.`Coord. Viaje1` AS coord1, p.`Coord. Viaje2` AS coord2
WITH p, distance(point({latitude: p.`Coord. Viaje1`.latitude, longitude: p.`Coord. Viaje1`.longitude}), point({latitude: p.`Coord. Viaje2`.latitude, longitude: p.`Coord. Viaje2`.longitude})) AS distancia
RETURN p.ID, p.Nombre, distancia
ORDER BY distancia DESC
LIMIT 10;

\\Personas que se siguen mutuamente
MATCH (p1:Persona)-[:SIGUE]->(p2:Persona)
RETURN p1.Nombre, p2.Nombre

\\ Transportes más utilizados
MATCH (p:Persona)
WITH p, p.`Transporte1` AS transporte1, p.`Transporte2` AS transporte2
UNWIND [transporte1, transporte2] AS transporte
RETURN transporte, count(*) AS cantidad
ORDER BY cantidad DESC;

\\ Año en que la persona más viajó
MATCH (p:Persona)
WITH p, [p.`Fecha Viaje 1`, p.`Fecha Viaje 2`] AS fechas
UNWIND fechas AS fecha
WITH p, date(datetime(fecha, 'dd/MM/yyyy')) AS fecha_viaje
RETURN year(fecha_viaje) AS año, count(*) AS cantidad
ORDER BY cantidad DESC
LIMIT 1;

