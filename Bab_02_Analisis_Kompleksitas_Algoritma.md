# BAB 2
# ANALISIS KOMPLEKSITAS ALGORITMA

---

> *"The analysis of algorithms is the theoretical study of computer program performance and resource usage. The most important resource is usually time... But efficiency in terms of time is not the only important measure of an algorithm."*
>
> -- Thomas H. Cormen, dkk., *Introduction to Algorithms*, edisi ketiga

---

## Tujuan Pembelajaran

Setelah mempelajari bab ini secara tuntas, mahasiswa diharapkan mampu:

1. **[C2 - Memahami]** Menjelaskan konsep analisis asimtotik dan alasan mengapa pendekatan ini lebih disukai dibanding pengukuran empiris sederhana dalam mengevaluasi efisiensi algoritma.
2. **[C2 - Memahami]** Mendefinisikan dan menginterpretasikan notasi Big-O, Big-Omega (Omega), dan Big-Theta (Theta) beserta definisi formalnya berdasarkan konstanta batas c dan nilai ambang n0.
3. **[C3 - Menerapkan]** Membuktikan secara formal bahwa suatu fungsi T(n) termasuk dalam kelas notasi asimtotik tertentu dengan menemukan nilai konstanta c dan n0 yang memenuhi syarat.
4. **[C4 - Menganalisis]** Menghitung fungsi kompleksitas waktu T(n) algoritma iteratif maupun rekursif secara step-by-step dengan menghitung frekuensi eksekusi tiap pernyataan.
5. **[C4 - Menganalisis]** Membedakan analisis kasus terbaik (*best case*), kasus terburuk (*worst case*), dan kasus rata-rata (*average case*) dari algoritma yang sama, serta menjelaskan relevansi praktis masing-masing.
6. **[C4 - Menganalisis]** Membandingkan efisiensi relatif berbagai algoritma berdasarkan kelas kompleksitasnya dan menentukan algoritma yang tepat untuk ukuran input yang diberikan.
7. **[C3 - Menerapkan]** Mengimplementasikan kode Python untuk mengukur kompleksitas waktu algoritma secara empiris dan menginterpretasikan hasilnya untuk mengonfirmasi analisis teoritis.
8. **[C5 - Mengevaluasi]** Menilai pertukaran (*trade-off*) antara kompleksitas waktu dan kompleksitas ruang dalam konteks perancangan solusi algoritmik.

---

## 2.1 Pendahuluan: Mengapa Efisiensi Algoritma Menentukan Segalanya

Bayangkan dua arsitek merancang jembatan di atas sungai yang sama. Keduanya menghasilkan jembatan yang kokoh dan dapat dilalui kendaraan. Namun, satu arsitek menggunakan bahan dua kali lebih banyak dan waktu pembangunan tiga kali lebih lama. Dalam dunia rekayasa, perbedaan semacam ini bukan sekadar soal preferensi estetis -- ia berdampak langsung pada biaya, waktu, dan kelayakan proyek. Demikian pula dalam ilmu komputer, dua algoritma yang menghasilkan jawaban benar yang identik tetap dapat berbeda secara drastis dalam hal sumber daya yang mereka konsumsi.

Pertimbangkan sebuah masalah konkret. Sebuah platform e-commerce menyimpan katalog produk yang terus berkembang. Pada fase awal dengan 1.000 produk, algoritma pencarian apa pun terasa cepat karena perbedaan antaralgoritma nyaris tidak terasa oleh pengguna. Namun ketika katalog tumbuh menjadi 10 juta produk -- angka yang sangat realistis untuk platform besar -- pilihan algoritma menjadi penentu apakah sistem tersebut dapat merespons dalam hitungan milidetik atau justru membuat pengguna menunggu selama beberapa menit. Pada 100 juta produk, algoritma yang salah tidak hanya membuat sistem lambat; ia bisa membuat sistem sama sekali tidak dapat beroperasi.

Inilah esensi dari analisis kompleksitas algoritma: memberikan kerangka matematis yang memungkinkan kita memprediksi perilaku algoritma sebelum kita membangun sistem, jauh sebelum kita memiliki 100 juta data yang nyata. Dengan alat analisis yang tepat, seorang insinyur perangkat lunak dapat membuat keputusan desain yang terinformasi sejak tahap perancangan, bukan setelah sistem sudah berjalan dan masalah kinerja sudah muncul di produksi.

Bab ini membangun fondasi analitis yang diperlukan untuk memahami semua struktur data dan algoritma yang akan dipelajari dalam buku ini. Dimulai dari motivasi kuantitatif tentang mengapa efisiensi penting, dilanjutkan dengan sistem notasi matematis yang menjadi bahasa universal komunitas ilmuwan komputer, kemudian menyelami teknik analisis manual yang rinci, dan diakhiri dengan cara memverifikasi analisis teoritis melalui pengukuran empiris menggunakan Python.

---

## 2.2 Pertumbuhan Fungsi: Intuisi Kuantitatif

Sebelum memperkenalkan formalisme matematis, penting untuk membangun intuisi yang kuat tentang seberapa dramatis perbedaan perilaku algoritma dengan kelas kompleksitas yang berbeda.

### 2.2.1 Ilustrasi Divergensi Pertumbuhan

Misalkan kita memiliki dua algoritma yang menyelesaikan masalah pencarian. Algoritma A menggunakan strategi brute-force dengan kompleksitas n^2 operasi, sedangkan Algoritma B menggunakan strategi yang lebih cerdas dengan kompleksitas n log2(n) operasi. Pada input kecil, perbedaannya mungkin tidak berarti. Namun perhatikan bagaimana keduanya berperilaku seiring pertumbuhan n, yang dirangkum dalam Tabel 2.1 berikut.

**Tabel 2.1** Perbandingan Pertumbuhan n log2(n) versus n^2

```
+----------+----------------+--------------------+------------------------------+
|    n     |  n * log2(n)   |        n^2         |  Rasio n^2 / (n log2 n)      |
+----------+----------------+--------------------+------------------------------+
|       10 |             33 |                100 |  ~ 3 kali                    |
|      100 |            664 |             10.000 |  ~ 15 kali                   |
|    1.000 |          9.966 |          1.000.000 |  ~ 100 kali                  |
|   10.000 |        132.877 |        100.000.000 |  ~ 753 kali                  |
|  100.000 |      1.660.964 |     10.000.000.000 |  ~ 6.022 kali                |
|1.000.000 |     19.931.568 |    10^12           |  ~ 50.168 kali               |
+----------+----------------+--------------------+------------------------------+
```

Angka-angka dalam Tabel 2.1 menjadi nyata jika kita mengasumsikan komputer modern yang mampu melakukan satu miliar (10^9) operasi per detik. Untuk n = 1.000.000, Algoritma B (n log n) menyelesaikan tugasnya dalam sekitar 0,02 detik -- hampir tidak terasa. Algoritma A (n^2), sebaliknya, membutuhkan sekitar 16,67 menit. Bukan perbedaan yang dapat diabaikan. Untuk n = 10^9 (satu miliar), Algoritma B masih selesai dalam sekitar setengah menit, sedangkan Algoritma A akan membutuhkan lebih dari 31 tahun.

Perbedaan ini bukan soal perangkat keras yang lebih cepat atau bahasa pemrograman yang lebih efisien. Bahkan jika kita memasang CPU yang 1.000 kali lebih cepat, Algoritma A untuk n = 10^9 masih akan membutuhkan waktu sekitar 11 hari. Satu-satunya jalan keluar yang sesungguhnya adalah memilih algoritma dengan kelas kompleksitas yang lebih baik.

### 2.2.2 Keterbatasan Pengukuran Empiris Semata

Setelah melihat betapa dramatisnya perbedaan pertumbuhan fungsi kompleksitas, seseorang mungkin masih berpendapat bahwa solusi praktis adalah dengan sekadar mengukur waktu eksekusi program secara langsung untuk berbagai ukuran input. Pendekatan ini, meski berguna sebagai konfirmasi, memiliki beberapa keterbatasan mendasar yang membuatnya tidak memadai sebagai satu-satunya metode analisis.

Pertama, ada ketergantungan pada perangkat keras. Program yang dieksekusi pada CPU Intel Core i9 generasi terbaru dengan cache L3 yang besar akan menunjukkan waktu yang jauh berbeda dibanding program yang sama pada CPU ARM Cortex-A55 di perangkat tertanam. Hasil pengukuran empiris hanya valid untuk perangkat keras spesifik tempat pengukuran dilakukan.

Kedua, ada pengaruh beban sistem (*system load*). Sistem operasi modern menjalankan puluhan proses secara bersamaan. Aktivitas antivirus yang tiba-tiba, pembaruan sistem yang berjalan di latar belakang, atau proses lain yang menggunakan memori dapat membuat waktu eksekusi berfluktuasi secara signifikan antara satu pengukuran dan pengukuran berikutnya, bahkan untuk program dan data yang identik.

Ketiga, ada ketergantungan pada bahasa pemrograman dan implementasi. Algoritma yang sama yang ditulis dalam bahasa C dengan optimasi kompiler akan berjalan puluhan kali lebih cepat daripada implementasi Python yang setara. Perbandingan antaralgoritma secara empiris hanya bermakna jika implementasinya berada pada tingkat kualitas yang setara.

Keempat, dan mungkin yang paling penting, ada ketergantungan pada konten data. Waktu eksekusi suatu algoritma sering kali bergantung tidak hanya pada ukuran input tetapi juga pada konten atau urutan data. Algoritma Bubble Sort pada array yang sudah terurut berperilaku sangat berbeda dari perilakunya pada array yang terurut terbalik.

Karena itulah komunitas ilmuwan komputer mengembangkan metode analisis yang abstrak, matematis, dan independen dari faktor-faktor kontekstual tersebut. Metode ini disebut analisis asimtotik, dan ia bekerja dengan cara menganalisis bagaimana fungsi kompleksitas suatu algoritma berperilaku ketika ukuran input mendekati tak terhingga.

---

## 2.3 Notasi Asimtotik: Bahasa Universal Analisis Algoritma

