#Library
library(ggbiplot)
library(readr)
library(factoextra)

#Menginput Dataset ke R
data <- read.csv("C:/Users/ACER/Downloads/Compressed/CSGOcomplete.csv") 

#mengambil 50 data acak
datasample <- data[sample(nrow(data), 50),c(1:16) ]

#Membuang data yg ada string nya biar bisa di PCA
dataNum <- datasample[,c(6:16)]
#PCA pakai prcomp
data.pca <- prcomp(dataNum, center= TRUE, scale = TRUE)

#nampilin Biplot pakai data pca
bplot <- ggbiplot (data.pca,
                   choices = c(1,2),
                   obs.scale=1, var.scale = 1,
                   labels=datasample$Map,
                   varname.size = 4,
                   varname.abbrev = TRUE,
                   var.axes = TRUE,
                   circle = FALSE)
print(bplot)

