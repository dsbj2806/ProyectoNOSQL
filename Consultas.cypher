//Consultas         
//Para ver mis nodos:
MATCH (n)
RETURN n;


//Para confirmar que funciona se hace lo siguiente:
MATCH (p:Persona)
RETURN p;


//Para consultar las ubicaciones:
MATCH (u:Ubicacion)
RETURN u;


//Para consultar las relaciones de tipo REALIZA entre personas y viajes:
MATCH (:Persona)-[r:REALIZA]->(:Viaje)
RETURN r;

//Para consultar viajes de algunas personas :                         
MATCH (p:Persona )-[:REALIZA]->(v:Viaje)
RETURN p, v;

//consulta para saber a quien sigue todas las personas
MATCH (p1:Persona)
OPTIONAL MATCH (p1)-[:SIGUE]->(p2:Persona)
RETURN p1.Nombre AS Persona, COLLECT(p2.Nombre) AS Siguiendo;


//Consulta para la relación entre Viaje1 y Transporte1:
MATCH (v1:Viaje)-[:UTILIZA]->(t1:Transporte)
WHERE EXISTS(v1.Coordenadas) AND EXISTS(t1.Nombre)
RETURN v1, t1;


//Consulta para la relación entre Viaje2 y Transporte2:
MATCH (v2:Viaje)-[:UTILIZA]->(t2:Transporte)
WHERE EXISTS(v2.Coordenadas) AND EXISTS(t2.Nombre)
RETURN v2, t2;