Notasi asimtotik adalah sistem notasi matematis yang digunakan untuk mendeskripsikan perilaku fungsi ketika argumennya tumbuh sangat besar. Dalam konteks analisis algoritma, kita menggunakan notasi ini untuk mendeskripsikan bagaimana waktu atau ruang yang dibutuhkan suatu algoritma tumbuh seiring meningkatnya ukuran input n. Terdapat tiga notasi utama yang menjadi standar dalam literatur ilmu komputer: Big-O, Big-Omega, dan Big-Theta.

### 2.3.1 Notasi Big-O: Batas Atas Pertumbuhan

Notasi Big-O adalah notasi yang paling sering digunakan dalam praktik. Ia mendefinisikan batas atas pertumbuhan suatu fungsi, yang dalam konteks algoritma berarti menjamin bahwa algoritma tidak akan berjalan lebih lambat dari fungsi yang dinyatakan -- dalam skenario terburuk sekalipun.

**Definisi Formal 2.1 (Big-O).**
Suatu fungsi f(n) dikatakan O(g(n)) jika dan hanya jika terdapat konstanta positif c dan bilangan bulat positif n0 sehingga untuk semua n yang memenuhi n >= n0, berlaku:

```
0 <= f(n) <= c * g(n)
```

Definisi ini perlu dicermati dengan teliti karena setiap unsurnya memiliki makna yang penting. Konstanta c mengizinkan adanya "faktor pengali tersembunyi" -- kita tidak peduli jika suatu algoritma berjalan dua kali atau bahkan sepuluh kali lebih lambat dari g(n), selama faktor ini konstan dan tidak bergantung pada n. Nilai ambang n0 mengizinkan perilaku fungsi yang "buruk" untuk nilai n yang kecil -- yang penting adalah bagaimana fungsi berperilaku untuk nilai n yang besar. Dengan kata lain, Big-O hanya peduli pada perilaku asimtotik, yaitu perilaku jangka panjang ketika n tumbuh.

---

> **Catatan Penting 2.1: Interpretasi Pernyataan Big-O**
>
> Ketika seorang insinyur mengatakan "algoritma ini adalah O(n^2)", pernyataan tersebut tidak berarti bahwa algoritma tersebut membutuhkan tepat n^2 operasi. Ia berarti bahwa ada suatu konstanta c sehingga jumlah operasi tidak pernah melebihi c*n^2 untuk semua n yang cukup besar. Ini adalah pernyataan tentang batas atas pertumbuhan, bukan pernyataan tentang jumlah operasi yang tepat.

---

Untuk memahami definisi ini secara operasional, mari kita lakukan pembuktian formal melalui sebuah contoh.

**Contoh 2.1: Pembuktian f(n) = 3n^2 + 5n + 2 adalah O(n^2).**

Kita perlu menemukan c > 0 dan n0 > 0 sehingga 3n^2 + 5n + 2 <= c * n^2 untuk semua n >= n0.

Langkah 1: Ekspansi dan penggantian suku.
Untuk n >= 1, berlaku n <= n^2 (karena n >= 1 mengimplikasikan n * 1 <= n * n), dan juga 1 <= n^2 (karena n >= 1). Menggunakan fakta ini:

```
3n^2 + 5n + 2 <= 3n^2 + 5n^2 + 2n^2    (karena n <= n^2 dan 1 <= n^2 untuk n >= 1)
              = 10n^2
```

Langkah 2: Identifikasi konstanta.
Dengan c = 10 dan n0 = 1, terbukti bahwa untuk semua n >= 1:

```
3n^2 + 5n + 2 <= 10 * n^2
```

Kesimpulan: f(n) = 3n^2 + 5n + 2 adalah O(n^2).

Pembuktian ini mengungkap prinsip penting: suku dengan laju pertumbuhan tertinggi mendominasi perilaku asimtotik. Suku 5n dan konstanta 2 menjadi tidak signifikan dibandingkan dengan 3n^2 untuk nilai n yang besar. Oleh karena itu, secara praktis, kita dapat langsung mengidentifikasi kelas Big-O suatu polinomial dari suku berderajat tertingginya.

Selain pembuktian dari definisi, terdapat beberapa sifat aljabar penting dari notasi Big-O yang sangat berguna dalam analisis algoritma:

**Aturan Penjumlahan:** O(f(n)) + O(g(n)) = O(max(f(n), g(n))). Ini berarti jika sebuah algoritma terdiri dari dua bagian berturut-turut -- bagian pertama O(n^2) dan bagian kedua O(n) -- maka keseluruhan algoritma adalah O(n^2). Suku yang lebih kecil "diserap" oleh suku yang lebih besar.

**Aturan Perkalian:** O(f(n)) * O(g(n)) = O(f(n) * g(n)). Jika ada perulangan O(n) di dalam perulangan O(log n), kompleksitas totalnya adalah O(n log n).

**Aturan Konstanta:** O(k * f(n)) = O(f(n)) untuk setiap konstanta k > 0. Koefisien konstanta tidak mengubah kelas Big-O; O(5n^2) adalah identik dengan O(n^2).

### 2.3.2 Notasi Big-Omega: Batas Bawah Pertumbuhan

Sementara Big-O menjamin bahwa suatu algoritma tidak akan berjalan lebih lambat dari fungsi yang dinyatakan, Big-Omega memberikan jaminan yang berlawanan: ia menyatakan bahwa algoritma setidaknya akan membutuhkan sebanyak itu waktu -- sekurang-kurangnya dalam kasus terbaiknya.

**Definisi Formal 2.2 (Big-Omega).**
Suatu fungsi f(n) dikatakan Omega(g(n)) jika dan hanya jika terdapat konstanta positif c dan bilangan bulat positif n0 sehingga untuk semua n >= n0, berlaku:

```
0 <= c * g(n) <= f(n)
```

Big-Omega berguna dalam konteks yang berbeda dari Big-O. Ketika seorang ilmuwan komputer membuktikan bahwa suatu masalah memiliki batas bawah Omega(n log n) -- seperti yang terbukti untuk masalah pengurutan berbasis perbandingan -- itu berarti tidak akan pernah ada algoritma pengurutan berbasis perbandingan yang lebih cepat dari O(n log n), tidak peduli seberapa cerdas algoritma tersebut dirancang.

**Contoh 2.2: Pembuktian f(n) = n^2/2 - 3n adalah Omega(n^2).**

Kita perlu menemukan c > 0 dan n0 > 0 sehingga c * n^2 <= n^2/2 - 3n untuk semua n >= n0.

Langkah 1: Manipulasi aljabar untuk menemukan syarat.

```
n^2/2 - 3n >= c * n^2
n^2/2 - 3n >= n^2/4     (misalkan c = 1/4, kita cari n0)
n^2/2 - n^2/4 >= 3n
n^2/4 >= 3n
n/4 >= 3
n >= 12
```

Langkah 2: Verifikasi.
Untuk n0 = 12 dan c = 1/4: berlaku n^2/2 - 3n >= n^2/4.

Kesimpulan: f(n) = Omega(n^2) dengan c = 1/4 dan n0 = 12.

### 2.3.3 Notasi Big-Theta: Batas Ketat

Notasi Big-Theta adalah yang paling informatif dari ketiganya karena ia memberikan karakterisasi pertumbuhan yang paling presisi. Sebuah fungsi dikatakan Theta(g(n)) jika dan hanya jika ia adalah sekaligus O(g(n)) maupun Omega(g(n)).

**Definisi Formal 2.3 (Big-Theta).**
Suatu fungsi f(n) dikatakan Theta(g(n)) jika dan hanya jika terdapat konstanta positif c1, c2, dan bilangan bulat positif n0 sehingga untuk semua n >= n0, berlaku:

```
0 <= c1 * g(n) <= f(n) <= c2 * g(n)
```

Ketika f(n) = Theta(g(n)), kita dapat mengatakan dengan pasti bahwa f(n) dan g(n) tumbuh pada laju yang secara asimtotik ekuivalen -- tidak lebih cepat dan tidak lebih lambat, hanya berbeda pada konstanta pengali.

**Contoh 2.3: Pembuktian f(n) = (n^2 + n)/2 adalah Theta(n^2).**

Batas atas (Big-O):
Untuk n >= 1, n <= n^2, sehingga n^2 + n <= n^2 + n^2 = 2n^2, dan (n^2 + n)/2 <= n^2.
Jadi c2 = 1 dan n0 = 1 berlaku untuk batas atas.

Batas bawah (Big-Omega):
Karena n >= 0, maka n^2 + n >= n^2, sehingga (n^2 + n)/2 >= n^2/2.
Jadi c1 = 1/2 berlaku untuk batas bawah.

Kesimpulan: Karena terdapat c1 = 1/2, c2 = 1, dan n0 = 1 sehingga c1*n^2 <= (n^2+n)/2 <= c2*n^2, terbukti f(n) = Theta(n^2).

### 2.3.4 Perbandingan Tiga Notasi Utama

Tabel 2.2 merangkum perbandingan ketiga notasi utama beserta padanannya dalam sistem perbandingan matematika tradisional.

**Tabel 2.2** Perbandingan Notasi Asimtotik

```
+-------------+---------------+----------+---------------------------------------+--------------------+
| Notasi      | Nama          | Batas    | Makna Informal                        | Analogi Matematis  |
+-------------+---------------+----------+---------------------------------------+--------------------+
| O(g(n))     | Big-O         | Atas     | "Tidak tumbuh lebih cepat dari g(n)"  | f <= g (asimtotik) |
| Omega(g(n)) | Big-Omega     | Bawah    | "Tidak tumbuh lebih lambat dari g(n)" | f >= g (asimtotik) |
| Theta(g(n)) | Big-Theta     | Ketat    | "Tumbuh pada laju yang sama dengan    | f = g (asimtotik)  |
|             |               |          |  g(n)"                                |                    |
| o(g(n))     | Little-o      | Atas     | "Tumbuh jauh lebih lambat dari g(n)"  | f < g (asimtotik)  |
|             |               | ketat    |                                       |                    |
| omega(g(n)) | Little-omega  | Bawah    | "Tumbuh jauh lebih cepat dari g(n)"   | f > g (asimtotik)  |
|             |               | ketat    |                                       |                    |
+-------------+---------------+----------+---------------------------------------+--------------------+
```

