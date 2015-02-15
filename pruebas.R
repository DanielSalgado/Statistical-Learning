#########################################
#### Script de pruebas para la tesis ####
#########################################

##### Unsupervised learning #####

#### Kmeans ####
##Ejemplo del libro An introduction to Statistival Learning
set.seed(2)
#Creamos los datos dummy
x <- matrix(rnorm(50*2), ncol = 2) 
x[1:25, 1] <- x[1:25, 1] + 3
x[1:25, 2] <- x[1:25, 2] - 4
#k-means con k=2
km.out <- kmeans(x,2,nstart=20)
plot(x, col = (km.out$cluster + 2), 
     main = "K-Means Clustering Results with K=2",
     xlab = "", ylab = "", pch=20, cex=2)
#k-means con k=3
set.seed(4)
km.out=kmeans(x,3,nstart=20)
km.out
plot(x, col = (km.out$cluster + 1),
     main = "K-Means Clustering Results with K=3",
     xlab="", ylab="",pch=20, cex=2)
# la variable nstart en kmeans indica el numero de veces que se 
# seleccionaran de manera aleatoria los centros, 
# kmeans regresa el que tiene menor 
# tot.withinss (total sum of squares betweet clusters)
set.seed(3)
km.out <- kmeans(x,3,nstart=1)
km.out$tot.withinss
km.out <- kmeans(x,3,nstart=20)
km.out$tot.withinss

# Notas de Dan:
# kmeans regresa automaticamente los mejores resultados de
# los nstart intentos, podemos hacer una funcion que pruebe con
# distintos valores de k y regrese el de mejores resultados.


# descripcion: Esta funcion corre el algoritmo kmeans para distintas k's
# input: Datos y Numero maximo de k's
# output: kmeans output con los mejores resultados
bestKmeans <- function(X, N){
  ks <- seq(1,N,1) #vector de k's
  outputs <- c() #aqui almacenaremos los outputs para cada valor de k
  tot.withinss.v <- c()
  for (i in 1:N){
    #outputs <- c(outputs, kmeans(X, i, nstart = 50)) #esta creando una lista con todos los elementos (27 si k =3), arreglar
    output <- kmeans(X,i,nstart=50)
    tot.withinss.v <- c(tot.withinss.v, output$tot.withinss)
    print(paste0("intentando con ", i, " queda tot.withinss de: ", output$tot.withinss))
  }
  return(3)
}

## hallasgoz: entre mas grande sea K, el tot.withinss disminuye
