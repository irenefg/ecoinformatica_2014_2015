#reto_3_p4.R

library(raster)
library(rgdal)

setwd("~/ecoinformatica_2014_2015/sesion_3")

horas<- c("12","13","14","15")
valores<- c()

for(hora in horas){
imagenes<-list.files("./NDVI/ndvi",full.names = TRUE, pattern=hora)

imagen<-stack(imagenes)
media<-mean(imagen)

valores<- rbind(valores,mean(media[]))
}
plot(valores)

