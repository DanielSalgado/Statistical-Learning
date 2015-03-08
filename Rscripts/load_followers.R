## Este script carga los datos guardados de los ff de coca
files <- paste0("data/",list.files("data/")[grep("ccf*", list.files("data/"))])
source("Rscripts/load_libraries.R")

file_to_df <- function(file){
  load(file)
  return (twListToDF(curr.users))
}

system.time(data.frames <- lapply(files, file_to_df))
system.time(df <- do.call("rbind", data.frames))


sample.size <- 16000
set.seed(1234)
sample <- df[sample(nrow(df), sample.size), ]
system.time(save(sample, file = "data/df_ccf_sample.RData"))
system.time(save(df, file = "data/df_ccf.RData"))
