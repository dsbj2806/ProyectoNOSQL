n<-2000
nombre = sample(c("Alice", "Bob", "Carol","Carlos","Isaac","Nahomy","Fabricio","Daniel","Luffy","Francisco","Yarlin","Miriam","Steyfell"), n, replace = TRUE)
apellido1= sample(c("Jimenez", "Vargas", "Messi","Martinez","Cordero","Segura","Vilchez","Sibaja","D","Calderon","Vargas","Calvo","Smith"), n, replace = TRUE)
apellido2= sample(c("Barboza", "Vargas", "Messi","Rodriguez","Alvarado","Badilla","Monge","Salazar","Monkey","Fonseca","Valverde","Alfaro","Morgan"), n, replace = TRUE)
id = 1:n
amigo1<-NULL
amigo2<-NULL
for (i in 1:n) {
  posible1<-setdiff(id,i)
  amigo1<-c(amigo1,sample(posible1,1))
  posible2<-setdiff(id,c(i,amigo2))
  amigo2<-c(amigo2,sample(posible2,1))
}
inicio2021<- as.Date("2021-01-01")
final2021 <- as.Date("2021-12-31")
inicio2022<- as.Date("2022-01-01")
final2022 <- as.Date("2022-12-31")

# Generar data frame
df <- data.frame(
  id,
  nombre<-paste(nombre,apellido1,apellido2,sep = " "),
  edad = abs(round(rnorm(n, 30, 10))),
  ubicacion<-paste( runif(n, -90, 90),runif(n,-180,180),sep = ","),
  amigo1,
  amigo2,
  viaje1<-paste( runif(n, -90, 90),runif(n,-180,180),sep = ","),
  fechaviaje1<- sample(seq(inicio2021, final2021, by="days"), n,replace = T),
  viaje2<-paste( runif(n, -90, 90),runif(n,-180,180),sep = ","),
  fechaviaje2<- sample(seq(inicio2022, final2022, by="days"), n,replace = T)
)


names(df)<-c("ID","Nombre","Edad","Vive en","ID amigo1","ID amigo2","Coord. Viaje1","Fecha Viaje 1","Coord. Viaje2","Fecha Viaje 2")









setwd("C:/Users/danie/OneDrive/Cosas/Escritorio")
write.csv(df,file = "datosfalsos.csv")