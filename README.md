# ProyectoNOSQL
En este proyecto se genera una base de datos de grafos capaz de manejar distancias viajadas, personas y relaciones entre lugares y personas.

Se utilizan los lenguajes:
* R
* Cypher de la base de datos Neo4j
* DO de las bases de datos de InfiniteGraph.

## Generación de datos
Se generó aleatoriamente un archivo CSV,utilizando el lenguaje de programación R, con todos los datos necesarios, personas, sus edades, a quienes sigue, donde se ubica al incio de sus viajes, donde se ubica al final de sus viajes y la fecha de estos respectivos viajes. 

Es decir, estamos usando viajes falsos. Por lo que se debe de considerar lo siguiente. 
 * Es altamente probable que una persona viva o se dirija al medio del oceáno, sin embargo esto no representa un problema para lo que se quiere probar con este proyecto.
 * Es probable que existan personas con el mismo nombre y apellidos, pero el ID debería solucionar esto.

También se debe de decir que en las bases de datos de grafos las relaciones son **unidireccionales** por lo que se prefiere:
* Una relación de *seguimiento*, no de amistad, similar a la red social Instagram
  * En este caso, cada persona puede tener,como máximo, n-1 seguidores(Ya que no se puede seguir a sí misma), pero para facilitar la generación de los datos, cada persona puede seguir solo a dos personas.

El archivo CSV utilizado está en el repositorio como "datossimulados.csv" sin embargo se invita a utilizar el código con los que se generaron y crear un archivo propio con los cambios deseados. 

## Instalaciones 

### Instalación de InfiniteGraph

De la web oficial de [InfiniteGraph](https://infinitegraph.com/free-download/) podemos descargar los archivos directamente. Estos archivos vienen en un .ZIP que podemos extraer donde queramos, en este caso los vamos a exrtraer en Disco Local(C:) en una carpeta llamada "InfiniteGraph"

Debería de quedarnos algo así
![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/94d5c9b1-0ce5-4bcd-833f-e4dbe3df256d)

Una vez con esto hecho podemos avanzar al siguiente paso, que es agregar un PATH

Esto se hace de la siguiente forma:

En configuración nos vamos a Sistema 

![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/ff41334e-b69f-413d-a6a8-f681694453d1)

En sistema bajamos hasta información. 
Y buscamos la opción "Configuración Avanzada del sistema"

![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/fc859826-131b-4945-b542-b9dea52642a5)

Y ahí vamos a entrar en las variables de entorno que deberiá de verse algo así: 

![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/03c7f05c-d829-41d3-ac41-b5a704dd3a7f)

Y vamoos a buscar la opciíon PATH en Variables del sistema: 
![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/2a606d53-d768-4867-936c-95fbad306f04)

Una vez en Path vamos a agregar un nuevo Path y en examinar buscamos la carpeta bin de infinitegraph

Que debería de verse así: 

![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/b53c64fa-2efe-4f87-bb36-4924fac5d1ae)

Luego de esto, en el escritorio damos click derecho abrir en terminal:
Y escribimos en la terminal lo siguiente: 
C:\InfiniteGraph\bin\objy startlockserver -noscm 
Y le damos enter 

Después escribimos lo siguiente: 

C:\InfiniteGraph\bin\objy startstudioserver

Y por último entramos desde nuestro navegador preferido al siguiente "Enlace": 

http://localhost:8190 


**NOTA:** El .ZIP se debería de poder extraer en cualquier carpeta de la computadora, por lo que si se escoge una carpeta diferente para almacenar, solo debemos de asegurarnos de que el PATH esté bien especificado y sea congrunte entre los pasos que lo necesitan. 

## Cargar los datos de CSV a Neo4j 

El código utiliza Neo4j para cargar datos desde un archivo CSV, crear nodos para personas, ubicaciones y viajes, establecer relaciones entre ellos y realizar consultas. A continuación, una descripción de cada sección:

Empezamos usando el documento llamado “Creaciondenodosyrelaciones”. La línea `LOAD CSV WITH HEADERS FROM 'file:///csvpequeño.csv' AS row` significa que está leyendo un archivo CSV llamado 'csvpequeño.csv' y se asigna cada fila a una variable llamada `row`. El atributo `WITH HEADERS` quiere decir que la primera fila del archivo CSV contiene los nombres de las columnas.

Seguidamente, se procede a la creación de nodos para representar personas en la base de datos Neo4j. La línea `CREATE (:Persona {ID: row.ID, Nombre: row.Nombre, Edad: row.Edad, ViveEn: row.ViveEn})` crea un nodo de tipo "Persona" con propiedades como ID, Nombre, Edad y ViveEn. Estas se obtienen de las columnas del archivo CSV utilizando la variable `row`.
Luego, se crea un nodo para las ubicaciones únicas. La línea `WITH DISTINCT row.ViveEn AS ubicacion, row` selecciona valores de la columna "Vive en" y los asigna a la variable `ubicacion`.Además, se utiliza `MERGE` para crear un nodo de tipo "Ubicación" con la propiedad "Nombre" establecida en `ubicacion`.

Asimismo, se deben crear nodos para representar viajes y establecer relaciones entre personas, viajes y ubicaciones. Se realiza en dos partes, una para cada posible viaje, primero se verifica si la columna `Coord. Viaje1` no es nula con la condición `WHERE row.CoordViaje1 IS NOT NULL`. Si esa condición es verdadera, se crean nodos de tipo "Persona" y "Ubicación" si aún no existen y se establecen relaciones entre ellos y el nodo de tipo "Viaje" para representar el primer viaje. Las relaciones incluyen "REALIZA" entre personas y viajes, así como "DESTINO" entre viajes y ubicaciones. Del mismo modo, se crea una para viaje 2, igual se verifica que la columna `Coord. Viaje2` no es nula. Si es cierto, se crean nodos de tipo "Viaje" para representar el segundo viaje y se establecen relaciones "REALIZA" entre personas y viajes.
Finalmente, se crean relaciones entre personas para representar a quién sigue cada persona. Se verifican las columnas `ID sigue1` e `ID sigue2` para determinar si una persona sigue a otra. Si es así, se usa `MATCH` y `MERGE` para crear relaciones "SIGUE" entre las personas correspondientes.

## Realizar consultas para verificar la exportación de datos 
Ahora, para verificar que funcionen los nodos y relaciones, usaremos el archivo llamado “Para_ver_mis_nodos”, y realizaremos las siguientes consultas:
La consulta `MATCH (n) RETURN n;` muestra todos los nodos en la base de datos.
La consulta `MATCH (p:Persona) RETURN p;` devuelve todos los nodos de tipo "Persona".
La consulta `MATCH (u:Ubicacion) RETURN u;` muestra todos los nodos de tipo "Ubicación".
La consulta `MATCH (p:Persona)-[:REALIZA]->(v:Viaje) RETURN p, v;` muestra las relaciones "REALIZA" entre personas y viajes.
La consulta `MATCH (p:Persona)-[:REALIZA]->(v:Viaje) RETURN p, v;` muestra los viajes realizados por personas específicas.
La consulta `MATCH (seguidor:Persona)-[:SIGUE]->(seguido:Persona) RETURN seguidor.Nombre AS Seguidor, seguido.Nombre AS Seguido;` muestra las relaciones "SIGUE" entre personas y sus seguidores.

Y de este modo verificar que funcione tanto la carga de datos como los nodos y relaciones entre nuestras variables.


