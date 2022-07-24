#Library
library(cluster)
library(dendextend)
library(factoextra)
library(car)

#menginput dataset
CSGOComplete <- read_csv("C:/Users/ACER/Downloads/Compressed/CSGOComplete.csv")
csgo <- CSGOComplete[c(1:40),]
csgob <- csgo[,c(6:16)]

# Uji asumsi multikolinearitas
cor(csgob)

#Menghitung jarak antar data
jarak <- dist(csgob)

## Perbandingan korelasi antar metode hirarki
# Single
hc1 = hclust(jarak, 'single')
d1 = cophenetic(hc1)
cor.Single = cor(jarak, d1) 
cor.Single
# Average
hc2 = hclust(jarak,"ave")
d2 = cophenetic(hc2)
cor.ave = cor (jarak,d2)
cor.ave
# Complete
hc3 = hclust(jarak,"complete")
d3 = cophenetic(hc3)
cor.comp = cor (jarak,d3)
cor.comp

## Analisis cluster dgn hirarki average
hirarki.ave=hclust(jarak,method = "ave")
hirarki.ave

# dendrogram
plot(hirarki.ave, labels = csgo$Map)

#jumlah cluster yang optimal
fviz_nbclust(csgob, hcut, method = 'silhouette')
#karena hasil optimal = 2, maka k = 2
plot(hirarki.ave, labels = csgo$Map)
rect.hclust(hirarki.ave, k = 2, border = 2:3)

## Anggota cluster
hasil.cut = cutree(hirarki.ave,2)
table(hasil.cut)

#melihat siapa saja anggota cluster
row.names(csgob) [hasil.cut == 1]
labels=csgo$Map [hasil.cut == 1] ; labels
row.names(csgob) [hasil.cut == 2]
labels=csgo$Map [hasil.cut == 2] ; labels
