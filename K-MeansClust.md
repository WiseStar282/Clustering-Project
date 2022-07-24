## K-Means Clustering
K-means clustering merupakan salah satu metode cluster analysis non hirarki yang berusaha untuk mempartisi objek yang ada kedalam satu atau lebih cluster atau kelompok objek berdasarkan karakteristiknya, sehingga objek yang mempunyai karakteristik yang sama dikelompokan dalam satu cluster yang sama dan objek yang mempunyai karakteristik yang berbeda dikelompokan kedalam cluster yang lain.

Langkah-langkah:
```lua
#Menginput Dataset ke R
data <- read.csv("C:/Users/ACER/Downloads/Compressed/CSGOcomplete.csv", row.names = NULL)

# Set kolom pertama menjadi nama baris
baru <- data[,-1] # Menghapus kolom pertama
rownames(baru) <- make.names(data$Map, unique = TRUE)

#Mengambil 50 data acak
databaru <- baru[sample(nrow(data), 50),c(6:15)]

#Mencari Jumlah Clustering Optimal Dengan Metode Silhouette
fviz_nbclust(databaru, kmeans, method = "silhouette")

#Kmeans Tanpa di PCA dengan k=2
kmeans.awal <- kmeans(databaru,2)
kmeans.awal

#Gambar Plot Kmeans Sebelum di PCA
plot(databaru[c("Assists", "Deaths")], col=
       kmeans.awal$cluster, main = "Kmeans Sebelum PCA" )
points(kmeans.awal$centers[,c("Assists", "Deaths")],
       col= 1:2, pch = 8, cex =2)

#Gambar Plot clustering Kmeans Sebelum di PCA
fviz_cluster(kmeans.awal, databaru)

#Kmeans Setelah di PCA
data.pca <- prcomp(databaru, center = TRUE, scale = TRUE)
df.pca <- as.data.frame(data.pca$x[,1:2])
kmeans2 <- kmeans(df.pca,2)
kmeans2

#Gambar Plot Kmeans k=2 Setelah di PCA
plot (df.pca[c("PC1", "PC2")], col= kmeans2$cluster)
points(kmeans2$centers[,c("PC1", "PC2")], col= 1:2, pch = 8, cex = 2)

#Gambar Plot clustering Kmeans Setelah di PCA
fviz_cluster(kmeans2, databaru)
```
**Hasil:**
|Dataset Counterstrike|Mengambil 50 Data Sampel Bertipe Numerik|
|--|--|
| ![dataset counterstrike](https://user-images.githubusercontent.com/87527087/180640072-3d3388f6-957a-4b25-a3ad-95a7cb24b46e.png)| ![50 data numerik](https://user-images.githubusercontent.com/87527087/180640073-b7093b3d-fdc0-4c8b-9503-9bec7a7a3538.png)|

|Jumlah Cluster Optimal Dengan Metode Silhoutte|
|--|
|![optimal cluster](https://user-images.githubusercontent.com/87527087/180640097-12b8355b-ece2-4534-9c03-d405c58ef6d4.png) |
Jumlah cluster optimal = 2. Sehingga k pada kmeans adalah 2.

**Hasil Perhitungan Kmeans Clustering**
|Sebelum PCA|Setelah PCA|
|--|--|
|![kmeans awal](https://user-images.githubusercontent.com/87527087/180640691-3326d97d-b0fa-469c-afe4-a9cafd94a590.png)| ![kmeans2](https://user-images.githubusercontent.com/87527087/180641019-3aa56341-a06a-4289-9131-6eb5bb781aa5.png)|
Nilai within-cluster sum of squares = 66.5% |Nilai within-cluster sum of squares = 38.9%

**Gambar Plot Kmeans Clustering <br/>**
|Sebelum PCA|Setelah PCA|
|--|--|
|![plot kmeans awal](https://user-images.githubusercontent.com/87527087/180640693-f4db0294-8ada-49c3-a2e3-8a5bc8f5076f.png) |![plot kmeans2](https://user-images.githubusercontent.com/87527087/180641006-3ebf7ea2-b157-4d4f-9397-ba430c906e5c.png)|
|![plot fvr awal](https://user-images.githubusercontent.com/87527087/180641216-8a5719e2-7319-4a30-ad30-fa8c82fb3ab6.png)|![plot fvr pca](https://user-images.githubusercontent.com/87527087/180641222-e7a30c00-5c87-4e34-b27f-ef582565562e.png)|

**Hasil Interpretasi:**
<p align='justify'> &emsp;&emsp;&emsp;Berdasarkan gambar diatas, jumlah clustering yang dibutuhkan cukup 2 saja karena sudah memperlihatkan perbedaan antar cluster. Pada kmeans sebelum PCA, jumlah objek clusternya atau <em>size</em> adalah 18 untuk cluster 1 dan 32 untuk cluster 2. Sedangkan pada kmeans setelah PCA, <em>size-nya</em> adalah 39 untuk cluster 1 dan 11 untuk cluster 2. Kemudian dapat dilihat nilai Within cluster ss(<em>sum of square</em>) kmeans setelah PCA lebih kecil daripada sebelum PCA. Nilai within cluster ss adalah ukuran variabilitas pengamatan dalam setiap cluster. Secara umum, cluster yang memiliki jumlah kuadrat kecil lebih <em>compact</em> daripada cluster yang memiliki jumlah kuadrat besar. Cluster yang memiliki nilai lebih tinggi menunjukkan variabilitas pengamatan yang lebih besar di dalam cluster. Umumnya ketika melakukan clustering, nilai within cluster ss nya harus dibuat sekecil-kecilnya agar variabilitas(heterogenitas) didalam cluster itu semakin kecil. Cluster yang baik adalah cluster yang homogenitas (kesamaan) yang tinggi antar anggota dalam satu cluster (within-cluster) dan heterogenitas (perbedaan) yang tinggi antar cluster yang satu dengan cluster yang lainnya (between-cluster). <br>
&emsp;&emsp;&emsp;Pada gambar plotting hasil kmeans clustering, meski keduanya sama-sama menggunakan k=2, kmeans clustering setelah PCA lebih terlihat jelas perbedaan antara masing-masing cluster dibandingkan sebelum PCA yang mana bisa dilihat kurang jelas suatu objek itu termasuk cluster 1 atau cluster 2.
Sehingga dapat disimpulkan bahwa hasil k-means clustering akan lebih baik setelah dilakukan proses PCA (<em>Principal Component Analysis</em>)
</p>
       
