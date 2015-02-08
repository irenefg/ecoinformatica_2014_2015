#reto_3_p2.R

suma <- 0
a<-scan(n=10)
  umbral<-13
for(valor in a){
  if(valor>umbral){
    suma<-suma+1
  }
}
print(suma)


#reto_3_p1.R

multiplicacion<-1
a<-scan(n=5)
for(valor in a){
  multiplicacion<-multiplicacion*valor
}
print(multiplicacion)


#reto_3_p3.R

a<-scan(n=10)
mean(a)
print(mean)
