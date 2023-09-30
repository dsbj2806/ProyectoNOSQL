n<-1000
nombre = sample(c("Alice", "Bob", "Carol","Carlos","Isaac","Nahomy","Fabricio","Daniel","Luffy"), n, replace = TRUE)
apellido1= sample(c("Jimenez", "Vargas", "Messi","Martinez","Cordero","Segura","Vilchez","Sibaja","D"), n, replace = TRUE)
apellido2= sample(c("Barboza", "Vargas", "Messi","Rodriguez","Alvarado","Badilla","Monge","Salazar","Monkey"), n, replace = TRUE)
# Generate a data frame with n rows and 3 columns
df <- data.frame(
  id = 1:n,
  edad = abs(round(rnorm(n, 30, 15))),
  nombre<-paste(nombre,apellido1,apellido2,sep = " "),
  ubicacion<-paste( runif(n, -90, 90),runif(n,-180,180),sep = ","),
  amigo1<-round(runif(n,1,n)),
  amigo2<-round(runif(n,1,n))
)

# Print the data frame
names(df)=c("ID","Edad","Nombre","Ubicacion","IDAmigo1","IDAmigo2")

summary(df$edad)

head(df)
df[df$Nombre=="Daniel Sibaja Salazar",]

setwd("C:/Users/danie/OneDrive/Cosas/Escritorio")
write.csv(df,file = "datosfalsos.csv")