Perlu dicatat bahwa dalam praktik sehari-hari, insinyur perangkat lunak dan bahkan banyak literatur akademis sering menggunakan notasi Big-O meskipun yang dimaksud secara teknis adalah Big-Theta. Ketika seseorang mengatakan "Merge Sort adalah O(n log n)", mereka biasanya bermaksud mengatakan bahwa ia adalah Theta(n log n) -- batas yang ketat -- bukan sekadar batas atas. Pembaca harus mewaspadai penggunaan konvensi ini dan memahami konteksnya.

---

> **Tahukah Anda? 2.1: Asal-Usul Notasi Big-O**
>
> Notasi Big-O pertama kali diperkenalkan oleh matematikawan Jerman Paul Bachmann dalam karyanya *Die Analytische Zahlentheorie* (1894), jauh sebelum era komputer digital. Ia awalnya dikembangkan sebagai alat dalam teori bilangan untuk mendeskripsikan laju pertumbuhan fungsi dalam analisis bilangan prima. Edmund Landau kemudian mempopulerkan dan memperluas sistem notasi ini, sehingga kadang disebut "notasi Bachmann-Landau". Donald Knuth, dalam seri *The Art of Computer Programming*, mengadaptasi dan menstandarkan notasi ini untuk digunakan dalam analisis algoritma pada 1970-an, bentuk yang kini menjadi standar universal di seluruh dunia ilmu komputer.

---

## 2.4 Hirarki Kelas Kompleksitas

Tidak semua fungsi kompleksitas dicipta setara. Ada urutan yang ketat tentang seberapa cepat berbagai kelas fungsi tumbuh, dan urutan ini memiliki konsekuensi praktis yang sangat besar.

### 2.4.1 Urutan Pertumbuhan

Urutan kelas kompleksitas dari yang paling efisien hingga paling tidak efisien adalah:

```
O(1) < O(log n) < O(sqrt(n)) < O(n) < O(n log n) < O(n^2) < O(n^3) < O(2^n) < O(n!)
```

Diagram ASCII pada Gambar 2.1 mengilustrasikan perbedaan laju pertumbuhan berbagai fungsi ini secara visual.

**Gambar 2.1** Diagram Pertumbuhan Fungsi Kompleksitas

```
Jumlah
Operasi
   ^
   |                                                                     n!
   |                                                                  .
   |                                                               .
1000|                                                           .
   |                                                       .  2^n
   |                                                  ..
   |                                            ..
 700|                                     ..
   |                              ...
   |                         ...                                n^3
 500|                   ...
   |              ...
   |         ...                                           n^2
 300|     ...
   |   ..
   | ..                                             n log n
 100| .
   |.   .--.---.-----.-------.----------.-------------- n
   | .-'                                          sqrt(n)
  50|'----------------------------------------------
   |.............................................  log n
   |_____________________________________________  O(1)
   |________________________________________________>
   0     5    10   15   20   25   30   35   40    n
```

Gambar 2.1 mengungkap sebuah pola penting: fungsi eksponensial (2^n) dan faktorial (n!) tumbuh sedemikian cepat sehingga bahkan untuk nilai n yang moderat (sekitar 20-25), nilainya sudah melampaui batas kapasitas komputer mana pun. Sebaliknya, fungsi logaritmik (log n) tumbuh begitu lambat sehingga bahkan untuk n = 10^18, nilai log2(n) hanya sekitar 60.

Untuk melengkapi intuisi, Tabel 2.3 menyajikan nilai numerik dari beberapa fungsi kompleksitas untuk nilai n yang dipilih.

**Tabel 2.3** Nilai Numerik Fungsi Kompleksitas untuk Berbagai n

```
+-----+------+----------+------+------------+--------+--------+
|  n  | O(1) | O(log n) | O(n) | O(n log n) | O(n^2) | O(2^n) |
+-----+------+----------+------+------------+--------+--------+
|   1 |    1 |        0 |    1 |          0 |      1 |      2 |
|   2 |    1 |        1 |    2 |          2 |      4 |      4 |
|   4 |    1 |        2 |    4 |          8 |     16 |     16 |
|   8 |    1 |        3 |    8 |         24 |     64 |    256 |
|  16 |    1 |        4 |   16 |         64 |    256 |  65536 |
|  20 |    1 |      4.3 |   20 |         86 |    400 |1048576 |
+-----+------+----------+------+------------+--------+--------+
```

### 2.4.2 O(1) -- Kompleksitas Konstan

Kelas O(1) merepresentasikan algoritma yang menjalankan jumlah operasi yang tetap dan konstan, terlepas dari berapa pun ukuran input yang diberikan. Ini adalah kelas yang paling ideal karena kinerjanya tidak terdegradasi sama sekali seiring bertambahnya data.

Ciri khas algoritma O(1) adalah tidak adanya perulangan atau rekursi yang skalanya bergantung pada n. Operasi yang dilakukan adalah akses langsung, kalkulasi sederhana, atau manipulasi elemen tunggal.

```python
def akses_elemen(arr, i):
    """Mengakses elemen array pada indeks tertentu: O(1)"""
    return arr[i]   # Selalu tepat 1 operasi, berapa pun panjang arr

def cek_genap(n):
    """Memeriksa apakah bilangan genap: O(1)"""
    return n % 2 == 0  # Selalu 1 operasi modulo

def swap_dua_elemen(arr, i, j):
    """Menukar dua elemen dalam array: O(1)"""
    arr[i], arr[j] = arr[j], arr[i]  # Tiga penugasan, konstan
```

Contoh lain dari operasi O(1): push dan pop pada stack berbasis array, mengakses nilai pada dictionary Python (hash table), dan memeriksa apakah sebuah bilangan lebih besar dari nol.

### 2.4.3 O(log n) -- Kompleksitas Logaritmik

Algoritma dengan kompleksitas logaritmik adalah yang paling efisien di antara algoritma yang harus "memproses" setidaknya satu bagian dari input. Prinsip kerjanya adalah membagi ruang masalah dengan faktor konstan (biasanya dua) di setiap langkah, sehingga jumlah langkah yang dibutuhkan hanya setara dengan berapa kali kita dapat membagi n hingga mencapai 1.

```python
def binary_search(arr, target):
    """Pencarian biner pada array terurut: O(log n)"""
    kiri, kanan = 0, len(arr) - 1
    while kiri <= kanan:
        tengah = (kiri + kanan) // 2
        if arr[tengah] == target:
            return tengah
        elif arr[tengah] < target:
            kiri = tengah + 1     # Buang setengah kiri
        else:
            kanan = tengah - 1   # Buang setengah kanan
    return -1
```

Untuk array berukuran 1.000.000, binary search hanya membutuhkan paling banyak log2(1.000.000) = sekitar 20 iterasi. Sebagai perbandingan, pencarian linear pada array yang sama membutuhkan hingga 1.000.000 iterasi dalam kasus terburuk.

---

> **Catatan Penting 2.2: Basis Logaritma dan Big-O**
>
> Dalam notasi Big-O, basis logaritma tidak memengaruhi kelas kompleksitas. O(log2(n)), O(log10(n)), dan O(ln(n)) semuanya adalah kelas yang sama, yaitu O(log n), karena logaritma dengan basis berbeda hanya berbeda pada faktor konstanta pengali: log_a(n) = log_b(n) / log_b(a). Mengingat konstanta dihilangkan dalam notasi Big-O, semua bentuk logaritma termasuk dalam satu kelas yang sama.

---

### 2.4.4 O(n) -- Kompleksitas Linear

Algoritma linear harus "melihat" setiap elemen input setidaknya sekali, sehingga jumlah operasinya sebanding dengan ukuran input. Ini adalah kompleksitas yang paling optimal yang dapat dicapai untuk masalah yang memang mensyaratkan pemrosesan seluruh input.

```python
def cari_maksimum(arr):
    """Menemukan nilai maksimum dalam array tak terurut: O(n)"""
    if not arr:
        return None
    maks = arr[0]
    for i in range(1, len(arr)):   # Satu perulangan tunggal, n-1 iterasi
        if arr[i] > maks:
            maks = arr[i]
    return maks

def hitung_jumlah(arr):
    """Menghitung jumlah semua elemen: O(n)"""
    total = 0
    for elemen in arr:   # Satu perulangan, n iterasi
        total += elemen
    return total
```

Untuk masalah seperti "menemukan nilai maksimum dalam array yang tidak terurut", kompleksitas O(n) adalah optimal secara teori -- kita tidak bisa menemukan maksimum tanpa memeriksa setiap elemen setidaknya sekali.

### 2.4.5 O(n log n) -- Kompleksitas Linearitmik

Kelas ini sangat penting dalam praktek karena semua algoritma pengurutan berbasis perbandingan yang efisien -- Merge Sort, Heap Sort, dan Quick Sort dalam kasus rata-rata -- berada dalam kelas ini. Ini juga merupakan batas bawah teoritis untuk pengurutan berbasis perbandingan: telah dibuktikan bahwa tidak ada algoritma pengurutan berbasis perbandingan yang dapat lebih cepat dari Omega(n log n).

```python
def merge_sort(arr):
    """Pengurutan Merge Sort: O(n log n)"""
    if len(arr) <= 1:
        return arr
    tengah = len(arr) // 2
    kiri = merge_sort(arr[:tengah])     # Rekursi pada setengah kiri: T(n/2)
    kanan = merge_sort(arr[tengah:])    # Rekursi pada setengah kanan: T(n/2)
    return gabung(kiri, kanan)          # Penggabungan: O(n)

def gabung(kiri, kanan):
    """Menggabungkan dua array terurut: O(n)"""
    hasil = []
    i = j = 0
    while i < len(kiri) and j < len(kanan):
        if kiri[i] <= kanan[j]:
            hasil.append(kiri[i])
            i += 1
        else:
            hasil.append(kanan[j])
            j += 1
    hasil.extend(kiri[i:])
    hasil.extend(kanan[j:])
    return hasil
```

