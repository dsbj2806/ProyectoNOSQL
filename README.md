# ProyectoNOSQL
En este proyecto se genera una base de datos de grafos capaz de manejar distancias viajadas, personas y relaciones entre lugares y personas.

Se utilizan los lenguajes:
* R
* Cypher de la base de datos Neo4j
* SparQL de la base de datos GraphDB

## Instalación de programas

### R y RStudio
Para generar los datos se utilizó RStudio, por lo cual es necesario explicar como instalar R y RStudio en la computadora. 

1) El primer paso es instalar **R**, para eso debemos ir a [esta página web](https://cran.r-project.org/bin/windows/base/) y debemos seleccionar la siguiente opción: ![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/7a7bf50e-9b3e-49a9-b5a6-cb78b5062a8d)

    * Eso iniciara la descarga la cual vamos a almacenar en la dirección de nuestra computadora que queramos.
    
    * Deberíamos tener algo así: ![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/1cb21a09-11d2-4b5a-bd97-53662aa44e93)

    * Al abrirlo podemos escoger el idioma que queramos para R y simplemente seguir los pasos del instalador. Es bastante sencillo. No hay que seleccionar ninguna configuración en especial, por lo cual se puede solo precionar "Siguiente" hasta que termine.

2) El segundo paso es instalar **RStudio**. Para hacerlo debemos primero dirigirnos a la siguiente [dirección](https://posit.co/download/rstudio-desktop/) y seleccionar la siguiente opción: ![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/6eea3014-c2f9-47c3-ba27-98318fa587e2)

    * Igualmente eso debería de iniciar la descarga del instalador y que debería de verse algo así:
![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/65b251e2-2113-4baf-963b-b135246a237a)

    * De igual forma que con R, podemos simplemente precionar "Siguiente" en todas las opciones pues no requiere ninguna instalación especial. 

    * Una vez realizado todo el proceso deberíamos poder usar RStudio, el cual se ve de esta forma:
![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/d3af257a-67fb-4acb-a546-adb515147bf2)



### Neo4j
Para crear las conexiones en el volumen de datos y las consultas correspondientes, se utilizó Neo4j, un software libre de base de datos orientada a grafos, implementado en Java.
Para instalarlo se pueden seguir los siguientes pasos: 

1) Dirigirse a esta [esta página web](https://neo4j.com/download/)
2) Posteriormente seleccionar la opción Download.
3) Se deberá completar el siguiente formulario con los datos del usuario: ![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/49732161/f5cb58b2-6428-4da8-afcd-646605ef3145) Una vez lleno dicho formulario se aceptan los términos y condiciones y se selecciona la opción Download Desktop.
   
Seguidamente, localice el archivo recién descargado y haga doble clic en él para iniciar la instalación. A continuación, siga los pasos que aparecen en pantalla para completar la instalación.
Una vez iniciado Neo4j Desktop, se debe proporcionar una clave de activación para activar la copia de Desktop. Copia y pega la clave, que se encuentra en la parte superior de la página de descarga, en la casilla de la aplicación Desktop. Alternativamente, se puede generar una nueva clave desde la aplicación Desktop rellenando el formulario que aparece a la derecha de la pantalla.
   

### GraphDB

Instalar GraphDB tampoco debería suponer un problema. Para hacerlo podemos seguir los siguientes pasos:  

1) Dirigirse a la siguiente [Dirección](https://graphdb.ontotext.com/)

2) Seleccionar esta opcíon: ![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/a2d96fa8-5622-4a4c-a4bf-85a437e0f1da)

3) Llenar la siguiente información: ![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/78c5d42f-fcf8-46c5-b654-80cb7112e166)
     * Un correo electronico será enviado con la información de descarga.
4) El correo debería verse algo así: ![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/48aae7a3-f6e1-48f8-aa67-43dacc1b32f5)ç
   * Seleccionamos la opcion de nuestro sistema operativo. En este caso, windows, eso debría iniciar la instalación
5) Una vez descargado el instalador,aceptamos los terminos y condiciones y le damos siguiente.
6) Una vez instalado se puede ver algo así: ![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/144052489/c359cd61-4fa0-4484-97a7-8a8016eb2087)

### OntoRefine

Para descaragar OntoRefine debemos dirigirnos a la siguiente dirección: https://www.ontotext.com/products/ontotext-refine/
<img width="652" alt="image" src="https://github.com/dsbj2806/ProyectoNOSQL/assets/146558517/8cb1acff-a140-4dda-8750-222ba14918ae">

