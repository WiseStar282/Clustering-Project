## Hierarchical Clustering
Hierarchical clustering adalah teknik clustering yang membentuk hirarki (dendrogram) atau berdasarkan tingkatan tertentu sehingga menyerupai struktur pohon. Dengan demikian proses pengelompokannya dilakukan secara bertingkat atau bertahap. Tujuannya untuk menunjukkan kemiripan antar data. Setiap data yang mirip akan memiliki hubungan hirarki yang dekat dan menbentuk cluster data. <br>
Pada clustering ini, metode pengelompokkan yang digunakan adalah
1. Single linkage
2. Complete linkage
3. Average linkage
</a>
Langkah-langkah:<br/>

Full kode R nya bisa diklik [disini](https://github.com/WiseStar282/Clustering-Project/tree/main/Hierarchical%20Clustering)

 **Menyiapkan Library dan Dataset**

```lua
#Library
library(cluster)
library(dendextend)
library(factoextra)
library(car)

#Menginput dataset
CSGOComplete <- read_csv("C:/Users/ACER/Downloads/Compressed/CSGOComplete.csv")
csgo <- CSGOComplete[c(1:40),]
csgob <- csgo[,c(6:16)]
```

|Dataset Counterstrike|Data Sample Bertipe Numerik|
|--|--|
|![dataset](https://user-images.githubusercontent.com/87527087/180655738-fef71c90-6f9a-4f73-9062-3a9e268c3b99.png)|![csgob](https://user-images.githubusercontent.com/87527087/180655742-7cd3dd4a-a6f6-48a3-a5b0-0396d905a863.png)|

**Menguji Multikolinearitas**

```lua
#Uji asumsi multikolinearitas
cor(csgob)
```
|Hasil Uji Multikolinearitas|
|--|
|![cor csgo](https://user-images.githubusercontent.com/87527087/180656064-b0d75f6c-ce69-4415-b4a1-5656965ad208.png)|
Dari output matriks korelasi data CSGO, terlihat bahwa nilai korelasi antar variabel berada di bawah 0.8 sehingga tidak ada multikolinearitas pada dataset ini.

**Menghitung matrix jarak Euclidian**
```lua
#Menghitung Jarak Antar Data
jarak <- dist(csgob)
```

**Membandingkan Nilai Korelasi Cophenetic Antar Metode Hirarki**

```lua
## Perbandingan korelasi antar metode hirarki
# Single Linkage
hc1 = hclust(jarak, 'single')
d1 = cophenetic(hc1)
cor.Single = cor(jarak, d1) 
cor.Single

# Average Linkage
hc2 = hclust(jarak,"ave")
d2 = cophenetic(hc2)
cor.ave = cor (jarak,d2)
cor.ave

# Complete Linkage
hc3 = hclust(jarak,"complete")
d3 = cophenetic(hc3)
cor.comp = cor (jarak,d3)
cor.comp
```
|Single Linkage|Average Linkage|Complete Linkage|
|--|--|--|
|![single](https://user-images.githubusercontent.com/87527087/180656402-56906bc4-5127-4bfa-bcfc-a799e986b9a7.png)|![average](https://user-images.githubusercontent.com/87527087/180656406-72edba60-3e10-4a0a-9ff1-888d973ecc8a.png)|![complete](https://user-images.githubusercontent.com/87527087/180656407-2d44796d-4c0d-4d41-a098-f222ae1c8b49.png)|

Metode yang memiliki korelasi cophenetic tertinggi (nilainya mendekati 1) adalah metode yang terbaik. Dari ketiga metode tersebut,metode **average linkage** adalah metode terbaik untuk dataset ini.

**Melakukan Hierarchical Clustering Dengan Metode Average Linkage

```lua
## Analisis cluster dgn hirarki average
hirarki.ave=hclust(jarak,method = "ave")
hirarki.ave
```

**Membuat Dendrogram Data**

```lua
# dendrogram
plot(hirarki.ave, labels = csgo$Map)
```
![dendogram](https://user-images.githubusercontent.com/87527087/180656785-7ae325a2-1d50-4017-87c8-a79d94b45c8a.png)

**Mencari Jumlah Cluster Yang Optimal Dengan Metode Silhouette**

```lua
#jumlah cluster yang optimal
fviz_nbclust(csgob, hcut, method = 'silhouette')
```
|Jumlah Cluster Optimal = 2|
|--|
| ![optimal cluster](https://user-images.githubusercontent.com/87527087/180656867-26b7940d-a3bd-46dc-b188-9af2883db37b.png)|

**Membagi Dendogram Kedalam Cluster**

```lua
#karena hasil optimal = 2, maka k = 2
plot(hirarki.ave, labels = csgo$Map)
rect.hclust(hirarki.ave, k = 2, border = 2:3)
```
![cluster dendogram](https://user-images.githubusercontent.com/87527087/180656899-7964ff09-f717-4fa7-bbed-0094a7a05b50.png)

**Melihat Anggota Masing-Masing Cluster**

```lua
## Anggota cluster
hasil.cut = cutree(hirarki.ave,2)
table(hasil.cut)

#melihat siapa saja anggota cluster
row.names(csgob) [hasil.cut == 1]
labels=csgo$Map [hasil.cut == 1] ; labels
row.names(csgob) [hasil.cut == 2]
labels=csgo$Map [hasil.cut == 2] ; labels
```
|Jumlah Anggota Cluster|
|--|
|![anggota cluster](https://user-images.githubusercontent.com/87527087/180657090-12d4ad12-1db2-4afc-a094-df23281c80da.png)|
Cluster 1 berjumlah 24 dan cluster 2 berjumlah 16

|Anggota Cluster 1|Anggota Cluster 2|
|--|--|
|![cluster1](https://user-images.githubusercontent.com/87527087/180657083-b1708969-a61b-4b50-b7d5-7d094a506ffd.png)|![cluster2](https://user-images.githubusercontent.com/87527087/180657085-fc145e5b-ab64-4230-9a79-438fd3f57b3f.png)| 

**Pembahasan**
<p align="justify">Berdasarkan dataset ini, dari ketiga teknik agglomerative, ternyata teknik average linkage adalah
teknik agglomerative terbaik untuk data CSGO karena memiliki nilai korelasi cophenetic tertinggi
yaitu 0.7178595 sehingga analisis cluster pada data CSGO menggunakan teknik average linkage.
Jumlah kluster yang diperlukan cukup 2 saja karena dengan 2 klustering sudah terlihat variasi
antara cluster 1 dan cluster 2. Cluster 1 memiliki anggota yang lebih banyak yaitu sebanyak 24
map (dalam CSGO) dan cluster 2 sebanyak 16 map dengan nama map terbanyak yaitu Mirage </p>

[Homepage](https://github.com/WiseStar282/Clustering-Project)