Intuisi di balik O(n log n): algoritma ini membagi masalah ukuran n menjadi dua submasalah ukuran n/2 (menghasilkan log2(n) tingkat rekursi), dan pada setiap tingkat rekursi, total pekerjaan yang dilakukan adalah O(n). Hasilnya adalah log(n) tingkat masing-masing dengan pekerjaan O(n), menghasilkan O(n log n) keseluruhan.

### 2.4.6 O(n^2) -- Kompleksitas Kuadratik

Algoritma kuadratik biasanya muncul dari pola dua perulangan bersarang di mana setiap elemen input dibandingkan atau diproses bersama dengan setiap elemen input lainnya. Kelas ini masih praktis untuk n yang tidak terlalu besar (hingga sekitar 10.000), tetapi menjadi tidak layak untuk n yang lebih besar.

```python
def bubble_sort(arr):
    """Pengurutan Bubble Sort: O(n^2)"""
    n = len(arr)
    arr = arr.copy()
    for i in range(n):               # Perulangan luar: n iterasi
        for j in range(n - i - 1):   # Perulangan dalam: hingga n-1 iterasi
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr
```

### 2.4.7 O(2^n) dan O(n!) -- Kompleksitas Eksponensial dan Faktorial

Kedua kelas ini dianggap "tidak praktis" (*intractable*) kecuali untuk nilai n yang sangat kecil. Algoritma eksponensial sering muncul dari strategi rekursif yang naif -- menyelesaikan submasalah yang sama berulang kali tanpa menyimpan hasilnya.

```python
def fibonacci_naif(n):
    """Fibonacci rekursif naif: O(2^n) -- TIDAK EFISIEN"""
    if n <= 1:
        return n
    return fibonacci_naif(n - 1) + fibonacci_naif(n - 2)
```

Untuk n = 50, fungsi ini melakukan sekitar 2^50 ≈ 10^15 operasi. Pada komputer 10^9 operasi/detik, ini membutuhkan lebih dari 11 hari. Untuk n = 100, waktu yang dibutuhkan melebihi usia alam semesta.

**Tabel 2.4** Praktikalitas Algoritma Berdasarkan Kelas Kompleksitas

```
+--------------------+----------------+------------------------------------------+-----------------------+
| Kelas Kompleksitas | Nama           | Contoh Algoritma                         | Praktis untuk n...    |
+--------------------+----------------+------------------------------------------+-----------------------+
| O(1)               | Konstan        | Akses array, operasi hash table          | Semua ukuran n        |
| O(log n)           | Logaritmik     | Binary search, BST seimbang              | n hingga 10^18        |
| O(sqrt(n))         | Akar kuadrat   | Uji primalitas, Sieve of Eratosthenes    | n hingga 10^12        |
| O(n)               | Linear         | Linear search, pemrosesan array          | n hingga 10^8         |
| O(n log n)         | Linearitmik    | Merge sort, Heap sort, FFT               | n hingga 10^6 - 10^7  |
| O(n^2)             | Kuadratik      | Bubble sort, Insertion sort              | n hingga 10^3 - 10^4  |
| O(n^3)             | Kubik          | Perkalian matriks naif                   | n hingga 500          |
| O(2^n)             | Eksponensial   | Fibonacci naif, enumerasi subset         | n hingga 20-25        |
| O(n!)              | Faktorial      | Permutasi brute force, TSP naif          | n hingga 12           |
+--------------------+----------------+------------------------------------------+-----------------------+
```

---

## 2.5 Analisis Kasus: Terbaik, Terburuk, dan Rata-rata

Sampai sejauh ini kita telah membahas kompleksitas algoritma seolah-olah setiap algoritma hanya memiliki satu perilaku untuk setiap ukuran input n. Kenyataannya, banyak algoritma berperilaku sangat berbeda tergantung pada konten atau susunan data input, bukan hanya ukurannya. Untuk menangkap nuansa ini, analisis kompleksitas mengenal tiga skenario.

### 2.5.1 Definisi Tiga Skenario Analisis

**Kasus Terburuk (Worst Case).** Ini adalah skenario input yang menyebabkan algoritma melakukan jumlah operasi maksimum. Dalam notasi, kita menulis T_worst(n) untuk fungsi kompleksitas kasus terburuk. Kasus terburuk adalah yang paling banyak digunakan dalam praktik karena ia memberikan jaminan: "tidak peduli data apa yang diterima, algoritma ini tidak akan lebih lambat dari ini". Jaminan ini sangat berharga dalam konteks sistem yang membutuhkan latensi yang dapat diprediksi.

**Kasus Terbaik (Best Case).** Ini adalah skenario input yang menyebabkan algoritma melakukan jumlah operasi minimum. Kasus terbaik jarang menjadi tolok ukur utama dalam praktik karena kita tidak dapat mengandalkan input yang selalu berada dalam konfigurasi ideal. Namun, ia berguna untuk memahami rentang perilaku algoritma dan untuk membandingkan algoritma dalam skenario tertentu.

**Kasus Rata-rata (Average Case).** Ini adalah ekspektasi matematis jumlah operasi atas distribusi input yang diasumsikan. Analisis kasus rata-rata secara teknis lebih kompleks karena membutuhkan asumsi tentang distribusi probabilitas input. Untuk kasus yang paling sederhana, kita biasanya mengasumsikan distribusi seragam (*uniform distribution*).

---

> **Catatan Penting 2.3: Jangan Salah Memetakan Kasus ke Notasi**
>
> Sebuah kesalahpahaman yang sangat umum adalah mengidentifikasikan "Big-O dengan kasus terburuk", "Big-Omega dengan kasus terbaik", dan "Big-Theta dengan kasus rata-rata". Ini tidak tepat. Ketiga notasi (Big-O, Omega, Theta) dapat digunakan pada setiap skenario kasus. Misalnya, kita bisa menyatakan bahwa kasus terburuk Binary Search adalah O(log n) sekaligus Omega(log n), yaitu Theta(log n). Notasi dan kasus adalah dua dimensi analisis yang independen.

---

### 2.5.2 Analisis Lengkap Pencarian Linear

Algoritma pencarian linear adalah subjek yang sempurna untuk mendemonstrasikan analisis tiga kasus karena perilakunya sangat bergantung pada posisi elemen yang dicari.

```python
def linear_search(arr, target):
    """Pencarian linear: menelusuri array dari awal hingga target ditemukan"""
    for i in range(len(arr)):
        if arr[i] == target:
            return i        # Ditemukan: hentikan pencarian
    return -1               # Tidak ditemukan
```

**Analisis Kasus Terbaik.** Target ditemukan pada posisi pertama (indeks 0). Algoritma melakukan tepat 1 perbandingan dan langsung kembali. T_best(n) = 1 = O(1). Perhatikan: meskipun array berisi satu juta elemen, waktu eksekusinya tidak berubah jika elemen yang dicari selalu ada di posisi pertama.

**Analisis Kasus Terburuk.** Target berada di posisi terakhir (indeks n-1) atau tidak ada dalam array sama sekali. Algoritma harus memeriksa semua n elemen sebelum memberikan jawaban. T_worst(n) = n = O(n).

**Analisis Kasus Rata-rata.** Untuk kasus ini, kita membuat dua asumsi: (1) target selalu ada dalam array, dan (2) distribusi posisi target adalah seragam -- setiap posisi memiliki probabilitas yang sama yaitu 1/n untuk menjadi posisi target.

Jika target berada di posisi ke-k (menggunakan indeks 1), dibutuhkan tepat k perbandingan. Nilai ekspektasi jumlah perbandingan adalah:

```
T_avg(n) = sum_{k=1}^{n} P(target di posisi k) * k
         = sum_{k=1}^{n} (1/n) * k
         = (1/n) * sum_{k=1}^{n} k
         = (1/n) * (n * (n+1) / 2)
         = (n+1) / 2
```

Untuk n yang besar, (n+1)/2 ≈ n/2, sehingga T_avg(n) = O(n). Secara rata-rata, kita memeriksa setengah dari elemen array -- masih O(n), tetapi lebih cepat dari kasus terburuk dengan faktor konstanta 2.

### 2.5.3 Analisis Lengkap Binary Search

Binary search menunjukkan profil yang berbeda karena perbedaan kinerjanya antar kasus jauh lebih dramatis dibandingkan pencarian linear.

**Kasus Terbaik.** Target berada tepat di posisi tengah array pada iterasi pertama. Hanya diperlukan 1 perbandingan. T_best(n) = O(1).

**Kasus Terburuk.** Target tidak ada dalam array, atau berada di posisi paling tepi. Pada setiap iterasi, ruang pencarian dibagi dua:

```
Sebelum iterasi 1: n elemen dalam ruang pencarian
Setelah iterasi 1: n/2 elemen tersisa
Setelah iterasi 2: n/4 elemen tersisa
Setelah iterasi k: n/2^k elemen tersisa
```

Algoritma berhenti ketika n/2^k <= 1, yaitu ketika 2^k >= n, atau k >= log2(n). Jumlah iterasi maksimum adalah floor(log2(n)) + 1. T_worst(n) = O(log n).

**Kasus Rata-rata.** Analisis kasus rata-rata binary search lebih kompleks, tetapi hasilnya juga O(log n) -- hanya berbeda pada konstanta dibandingkan kasus terburuk.

### 2.5.4 Analisis Kasus pada Bubble Sort

Bubble Sort menunjukkan contoh menarik di mana kasus terbaik dapat jauh berbeda dari kasus terburuk jika implementasinya menggunakan optimasi yang tepat.

```
Kasus Terbaik (dengan optimasi flag 'swapped'): O(n)
  - Jika array sudah terurut, satu pass tanpa pertukaran cukup untuk
    mendeteksi ini. Perulangan luar berjalan hanya 1 kali.

Kasus Terbaik (tanpa optimasi): O(n^2)
  - Tanpa flag, perulangan tetap berjalan n*(n-1)/2 iterasi meskipun
    tidak ada pertukaran yang dilakukan.

Kasus Terburuk (array terurut terbalik): O(n^2)
  - Setiap elemen harus bergerak ke posisi yang berjauhan.
  - Total pertukaran: n*(n-1)/2 kali.

Kasus Rata-rata: O(n^2)
  - Secara rata-rata juga memerlukan O(n^2) operasi.
```

