## ---- inicial_setup
twitter_setip <- function(){
  source("Rscripts/load_libraries.R")
  source("Rscripts/twitter_handshake.R")
  source("Rscripts/database_conection.R")
  twitter_handshake()
}

## ---- get_followers_ids
get_followers_ids <- function(username, r = 1000){
  user <- getUser(username)
  followers_ids <- user$getFollowerIDs(retryOnRateLimit = r)
  followers_ids
}

## ---- store_followers_ids
store_folowers_ids <- function(username, followers_ids){
  file_name <- paste0("data/", username, "_fwids.RData")
  ms <- paste0("Followers ids guardadas en ", 
               "data/", username, "_fwids.RData")
  print(ms) ## manda el mensaje aunque falle al guardar, corregir.
  save(followers_ids, file = file_name) 
}

## ---- load_followers_ids
load_followers_ids <- function(ids_file){
  load(ids_file) ## se carga con el nombre followers_ids
}


## son 100 usuarios por consulta
## , 180 consultas por 15m.
## Cada 15m se puede obtener 180*100 usuarios (un chunck)
## ---- get_followers
get_followers <- function(user, followers_ids, r = 1000){
  chunks_n <- ceiling(length(followers_ids)/(180*100))+1
  indices <- seq(1,chunks_n*180*100, 180*100)
  
  for (i in 1:(length(indices)-1)){
    curr_ids <- followers_ids[indices[i]:indices[i+1]]
    curr_users <- lookupUsers(curr_ids, retryOnRateLimit = r)
    dir.create(paste0("data/", user))
    file_name <- paste0("data/", user, "/", "f", i, ".RData")
    save(curr_users, file = file_name)
    store_users_db(curr_users, table = user)
  }
}


## ---- otros