Seleccionamos el sistema operativo correspondiente:

<img width="605" alt="image" src="https://github.com/dsbj2806/ProyectoNOSQL/assets/146558517/425f9564-92da-42c2-a7fb-79cc211811b3">

Una vez descargado el instalador,aceptamos los terminos y condiciones y le damos siguiente.

Instalado se puede ver de la siguiente forma:
<img width="910" alt="image" src="https://github.com/dsbj2806/ProyectoNOSQL/assets/146558517/5aa3be6c-6d1d-4d7e-8109-d2ecc3f122b2">

 

## Generación de datos
Se generó aleatoriamente un archivo CSV,utilizando el lenguaje de programación R, con todos los datos necesarios, personas, sus edades, a quienes sigue, donde se ubica al incio de sus viajes, donde se ubica al final de sus viajes y la fecha de estos respectivos viajes. 

Es decir, estamos usando viajes falsos. Por lo que se debe de considerar lo siguiente. 
 * Es altamente probable que una persona viva o se dirija al medio del oceáno, sin embargo esto no representa un problema para lo que se quiere probar con este proyecto.
 * Es probable que existan personas con el mismo nombre y apellidos, pero el ID debería solucionar esto.

También se debe de decir que en las bases de datos de grafos las relaciones son **unidireccionales** por lo que se prefiere:
* Una relación de *seguimiento*, no de amistad, similar a la red social Instagram
  * En este caso, cada persona puede tener,como máximo, n-1 seguidores(Ya que no se puede seguir a sí misma), pero para facilitar la generación de los datos, cada persona puede seguir solo a dos personas.

El archivo CSV utilizado está en el repositorio como "datossimulados.csv" sin embargo se invita a utilizar el código con los que se generaron y crear un archivo propio con los cambios deseados. 




## Utilización de los productos
### Cargar los datos de CSV a Neo4j 

El código utiliza Neo4j para cargar datos desde un archivo CSV, crear nodos para personas, ubicaciones y viajes, establecer relaciones entre ellos y realizar consultas. A continuación, una descripción de cada sección:


Empezamos usando el documento llamado “Codigo_para_cargar_base.cypher”. La línea `LOAD CSV WITH HEADERS FROM 'file:///datossimulados.csv' AS row` significa que está leyendo un archivo CSV llamado 'datossimulados.csv' y se asigna cada fila a una variable llamada `row`. El atributo `WITH HEADERS` quiere decir que la primera fila del archivo CSV contiene los nombres de las columnas.


Seguidamente, se procede a la creación de nodos para representar personas en la base de datos Neo4j. La línea `CREATE (:Persona {ID: row.ID, Nombre: row.Nombre, Edad: row.Edad, ViveEn: row.ViveEn})` crea un nodo de tipo "Persona" con propiedades como ID, Nombre, Edad y ViveEn. Estas se obtienen de las columnas del archivo CSV utilizando la variable `row`.
Luego, se crea un nodo para las ubicaciones únicas. La línea `WITH DISTINCT row.ViveEn AS ubicacion, row` selecciona valores de la columna "Vive en" y los asigna a la variable `ubicacion`.Además, se utiliza `MERGE` para crear un nodo de tipo "Ubicación" con la propiedad "Nombre" establecida en `ubicacion`.


Asimismo, se deben crear nodos para representar viajes y establecer relaciones entre personas, viajes y ubicaciones. Se realiza en dos partes, una para cada posible viaje, primero se verifica si la columna `Coord. Viaje1` no es nula con la condición `WHERE row.CoordViaje1 IS NOT NULL`. Si esa condición es verdadera, se crean nodos de tipo "Persona" y "Ubicación" si aún no existen y se establecen relaciones entre ellos y el nodo de tipo "Viaje" y “Transporte” para representar el primer viaje y transporte. Las relaciones incluyen "REALIZA" entre personas y viajes, así como "DESTINO" entre viajes y ubicaciones y finalmente “UTILIZA” entre viaje y transporte. Del mismo modo, se crea una para cada una pero para el segundo viajes y transporte.

También, se crean relaciones entre personas para representar a quién sigue cada persona. Se verifican las columnas `ID sigue1` e `ID sigue2` para determinar si una persona sigue a otra. Si es así, se usa `MATCH` y `MERGE` para crear relaciones "SIGUE" entre las personas correspondientes.