---

> **Tahukah Anda? 2.2: Kompleksitas Quicksort yang Paradoks**
>
> Quicksort adalah salah satu algoritma pengurutan yang paling banyak digunakan dalam praktik, termasuk dalam implementasi standar Python (timsort adalah hybrid mergesort-insertion sort, tetapi quicksort digunakan di banyak konteks lain). Paradoksnya, kasus terburuk Quicksort adalah O(n^2) -- lebih buruk dari Merge Sort yang selalu O(n log n). Namun, kasus rata-rata Quicksort adalah O(n log n) dengan konstanta yang sangat kecil, sehingga dalam praktik ia sering mengalahkan Merge Sort. Lebih menarik lagi, kasus terburuk O(n^2) hanya terjadi jika pivot yang dipilih selalu merupakan elemen minimum atau maksimum, sesuatu yang dapat dihindari dengan pemilihan pivot yang cerdas (seperti median-of-three atau pemilihan pivot acak).

---

## 2.6 Kompleksitas Ruang

Selain waktu, sumber daya komputasi yang penting lainnya adalah memori. Kompleksitas ruang (*space complexity*) mengukur jumlah memori yang dibutuhkan suatu algoritma sebagai fungsi dari ukuran input. Seperti kompleksitas waktu, kompleksitas ruang juga dinyatakan menggunakan notasi Big-O.

### 2.6.1 Ruang Bantu versus Ruang Total

Ketika menganalisis kompleksitas ruang, penting untuk membedakan dua konsep:

**Ruang Bantu (*Auxiliary Space*).** Memori ekstra yang digunakan algoritma di luar memori yang diperlukan untuk menyimpan input itu sendiri. Ini adalah ukuran yang paling relevan karena mencerminkan "overhead" memori yang ditambahkan oleh algoritma.

**Ruang Total (*Total Space*).** Jumlah total memori yang digunakan, termasuk memori untuk input. Untuk input berukuran n, ini selalu setidaknya O(n).

Dalam sebagian besar konteks, ketika kita berbicara tentang "space complexity" suatu algoritma, yang dimaksud adalah ruang bantu. Jika tidak dinyatakan sebaliknya, asumsi ini berlaku sepanjang buku ini.

### 2.6.2 Contoh Analisis Kompleksitas Ruang

**Pencarian linear: O(1) ruang bantu.** Pencarian linear hanya membutuhkan satu variabel indeks tambahan (variabel `i` dalam perulangan). Tidak ada struktur data tambahan yang dibuat yang ukurannya bergantung pada n.

**Fibonacci Rekursif: O(n) ruang bantu.** Meskipun sekilas fungsi Fibonacci rekursif tidak tampak menggunakan banyak memori, ia membangun *call stack* (tumpukan pemanggilan fungsi) yang kedalamannya mencapai n. Setiap frame pada call stack membutuhkan sejumlah memori konstan, sehingga total memori yang digunakan adalah O(n).

**Fibonacci Iteratif: O(1) ruang bantu.** Versi iteratif hanya membutuhkan dua variabel untuk menyimpan nilai Fibonacci sebelumnya.

```python
def fibonacci_iteratif(n):
    """Fibonacci iteratif: O(n) waktu, O(1) ruang bantu"""
    if n <= 1:
        return n
    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b   # Hanya 2 variabel yang digunakan
    return b
```

**Merge Sort: O(n) ruang bantu.** Merge Sort membutuhkan array tambahan berukuran n untuk proses penggabungan. Inilah salah satu kekurangannya dibandingkan Heap Sort yang menggunakan O(1) ruang bantu.

### 2.6.3 Trade-off Waktu dan Ruang

Salah satu prinsip paling fundamental dalam perancangan algoritma adalah bahwa waktu dan ruang sering kali dapat dipertukarkan. Dengan menggunakan lebih banyak memori, kita sering dapat menghemat waktu, dan sebaliknya.

Tabel 2.5 mengilustrasikan trade-off ini dengan contoh konkret.

**Tabel 2.5** Trade-off Waktu-Ruang pada Algoritma Fibonacci dan Pengurutan

```
+---------------------+--------------------+--------------------+-----------------------------+
| Algoritma           | Kompleksitas Waktu | Kompleksitas Ruang | Keterangan                  |
+---------------------+--------------------+--------------------+-----------------------------+
| Fibonacci Rekursif  | O(2^n)             | O(n)               | Sangat tidak efisien        |
| Fibonacci Memoized  | O(n)               | O(n)               | Waktu jauh lebih baik,      |
|                     |                    |                    | ruang sama                  |
| Fibonacci Iteratif  | O(n)               | O(1)               | Waktu dan ruang optimal     |
| Bubble Sort         | O(n^2)             | O(1)               | Lambat, hemat memori        |
| Merge Sort          | O(n log n)         | O(n)               | Cepat, butuh memori ekstra  |
| Heap Sort           | O(n log n)         | O(1)               | Cepat dan hemat memori      |
+---------------------+--------------------+--------------------+-----------------------------+
```

Fibonacci dengan memoization menunjukkan teknik yang disebut *dynamic programming* (pemrograman dinamis): kita menyimpan hasil komputasi sebelumnya dalam tabel (O(n) ruang tambahan) untuk menghindari penghitungan ulang yang redundan, sehingga mengubah kompleksitas waktu dari O(2^n) menjadi O(n).

---

## 2.7 Analisis Kompleksitas Step-by-Step: Lima Contoh Lengkap

Bagian ini adalah jantung dari bab ini dari sudut pandang kompetensi teknis. Lima contoh berikut menunjukkan prosedur sistematis untuk menghitung kompleksitas waktu secara tepat.

### 2.7.1 Contoh 2.4: Perulangan Tunggal

```python
def fungsi_a(n):
    total = 0               # Baris 1: 1 operasi penugasan
    for i in range(n):      # Baris 2: n iterasi (kondisi diperiksa n+1 kali)
        total += i          # Baris 3: 1 operasi per iterasi
    return total            # Baris 4: 1 operasi return
```

**Tabel 2.6** Analisis Frekuensi Eksekusi -- Contoh 2.4

```
+-------+---------------------------+-------------------+
| Baris | Pernyataan                | Frekuensi Eksekusi|
+-------+---------------------------+-------------------+
|   1   | total = 0                 | 1 kali            |
|   2   | Cek kondisi for (n+1 cek) | n + 1 kali        |
|   3   | total += i                | n kali            |
|   4   | return total              | 1 kali            |
+-------+---------------------------+-------------------+
```

Perhitungan T(n):
```
T(n) = 1 + (n + 1) + n + 1
     = 2n + 3
```

Pembuktian Big-O: Untuk c = 3 dan n0 = 3:
```
2n + 3 <= 3n    untuk semua n >= 3
(Verifikasi: n=3 → 9 <= 9, terpenuhi dengan kesetaraan)
```

**Kesimpulan:** fungsi_a memiliki kompleksitas waktu O(n).

### 2.7.2 Contoh 2.5: Dua Perulangan Bersarang Seragam

```python
def fungsi_b(n):
    hitung = 0                    # 1 operasi
    for i in range(n):            # Perulangan luar: n iterasi
        for j in range(n):        # Perulangan dalam: n iterasi per iterasi luar
            hitung += 1           # 1 operasi per iterasi
    return hitung                 # 1 operasi
```

**Tabel 2.7** Analisis Frekuensi Eksekusi -- Contoh 2.5

```
+-------+-----------------------------------+--------------------------+
| Baris | Pernyataan                        | Frekuensi Eksekusi       |
+-------+-----------------------------------+--------------------------+
|   1   | hitung = 0                        | 1 kali                   |
|   2   | Cek kondisi for luar              | n + 1 kali               |
|   3   | Cek kondisi for dalam             | n * (n + 1) kali         |
|   4   | hitung += 1                       | n * n = n^2 kali         |
|   5   | return hitung                     | 1 kali                   |
+-------+-----------------------------------+--------------------------+
```

Perhitungan T(n):
```
T(n) = 1 + (n + 1) + n(n + 1) + n^2 + 1
     = 1 + n + 1 + n^2 + n + n^2 + 1
     = 2n^2 + 2n + 3
```

Pembuktian Big-O: Untuk c = 3 dan n0 = 2:
```
2n^2 + 2n + 3 <= 3n^2    untuk semua n >= 2
(Verifikasi: n=2 → 8+4+3=15, 3*4=12... coba c=4, n0=3: 18+6+3=27, 4*9=36, terpenuhi)
```

Gunakan c = 4 dan n0 = 3: 2n^2 + 2n + 3 <= 4n^2 untuk semua n >= 3.

**Kesimpulan:** fungsi_b memiliki kompleksitas waktu O(n^2).

### 2.7.3 Contoh 2.6: Perulangan Bersarang Tidak Seragam (Segitiga)

```python
def fungsi_c(n):
    hitung = 0
    for i in range(n):        # i mengambil nilai 0, 1, 2, ..., n-1
        for j in range(i):    # j mengambil nilai 0, 1, ..., i-1
            hitung += 1
    return hitung
```

Contoh ini lebih menarik karena perulangan dalam tidak selalu berjalan n kali; ia berjalan sebanyak nilai i saat itu.

Derivasi jumlah total eksekusi operasi dalam:
```
Untuk i = 0: j berjalan 0 kali  →  0 iterasi
Untuk i = 1: j berjalan 1 kali  →  1 iterasi
Untuk i = 2: j berjalan 2 kali  →  2 iterasi
Untuk i = 3: j berjalan 3 kali  →  3 iterasi
         ...
Untuk i = n-1: j berjalan n-1 kali → n-1 iterasi
```

Total iterasi = 0 + 1 + 2 + 3 + ... + (n-1) = n(n-1)/2

Menggunakan rumus jumlah deret aritmetika: sum_{k=0}^{n-1} k = n(n-1)/2.

Sehingga:
```
T(n) = n(n-1)/2 = n^2/2 - n/2
```

Pembuktian Big-O: Untuk c = 1 dan n0 = 1:
```
n^2/2 - n/2 <= n^2/2 <= n^2    untuk semua n >= 1
```

