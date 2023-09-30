LOAD CSV WITH HEADERS FROM 'file:///datosfalsos.csv' AS row
WITH row WHERE row.id IS NOT NULL
MERGE (n:Node {Name: row.id})

MATCH (n) RETURN (n)

uwu