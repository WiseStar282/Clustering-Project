# Clustering-Project-With-R Studio
Melakukan projek sederhana tentang clustering dan analisis biplot menggunakan software R Studio
# Dataset
Dataset berjudul _CounterStrike: Match statistics for Counter Strike Global Offensive._
<br>Dataset ini diambil dari kaggle dan dapat diakses pada link: https://www.kaggle.com/datasets/thesiff/counterstrike
## A. Analisis Biplot
Menurut Sartono dkk, Biplot adalah salah satu upaya menggambarkan data-data yang ada pada tabel ringkasan dalam grafik berdimensi dua. 
Informasi yang diberikan oleh biplot mencakup objek dan peubah dalam satu gambar.
<br>Analisis biplot dapat memberikan informasi berupa: 
  1. Korelasi antar peubah
  2. Keberagaman Peubah
  3. Kedekatan antar objek yang diamati 
 <a/>
 Langkah-langkah:
 
```diff
#Menginput Dataset ke R
data <- read.csv("C:/Users/ACER/Downloads/Compressed/CSGOcomplete.csv") 

#mengambil 50 data acak
baru <- data[sample(nrow(data), 50), ]
databaru <- data[c(1,7,12,96,124,161,409,581,788,913,
               1095,515,746,44,579,882,230,616,966,311,
               981,924,872,68,1092,91,647,105,917,768,
               710,193,1111,395,1000,971,332,685,345,984,305,161,
              427,1040,314,587,146,660,396,430),c(1:16)]

#Membuang data yg ada string nya biar bisa di PCA
datasample <- databaru[,c(6:16)]
#PCA pakai prcomp
data.pca <- prcomp(datasample, center= TRUE, scale = TRUE)

#nampilin Biplot pakai data pca
bplot <- ggbiplot (data.pca,
                  choices = c(1,2),
                  obs.scale=1, var.scale = 1,
                  labels=baru$Map,
                  varname.size = 4,
                  varname.abbrev = TRUE,
                  var.axes = TRUE,
                  circle = FALSE)
print(bplot)

```