**Kesimpulan:** fungsi_c memiliki kompleksitas O(n^2). Meskipun fungsi_c lebih cepat dari fungsi_b dengan faktor 2 (karena melakukan n^2/2 bukan n^2 operasi), keduanya berada dalam kelas kompleksitas yang sama.

### 2.7.4 Contoh 2.7: Perulangan Logaritmik

```python
def fungsi_log(n):
    """Mengilustrasikan perulangan dengan langkah perkalian"""
    i = 1
    hitung = 0
    while i < n:
        hitung += 1
        i = i * 2       # i melipatganda di setiap iterasi
    return hitung
```

Kunci analisis adalah memperhatikan bagaimana variabel kontrol i berubah: i mengambil nilai 1, 2, 4, 8, 16, ..., 2^k. Perulangan berhenti ketika i >= n, yaitu ketika 2^k >= n.

Derivasi:
```
2^k >= n
k >= log2(n)
```

Jumlah iterasi = floor(log2(n)).

**Kesimpulan:** fungsi_log memiliki kompleksitas O(log n). Pola kunci yang perlu dikenali: jika variabel kontrol dikalikan (atau dibagi) dengan konstanta di setiap iterasi, perulangan adalah logaritmik.

### 2.7.5 Contoh 2.8: Algoritma Rekursif -- Merge Sort

Analisis algoritma rekursif membutuhkan pendekatan yang berbeda: kita menggunakan relasi rekurensi.

```python
def merge_sort(arr):
    if len(arr) <= 1:              # Base case: T(1) = O(1)
        return arr
    tengah = len(arr) // 2
    kiri = merge_sort(arr[:tengah])    # Submasalah ukuran n/2: T(n/2)
    kanan = merge_sort(arr[tengah:])   # Submasalah ukuran n/2: T(n/2)
    return gabung(kiri, kanan)         # Penggabungan: O(n)
```

**Langkah 1: Tuliskan relasi rekurensi.**

```
T(n) = 2 * T(n/2) + O(n)     untuk n > 1
T(1) = O(1)                   base case
```

Di mana:
- 2 * T(n/2): dua pemanggilan rekursif, masing-masing pada submasalah ukuran n/2
- O(n): waktu untuk fungsi `gabung` yang memproses n elemen

**Langkah 2: Visualisasikan pohon rekursi.**

```
Level 0:  [n elemen]                        --> Biaya merge: n
            /          \
Level 1: [n/2]         [n/2]               --> Biaya merge: 2*(n/2) = n
          / \           / \
Level 2:[n/4][n/4]  [n/4][n/4]             --> Biaya merge: 4*(n/4) = n
        ...
Level k: 2^k submasalah ukuran n/2^k       --> Biaya merge: n
        ...
Level log n: n submasalah ukuran 1         --> Biaya: n
```

Terdapat log2(n) + 1 level, dan setiap level menyumbangkan total biaya n. Oleh karena itu:

**Langkah 3: Hitung total biaya.**

```
T(n) = n * (log2(n) + 1)
     = n * log2(n) + n
     = Theta(n log n)
```

Hasil ini juga dapat diperoleh secara formal menggunakan Master Theorem. Untuk rekurensi T(n) = a*T(n/b) + f(n) dengan a = 2, b = 2, f(n) = n:
- n^(log_b a) = n^(log_2 2) = n^1 = n
- Karena f(n) = Theta(n^(log_b a)) = Theta(n), kita masuk Kasus 2 Master Theorem
- Kesimpulan: T(n) = Theta(n^(log_b a) * log n) = Theta(n log n)

**Kesimpulan:** Merge Sort memiliki kompleksitas waktu Theta(n log n) -- baik dalam kasus terbaik, kasus terburuk, maupun kasus rata-rata.

---

## 2.8 Pengukuran Empiris dengan Python

Analisis teoritis memberikan jaminan matematis tentang perilaku algoritma, tetapi pengukuran empiris memberikan gambaran yang lebih konkret dan dapat digunakan untuk mengonfirmasi analisis teoritis serta mengidentifikasi konstanta tersembunyi. Modul `time` dan `random` Python memungkinkan kita melakukan eksperimen pengukuran kinerja yang sistematis.

```python
import time
import random
import math

# ============================================================
# Definisi algoritma yang akan diukur
# ============================================================

def linear_search(arr, target):
    """Pencarian linear: O(n) -- kompleksitas teoritis"""
    for i in range(len(arr)):
        if arr[i] == target:
            return i
    return -1

def binary_search(arr, target):
    """Pencarian biner: O(log n) -- array harus terurut"""
    kiri, kanan = 0, len(arr) - 1
    while kiri <= kanan:
        tengah = (kiri + kanan) // 2
        if arr[tengah] == target:
            return tengah
        elif arr[tengah] < target:
            kiri = tengah + 1
        else:
            kanan = tengah - 1
    return -1

def bubble_sort(arr):
    """Bubble sort: O(n^2)"""
    arr = arr.copy()  # Salin untuk menghindari modifikasi data asli
    n = len(arr)
    for i in range(n):
        for j in range(n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr

def gabung(kiri, kanan):
    """Fungsi pembantu untuk merge_sort"""
    hasil = []
    i = j = 0
    while i < len(kiri) and j < len(kanan):
        if kiri[i] <= kanan[j]:
            hasil.append(kiri[i])
            i += 1
        else:
            hasil.append(kanan[j])
            j += 1
    hasil.extend(kiri[i:])
    hasil.extend(kanan[j:])
    return hasil

def merge_sort(arr):
    """Merge sort: O(n log n)"""
    if len(arr) <= 1:
        return arr
    tengah = len(arr) // 2
    kiri = merge_sort(arr[:tengah])
    kanan = merge_sort(arr[tengah:])
    return gabung(kiri, kanan)

# ============================================================
# Infrastruktur pengukuran waktu
# ============================================================

def ukur_waktu(fungsi, *args, ulang=5):
    """
    Mengukur waktu eksekusi rata-rata suatu fungsi.
    Menjalankan pengukuran sebanyak `ulang` kali dan mengembalikan rata-rata.
    Penggunaan rata-rata mengurangi pengaruh fluktuasi sistem.
    """
    total_waktu = 0
    for _ in range(ulang):
        mulai = time.perf_counter()   # Gunakan perf_counter untuk presisi tinggi
        fungsi(*args)
        selesai = time.perf_counter()
        total_waktu += (selesai - mulai)
    return total_waktu / ulang

# ============================================================
# Eksperimen utama
# ============================================================

def jalankan_eksperimen():
    """Menjalankan perbandingan kinerja untuk berbagai ukuran input"""
    ukuran_n = [100, 500, 1000, 5000, 10000]

    print("=" * 78)
    print(f"{'n':>8} | {'Linear(ms)':>12} | {'Binary(ms)':>12} | "
          f"{'Bubble(ms)':>12} | {'Merge(ms)':>11}")
    print("=" * 78)

    hasil_sebelumnya = {}

    for n in ukuran_n:
        data = random.sample(range(n * 10), n)
        data_terurut = sorted(data)
        target = data[-1]   # Worst case untuk linear search

        t_linear = ukur_waktu(linear_search, data, target) * 1000
        t_binary = ukur_waktu(binary_search, data_terurut, target) * 1000
        t_bubble = ukur_waktu(bubble_sort, data) * 1000
        t_merge  = ukur_waktu(merge_sort, data) * 1000

        print(f"{n:>8} | {t_linear:>12.4f} | {t_binary:>12.4f} | "
              f"{t_bubble:>12.4f} | {t_merge:>11.4f}")

        hasil_sebelumnya[n] = (t_linear, t_binary, t_bubble, t_merge)

    print("=" * 78)

    # Analisis rasio pertumbuhan
    print("\n-- Analisis Rasio Pertumbuhan (n=1000 ke n=10000, faktor 10x) --")
    t1 = hasil_sebelumnya[1000]
    t2 = hasil_sebelumnya[10000]
    label = ["Linear Search", "Binary Search", "Bubble Sort", "Merge Sort"]
    prediksi = ["~10x (O(n))", "~1.33x (O(log n))", "~100x (O(n^2))",
                "~13.3x (O(n log n))"]

    for i in range(4):
        if t1[i] > 0:
            rasio = t2[i] / t1[i]
            print(f"  {label[i]:<15}: rasio aktual = {rasio:6.2f}x  |  "
                  f"prediksi teoritis: {prediksi[i]}")

if __name__ == "__main__":
    jalankan_eksperimen()
```

**Contoh Output yang Diharapkan:**

```
==============================================================================
       n |   Linear(ms) |   Binary(ms) |   Bubble(ms) |   Merge(ms)
==============================================================================
     100 |       0.0052 |       0.0003 |       0.0850 |      0.0620
     500 |       0.0260 |       0.0004 |       2.1500 |      0.3600
    1000 |       0.0510 |       0.0005 |       8.8000 |      0.7700
    5000 |       0.2550 |       0.0006 |     220.0000 |      4.3000
   10000 |       0.5100 |       0.0007 |     882.0000 |      9.2000
==============================================================================

-- Analisis Rasio Pertumbuhan (n=1000 ke n=10000, faktor 10x) --
  Linear Search  : rasio aktual =  10.00x  |  prediksi teoritis: ~10x (O(n))
  Binary Search  : rasio aktual =   1.40x  |  prediksi teoritis: ~1.33x (O(log n))
  Bubble Sort    : rasio aktual = 100.23x  |  prediksi teoritis: ~100x (O(n^2))
  Merge Sort     : rasio aktual =  11.95x  |  prediksi teoritis: ~13.3x (O(n log n))
```

Perhatikan betapa erat rasio aktual mendekati prediksi teoritis. Ini adalah konfirmasi empiris yang kuat bahwa analisis asimtotik, meski abstrak dan matematis, mencerminkan perilaku nyata program dengan akurasi yang tinggi.

---

## 2.9 Studi Kasus: Pemilihan Algoritma Pencarian pada Sistem E-commerce

Bagian ini menyajikan studi kasus yang mensimulasikan keputusan teknik nyata yang dihadapi insinyur perangkat lunak dalam memilih algoritma untuk sistem skala besar.

