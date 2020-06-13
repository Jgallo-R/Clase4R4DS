#### Ejemplos : Series economicas ####
rm(list =ls())
setwd("C:/Users/JGALLO/Desktop/Clase4R4DS/")
getwd()
dir()

# Precios de un articulo : Oro

Oro <- read.csv("GOLDAMGBD228NLBM.csv.txt", na.strings = ".")## elpunto representa el caracter NA

# Modifiquemos los nombres de las varibales :
colnames(Oro) <- c("Fecha", "Precio")

# Estructura del data frame:
str(Oro)

#### Limpiar el data frame ####
#Veamos la existencia de NA en la columna Precio
sum(is.na(Oro$Precio)) 

# Limpiamos los NA
Oro <- na.omit(Oro)

# Convertimos las variables fecha a tipo date
Oro$Fecha <- as.Date(Oro$Fecha)
str(Oro)

#### Agregamos columna con informacion secundaria ####
# Pensando en lo que haremos mas adelante
View(Oro$Fecha)

# Agregamos la columna con el dia de la semana
Oro$dia <- weekdays(Oro$Fecha)
View(Oro)

# Agregamos la columna con el mes
Oro$mes <- months(Oro$Fecha)

# Agregamos la columna año
library(lubridate)
library(help = "lubridate")
  
Oro$año <- year(Oro$Fecha)

# Agreguemos una columna con el dia pero en numero
Oro$NumDia <- day(Oro$Fecha)

# Agreguemos una columna con la decada a la cual pertenece la data : usaremos Dplyr
library(dplyr)
floor_decade <- function(value){
  return(value - value%%10)
}
Oro <- mutate(.data = Oro, decada = floor_decade(Oro$año))

# Veamos finalmente la estructura de mi data frame
str(Oro)

#### Graficos de dispersion ####

# Diagrama de dispersion de DF en toda la linea del tiempo
head(Oro, n = 1)$Fecha      # Primer dia 
tail(Oro, n = 1)$Fecha     # Ultimo dia

# Usando la libreria graphics
# Escribamos en la etiqueta del eje x la venta del tiempo

plot(x = Oro$Fecha, y = Oro$Precio, type = "l",
     xlab = paste("Fecha[", head(Oro, n = 1)$Fecha, "-", tail(Oro, n = 1)$Fecha, "]" ),
     ylab = "Precio [USD]",
     main = "Precio del Oro [GOLDAMGBD228NLBM]",
     sub = "Fuente ; https://fred.stlouisfed.org")

dev.off()

# Hagamos la grafica en ggplot2
library(ggplot2)
ggplot(data = Oro, mapping = aes(x = Fecha, y = Precio))+
  geom_line()+
  xlab(paste("Fecha[", head(Oro, n = 1)$Fecha, "-", tail(Oro, n = 1)$Fecha, "]" ))+
  ylab("Precio [USD]")+
  ggtitle("Precio del Oro [GOLDAMGBD228NLBM]")+
  labs(subtitle = "Fuente ; https://fred.stlouisfed.org",
       caption = "Clase 4:CTIC-UNI")

























