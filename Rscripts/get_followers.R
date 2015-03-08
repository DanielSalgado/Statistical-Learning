## Recibe el path a un RData file con el output de get_followers_ids()
## y el username (para nombrar los archivos y tablas guardadas)
get_followers <- function(user, ids_file, retryOnRateLimit = 1000){
  source("Rscripts/load_libraries.R")
  source("Rscripts/twitter_handshake.R")
  source("Rscripts/database_conection.R")
  twitter_handshake()
  load(ids_file) ## se carga con el nombre followers.ids
  ## son 100 usuarios por consulta
  ## son 180 consultas por 15m
  ## cada 15m puedo obtener 180*100 usuarios.
  ## cada 15m un chunck, 18,000 usuarios.
  chunks.number <- ceiling(length(followers.ids)/(180*100))+1
  ind <- seq(1,chunks.number*180*100, 180*100)
  
  for (i in 1:(length(ind)-1)){
    curr.ids <- followers.ids[ind[i]:ind[i+1]]
    curr.users <- lookupUsers(curr.ids, retryOnRateLimit = retryOnRateLimit)
    dir.create(paste0("data/",user))
    file.name <- paste0("data/", user, "/", "f",i, ".RData")
    save(curr.users, file = file.name)
    b <- store_users_db(curr.users, table = user)
    ifelse(b,
           print(paste0("Chunck ", i,  "guardado en db.")),
           print(paste0("Error al guardar chunck ", i, "en db."))
    )
    print(paste0("Data Chunck guardado con exito en: ", file.name))
  }
}

