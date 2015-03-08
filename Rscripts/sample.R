## Data manipulation. user only
load("data/df_ccf_sample.RData")
row.names(sample) <- NULL
sample$accountAge <- as.integer(difftime(Sys.time() , sample$created, units = "days"))
sample$ffRatio <- sample$followersCount / sample$friendsCount
sample$statusesDensity <- sample$statusesCount / sample$accountAge
sample$protected <- as.integer(sample$protected)
sample$charDate <- as.character.Date(sample[,"created"], format = "%d/%m/%Y")

string_col <- c( "screenName", "name", "charDate", "lang")
num_col <- names(sample)[sapply(sample,is.numeric)]
#Columnas con datos de la relacion de un usuario con otros
rel_col <- c("followersCount", "friendsCount", "listedCount")
#Columnas con datos de su actividad en la plataforma
act_col <- c("statusesCount", "favoritesCount", "protected")
#Columnas con datos derivados de otras
extra_col <- c("accountAge", "ffRatio", "statusesDensity")

df <- sample[,sapply(sample,is.numeric)]
df <- df[!is.na(df$ffRatio),]


# 
# k = 3
# km.out <- kmeans(df, k, nstart=20)
# 
# plot(df$followersCount, df$friendsCount, col = (km.out$cluster + 2),
#      xlab = "FollowersCount", ylab = "FriendsCount",
#      main = "K-Means Clustering Results with K=2", pch=20, cex=2)
# 
# plot(log(df$followersCount), log(df$friendsCount), col = (km.out$cluster + 2),
#      xlab = "FollowersCount", ylab = "FriendsCount",
#      main = "K-Means Clustering Results with K=2", pch=20, cex=2)
# 
# 
# 