**Konteks.** Sebuah startup e-commerce sedang membangun fitur pencarian produk berdasarkan ID. Database produk diperkirakan akan tumbuh dari 10.000 produk pada tahap awal hingga 10 juta produk dalam dua tahun ke depan. Tim teknik harus memilih antara tiga pendekatan:

- **Pendekatan A:** Linear Search pada array tidak terurut, O(n)
- **Pendekatan B:** Binary Search pada array terurut, O(log n) per kueri (dengan overhead sorting O(n log n) sekali saat inisialisasi)
- **Pendekatan C:** Hash Table (dictionary Python), O(1) per kueri rata-rata (dengan overhead O(n) untuk membangun hash table)

**Analisis Komparatif.**

Misalkan database menyimpan n produk, dan sistem menerima q kueri pencarian per hari. Untuk menyederhanakan, asumsikan setiap kueri adalah pencarian tunggal berdasarkan ID.

Untuk tahap awal (n = 10.000, q = 100.000 kueri/hari):
```
Pendekatan A: Total biaya = q * O(n) = 100.000 * 10.000 = 10^9 operasi/hari
Pendekatan B: Overhead init = O(n log n) = 10.000 * 13 = 130.000 operasi (sekali)
              Total kueri = q * O(log n) = 100.000 * 13 = 1.300.000 operasi/hari
Pendekatan C: Overhead init = O(n) = 10.000 operasi (sekali)
              Total kueri = q * O(1) = 100.000 operasi/hari
```

Untuk tahap produksi (n = 10.000.000, q = 10.000.000 kueri/hari):
```
Pendekatan A: 10^7 * 10^7 = 10^14 operasi/hari
              → ~27.800 jam atau lebih dari 1100 hari pada 10^9 op/detik. Tidak layak.
Pendekatan B: 10^7 * log2(10^7) ≈ 10^7 * 23 = 2.3 * 10^8 operasi/hari
              → ~0,23 detik. Sangat layak.
Pendekatan C: 10^7 * O(1) = 10^7 operasi/hari
              → ~0,01 detik. Layak dengan margin yang lebih besar.
```

**Kesimpulan Studi Kasus.** Pendekatan C (hash table) adalah yang paling efisien untuk kasus ini, namun Pendekatan B (binary search) juga sangat kompetitif dan mungkin lebih mudah diimplementasikan dengan benar. Pendekatan A adalah yang paling mudah diimplementasikan pada tahap awal, tetapi akan menyebabkan kegagalan sistem yang fatal seiring pertumbuhan data.

Studi kasus ini mengilustrasikan mengapa memahami kompleksitas algoritma bukan sekadar pengetahuan akademis -- ia adalah keterampilan teknik inti yang berdampak langsung pada kelayakan sistem yang dibangun.

---

## Rangkuman Bab

1. **Motivasi Analisis Efisiensi.** Perbedaan kelas kompleksitas algoritma dapat mengakibatkan perbedaan waktu eksekusi yang bersifat astronomis seiring bertambahnya ukuran data -- dari milidetik hingga miliaran tahun. Analisis asimtotik memberikan kerangka yang independen dari perangkat keras, sistem operasi, dan bahasa pemrograman, sehingga memungkinkan perbandingan yang adil dan prediksi kinerja yang dapat diandalkan.

2. **Tiga Notasi Asimtotik Utama.** Big-O (O) mendefinisikan batas atas pertumbuhan fungsi -- jaminan kinerja dalam skenario terburuk -- dan merupakan notasi yang paling sering digunakan dalam praktik. Big-Omega (Omega) mendefinisikan batas bawah, berguna untuk menyatakan batas bawah teoritis suatu masalah. Big-Theta (Theta) mendefinisikan batas ketat dan memberikan karakterisasi yang paling presisi saat laju pertumbuhan atas dan bawah bertemu.

3. **Hirarki Kelas Kompleksitas.** Urutan efisiensi dari yang paling baik adalah: O(1) < O(log n) < O(sqrt(n)) < O(n) < O(n log n) < O(n^2) < O(n^3) < O(2^n) < O(n!). Loncatan dari satu kelas ke kelas berikutnya dalam hirarki ini menjadi semakin signifikan seiring pertumbuhan n, dan kelas eksponensial/faktorial dianggap tidak praktis untuk semua n yang non-trivial.

4. **Analisis Tiga Skenario Kasus.** Kasus terburuk memberikan jaminan kinerja maksimum dan paling banyak digunakan; kasus rata-rata mencerminkan kinerja tipikal dalam operasi normal; kasus terbaik menggambarkan batas bawah kinerja. Notasi asimtotik dan analisis kasus adalah dua dimensi yang independen -- keduanya dapat dikombinasikan secara bebas.

5. **Kompleksitas Ruang dan Trade-off.** Space complexity mengukur kebutuhan memori tambahan algoritma (ruang bantu). Waktu dan ruang sering kali dapat dipertukarkan: dengan menggunakan lebih banyak memori (seperti tabel memoization), kita dapat secara dramatis mengurangi waktu komputasi. Pilihan trade-off yang tepat bergantung pada kendala sumber daya sistem.

6. **Teknik Analisis Manual.** Prosedur sistematis untuk menganalisis kompleksitas waktu adalah: (1) identifikasi setiap pernyataan; (2) hitung frekuensi eksekusi tiap pernyataan sebagai fungsi n; (3) jumlahkan semua frekuensi untuk mendapatkan T(n); (4) identifikasi suku dominan; (5) terapkan definisi formal Big-O untuk menentukan kelas. Untuk algoritma rekursif, gunakan relasi rekurensi dan selesaikan dengan pohon rekursi atau Master Theorem.

7. **Konfirmasi Empiris.** Pengukuran waktu eksekusi aktual menggunakan Python (`time.perf_counter()`) dapat mengonfirmasi hasil analisis teoritis melalui analisis rasio pertumbuhan. Ketika n diperbesar dengan faktor k, waktu eksekusi algoritma O(n) meningkat ~k kali, O(n^2) meningkat ~k^2 kali, dan O(log n) meningkat ~log(k*n)/log(n) kali.

---

## Istilah Kunci

1. **Algoritma** -- Prosedur langkah-demi-langkah yang terdefinisi dengan baik untuk menyelesaikan suatu masalah komputasi dalam jumlah langkah yang terbatas.

2. **Analisis Asimtotik** -- Metode analisis yang mempelajari perilaku suatu fungsi ketika argumennya tumbuh sangat besar (mendekati tak terhingga), mengabaikan konstanta dan suku orde rendah.

3. **Big-O (O)** -- Notasi yang menyatakan batas atas pertumbuhan suatu fungsi; f(n) = O(g(n)) jika ada c > 0 dan n0 sehingga f(n) <= c*g(n) untuk semua n >= n0.

4. **Big-Omega (Omega)** -- Notasi yang menyatakan batas bawah pertumbuhan suatu fungsi; f(n) = Omega(g(n)) jika ada c > 0 dan n0 sehingga c*g(n) <= f(n) untuk semua n >= n0.

5. **Big-Theta (Theta)** -- Notasi yang menyatakan batas ketat pertumbuhan; f(n) = Theta(g(n)) jika f(n) adalah sekaligus O(g(n)) dan Omega(g(n)).

6. **Kompleksitas Waktu** -- Ukuran jumlah operasi elementer yang dilakukan algoritma sebagai fungsi dari ukuran input n.

7. **Kompleksitas Ruang** -- Ukuran jumlah memori yang digunakan algoritma sebagai fungsi dari ukuran input n.

8. **Ruang Bantu (Auxiliary Space)** -- Memori ekstra yang digunakan algoritma di luar memori yang dibutuhkan untuk menyimpan input.

9. **Kasus Terbaik (Best Case)** -- Skenario input yang menyebabkan algoritma menyelesaikan tugasnya dengan jumlah operasi minimum.

10. **Kasus Terburuk (Worst Case)** -- Skenario input yang menyebabkan algoritma menyelesaikan tugasnya dengan jumlah operasi maksimum; memberikan jaminan kinerja.

11. **Kasus Rata-rata (Average Case)** -- Ekspektasi matematis jumlah operasi atas distribusi probabilitas input yang diasumsikan.

12. **Relasi Rekurensi** -- Persamaan yang mendefinisikan fungsi kompleksitas suatu algoritma rekursif dalam terminologi nilai fungsi pada ukuran input yang lebih kecil.

13. **Master Theorem** -- Teorema yang memberikan solusi langsung untuk kelas relasi rekurensi berbentuk T(n) = a*T(n/b) + f(n), yang umum pada algoritma divide-and-conquer.

14. **Trade-off Waktu-Ruang** -- Fenomena di mana penggunaan memori yang lebih besar dapat mengurangi waktu komputasi, dan sebaliknya; prinsip perancangan algoritma yang fundamental.

15. **Hirarki Kompleksitas** -- Urutan total pada kelas-kelas fungsi berdasarkan laju pertumbuhannya; O(1) < O(log n) < O(n) < O(n log n) < O(n^2) < ... < O(2^n) < O(n!).

16. **Kompleksitas Konstan O(1)** -- Kelas algoritma yang menjalankan jumlah operasi tetap terlepas dari ukuran input.

17. **Kompleksitas Logaritmik O(log n)** -- Kelas algoritma yang membagi ruang masalah dengan faktor konstan di setiap langkah, menghasilkan jumlah langkah yang proporsional dengan logaritma ukuran input.

18. **Kompleksitas Linearitmik O(n log n)** -- Kelas algoritma yang merupakan batas bawah teoritis pengurutan berbasis perbandingan; dicapai oleh Merge Sort dan Heap Sort.

19. **Dynamic Programming** -- Teknik optimasi algoritma yang menyimpan hasil submasalah untuk menghindari rekomputasi redundan, sering mengubah kompleksitas eksponensial menjadi polinomial dengan biaya ruang tambahan.

---

## Soal Latihan

**Soal 2.1 [C2 - Memahami]**
Jelaskan mengapa analisis asimtotik dianggap superior dibandingkan pengukuran waktu eksekusi aktual sebagai metode utama untuk mengevaluasi efisiensi algoritma. Sebutkan dan jelaskan minimal tiga keterbatasan fundamental dari pengukuran empiris sederhana.