Otra parte importante es que para cada nodo 'Viaje' y 'Viajedos, se deben dividir la cadena de texto 'coordenadas' en dos partes: la latitud y la longitud, utilizando la función split. Tambien, se convierte estas partes de texto en números con decimales para latitud y longitud, se construye un objeto Point que representa la ubicación geoespacial utilizando las coordenadas de latitud y longitud, a este se le asigna al atributo 'Coordenadas' del nodo 'Viaje' o 'Viajedos' para que contenga la información de ubicación en formato geoespacial.

Finalmente, se elimina el atributo 'coordenadas' original, esto porque la información de ubicación se ha convertido en un objeto Point y se ha almacenado en el atributo 'Coordenadas', el atributo 'coordenadas' original se elimina para mantener la base de datos ordenada y eficiente.





### Verificación de la exportación de datos en Neo4j
Ahora, para verificar que funcionen los nodos y relaciones, usaremos el archivo llamado “Consultas.cypher”, y realizaremos las siguientes consultas:

1- Que muestra todos los nodos en la base de datos.

2- Devuelve todos los nodos de tipo "Persona".

3- Muestra todos los nodos de tipo "Ubicación".

4- Proporciona las relaciones "REALIZA" entre personas y viajes.

5-Detallar los viajes realizados por personas específicas.

6- Devuelve una lista de a quien sigue todas las personas.

7- Indica la relación entre Viaje1 y Transporte1.

8-Consulta para la relación entre Viaje2 y Transporte2.

9-Constulta para verificar las coordenas de los viajes de las personas.

Y de este modo verificar que funcione tanto la carga de datos como los nodos y relaciones entre nuestras variables.

### Consultas en Neo4j
Las consultas realizadas fueron las siguientes:
1) Se calcula el promedio de la edad de las personas que utilizan diferentes medios de transporte.
2) Se obtiene la distancia recorrida en kilómetros entre la ubicación (residencia) de una persona y los dos lugares que visitó. Además, se obtiene la suma de la distancia recorrida para cada viaje y se obtuvo una medida de cuántos kilómetros se desplazó esa persona.
3) S calculó la diferencia en la distancia total recorrida por las personas y las personas a las que siguen. 


### Cargar los datos de CSV a GraphDB

Para convertir datos de CSV a RDF en GraphDB, podemos usar el plugin OntoRefine, que está integrado en el Workbench de GraphDB.
Para ello, se deben seguir los siguientes pasos:

1.	Iniciamos GraphDB en modo Workbench.
  
2.	Creamos un proyecto.

3.	Importamos el archivo CSV.
   
4.	Definimos el mapeo entre los datos de CSV y el modelo RDF.

5.	Generamos el modelo RDF.

Paso 1: Iniciar GraphDB en modo Workbench
Para iniciar GraphDB en modo Workbench, se debe abrir un navegador y escribir la dirección http://localhost:7200/.

Paso 2: Crear un proyecto. Para crear un proyecto, hacemos clic en el botón "Create Project".

Paso 3: Importar el archivo CSV
Para importar el archivo CSV, hacemos clic en el botón "Import" > "Tabular (OntoRefine)".
Seleccionamos el archivo CSV y procedemos a hacer clic en el botón "Open".

Paso 4: Definir el mapeo entre los datos de CSV y el modelo RDF.
OntoRefine nos permite definir el mapeo entre los datos de CSV y el modelo RDF. Para ello, hacemos clic en el botón "Map".
En la ventana "Map", podemos definir el mapeo entre los campos del archivo CSV y las propiedades del modelo RDF.

Paso 5: Generar el modelo RDF
Una vez que se haya definido el mapeo, vamos a generar el modelo RDF. Para ello, hacemos clic en el botón "Generate".
OntoRefine generará el modelo RDF y lo almacenará en el proyecto.

Visual RDF Mapper:
![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/146558517/3c0bea0a-dd96-4196-b605-4c5b14d28cf0)

Para realizar el mapeo se debio dividir las columnas de la longitud y latitud con la opcion "split into a several columns", esto para poder transformar las respectivas variables (vive en y las coordenadas de viaje) a tipo numerico.

![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/146558517/2f5c6f3e-0928-4b71-9fba-34c84b1f26f4)

![image](https://github.com/dsbj2806/ProyectoNOSQL/assets/146558517/8dc60b26-389e-4b86-8b37-feffa2ef3b80)




