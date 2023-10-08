//Para ver mis nodos:
MATCH (n)
RETURN n;


//Para confirmar  los nodos de personas:
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

//consulta para saber a quien sigue cualquier nombre
MATCH (seguidor:Persona)-[:SIGUE]->(seguido:Persona)
RETURN seguidor.Nombre AS Seguidor, seguido.Nombre AS Seguido