---

**Soal 2.2 [C2 - Memahami]**
Diberikan tiga pernyataan berikut. Tentukan mana yang benar, mana yang salah, dan berikan penjelasan singkat untuk masing-masing:

(a) Jika f(n) = O(g(n)) dan g(n) = O(h(n)), maka f(n) = O(h(n)).

(b) Jika f(n) = O(n^2), maka f(n) bukan O(n^3).

(c) Setiap algoritma dengan kompleksitas O(n) pasti lebih cepat dari algoritma dengan kompleksitas O(n^2) untuk semua nilai n.

---

**Soal 2.3 [C3 - Menerapkan]**
Buktikan secara formal bahwa f(n) = 7n^3 + 2n^2 + 100 adalah O(n^3). Tunjukkan secara eksplisit nilai konstanta c dan nilai ambang n0 yang Anda gunakan, serta verifikasikan kebenaran pilihan tersebut untuk nilai n0 yang dipilih.

---

**Soal 2.4 [C3 - Menerapkan]**
Tentukan kompleksitas Big-O dari setiap potongan kode Python berikut dan jelaskan reasoning Anda:

(a)
```python
def fungsi_p(n):
    hasil = 0
    for i in range(n):
        for j in range(i, n):
            hasil += i + j
    return hasil
```

(b)
```python
def fungsi_q(n):
    i = n
    while i > 1:
        i = i // 2
    return i
```

(c)
```python
def fungsi_r(n):
    for i in range(n):
        j = 1
        while j < n:
            j = j * 3
    return i + j
```

---

**Soal 2.5 [C4 - Menganalisis]**
Analisis kompleksitas waktu dari fungsi berikut secara step-by-step. Hitung T(n) secara eksplisit (bukan hanya Big-O), dan buktikan kelas Big-O-nya secara formal.

```python
def fungsi_analisis(n):
    total = 0
    for i in range(n):
        for j in range(1, n, 3):
            total += i * j
    for k in range(n):
        total -= k
    return total
```

---

**Soal 2.6 [C4 - Menganalisis]**
Seorang mahasiswa mengklaim bahwa algoritma dengan T(n) = n^2/4 + 5*sqrt(n) + 100 memiliki kompleksitas O(sqrt(n)) karena "sqrt(n) adalah fungsi terbesar yang dapat membagi semua suku". Identifikasi kesalahan dalam pemikiran ini dan berikan kelas Big-O yang benar beserta pembuktiannya.

---

**Soal 2.7 [C4 - Menganalisis]**
Untuk masing-masing algoritma berikut, tentukan kompleksitas waktu untuk ketiga kasus (best case, worst case, average case) dan nyatakan dalam notasi Big-O:

(a) Pencarian linear pada array tidak terurut.

(b) Pencarian biner pada array terurut.

(c) Bubble Sort dengan optimasi flag `swapped`.

---

**Soal 2.8 [C3 - Menerapkan]**
Implementasikan fungsi Python `hitung_faktorisasi_prima(n)` yang mengembalikan semua faktor prima dari n. Kemudian analisis kompleksitas waktu implementasi Anda untuk kasus terburuk. Bandingkan dengan kompleksitas versi yang menggunakan pendekatan optimasi pemeriksaan hingga sqrt(n) saja.

---

**Soal 2.9 [C4 - Menganalisis]**
Dua algoritma berikut menyelesaikan masalah yang sama:

- Algoritma X: O(n^2) dengan konstanta tersembunyi c_X = 2
- Algoritma Y: O(n log n) dengan konstanta tersembunyi c_Y = 50

(a) Untuk nilai n berapakah Algoritma X lebih cepat dari Algoritma Y?

(b) Untuk nilai n berapakah Algoritma Y mulai mengungguli Algoritma X?

(c) Apa implikasi praktis dari analisis ini untuk pemilihan algoritma dalam konteks rekayasa perangkat lunak?

---

**Soal 2.10 [C5 - Mengevaluasi]**
Sebuah algoritma rekursif memiliki relasi rekurensi: T(n) = 3T(n/3) + O(n).

(a) Gambarlah pohon rekursi untuk relasi ini dan hitung total biaya di setiap level.

(b) Tentukan jumlah level dalam pohon rekursi.

(c) Hitung T(n) secara total dan nyatakan dalam notasi Big-Theta.

(d) Verifikasikan hasil Anda menggunakan Master Theorem dengan mengidentifikasi nilai a, b, dan f(n).

---

**Soal 2.11 [C5 - Mengevaluasi]**
Pertimbangkan dua implementasi untuk menghitung elemen maksimum dari matriks n x n:

```python
# Implementasi I
def maks_matriks_i(matriks):
    n = len(matriks)
    maks = matriks[0][0]
    for i in range(n):
        for j in range(n):
            if matriks[i][j] > maks:
                maks = matriks[i][j]
    return maks

# Implementasi II
def maks_matriks_ii(matriks):
    return max(max(baris) for baris in matriks)
```

(a) Analisis kompleksitas waktu dan ruang bantu dari kedua implementasi (n adalah dimensi matriks, total elemen = n^2).

(b) Apakah perbedaan dalam cara penulisan kode mencerminkan perbedaan kelas kompleksitas? Jelaskan.

---

**Soal 2.12 [C6 - Mencipta]**
Rancang sebuah program Python yang dapat secara otomatis memperkirakan kelas kompleksitas waktu suatu fungsi yang diberikan secara black-box (hanya dapat diakses melalui pemanggilan) dengan cara mengukur waktu eksekusinya pada berbagai ukuran input dan menganalisis pola rasio pertumbuhannya. Program Anda harus dapat membedakan setidaknya antara kelas O(1), O(log n), O(n), O(n log n), dan O(n^2). Jelaskan metodologi yang Anda gunakan dan diskusikan limitasi pendekatan ini.

---

## Bacaan Lanjutan

**1. Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022).** *Introduction to Algorithms* (4th ed.). MIT Press.
Teks referensi standar untuk analisis algoritma di tingkat lanjut. Bab 3 (*Growth of Functions*) membahas notasi asimtotik secara sangat mendalam dan rigorous dengan pembuktian matematis yang lengkap. Bab 4 (*Divide-and-Conquer*) memperkenalkan Master Theorem dalam konteks algoritma divide-and-conquer. Sangat direkomendasikan sebagai referensi primer untuk pembaca yang ingin memahami fondasi teoritis yang lebih dalam.

**2. Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013).** *Data Structures and Algorithms in Python.* Wiley.
Buku teks yang secara eksplisit menggunakan Python sebagai bahasa implementasi. Bab 3 (*Algorithm Analysis*) memberikan penjelasan yang sangat aksesibel tentang notasi asimtotik dengan banyak contoh implementasi Python. Sangat relevan bagi pembaca yang ingin menghubungkan konsep teoritis langsung dengan praktik pemrograman Python.

**3. Knuth, D. E. (1997).** *The Art of Computer Programming, Vol. 1: Fundamental Algorithms* (3rd ed.). Addison-Wesley.
Karya magnum opus dari "bapak analisis algoritma". Bagian 1.2 memperkenalkan notasi asimtotik dari perspektif matematika yang paling dalam. Knuth sendiri yang mempopulerkan penggunaan notasi O, Omega, dan Theta dalam konteks ilmu komputer. Bacaan yang berat tetapi sangat memperkaya pemahaman fondasi matematika analisis algoritma.

**4. Sedgewick, R., & Wayne, K. (2011).** *Algorithms* (4th ed.). Addison-Wesley.
Buku teks yang terkenal dengan pendekatan yang sangat visual dan penekanan pada intuisi sebelum formalisme. Bab 1.4 (*Analysis of Algorithms*) menyajikan framework analisis yang pragmatis dengan banyak ilustrasi grafis. Sangat baik untuk membangun intuisi visual tentang pertumbuhan fungsi sebelum masuk ke formalisme matematis yang ketat.

**5. Skiena, S. S. (2020).** *The Algorithm Design Manual* (3rd ed.). Springer.
Buku yang memiliki perspektif unik: menggabungkan teori dengan pengalaman praktis pemecahan masalah nyata. Bagian pertama tentang analisis mencakup diskusi yang sangat berguna tentang bagaimana memilih algoritma yang tepat dalam konteks rekayasa. "War Stories" -- kisah-kisah pengalaman nyata menghadapi masalah algoritmik -- sangat inspiratif.

**6. Miller, B., & Ranum, D. (2013).** *Problem Solving with Algorithms and Data Structures Using Python.* Franklin Beedle & Associates. Tersedia daring di https://runestone.academy/ns/books/published/pythonds/index.html
Sumber daring gratis yang sangat baik dengan pendekatan interaktif menggunakan Python. Bab 2 (*Algorithm Analysis*) menyajikan topik ini dengan cara yang sangat mudah dipahami dengan visualisasi yang bersih. Sangat direkomendasikan sebagai bacaan pelengkap yang accessible untuk pemula.

**7. Roughgarden, T. (2022).** *Algorithms Illuminated (Part 1): The Basics.* Soundlikeyourself Publishing.
Berdasarkan kuliah populer penulis di Coursera. Memberikan penjelasan yang intuitif dan elegan tentang analisis asimtotik dengan pendekatan yang menyeimbangkan rigor matematika dengan aksesibilitas. Sangat baik untuk pembaca yang merasa buku Cormen terlalu padat pada awalnya.

---

*Bab selanjutnya (Bab 3) akan memperkenalkan struktur data pertama yang fundamental: Array dan Linked List. Pemahaman yang solid tentang analisis kompleksitas dari bab ini akan langsung diterapkan untuk membandingkan kinerja operasi-operasi dasar pada kedua struktur data tersebut.*

---

**Hak Cipta dan Penggunaan**

Materi bab ini dikembangkan untuk keperluan pendidikan di lingkungan Institut Bisnis dan Teknologi Indonesia (INSTIKI). Penggunaan untuk keperluan pendidikan non-komersial diperbolehkan dengan mencantumkan sumber. Seluruh contoh kode dalam bab ini menggunakan Python 3.x dan telah diuji untuk kebenaran logisnya.
