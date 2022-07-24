## Analisis Biplot
Menurut Sartono dkk, Biplot adalah salah satu upaya menggambarkan data-data yang ada pada tabel ringkasan dalam grafik berdimensi dua. 
Informasi yang diberikan oleh biplot mencakup objek dan peubah dalam satu gambar.
<br>Analisis biplot dapat memberikan informasi berupa: 
  1. Korelasi antar peubah
  2. Keberagaman Peubah
  3. Kemiripan antar objek yang diamati 
 <a/>
 Langkah-langkah:<br>
 
 Full kode R bisa dilihat [disini](https://github.com/WiseStar282/Clustering-Project/blob/main/Analisis%20Biplot/CodeR_Analisis%20Biplot.R )
 
 **Menyiapkan Library dan Dataset**
 
```lua
#Library
library(factoextra)
library(ggbiplot)

#Menginput Dataset ke R
data <- read.csv("C:/Users/ACER/Downloads/Compressed/CSGOcomplete.csv") 

#Mengambil 50 data acak
databaru <- data[sample(nrow(data), 50), ]

#Membuat variabel baru tanpa kolom data non-numerik agar bisa di PCA
datasample <- databaru[,c(6:16)]
```
|Dataset counterstrike|Sample 50 Data Acak|Kolom Numerik|
|---|----|---|
|![dataset counter strike look](https://user-images.githubusercontent.com/87527087/180614604-ab040fbd-eb6a-472e-8dd0-048332116c2b.png)|![50 data acak](https://user-images.githubusercontent.com/87527087/180614944-a13cef7d-04ed-4bdd-9d67-ffa290157e03.png)|![dataNumerik](https://user-images.githubusercontent.com/87527087/180615073-75906f03-d56f-4ccf-9a56-c38643693632.png)|

**Melakukan PCA**

```lua
#Melakukan PCA dengan function prcomp
data.pca <- prcomp(datasample, center= TRUE, scale = TRUE)
```

**Membuat Grafik Biplot**

```lua
#Membuat grafik biplot
bplot <- ggbiplot (data.pca,
                  choices = c(1,2),
                  obs.scale=1, var.scale = 1,
                  labels=baru$Map,
                  varname.size = 4,
                  varname.abbrev = TRUE,
                  var.axes = TRUE,
                  circle = FALSE)
#Menampilkan hasil biplot
print(bplot)
```

**Hasil Gambar Biplot** <br>

![hasil biplot](https://user-images.githubusercontent.com/87527087/180615220-57c6f3b8-94ba-48ab-81ad-bfad24ba2175.png)

## **Hasil Interpretasi**
**1. Korelasi Antar Peubah**
>Tingkat korelasi tiap variabel dapat dilihat berdasarkan sudut yang terbentuk antara vektor
peubah. Semakin kecil sudut atau semakin lancip sudut yang terbentuk, maka semakin
positif tinggi korelasinya. Jika besar sudut melewati 90º atau semakin tumpul, maka
korelasi antara variable akan semakin kecil/negative.</br>
Berdasarkan gambar diatas, dapat dilihat ada peubah yang memiliki korelasi paling tinggi
yaitu
>1. Mvp,Wait Time dengan Ping.
>2. Assist dengan Team B Round

>Selain itu, ada juga yang memiliki korelasi tinggi tapi tidak setinggi yang sebelumnya yaitu
>1. Points, Kills dengan Mvp
>2. Team A Round dengan HS
>3. Match Time dengan Death <br/>

>Adapun peubah yang memiliki korelasi yang kecil adalah:
>1. Mvp dengan Death
>2. HS dengan Mvp
>3. Team A Round dan Mvp

**2. Variasi Peubah**
>Variasi peubah dapat dilihat dari panjangnya vektor peubah pada biplot. Dari gambar biplot diatas dapat
diketahui bahwa tiap peubah memiliki panjang vektor yang cukup bervariasi. Jika lihat
secara keseluruhan, peubah yang memiliki keragaman/variasi terkecil adalah **Ping** karena
memiliki panjang vector terpendek.Peubah **Points**, **Kills** dan **Mvp** memiliki keragaman
yang paling tinggi karena panjang vektornya yang paling besar.

**3. Kemiripan Objek yang Diamati**
>Kemiripan obyek dapat dilihat dari jarak antara kedua objek dalam biplot. Semakin dekat
jarak antar objek, maka semakin mirip objek tersebut. Dari biplot diatas dapat kita lihat
kemiripan antar beberapa objek, yaitu:
>1. Mirage, Cache, Dust II dengan peubah terkait yaitu **Deaths** dan **Team A Round**
>2. Mirage, Austria, Mirage dengan peubah yang terkait yaitu **Match Time**
>3. Canals, Dust II, Dust II dengan peubah yang terkait yaitu **Assis**t dan **Team B Round**
<a/>

[Homepage](https://github.com/WiseStar282/Clustering-Project) <br>
[Kmeans Clustering](https://github.com/WiseStar282/Clustering-Project/blob/main/K-MeansClust.md)
