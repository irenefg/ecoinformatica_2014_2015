#PRODUCTO 1:

library(Kendall)
library(raster)

#tendencia del robledal:

datos_ndvi<- read.csv("/home/irenefg/ecoinformatica_2014_2015/sesion_6/retos/producto_1/ndvi_robledal.csv", sep=";")

tendencia_ndvi<-data.frame()
tendencia_aux<-data.frame(iv_malla_modi_id=NA,tau_ndvi=NA,pvalor_ndvi=NA)
pixels<-unique(datos_ndvi$iv_malla_modi_id)
for(i in pixels){
  aux<-datos_ndvi[datos_ndvi$iv_malla_modi_id==i,]
  Kendall<-MannKendall(aux$ndvi_i)
  tendencia_aux$iv_malla_modi_id<-i
  tendencia_aux$tau_ndvi<-Kendall[[1]][1]
  tendencia_aux$pvalor_ndvi<-Kendall[[2]][1]
  tendencia_ndvi<-rbind(tendencia_ndvi,tendencia_aux)
}
head(tendencia_ndvi)

#tendencia de nieve:

datos_nieve<-read.csv("/home/irenefg/ecoinformatica_2014_2015/sesion_6/retos/producto_1/nieve_robledal.csv", sep=";")
tendencia_nieve<-data.frame()
tendencia_aux_nieve<-
  data.frame(nie_malla_modi_id=NA,tau_nieve=NA,pvalor_nieve=NA)
pixels<-unique(datos_nieve$nie_malla_modi_id)
for(i in pixels){
  aux<-datos_nieve[datos_nieve$nie_malla_modi_id==i,]
  Kendall<-MannKendall(aux$scd)
  tendencia_aux_nieve$nie_malla_modi_id<-i
  tendencia_aux_nieve$tau_nieve<-Kendall[[1]][1]
  tendencia_aux_nieve$pvalor_nieve<-Kendall[[2]][1]
  tendencia_nieve<-rbind(tendencia_nieve,tendencia_aux_nieve)
}
head(tendencia_nieve)


#tratar datos robledal:

datos_ndvi<- read.csv("/home/irenefg/ecoinformatica_2014_2015/sesion_6/retos/producto_1/ndvi_robledal.csv", sep=";")
library(plyr)

datos_nvdi<-datos_ndvi[,c(1,4,5)]
unique_datos_ndvi<-unique(datos_ndvi)
resultado_ndvi<-join(unique_datos_ndvi,tendencia_ndvi, by="iv_malla_modi_id")
head(resultado_ndvi)

#tratar datos nieve:

datos_nieve<-read.csv("/home/irenefg/ecoinformatica_2014_2015/sesion_6/retos/producto_1/nieve_robledal.csv", sep=";")

datos_nieve<-datos_nieve[,c(2,10,11)]
unique_datos_nieve<-unique(datos_nieve)
resultado_nieve<-join(unique_datos_nieve,tendencia_nieve, by="nie_malla_modi_id")
head(resultado_nieve)

#Hacer mapa robledal:

library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)

coordinates(resultado_ndvi) =~lng+lat
proj4string(resultado_ndvi)=CRS("+init=epsg:4326")
clases <- classIntervals(resultado_ndvi$tau_ndvi, n = 5)
plotclr <- rev(brewer.pal(5, "Spectral"))
colcode <- findColours(clases, plotclr)
pdf(file="pdf_robledal.pdf",height=8, width=10)
plot(resultado_ndvi, col=colcode, pch=19, cex = .6, main = "Mapa de tendencias en robledal")
legend("topright",legend=names(attr(colcode, "table")), fill=attr(colcode, "palette"), bty="n")
dev.off()

#Hacer mapa nieve:

coordinates(resultado_nieve) =~lng+lat
proj4string(resultado_nieve)=CRS("+init=epsg:4326")
clases <- classIntervals(resultado_nieve$tau_nieve, n = 5)
plotclr <- rev(brewer.pal(5, "Spectral"))
colcode <- findColours(clases, plotclr)
pdf(file="pdf_nieve.pdf",height=8, width=10)
plot(resultado_ndvi, col=colcode, pch=19, cex = .6, main = "Mapa de tendencias de nieve")
legend("topright",legend=names(attr(colcode, "table")), fill=attr(colcode, "palette"), bty="n")
dev.off()


