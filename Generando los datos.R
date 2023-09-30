
n<-100000 ### Se establece un número de personas falsas que se quieren generar automáticamente.
nombre = sample(c("Alice", "Bob", "Carol","Carlos","Isaac","Nahomy","Fabricio","Daniel","Luffy","Francisco","Yarlin","Miriam","Steyfell"), n, replace = TRUE) ### Se establecen una lista de posibles nombres y se escoge una muestra de tamaño n de esta lista, de esa forma se generan aleatoriamente los nombres 
apellido1= sample(c("Jimenez", "Vargas", "Messi","Martinez","Cordero","Segura","Vilchez","Sibaja","D","Calderon","Vargas","Calvo","Smith"), n, replace = TRUE) ### Se establece una lista de apellidos y de forma similar, se escogen.
apellido2= sample(c("Barboza", "Vargas", "Messi","Rodriguez","Alvarado","Badilla","Monge","Salazar","Monkey","Fonseca","Valverde","Alfaro","Morgan"), n, replace = TRUE) ### Acá igual pero para el segundo apellido, cabe aclarar que un nombre, un primer apellido y un segundo apellido pueden salir más de una vez gracias al parámetro "replace=TRUE"
id = 1:n ## Se genera un id en orden de 1 a n
sigue1<-NULL ## Se establece la variable sigue1
sigue2<-NULL ## Se establece la variable sigue2, esto se hace así para poder hacer un for y que una persona no sea amiga de sí misma.
for (i in 1:n) {
  posible1<-setdiff(id,i) ## Acá se establece un vector con números que contiene la diferencia entre id e i, o sea si i es 1 e id va de 1 a 100, esta lista va a ser de 2 a 100
  mamigo<-sample(posible1,2)## Se saca una muestra aleatoria de posible1, sin remplazo, para que una persona no pueda seguir a la misma persona 2 veces
  sigue1[i]<-mamigo[1] ## Se introducen en los vectores sigue1 y sigue2
  sigue2[i]<-mamigo[2]
}
inicio2021<- as.Date("2021-01-01") ###Simplemente se declaran Fechas de inicio y de final para facilitar las cosas más adelante.
final2021 <- as.Date("2021-12-31")
inicio2022<- as.Date("2022-01-01")
final2022 <- as.Date("2022-12-31")


df <- data.frame( ###Generar data frame
  id,
  nombre<-paste(nombre,apellido1,apellido2,sep = " "),
  edad = abs(round(rnorm(n, 30, 10))), ### Se genera una distribución normal de tamaño n, promedio 30 y desviación estándar 10 para generar las edades, la mayoría de personas entonces serán personas jovenes, es probable que aparezcan edades negativas y por eso se usa el valor absoluto
  ubicacion<-paste( runif(n, -90, 90),runif(n,-180,180),sep = ","),##Acá se generan aleatoriamente valores de latitud y longitud, para generar su casa.
  sigue1,
  sigue2,
  viaje1<-paste( runif(n, -90, 90),runif(n,-180,180),sep = ","),##Acá se generan aleatoriamente valores de latitud y longitud, para generar un viaje.
  fechaviaje1<- sample(seq(inicio2021, final2021, by="days"), n,replace = T), ## Se usan fechas aleatorias de 2021
  viaje2<-paste( runif(n, -90, 90),runif(n,-180,180),sep = ","),
  fechaviaje2<- sample(seq(inicio2022, final2022, by="days"), n,replace = T) ## Se usan fechas aleatorias de 2022, solo para asegurarse de que una persona no haga dos viajes largos el mismo día.
)


names(df)<-c("ID","Nombre","Edad","Vive en","ID sigue1","ID sigue2","Coord. Viaje1","Fecha Viaje 1","Coord. Viaje2","Fecha Viaje 2") ### Se le da un nombre a cada columna de la tabla, para facilitar búsqueda más adelante.

setwd("C:/Users/danie/OneDrive/Cosas/Escritorio") ### Se elige donde se debe guardar el csv
write.csv(df,file = "datossimulados.csv") ### Se guarda el csv.