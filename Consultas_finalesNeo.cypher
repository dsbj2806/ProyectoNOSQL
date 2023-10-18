//Diferencia entre persona y a quien sigue
MATCH (p:Persona)-[:SIGUE]->(s:Persona)                                                                                 
OPTIONAL MATCH (p)-[:REALIZA]->(v:Viaje)
OPTIONAL MATCH (p)-[:REALIZADOS]->(v2:Viajedos)   
OPTIONAL MATCH (s)-[:REALIZA]->(b:Viaje)
OPTIONAL MATCH (s)-[:REALIZADOS]->(b2:Viajedos)                                                                           
RETURN p.Nombre AS Persona,(point.distance(p.ViveEn,v.Coordenadas)+point.distance(p.ViveEn,v2.Coordenadas))/1000 AS DistanciaTotalPersona, s.Nombre AS Sigue,(point.distance(s.ViveEn,b.Coordenadas)+point.distance(s.ViveEn,b2.Coordenadas))/1000  AS DistanciaTotalSigue, ((point.distance(p.ViveEn,v.Coordenadas)+point.distance(p.ViveEn,v2.Coordenadas))/1000)-((point.distance(s.ViveEn,b.Coordenadas)+point.distance(s.ViveEn,b2.Coordenadas))/1000) AS Diferencia 
ORDER BY Diferencia DESC 
LIMIT 10

//Distancia Total 
MATCH (p:Persona)
OPTIONAL MATCH (p)-[:REALIZA]->(v:Viaje)
OPTIONAL MATCH (p)-[:REALIZADOS]->(v2:Viajedos)
RETURN p.Nombre AS Nombre, p.ViveEn AS vive, point.distance(p.ViveEn,v.Coordenadas)/1000 AS DistanciaV1, point.distance(p.ViveEn,v2.Coordenadas)/1000 AS DistanciaV2, (point.distance(p.ViveEn,v.Coordenadas)+point.distance(p.ViveEn,v2.Coordenadas))/1000 AS DistanciaTotal
ORDER BY DistanciaTotal DESC

//Promedio de edad por medio de transporte
MATCH (p:Persona)-[:REALIZA]->(viaje:Viaje)-[:UTILIZA]->(t:Transporte)
WITH t.Nombre AS NombreTransporte, toFloat(p.Edad) AS EdadNumerica
RETURN NombreTransporte, avg(EdadNumerica) AS PromedioEdad

