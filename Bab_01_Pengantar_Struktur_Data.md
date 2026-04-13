# BAB 1
# Pengantar Struktur Data: Fondasi Rekayasa Perangkat Lunak yang Efisien

---

> *"Algorithms + Data Structures = Programs."*
>
> — Niklaus Wirth, pencipta bahasa Pascal, dari judul bukunya yang berpengaruh (1976)

---

## Tujuan Pembelajaran

Setelah mempelajari bab ini, pembaca diharapkan mampu:

1. **Menjelaskan** (C2) definisi struktur data dan perannya dalam menentukan efisiensi waktu eksekusi serta penggunaan memori program komputer.
2. **Membedakan** (C2) karakteristik struktur data linear dan non-linear berdasarkan pola hubungan antar elemen, serta memberikan contoh penerapannya dalam perangkat lunak nyata.
3. **Membedakan** (C2) struktur data statis dan dinamis berdasarkan mekanisme alokasi memori dan fleksibilitas ukurannya.
4. **Menjelaskan** (C2) konsep Tipe Data Abstrak (Abstract Data Type/ADT) beserta prinsip abstraksi dan enkapsulasi yang mendasarinya.
5. **Menerapkan** (C3) konsep ADT dengan mengimplementasikan kelas Python yang mendefinisikan struktur data beserta operasi-operasinya secara lengkap dan benar.
6. **Menganalisis** (C4) dampak pemilihan struktur data terhadap kompleksitas waktu dan ruang suatu algoritma menggunakan notasi Big-O.
7. **Mengevaluasi** (C5) kesesuaian pemilihan struktur data untuk skenario pemrograman tertentu berdasarkan pertimbangan efisiensi, kemudahan implementasi, dan skalabilitas sistem.

---

## 1.1 Mengapa Struktur Data Adalah Inti dari Setiap Program

Bayangkan sebuah perpustakaan besar dengan koleksi ratusan ribu buku. Tanpa sistem pengorganisasian yang dirancang dengan cermat, seorang pengunjung yang hendak mencari sebuah buku tertentu harus memeriksa setiap rak satu per satu, dari buku pertama hingga buku terakhir. Proses ini tidak hanya memakan waktu yang sangat lama, tetapi juga akan menjadi mustahil secara praktis seiring bertambahnya jumlah koleksi. Perpustakaan modern mengatasinya dengan sistem katalog, kode klasifikasi Dewey Decimal, dan pengorganisasian fisik rak berdasarkan kategori, sehingga pencarian yang sama dapat diselesaikan dalam hitungan menit. Analogi ini secara akurat menggambarkan permasalahan inti yang diselesaikan oleh struktur data dalam dunia rekayasa perangkat lunak.

Setiap program komputer, pada hakikatnya, adalah sebuah mesin yang menerima data sebagai masukan, mengolahnya melalui serangkaian operasi, dan menghasilkan keluaran yang bermakna. Kualitas program tersebut tidak hanya ditentukan oleh kebenaran logikanya, tetapi juga oleh seberapa efisien ia menyimpan dan mengakses data sepanjang proses pengolahan berlangsung. Di sinilah struktur data (data structure) memainkan peran yang tidak dapat diabaikan.

Struktur data adalah cara sistematis untuk menyimpan, mengorganisasi, dan mengelola data di dalam memori komputer sehingga data tersebut dapat diakses dan dimodifikasi secara efisien. Definisi yang tampak sederhana ini mencakup dua dimensi yang saling bergantung: pertama, cara data direpresentasikan dan disusun di dalam memori, dan kedua, himpunan operasi yang dapat dilakukan pada data tersebut. Tanpa mempertimbangkan kedua dimensi ini secara bersama-sama, seorang programmer tidak dapat membuat keputusan yang tepat tentang bagaimana mengelola data dalam programnya.

Goodrich, Tamassia, dan Goldwasser (2013) mendefinisikan struktur data sebagai kombinasi dari representasi data dan operasi data yang bekerja pada representasi tersebut. Pengertian ini menekankan bahwa struktur data bukan sekadar tempat penyimpanan pasif, melainkan entitas aktif yang mendefinisikan cara interaksi dengan data yang dikandungnya. Sebuah larik (array), misalnya, bukan hanya "deretan kotak berisi nilai", melainkan sebuah struktur yang secara eksplisit mendukung operasi akses berbasis indeks dalam waktu konstan, sekaligus tidak secara efisien mendukung penyisipan di posisi tengah.

### 1.1.1 Dampak Nyata Pemilihan Struktur Data

Untuk memahami betapa seriusnya dampak pemilihan struktur data, pertimbangkan skenario yang sangat konkret: sebuah mesin pencari perlu memeriksa apakah suatu kata kunci telah terindeks di antara seratus juta entri yang tersimpan. Jika data disimpan dalam larik tak terurut, setiap pencarian membutuhkan pemeriksaan rata-rata setengah dari seluruh data, yakni lima puluh juta operasi perbandingan. Pada komputer modern yang mampu melakukan sekitar satu miliar operasi per detik, ini berarti setiap pencarian membutuhkan sekitar 50 milidetik. Angka ini mungkin terdengar kecil, tetapi jika mesin pencari tersebut melayani sepuluh juta kueri per detik (seperti Google pada puncak aktivitasnya), sistem tersebut akan lumpuh secara matematika.

Bandingkan dengan penggunaan tabel hash (hash table), yaitu struktur data yang dirancang khusus untuk pencarian berbasis kunci. Dengan tabel hash yang diimplementasikan dengan baik, operasi pencarian yang sama rata-rata hanya membutuhkan satu operasi, terlepas dari berapa pun jumlah data yang tersimpan. Perbedaan antara O(n) dan O(1) ini bukan sekadar perbedaan angka di atas kertas, melainkan perbedaan antara sistem yang berjalan dengan mulus dan sistem yang tidak dapat beroperasi sama sekali.

Cormen et al. (2022) tidak berlebihan ketika menyatakan bahwa pemilihan struktur data yang tepat atau salah dapat menentukan perbedaan antara solusi yang berjalan dalam hitungan detik dan solusi yang membutuhkan waktu lebih dari usia alam semesta untuk menyelesaikan komputasi yang sama. Pernyataan ini mencerminkan realitas yang dihadapi oleh setiap insinyur perangkat lunak dalam karir profesionalnya.

Dampak pemilihan struktur data dapat dirasakan pada empat dimensi utama.

**Efisiensi Waktu Eksekusi.** Algoritma pencarian biner pada larik terurut membutuhkan paling banyak log2(n) langkah untuk menemukan elemen di antara n data. Untuk n = 1.000.000, ini berarti maksimal 20 langkah, dibandingkan dengan rata-rata 500.000 langkah untuk pencarian linear. Perbedaan dua puluh berbanding lima ratus ribu ini adalah perbedaan antara pengalaman pengguna yang menyenangkan dan yang membuat frustrasi.

**Efisiensi Penggunaan Memori.** Pohon biner (binary tree) yang menyimpan satu juta data integer memerlukan ruang memori yang lebih besar dibandingkan larik yang menyimpan data yang sama, karena setiap simpul (node) dalam pohon membawa overhead berupa pointer ke simpul anak kiri dan kanan. Pilihan antara efisiensi waktu dan efisiensi memori ini adalah salah satu trade-off fundamental dalam rekayasa perangkat lunak.

**Kemudahan Pemeliharaan Kode.** Penggunaan antrian (queue) untuk memodelkan antrean pemrosesan tugas membuat kode jauh lebih mudah dipahami oleh siapapun yang membacanya, dibandingkan dengan pengelolaan manual indeks pada larik biasa. Kode yang bermakna semantis lebih mudah diuji, diperbaiki, dan dikembangkan oleh tim manapun.

**Skalabilitas Sistem.** Sistem yang dirancang dengan struktur data yang tepat dapat menangani pertumbuhan data yang dramatis tanpa perubahan arsitektur yang mendasar. Tabel hash yang digunakan basis data modern, misalnya, tetap efisien bahkan ketika volume data tumbuh dari ribuan menjadi miliaran rekaman.

---

## 1.2 Hubungan Simbiotik antara Struktur Data dan Algoritma

Tidak ada pembahasan tentang struktur data yang lengkap tanpa membicarakan hubungannya yang tak terpisahkan dengan algoritma. Donald Knuth, salah satu tokoh paling berpengaruh dalam sejarah ilmu komputer, mengajukan rumusan yang kemudian menjadi moto disiplin ini: "Program = Algoritma + Struktur Data." Niklaus Wirth, yang menciptakan bahasa pemrograman Pascal, mengangkat persamaan ini menjadi judul bukunya yang terbit pada tahun 1976.

Rumusan sederhana ini mengandung wawasan yang mendalam. Algoritma (algorithm) adalah prosedur langkah-demi-langkah yang terdefinisi dengan baik untuk menyelesaikan suatu masalah komputasi dalam waktu yang terbatas. Struktur data, di sisi lain, adalah kerangka yang menentukan bagaimana data disimpan dan diorganisasi untuk mendukung eksekusi algoritma tersebut. Keduanya bukan entitas yang independen, melainkan dua sisi dari satu kesatuan yang saling mendefinisikan.

Hubungan simbiotik ini bekerja dalam dua arah. Pertama, algoritma yang berbeda secara alami menuntut struktur data yang berbeda. Algoritma pengurutan cepat (quicksort) bekerja paling efisien pada larik yang mendukung akses berbasis indeks dalam waktu konstan. Algoritma penelusuran mendalam (depth-first search) secara alami memanfaatkan tumpukan (stack) untuk menyimpan simpul yang akan dikunjungi. Algoritma Dijkstra untuk mencari jalur terpendek dalam graf memerlukan antrian prioritas (priority queue) agar dapat bekerja secara efisien. Memilih struktur data yang tidak selaras dengan algoritma akan menghasilkan implementasi yang rumit, tidak efisien, atau bahkan tidak benar secara semantis.

Kedua, ketersediaan struktur data tertentu membuka kemungkinan algoritma yang baru dan lebih efisien. Penemuan tabel hash sebagai struktur data membuka jalan bagi keluarga algoritma yang mengandalkan pencarian waktu-konstan, yang sebelumnya tidak terbayangkan dengan struktur data yang ada. Demikian pula, konsep pohon biner seimbang (balanced binary search tree) memungkinkan operasi pencarian, penyisipan, dan penghapusan yang semuanya berjalan dalam O(log n) untuk data yang terus berubah.

Pemahaman tentang hubungan ini mengubah cara seorang programmer memandang masalah. Alih-alih langsung memikirkan "bagaimana saya menulis kode untuk menyelesaikan ini?", seorang insinyur perangkat lunak yang terlatih terlebih dahulu bertanya: "Pola akses data seperti apa yang dituntut oleh masalah ini? Operasi mana yang harus cepat? Seberapa sering data berubah?" Jawaban atas pertanyaan-pertanyaan ini mengarahkan pemilihan struktur data yang tepat, yang pada gilirannya membatasi dan memungkinkan pilihan algoritma yang tersedia.

---

## 1.3 Klasifikasi Struktur Data

Pemahaman tentang lanskap struktur data yang tersedia dimulai dari kemampuan mengklasifikasikannya berdasarkan karakteristik struktural yang mendasar. Dua pasang klasifikasi utama akan diuraikan dalam bagian ini: linear versus non-linear, dan statis versus dinamis.

### 1.3.1 Struktur Data Linear

Pada struktur data linear, elemen-elemen data disusun secara berurutan dalam satu dimensi. Setiap elemen, kecuali yang pertama dan yang terakhir, memiliki tepat satu elemen pendahulu (predecessor) dan tepat satu elemen penerus (successor). Properti urutan ini berarti bahwa seluruh elemen dapat ditelusuri satu per satu dalam satu lintasan linear, tanpa perlu mekanisme penelusuran yang lebih kompleks.

Sifat linear ini bukan berarti elemen-elemen tersebut harus tersimpan secara berdekatan di memori fisik komputer. Yang mendefinisikan linearitas adalah hubungan logis antar elemen, bukan lokasi fisiknya. Sebuah daftar berantai (linked list), misalnya, dapat memiliki elemen-elemen yang tersebar di berbagai lokasi memori yang tidak berdekatan, namun tetap dianggap linear karena setiap elemen memiliki referensi eksplisit ke satu elemen berikutnya, membentuk rantai linear yang terdefinisi dengan baik.

**Larik (Array)** adalah struktur data linear paling mendasar. Elemen-elemen larik disimpan secara berurutan di blok memori yang berdekatan, dan setiap elemen dapat diakses langsung melalui indeksnya dalam waktu konstan O(1). Sifat penyimpanan berurutan inilah yang memungkinkan akses berbasis indeks yang cepat, karena alamat memori elemen ke-i dapat dihitung langsung sebagai: alamat_awal + (i × ukuran_elemen).

```
Gambar 1.1 Representasi Larik dalam Memori

Indeks:  [0]  [1]  [2]  [3]  [4]
         +----+----+----+----+----+
Nilai:   | 10 | 25 | 37 | 42 | 58 |
         +----+----+----+----+----+
Memori:  1000 1004 1008 1012 1016   (asumsi integer 4 byte)

Akses nilai[2] = 10 + (2 × 4) - tidak perlu penelusuran urutan.
Setiap elemen memiliki tepat satu pendahulu dan satu penerus.
```

**Daftar Berantai (Linked List)** menyimpan elemen dalam simpul-simpul terpisah yang masing-masing mengandung data dan referensi (atau pointer) ke simpul berikutnya. Tidak ada jaminan kedekatan di memori fisik, tetapi urutan logis dijaga melalui rantai referensi tersebut. Linked list unggul dalam penyisipan dan penghapusan di posisi manapun dalam O(1) (jika referensi ke posisi tersebut sudah diketahui), tetapi akses elemen ke-i memerlukan penelusuran dari awal dalam O(n).

```
Gambar 1.2 Representasi Daftar Berantai

+------+----+    +------+----+    +------+----+    +------+------+
| data |next|--->| data |next|--->| data |next|--->| data | NULL |
|  10  |    |    |  25  |    |    |  37  |    |    |  42  |      |
+------+----+    +------+----+    +------+----+    +------+------+
  Simpul 1          Simpul 2          Simpul 3          Simpul 4

Setiap simpul menyimpan data dan referensi ke simpul berikutnya.
NULL menandai akhir daftar.
```

**Tumpukan (Stack)** adalah struktur data linear yang membatasi akses hanya pada satu ujung, yang disebut puncak (top). Aturan akses ini dikenal sebagai LIFO (Last In, First Out): elemen yang terakhir dimasukkan adalah yang pertama dikeluarkan, persis seperti tumpukan piring di restoran. Stack menyediakan operasi push (menambah ke puncak) dan pop (mengambil dari puncak) yang keduanya berjalan dalam O(1).

```
Gambar 1.3 Representasi Tumpukan (Stack)

Operasi: push(10), push(25), push(37), push(42)

Setelah keempat push:
          +----+
  TOP --> | 42 |  <- Elemen terakhir masuk, pertama keluar
          +----+
          | 37 |
          +----+
          | 25 |
          +----+
BOTTOM -> | 10 |  <- Elemen pertama masuk, terakhir keluar
          +----+

LIFO: Last In, First Out
pop() berikutnya akan mengembalikan 42.
```

**Antrian (Queue)** adalah struktur data linear yang bekerja mengikuti prinsip FIFO (First In, First Out): elemen yang pertama masuk adalah yang pertama keluar, persis seperti antrean manusia di loket. Penyisipan dilakukan di bagian belakang (rear) dan penghapusan dilakukan di bagian depan (front).

```
Gambar 1.4 Representasi Antrian (Queue)

Setelah enqueue("Budi"), enqueue("Sari"), enqueue("Andi"), enqueue("Dewi"):

REAR -->  +------+------+------+------+  <-- FRONT
          | Dewi | Andi | Sari | Budi |
          +------+------+------+------+
Urutan    masuk:  Budi -> Sari -> Andi -> Dewi
Urutan keluar: Budi -> Sari -> Andi -> Dewi

FIFO: First In, First Out
dequeue() berikutnya akan mengembalikan "Budi".
```

Keempat struktur data linear di atas memiliki karakteristik, kekuatan, dan kelemahan yang berbeda-beda. Tabel berikut merangkum perbandingan operasional utamanya.

```
Tabel 1.1 Perbandingan Kompleksitas Operasi Struktur Data Linear

+----------------+----------+-----------+----------+----------+
| Struktur Data  |  Akses   |  Sisip    |  Hapus   |  Cari    |
|                |  [i]     |  Awal/    |  Awal/   | Elemen   |
|                |          |  Tengah   |  Tengah  |          |
+----------------+----------+-----------+----------+----------+
| Array          |  O(1)    |  O(n)     |  O(n)    |  O(n)    |
| Linked List    |  O(n)    |  O(1)*    |  O(1)*   |  O(n)    |
| Stack          |  O(n)    |  O(1)     |  O(1)    |  O(n)    |
| Queue          |  O(n)    |  O(1)     |  O(1)    |  O(n)    |
+----------------+----------+-----------+----------+----------+
* Jika referensi ke posisi sudah diketahui.
Notasi O menunjukkan kompleksitas kasus terburuk (worst case).
```

### 1.3.2 Struktur Data Non-Linear

Berbeda dari struktur linear, pada struktur data non-linear satu elemen dapat terhubung ke lebih dari satu elemen lain, sehingga membentuk topologi yang lebih kaya: hierarki atau jaringan. Penelusuran seluruh elemen tidak dapat dilakukan dalam satu lintasan linear sederhana, melainkan memerlukan algoritma penelusuran khusus yang memperhitungkan kompleksitas hubungan antar elemen.

**Pohon (Tree)** merepresentasikan hubungan hierarkis antar elemen. Satu elemen khusus disebut akar (root) yang tidak memiliki induk (parent). Setiap elemen lain memiliki tepat satu induk, tetapi dapat memiliki nol atau lebih anak (children). Elemen tanpa anak disebut daun (leaf). Pohon biner (binary tree) adalah kasus khusus di mana setiap elemen memiliki paling banyak dua anak.

```
Gambar 1.5 Representasi Pohon Biner

                    [A]                <- Akar (Root), kedalaman 0
                   /   \
                [B]     [C]            <- Simpul internal, kedalaman 1
               /  \       \
             [D]  [E]     [F]          <- Daun (Leaf), kedalaman 2

Properti pohon:
- A adalah akar (tidak punya induk)
- B dan C adalah anak dari A
- D, E, F adalah daun (tidak punya anak)
- Tinggi pohon (height) = 2
- Jumlah simpul = 6
```

**Graf (Graph)** adalah struktur data paling umum yang merepresentasikan hubungan jaringan. Tidak ada hierarki atau batasan tentang pola koneksi antar elemen. Setiap elemen (disebut simpul atau vertex) dapat terhubung ke elemen manapun melalui sisi (edge). Graf dapat berarah (directed graph) jika hubungan antar elemen bersifat satu arah, atau tak berarah (undirected graph) jika hubungan bersifat dua arah.

```
Gambar 1.6 Representasi Graf Tak Berarah

        (A)--------(B)
       /  \          \
     (C)  (D)--------(E)
           |
          (F)

Vertex: A, B, C, D, E, F
Edge: A-B, A-C, A-D, B-E, D-E, D-F

Graf merepresentasikan jaringan dengan hubungan yang bebas.
Tidak ada batasan tentang berapa banyak koneksi per simpul.
```

Perbedaan fundamental antara struktur linear dan non-linear tercermin dalam karakteristik traversal-nya. Penelusuran graf memerlukan algoritma khusus seperti Breadth-First Search (BFS) atau Depth-First Search (DFS), yang harus secara eksplisit menangani kemungkinan siklus (satu simpul dapat dijangkau melalui lebih dari satu jalur) dan berbagai pola konektivitas yang kompleks.

### 1.3.3 Struktur Data Statis dan Dinamis

Dimensi klasifikasi kedua yang penting adalah berdasarkan mekanisme alokasi memori. Pembedaan ini berkaitan langsung dengan bagaimana program menggunakan sumber daya memori komputer selama eksekusinya.

**Struktur data statis** memiliki ukuran yang ditentukan pada saat program dikompilasi atau pada saat alokasi pertama kali dilakukan, dan ukuran ini tidak berubah selama program berjalan. Keuntungannya adalah kesederhanaan implementasi dan kecepatan akses, karena seluruh ruang memori tersedia seketika dan dapat diakses dengan kalkulasi indeks langsung. Kelemahannya adalah pemborosan memori jika data aktual lebih sedikit dari kapasitas yang dialokasikan, dan ketidakmampuan menangani data yang melebihi kapasitas.

```
Gambar 1.7 Masalah Kapasitas pada Struktur Data Statis

Array dengan kapasitas 10 elemen:
+----+----+----+----+----+----+----+----+----+----+
| 12 | 34 | 56 |    |    |    |    |    |    |    |
+----+----+----+----+----+----+----+----+----+----+
 [0]  [1]  [2]  [3]  [4]  [5]  [6]  [7]  [8]  [9]

Hanya 3 slot terisi dari 10 yang dialokasikan.
Sisa 7 slot (70% memori) terbuang sia-sia.

Atau sebaliknya: jika data ke-11 datang, tidak ada ruang
dan program harus menangani kondisi overflow.
```

**Struktur data dinamis** dapat tumbuh atau menyusut selama program berjalan, menyesuaikan diri dengan kebutuhan aktual data yang perlu disimpan. Memori dialokasikan saat elemen baru ditambahkan dan dibebaskan saat elemen dihapus. Ini menghasilkan penggunaan memori yang lebih efisien, tetapi dengan biaya kompleksitas implementasi yang lebih tinggi karena programmer (atau sistem runtime) harus mengelola alokasi dan dealokasi memori secara eksplisit.

---

> **Catatan Penting: Dinamisme di Python**
>
> Dalam Python, hampir semua struktur data bawaan bersifat dinamis. Tipe `list`, `dict`, dan `set` dapat tumbuh dan menyusut secara otomatis sesuai kebutuhan. Python mengelola memori melalui mekanisme penghitung referensi (reference counting) dan pengumpulan sampah (garbage collection), sehingga programmer tidak perlu mengelola alokasi memori secara manual seperti yang diperlukan di C atau C++. Tipe `tuple` adalah pengecualian: ia immutable (tidak dapat diubah setelah dibuat), membuatnya mirip struktur statis dalam hal konten, meskipun alokasi memorinya tetap dikelola secara dinamis oleh interpreter Python.

---

## 1.4 Tipe Data Abstrak: Jembatan antara Spesifikasi dan Implementasi

Setelah memahami apa itu struktur data dan bagaimana mengklasifikasikannya, langkah selanjutnya adalah memahami konsep yang menjembatani dunia teori dengan dunia implementasi: Tipe Data Abstrak (Abstract Data Type atau ADT).

### 1.4.1 Definisi dan Motivasi ADT

Tipe Data Abstrak adalah model matematika untuk suatu tipe data yang didefinisikan sepenuhnya oleh perilakunya (behavior) dari sudut pandang pengguna, terlepas dari bagaimana perilaku tersebut diimplementasikan di bawahnya. ADT menetapkan tiga hal secara formal:

1. **Domain (Domain)**: Himpunan nilai yang valid dapat dikandung oleh tipe data tersebut.
2. **Operasi (Operations)**: Himpunan fungsi yang dapat dilakukan pada nilai-nilai dalam domain tersebut, beserta spesifikasi masukan dan keluarannya.
3. **Aksioma (Axioms)**: Aturan-aturan yang mengatur perilaku operasi-operasi tersebut secara formal.

Motivasi utama untuk memperkenalkan konsep ADT adalah prinsip abstraksi (abstraction) dan enkapsulasi (encapsulation). Abstraksi berarti pengguna sebuah komponen perangkat lunak hanya perlu mengetahui apa yang dilakukan oleh komponen tersebut, bukan bagaimana ia bekerja di dalamnya. Enkapsulasi berarti detail implementasi disembunyikan dari pengguna, membatasi akses hanya melalui antarmuka (interface) yang terdefinisi.

Analogi yang paling mudah dipahami adalah remote kontrol televisi. Seorang pengguna menekan tombol "Volume Up" dan volume bertambah. Pengguna tidak perlu mengetahui rangkaian elektronik di dalam remote, frekuensi sinyal inframerah yang dikirimkan, atau logika pada chip penerima di televisi. Remote kontrol mendefinisikan sebuah ADT: ia memiliki domain (perintah yang dapat dikirimkan), operasi (menekan tombol), dan aksioma (menekan Volume Up menambah volume; menekan Volume Up sepuluh kali dari batas bawah menghasilkan volume yang lebih tinggi dari menekan sekali).

Pemisahan antara spesifikasi ADT dan implementasinya membawa tiga manfaat rekayasa yang sangat berharga.

**Modularitas**: Implementasi sebuah ADT dapat diganti sepenuhnya tanpa mempengaruhi kode yang menggunakannya, selama antarmuka dipertahankan. Sebuah ADT Stack yang awalnya diimplementasikan menggunakan larik dapat diganti dengan implementasi berbasis daftar berantai, dan seluruh program yang menggunakan Stack tersebut tidak perlu diubah sama sekali.

**Abstraksi Masalah**: Pemrogram yang menggunakan ADT dapat berfokus pada masalah yang sedang dipecahkan, bukan pada mekanisme penyimpanan data. Ini mengurangi beban kognitif dan memungkinkan pemecahan masalah yang lebih tinggi levelnya.

**Kemudahan Pengujian**: Spesifikasi ADT dapat diverifikasi secara independen dari implementasinya. Rangkaian uji (test suite) yang mengonfirmasi bahwa implementasi mematuhi semua aksioma ADT dapat ditulis satu kali dan digunakan untuk menguji implementasi manapun.

### 1.4.2 ADT Stack: Contoh Spesifikasi Formal

Untuk membuat konsep ADT lebih konkret, kita akan menspesifikasikan ADT Stack secara formal. Stack adalah koleksi elemen dengan aturan akses LIFO (Last In, First Out).

```
Tabel 1.2 Spesifikasi ADT Stack

+-------------+------------------+------------------+---------------------+
| Operasi     | Parameter        | Nilai Kembali    | Kondisi/Aksioma     |
+-------------+------------------+------------------+---------------------+
| push(item)  | item: tipe apa   | None             | Selalu berhasil;    |
|             | pun              |                  | size bertambah 1    |
+-------------+------------------+------------------+---------------------+
| pop()       | -                | Item dari puncak | Gagal (IndexError)  |
|             |                  |                  | jika is_empty()     |
+-------------+------------------+------------------+---------------------+
| peek()      | -                | Item dari puncak | Gagal (IndexError)  |
|             |                  | (tidak hapus)    | jika is_empty()     |
+-------------+------------------+------------------+---------------------+
| is_empty()  | -                | Boolean          | Selalu berhasil     |
+-------------+------------------+------------------+---------------------+
| size()      | -                | Integer >= 0     | Selalu berhasil     |
+-------------+------------------+------------------+---------------------+

Aksioma kunci:
  1. Setelah push(x), peek() mengembalikan x.
  2. Setelah push(x), pop() mengembalikan x dan is_empty()
     kembali ke kondisi sebelum push(x).
  3. Setelah Stack baru dibuat, is_empty() == True dan size() == 0.
```

Perhatikan bahwa spesifikasi di atas sama sekali tidak menyebutkan apakah Stack diimplementasikan menggunakan larik, daftar berantai, atau mekanisme penyimpanan lainnya. Inilah esensi dari abstraksi.

---

> **Tahukah Anda?**
>
> Konsep Tipe Data Abstrak pertama kali diperkenalkan secara formal oleh Barbara Liskov dan Stephen Zilles dalam makalah mereka "Programming with Abstract Data Types" (1974), yang dipresentasikan di ACM SIGPLAN Workshop on Programming Languages. Ide ini kemudian menjadi fondasi dari pemrograman berorientasi objek (object-oriented programming), yang mendominasi industri perangkat lunak selama dekade 1990-an hingga kini. Liskov kemudian menerima Turing Award pada tahun 2008 atas kontribusinya yang monumental dalam ilmu komputer, termasuk prinsip substitusi Liskov (Liskov Substitution Principle) yang menjadi salah satu dari prinsip SOLID dalam rekayasa perangkat lunak modern.

---

## 1.5 Implementasi ADT dalam Python

Python, sebagai bahasa pemrograman multi-paradigma yang mendukung pemrograman berorientasi objek secara penuh, menyediakan mekanisme kelas (class) yang ideal untuk mengimplementasikan ADT. Kelas Python memungkinkan kita mendefinisikan tipe data baru beserta himpunan operasi yang valid, sekaligus menyembunyikan detail implementasi di balik antarmuka yang terkontrol.

### 1.5.1 Model Objek Python: Variabel sebagai Referensi

Sebelum mengimplementasikan ADT, penting untuk memahami satu aspek fundamental dari Python yang secara langsung memengaruhi perilaku struktur data: Python menggunakan model di mana semua nilai adalah objek (object), dan variabel adalah referensi (references) atau label yang menunjuk ke objek tersebut di memori.

Berbeda dengan bahasa seperti C atau Java (untuk tipe primitif), di mana variabel adalah kotak yang secara langsung menyimpan nilai, variabel Python hanyalah nama yang "menempel" pada sebuah objek. Ini memiliki implikasi penting: dua variabel dapat menunjuk ke objek yang sama, sehingga perubahan melalui satu variabel akan terlihat melalui variabel lainnya.

```python
# ============================================================
# Kode 1.1: Demonstrasi Model Referensi Python
# ============================================================

print("=== MODEL REFERENSI DI PYTHON ===\n")

# Variabel adalah referensi, bukan kotak penyimpan nilai
a = [1, 2, 3]
b = a           # b dan a menunjuk ke OBJEK YANG SAMA

print(f"a = {a}")
print(f"b = {b}")
print(f"a is b: {a is b}")         # True: satu objek, dua nama
print(f"id(a) = {id(a)}")
print(f"id(b) = {id(b)}")          # id sama: alamat memori identik

# Modifikasi melalui b juga mengubah a
b.append(4)
print(f"\nSetelah b.append(4):")
print(f"a = {a}")                  # [1, 2, 3, 4] -- ikut berubah!
print(f"b = {b}")                  # [1, 2, 3, 4]

# Untuk membuat salinan independen, gunakan .copy()
print("\n=== MEMBUAT SALINAN INDEPENDEN ===")
c = [1, 2, 3]
d = c.copy()    # d adalah objek LIST BARU

d.append(4)
print(f"c = {c}")                  # [1, 2, 3] -- tidak berubah
print(f"d = {d}")                  # [1, 2, 3, 4]
print(f"c is d: {c is d}")        # False: dua objek berbeda
```

```
Gambar 1.8 Visualisasi Model Referensi Python di Memori

Setelah: a = [1, 2, 3] dan b = a

Heap (penyimpanan objek):
+---------------------------+
|  Objek List               |
|  Nilai: [1, 2, 3]         | <--- Alamat: 0x7f3a2b4c
|  Ref count: 2             |
+---------------------------+
           ^         ^
           |         |
    a (label)   b (label)

Stack variabel (frame fungsi):
  a ----+
        +----> [1, 2, 3] di heap (satu objek)
  b ----+

Modifikasi apapun melalui a atau b memengaruhi OBJEK YANG SAMA.
```

Pemahaman tentang referensi objek ini sangat kritis ketika bekerja dengan struktur data. Sebuah kesalahan umum yang sering dilakukan oleh pemrogram Python pemula adalah membuat "salinan" struktur data yang sebenarnya hanyalah alias, lalu terkejut ketika keduanya berubah secara bersamaan.

### 1.5.2 Implementasi Lengkap ADT Stack

Berikut adalah implementasi lengkap ADT Stack dalam Python menggunakan kelas, sesuai dengan spesifikasi yang telah dirumuskan di Tabel 1.2.

```python
# ============================================================
# Kode 1.2: Implementasi ADT Stack
# ============================================================

class Stack:
    """
    Implementasi ADT Stack menggunakan list Python.

    Stack adalah struktur data linear yang mengikuti prinsip LIFO
    (Last In, First Out): elemen yang terakhir dimasukkan adalah
    elemen yang pertama dikeluarkan.

    Analogi: Tumpukan piring di restoran, tombol undo pada
    editor teks, atau tumpukan buku di atas meja.

    Semua operasi utama (push, pop, peek, is_empty, size)
    memiliki kompleksitas waktu O(1).

    Contoh penggunaan:
        >>> s = Stack()
        >>> s.push(10)
        >>> s.push(20)
        >>> s.peek()
        20
        >>> s.pop()
        20
        >>> s.size()
        1
    """

    def __init__(self):
        """Menginisialisasi stack kosong."""
        self._data = []  # Atribut privat: detail implementasi tersembunyi

    def push(self, item):
        """
        Menambahkan item ke puncak stack.

        Parameter:
            item: Elemen yang akan ditambahkan (tipe data apapun).

        Kompleksitas waktu: O(1) amortized.
        """
        self._data.append(item)

    def pop(self):
        """
        Menghapus dan mengembalikan elemen dari puncak stack.

        Returns:
            Elemen yang berada di puncak stack.

        Raises:
            IndexError: Jika stack dalam kondisi kosong.

        Kompleksitas waktu: O(1).
        """
        if self.is_empty():
            raise IndexError("pop dari stack yang kosong")
        return self._data.pop()

    def peek(self):
        """
        Mengembalikan elemen di puncak stack tanpa menghapusnya.

        Returns:
            Elemen yang berada di puncak stack.

        Raises:
            IndexError: Jika stack dalam kondisi kosong.

        Kompleksitas waktu: O(1).
        """
        if self.is_empty():
            raise IndexError("peek pada stack yang kosong")
        return self._data[-1]

    def is_empty(self):
        """
        Memeriksa apakah stack tidak mengandung elemen apapun.

        Returns:
            True jika stack kosong, False sebaliknya.

        Kompleksitas waktu: O(1).
        """
        return len(self._data) == 0

    def size(self):
        """
        Mengembalikan jumlah elemen yang saat ini ada dalam stack.

        Returns:
            Integer non-negatif yang menyatakan jumlah elemen.

        Kompleksitas waktu: O(1).
        """
        return len(self._data)

    def __str__(self):
        """Representasi string untuk keperluan cetak dan debugging."""
        if self.is_empty():
            return "Stack: [] (kosong)"
        return f"Stack: {self._data} <- TOP"

    def __repr__(self):
        """Representasi resmi objek untuk keperluan debugging."""
        return f"Stack({self._data!r})"


# ============================================================
# Demonstrasi lengkap ADT Stack
# ============================================================

def demonstrasi_stack():
    """Fungsi demonstrasi semua operasi ADT Stack."""
    print("=" * 55)
    print("      DEMONSTRASI ADT STACK")
    print("=" * 55)

    tumpukan = Stack()
    print(f"\n[1] Stack baru dibuat: {tumpukan}")
    print(f"    is_empty() = {tumpukan.is_empty()}")
    print(f"    size()     = {tumpukan.size()}")

    print("\n[2] Operasi push berurutan:")
    for nilai in [10, 25, 37, 42]:
        tumpukan.push(nilai)
        print(f"    push({nilai:>2}) -> {tumpukan}")

    print(f"\n[3] Memeriksa puncak tanpa mengambil:")
    print(f"    peek()  = {tumpukan.peek()}")
    print(f"    size()  = {tumpukan.size()}  (tidak berubah)")

    print("\n[4] Operasi pop satu per satu:")
    while not tumpukan.is_empty():
        diambil = tumpukan.pop()
        print(f"    pop() -> {diambil} | Sisa: {tumpukan}")

    print("\n[5] Penanganan error saat pop pada stack kosong:")
    try:
        tumpukan.pop()
    except IndexError as kesalahan:
        print(f"    IndexError: {kesalahan}")


if __name__ == "__main__":
    demonstrasi_stack()
```

Keluaran yang dihasilkan oleh program di atas adalah sebagai berikut.

```
=======================================================
      DEMONSTRASI ADT STACK
=======================================================

[1] Stack baru dibuat: Stack: [] (kosong)
    is_empty() = True
    size()     = 0

[2] Operasi push berurutan:
    push(10) -> Stack: [10] <- TOP
    push(25) -> Stack: [10, 25] <- TOP
    push(37) -> Stack: [10, 25, 37] <- TOP
    push(42) -> Stack: [10, 25, 37, 42] <- TOP

[3] Memeriksa puncak tanpa mengambil:
    peek()  = 42
    size()  = 4  (tidak berubah)

[4] Operasi pop satu per satu:
    pop() -> 42 | Sisa: Stack: [10, 25, 37] <- TOP
    pop() -> 37 | Sisa: Stack: [10, 25] <- TOP
    pop() -> 25 | Sisa: Stack: [10] <- TOP
    pop() -> 10 | Sisa: Stack: [] (kosong)

[5] Penanganan error saat pop pada stack kosong:
    IndexError: pop dari stack yang kosong
```

Perhatikan bagaimana antarmuka yang diekspos kepada pengguna (`push`, `pop`, `peek`, `is_empty`, `size`) sama sekali tidak mengungkapkan bahwa di baliknya ada sebuah `list` Python. Atribut `_data` ditandai sebagai privat dengan awalan garis bawah, yang merupakan konvensi Python untuk menunjukkan bahwa atribut tersebut tidak dimaksudkan untuk diakses langsung dari luar kelas.

### 1.5.3 Implementasi ADT Queue

Untuk memperkuat pemahaman tentang ADT, berikut adalah implementasi ADT Queue yang mengikuti prinsip FIFO.

```python
# ============================================================
# Kode 1.3: Implementasi ADT Queue dan Simulasi Antrian
# ============================================================

class Queue:
    """
    Implementasi ADT Queue (Antrian) menggunakan list Python.

    Queue mengikuti prinsip FIFO (First In, First Out):
    elemen yang pertama masuk adalah yang pertama keluar,
    persis seperti antrian kasir di supermarket.

    Operasi:
        enqueue(item) : Menambah item ke belakang antrian. O(1)
        dequeue()     : Mengambil item dari depan antrian. O(n)*
        front()       : Melihat item terdepan tanpa menghapus. O(1)
        is_empty()    : Memeriksa apakah antrian kosong. O(1)
        size()        : Mengembalikan jumlah item. O(1)

    *Catatan: dequeue() pada implementasi berbasis list memiliki
    kompleksitas O(n) karena pergeseran elemen. Implementasi
    berbasis collections.deque mencapai O(1).
    """

    def __init__(self):
        """Menginisialisasi antrian kosong."""
        self._items = []

    def enqueue(self, item):
        """Menambahkan item ke bagian belakang antrian."""
        self._items.append(item)

    def dequeue(self):
        """
        Menghapus dan mengembalikan item dari depan antrian.

        Raises:
            IndexError: Jika antrian kosong.
        """
        if self.is_empty():
            raise IndexError("dequeue dari antrian yang kosong")
        return self._items.pop(0)

    def front(self):
        """
        Mengembalikan item terdepan tanpa menghapusnya.

        Raises:
            IndexError: Jika antrian kosong.
        """
        if self.is_empty():
            raise IndexError("front pada antrian yang kosong")
        return self._items[0]

    def is_empty(self):
        """Memeriksa apakah antrian tidak berisi elemen."""
        return len(self._items) == 0

    def size(self):
        """Mengembalikan jumlah item dalam antrian."""
        return len(self._items)

    def __str__(self):
        if self.is_empty():
            return "Queue: [] (kosong)"
        return f"Queue: FRONT->{self._items}<-REAR"


# Simulasi antrian pelanggan di loket bank
print("=" * 55)
print("   SIMULASI ANTRIAN PELANGGAN DI LOKET BANK")
print("=" * 55)

antrian_bank = Queue()

# Pelanggan tiba secara berurutan
pelanggan_tiba = ["Budi", "Sari", "Andi", "Dewi", "Rudi"]
print("\nPelanggan tiba:")
for nama in pelanggan_tiba:
    antrian_bank.enqueue(nama)
    print(f"  {nama:>6} masuk antrian | {antrian_bank}")

print(f"\nJumlah pelanggan menunggu: {antrian_bank.size()}")
print(f"Pelanggan di depan antrian: {antrian_bank.front()}")

# Pelanggan dilayani satu per satu
print("\nPelanggan dilayani (urutan FIFO):")
nomor_layanan = 1
while not antrian_bank.is_empty():
    dilayani = antrian_bank.dequeue()
    print(f"  [{nomor_layanan}] Melayani: {dilayani:>6} | Sisa: {antrian_bank}")
    nomor_layanan += 1
```

---

## 1.6 Notasi Big-O: Bahasa Bersama untuk Efisiensi

Sampai titik ini, kita telah beberapa kali menyebutkan konsep seperti "O(1)", "O(n)", dan "O(log n)" tanpa penjelasan formal. Notasi Big-O adalah bahasa standar yang digunakan oleh ilmuwan komputer dan insinyur perangkat lunak di seluruh dunia untuk mengekspresikan efisiensi algoritma dan operasi struktur data.

Notasi Big-O, yang secara formal ditulis sebagai O(f(n)), menggambarkan bagaimana waktu eksekusi atau penggunaan memori suatu algoritma tumbuh relatif terhadap ukuran masukan n, dalam kasus terburuk (worst case). "Big" dalam Big-O merujuk pada fakta bahwa notasi ini fokus pada laju pertumbuhan secara asimptotik, yaitu bagaimana perilaku algoritma untuk nilai n yang sangat besar, mengabaikan konstanta dan suku-suku berorde rendah.

```
Gambar 1.9 Perbandingan Laju Pertumbuhan Notasi Big-O

Waktu (operasi)
     |
10000|                                              O(2^n) /
     |                                             /
 5000|                                            /
     |
 1000|                                     O(n^2)/
     |                                    /
  500|                                   /
     |                          O(n log n)
  100|                         /
     |                   O(n) /
   50|                   /
     |          O(log n)/
   10|          /
     |         /  O(1)
    1|--------/------------------------------------------
     +-------------------------------------------> n
       1   5  10   20   50  100  200  500  1000

Urutan dari terbaik (tumbuh paling lambat) ke terburuk:
O(1) < O(log n) < O(n) < O(n log n) < O(n^2) < O(2^n)
```

Pemahaman tentang notasi Big-O memungkinkan perbandingan efisiensi yang objektif, terlepas dari perbedaan perangkat keras, bahasa pemrograman, atau detail implementasi. Perbedaan antara O(1) dan O(n) untuk operasi pencarian di antara satu juta data berarti perbedaan antara satu operasi dan satu juta operasi, terlepas dari seberapa cepat komputer yang menjalankannya.

Kode berikut mendemonstrasikan secara empiris perbedaan nyata antara O(n) dan O(1) untuk operasi keanggotaan (membership testing).

```python
# ============================================================
# Kode 1.4: Perbandingan Empiris O(n) vs O(1) pada Pencarian
# ============================================================

import time
import random

def ukur_waktu_pencarian(koleksi, target, label_koleksi):
    """
    Mengukur waktu pencarian elemen dalam sebuah koleksi.

    Parameter:
        koleksi    : Struktur data yang diuji (list, set, atau dict)
        target     : Elemen yang dicari
        label_koleksi : Nama struktur data untuk label output

    Returns:
        Waktu pencarian dalam mikrodetik.
    """
    mulai = time.perf_counter()
    _ = target in koleksi  # Operasi pencarian
    selesai = time.perf_counter()
    durasi_us = (selesai - mulai) * 1_000_000  # ke mikrodetik
    ditemukan = target in koleksi
    print(f"  {label_koleksi:<18} : {durasi_us:>10.4f} µs | "
          f"Ditemukan: {ditemukan}")
    return durasi_us

# Persiapan data: 500.000 elemen acak
N = 500_000
data_acak = random.sample(range(N * 2), N)  # N angka unik

data_list = data_acak                          # O(n) pencarian
data_set  = set(data_acak)                     # O(1) pencarian rata-rata
data_dict = {v: True for v in data_acak}      # O(1) pencarian rata-rata

# Cari elemen di posisi akhir (kasus terburuk untuk list)
target = data_acak[-1]

print(f"=== PERBANDINGAN PENCARIAN (N = {N:,} elemen) ===")
print(f"Target: {target}\n")

t_list = ukur_waktu_pencarian(data_list, target, "List  [O(n)]")
t_set  = ukur_waktu_pencarian(data_set,  target, "Set   [O(1)]")
t_dict = ukur_waktu_pencarian(data_dict, target, "Dict  [O(1)]")

rasio = t_list / t_set if t_set > 0 else float('inf')
print(f"\nList {rasio:.0f}x lebih lambat dari Set untuk pencarian ini.")
print("Kesimpulan: Pilihan struktur data sangat menentukan kinerja!")
```

Pada mesin tipikal, output program di atas akan menunjukkan bahwa pencarian dalam `list` memakan waktu puluhan hingga ratusan kali lebih lama dibandingkan pencarian dalam `set` atau `dict`, untuk data sebesar 500.000 elemen. Perbedaan ini akan semakin membesar secara proporsional seiring bertambahnya jumlah data.

---

> **Studi Kasus: Pemilihan Struktur Data pada Sistem Rekomendasi**
>
> Sebuah platform streaming musik perlu mengimplementasikan fitur "Lagu yang Baru-Baru Ini Diputar" yang menampilkan 10 lagu terakhir yang didengarkan oleh pengguna. Setiap kali lagu baru diputar, ia masuk ke daftar teratas, dan jika sudah ada 10 lagu, lagu tertua dibuang dari daftar.
>
> Analisis kebutuhan menunjukkan: (1) data baru selalu ditambahkan di satu ujung (depan), (2) data lama dihapus dari ujung lain (belakang) ketika kapasitas penuh, dan (3) urutan penting untuk ditampilkan dari yang terbaru ke terlama.
>
> Struktur data yang tepat untuk kasus ini adalah antrian berkapasitas tetap (bounded queue), atau lebih spesifik lagi, antrian geser (sliding window queue). Implementasinya dapat menggunakan `collections.deque` dengan `maxlen=10` di Python, yang secara otomatis menghapus elemen tertua saat elemen baru ditambahkan melampaui kapasitas.
>
> ```python
> from collections import deque
>
> riwayat_putar = deque(maxlen=10)
>
> # Simulasi pemutaran lagu
> lagu_diputar = [f"Lagu_{i}" for i in range(1, 15)]
> for lagu in lagu_diputar:
>     riwayat_putar.appendleft(lagu)
>
> print("10 lagu terakhir (terbaru ke terlama):")
> for i, lagu in enumerate(riwayat_putar, 1):
>     print(f"  {i}. {lagu}")
> ```
>
> `collections.deque` dengan `maxlen` adalah contoh nyata bagaimana pemilihan struktur data yang tepat menghasilkan kode yang ringkas, efisien (O(1) untuk semua operasi), dan bermakna semantis secara langsung.

---

## 1.7 Peta Perjalanan Studi Struktur Data

Bab ini telah membangun fondasi konseptual yang akan menopang seluruh perjalanan studi ini. Untuk memberikan gambaran yang jelas tentang ke mana arah pembahasan selanjutnya, berikut adalah peta topik yang akan dibahas secara berurutan, di mana setiap lapisan membangun pemahaman di atas lapisan sebelumnya.

```
Gambar 1.10 Peta Perjalanan Studi Struktur Data

LAPISAN 1: FONDASI (Bab 1-2)
+------------------------------------------+
|  Pengantar Struktur Data (Bab ini)       |
|  Kompleksitas Algoritma & Review Python  |
+------------------------------------------+
                    |
                    v
LAPISAN 2: STRUKTUR LINEAR (Bab 3-5)
+------------------------------------------+
|  Array & List Python yang Mendalam       |
|  Stack (Tumpukan) dan Aplikasinya        |
|  Queue (Antrian), Deque, Priority Queue  |
+------------------------------------------+
                    |
                    v
LAPISAN 3: STRUKTUR BERANTAI (Bab 6-8)
+------------------------------------------+
|  Singly Linked List                      |
|  Doubly Linked List                      |
|  Circular Linked List                    |
+------------------------------------------+
                    |
                    v
LAPISAN 4: STRUKTUR HIERARKIS (Bab 9-11)
+------------------------------------------+
|  Binary Tree dan Traversal               |
|  Binary Search Tree                      |
|  AVL Tree (Pohon Seimbang Otomatis)      |
+------------------------------------------+
                    |
                    v
LAPISAN 5: PENCARIAN & HASHING (Bab 12-13)
+------------------------------------------+
|  Hash Table dan Fungsi Hash              |
|  Heap dan Priority Queue Lanjutan        |
+------------------------------------------+
                    |
                    v
LAPISAN 6: STRUKTUR JARINGAN (Bab 14-16)
+------------------------------------------+
|  Graf: Representasi dan Traversal        |
|  Algoritma Jalur Terpendek               |
|  Aplikasi & Studi Kasus Terintegrasi     |
+------------------------------------------+
```

Urutan ini dirancang dengan sengaja. Struktur data yang lebih kompleks secara konseptual dibangun di atas pemahaman tentang struktur yang lebih sederhana. Pemahaman tentang daftar berantai, misalnya, akan sangat membantu ketika mempelajari pohon dan graf, karena ketiganya menggunakan konsep simpul dan referensi antar-simpul.

---

## 1.8 Rangkuman Bab

1. **Struktur data** adalah cara sistematis untuk menyimpan, mengorganisasi, dan mengelola data di memori komputer, mencakup representasi data dan operasi yang dapat dilakukan padanya. Pemilihan struktur data yang tepat secara langsung menentukan efisiensi waktu eksekusi, penggunaan memori, kemudahan pemeliharaan kode, dan skalabilitas sistem.

2. **Hubungan antara struktur data dan algoritma** bersifat simbiotik dan tak terpisahkan. Algoritma menentukan langkah-langkah logis penyelesaian masalah, sedangkan struktur data menyediakan kerangka penyimpanan dan akses yang mendukung eksekusi algoritma. Keduanya harus dioptimalkan bersama, tidak secara terpisah.

3. **Klasifikasi linear versus non-linear** membedakan struktur data berdasarkan pola hubungan antar elemen: struktur linear (larik, daftar berantai, tumpukan, antrian) menyusun elemen dalam satu dimensi berurutan dengan hubungan satu-ke-satu, sedangkan struktur non-linear (pohon, graf) memungkinkan hubungan satu-ke-banyak atau banyak-ke-banyak yang mencerminkan topologi hierarki atau jaringan.

4. **Klasifikasi statis versus dinamis** membedakan struktur data berdasarkan mekanisme alokasi memori: statis memiliki ukuran tetap yang ditentukan sebelum eksekusi sehingga sederhana namun tidak fleksibel, sedangkan dinamis dapat tumbuh dan menyusut selama runtime sehingga efisien dalam penggunaan memori namun dengan kompleksitas implementasi yang lebih tinggi.

5. **Tipe Data Abstrak (ADT)** adalah spesifikasi matematis yang mendefinisikan tipe data berdasarkan domain, operasi, dan aksiomanya, terlepas dari detail implementasi. ADT memisahkan "apa yang dilakukan" dari "bagaimana dilakukan", mendukung prinsip abstraksi dan enkapsulasi yang menjadi fondasi rekayasa perangkat lunak berkualitas tinggi.

6. **Python** menggunakan model referensi objek di mana variabel adalah label yang menunjuk ke objek di memori. Pemahaman tentang perbedaan antara referensi dan salinan sangat krusial untuk menghindari bug yang tidak disengaja saat memanipulasi struktur data. Python mendukung implementasi ADT melalui mekanisme kelas yang lengkap dengan enkapsulasi atribut dan metode.

7. **Notasi Big-O** adalah bahasa standar untuk mengekspresikan dan membandingkan efisiensi operasi struktur data dan algoritma secara objektif, independen dari perangkat keras maupun implementasi spesifik. Notasi ini memfokuskan pada laju pertumbuhan asimptotik sebagai fungsi ukuran masukan, memungkinkan prediksi kinerja untuk skenario data besar.

---

## 1.9 Istilah Kunci

**Abstraksi (Abstraction)**: Prinsip desain perangkat lunak yang menyembunyikan kompleksitas internal sebuah komponen dan hanya mengekspos antarmuka (interface) yang diperlukan pengguna.

**Aksioma (Axiom)**: Aturan formal yang mendefinisikan perilaku yang dijamin dari sebuah ADT, bersifat deklaratif dan independen dari implementasi.

**Algoritma (Algorithm)**: Prosedur langkah-demi-langkah yang terdefinisi dengan baik untuk menyelesaikan masalah komputasi tertentu dalam jumlah langkah yang terbatas.

**Antrian (Queue)**: Struktur data linear dengan aturan akses FIFO (First In, First Out), di mana elemen ditambahkan di bagian belakang (rear) dan dihapus dari bagian depan (front).

**Enkapsulasi (Encapsulation)**: Prinsip pemrograman berorientasi objek yang menggabungkan data dan operasi yang bekerja pada data tersebut dalam satu unit (kelas), sekaligus menyembunyikan detail implementasi.

**Graf (Graph)**: Struktur data non-linear yang terdiri dari sekumpulan simpul (vertex) dan sisi (edge) yang menghubungkan pasangan simpul, merepresentasikan hubungan jaringan yang bebas tanpa batasan hierarki.

**Kelas (Class)**: Mekanisme dalam pemrograman berorientasi objek untuk mendefinisikan tipe data baru beserta atribut (data) dan metode (operasi) yang menjadi miliknya.

**Kompleksitas Waktu (Time Complexity)**: Ukuran seberapa banyak waktu (dinyatakan dalam jumlah operasi dasar) yang dibutuhkan suatu algoritma relatif terhadap ukuran masukannya.

**Larik (Array)**: Struktur data linear yang menyimpan elemen-elemen dengan tipe data yang sama secara berurutan di blok memori yang berdekatan, mendukung akses berbasis indeks dalam O(1).

**Notasi Big-O (Big-O Notation)**: Notasi matematis yang mengekspresikan laju pertumbuhan asimptotik dari fungsi kompleksitas waktu atau ruang suatu algoritma dalam kasus terburuk.

**Pohon (Tree)**: Struktur data non-linear hierarkis yang terdiri dari simpul-simpul yang terhubung, di mana satu simpul khusus (akar/root) tidak memiliki induk, dan setiap simpul lain memiliki tepat satu induk.

**Referensi (Reference)**: Dalam Python, variabel bukan menyimpan nilai secara langsung melainkan menyimpan referensi (penunjuk) ke objek yang ada di heap memori.

**Struktur Data (Data Structure)**: Cara sistematis untuk menyimpan, mengorganisasi, dan mengelola data di memori komputer sehingga dapat diakses dan dimodifikasi secara efisien, mencakup representasi data dan operasi yang dapat dilakukan padanya.

**Struktur Data Dinamis (Dynamic Data Structure)**: Struktur data yang dapat tumbuh atau menyusut selama runtime program, dengan memori yang dialokasikan dan dibebaskan sesuai kebutuhan aktual.

**Struktur Data Linear (Linear Data Structure)**: Struktur data di mana elemen disusun secara berurutan dan setiap elemen memiliki paling banyak satu pendahulu dan satu penerus.

**Struktur Data Non-Linear (Non-Linear Data Structure)**: Struktur data di mana satu elemen dapat terhubung ke lebih dari satu elemen lain, membentuk topologi hierarki atau jaringan.

**Struktur Data Statis (Static Data Structure)**: Struktur data dengan ukuran yang ditentukan sebelum atau saat awal eksekusi program dan tidak berubah selama program berjalan.

**Tipe Data Abstrak / ADT (Abstract Data Type)**: Model matematika untuk tipe data yang didefinisikan oleh domain, operasi, dan aksiomanya, terlepas dari detail implementasi konkretnya.

**Tumpukan (Stack)**: Struktur data linear dengan aturan akses LIFO (Last In, First Out), di mana operasi penambahan (push) dan penghapusan (pop) hanya dilakukan pada satu ujung yang disebut puncak (top).

**Pengumpulan Sampah (Garbage Collection)**: Mekanisme manajemen memori otomatis yang mendeteksi dan membebaskan objek-objek yang tidak lagi dirujuk oleh variabel manapun dalam program.

---

## 1.10 Soal Latihan

### A. Pilihan Ganda

*Petunjuk: Pilih satu jawaban yang paling tepat untuk setiap soal berikut.*

---

**Soal 1** (C2 - Memahami)

Perhatikan pernyataan-pernyataan berikut:

(i)   Struktur data linear menyusun elemen secara berurutan dengan hubungan satu-ke-satu.
(ii)  Graf adalah contoh struktur data linear.
(iii) Tumpukan (stack) mengikuti prinsip FIFO (First In, First Out).
(iv)  Pohon (tree) adalah contoh struktur data non-linear.

Pernyataan yang **benar** adalah...

A. (i) dan (ii) saja
B. (i) dan (iv) saja
C. (ii) dan (iii) saja
D. (iii) dan (iv) saja

---

**Soal 2** (C2 - Memahami)

Sebuah sistem operasi perlu memproses tugas-tugas cetak (print job) dari berbagai pengguna dengan urutan pemrosesan sama dengan urutan permintaan masuk. Struktur data yang paling tepat untuk memodelkan skenario ini adalah...

A. Stack, karena mendukung akses cepat ke tugas yang terakhir diterima.
B. Queue, karena prinsip FIFO sesuai dengan urutan kedatangan permintaan.
C. Pohon biner, karena memungkinkan pengorganisasian berdasarkan prioritas.
D. Larik statis, karena ukuran tugas cetak dapat diprediksi sebelumnya.

---

**Soal 3** (C3 - Menerapkan)

Perhatikan fragmen kode Python berikut:

```python
x = [10, 20, 30]
y = x
y.append(40)
print(len(x))
```

Keluaran yang dihasilkan oleh kode tersebut adalah...

A. `3`
B. `4`
C. `1`
D. Error: tidak dapat memodifikasi list melalui alias

---

**Soal 4** (C3 - Menerapkan)

Perhatikan operasi Stack berikut yang dilakukan secara berurutan pada Stack yang awalnya kosong:
`push(5)`, `push(3)`, `push(7)`, `pop()`, `push(1)`, `peek()`

Nilai yang dikembalikan oleh operasi `peek()` terakhir adalah...

A. `3`
B. `5`
C. `7`
D. `1`

---

**Soal 5** (C4 - Menganalisis)

Sebuah aplikasi media sosial perlu menyimpan daftar pengikut (followers) dari 10 juta pengguna, dan sering melakukan operasi untuk mengecek apakah pengguna A mengikuti pengguna B. Manakah kombinasi struktur data dan alasan yang paling tepat?

A. List untuk setiap pengguna, karena mudah diimplementasikan dan mendukung urutan pengikut.
B. Set untuk setiap pengguna, karena operasi keanggotaan (membership) berjalan dalam O(1) rata-rata.
C. Stack untuk setiap pengguna, karena mendukung penambahan dan penghapusan pengikut terbaru dengan cepat.
D. Array terurut untuk setiap pengguna, karena mendukung pencarian biner dengan O(log n).

---

### B. Soal Esai

*Petunjuk: Jawab setiap pertanyaan secara lengkap, terstruktur, dan sertakan contoh atau ilustrasi bila diperlukan.*

---

**Soal 6** (C2 - Memahami)

Jelaskan dengan kata-kata Anda sendiri apa yang dimaksud dengan prinsip LIFO pada tumpukan (stack) dan prinsip FIFO pada antrian (queue). Berikan masing-masing dua contoh nyata dari kehidupan sehari-hari atau sistem komputasi yang secara alami mengikuti prinsip tersebut. Untuk setiap contoh, jelaskan mengapa prinsip tersebut yang berlaku dan bukan prinsip sebaliknya.

---

**Soal 7** (C4 - Menganalisis)

Jelaskan perbedaan mendasar antara **Tipe Data Abstrak (ADT)** dan **implementasi struktur data**. Mengapa pemisahan antara spesifikasi ADT dan implementasinya dianggap sebagai praktik rekayasa perangkat lunak yang baik? Berikan contoh konkret yang mengilustrasikan bagaimana dua implementasi berbeda dari ADT yang sama dapat dipertukarkan tanpa memengaruhi kode yang menggunakannya. Sertakan contoh kode Python singkat untuk mendukung penjelasan Anda.

---

**Soal 8** (C4 - Menganalisis)

Seorang pengembang memiliki pilihan antara menggunakan `list` Python atau `set` Python untuk menyimpan koleksi 1.000.000 nomor identifikasi unik, dan aplikasinya intensif dalam operasi pengecekan keberadaan suatu nomor dalam koleksi. Analisislah pilihan mana yang lebih tepat. Jelaskan alasan teknis di balik perbedaan kinerjanya, dan tuliskan kode Python yang mengukur secara empiris perbedaan waktu eksekusi keduanya. Apakah ada situasi di mana pilihan sebaliknya justru lebih tepat? Jelaskan.

---

**Soal 9** (C4 - Menganalisis)

Perhatikan peta perjalanan topik dalam buku ini (Gambar 1.10). Mengapa studi tentang daftar berantai (linked list) ditempatkan sebelum studi tentang pohon (tree) dan graf, meskipun ketiganya adalah struktur data yang berbeda? Identifikasi setidaknya tiga konsep dari linked list yang akan menjadi prasyarat atau analogi yang berguna dalam memahami pohon dan graf. Jelaskan hubungan konseptual tersebut.

---

**Soal 10** (C5 - Mengevaluasi)

Evaluasi pernyataan berikut secara kritis: *"Semakin banyak operasi yang didukung oleh sebuah struktur data, semakin baik dan fleksibel struktur data tersebut."*

Apakah Anda setuju atau tidak setuju? Bangun argumen yang koheren menggunakan minimal dua contoh struktur data dari materi bab ini. Pertimbangkan dimensi-dimensi seperti kompleksitas waktu operasi, overhead memori, dan kompleksitas implementasi dalam argumen Anda.

---

**Soal 11** (C5 - Mengevaluasi)

Seorang tim pengembang berargumen bahwa karena Python memiliki tipe `list` yang sangat serbaguna dan dapat digunakan sebagai stack, queue, maupun array sekaligus, maka tidak ada manfaat untuk membuat kelas `Stack` atau `Queue` terpisah dalam program Python. Evaluasi argumen ini. Di mana argumen tersebut mengandung kebenaran, dan di mana ia keliru? Kaitkan jawaban Anda dengan prinsip-prinsip ADT, abstraksi, dan rekayasa perangkat lunak yang telah dibahas dalam bab ini.

---

**Soal 12** (C6 - Mencipta)

Rancang dan implementasikan sebuah ADT bernama `Riwayat` yang merepresentasikan fitur riwayat penelusuran (browser history) pada sebuah peramban web. ADT ini harus memenuhi spesifikasi berikut:

- Menyimpan URL yang dikunjungi dengan urutan kronologis.
- Mendukung navigasi mundur (back) ke halaman sebelumnya.
- Mendukung navigasi maju (forward) ke halaman yang pernah ditinggalkan.
- Menampilkan URL halaman saat ini.
- Ketika pengguna mengunjungi URL baru setelah melakukan navigasi mundur, semua halaman "ke depan" yang ada sebelumnya harus dihapus.

Tuliskan: (a) spesifikasi ADT `Riwayat` dalam bentuk tabel yang mencantumkan setiap operasi beserta parameternya, nilai kembaliannya, dan kondisi error-nya; (b) implementasi kelas Python `Riwayat` yang lengkap dengan docstring pada setiap metode; dan (c) program demonstrasi yang mencakup skenario: mengunjungi lima halaman, mundur dua langkah, maju satu langkah, lalu mengunjungi halaman baru (sehingga riwayat ke depan terhapus).

---

## 1.11 Bacaan Lanjutan

1. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013). *Data Structures and Algorithms in Python*. John Wiley & Sons.**
   Buku ini adalah referensi utama yang paling direkomendasikan untuk kursus ini. Ditulis khusus untuk Python, buku ini memadukan kedalaman teori dengan implementasi praktis yang elegan. Bab 1 dan 2 membahas model objek Python dan pemrograman berorientasi objek yang menjadi fondasi implementasi ADT. Bab 6 dan seterusnya membahas setiap struktur data utama dengan analisis matematika yang ketat.

2. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022). *Introduction to Algorithms* (4th ed.). MIT Press.**
   Dikenal sebagai "CLRS" dan sering disebut "Bible of Algorithms", buku ini adalah referensi definitif untuk teori algoritma dan struktur data. Meski pseudokodenya bukan Python, landasan matematisnya tak tertandingi. Bab 1 membahas peran algoritma dalam komputasi, dan Bab 10 memperkenalkan struktur data dasar. Cocok untuk pembaca yang ingin mendalami analisis formal kompleksitas.

3. **Miller, B. N., & Ranum, D. L. (2011). *Problem Solving with Algorithms and Data Structures Using Python* (2nd ed.). Franklin, Beedle & Associates.**
   Buku yang tersedia secara gratis di runestone.academy ini mengambil pendekatan berbasis pemecahan masalah yang sangat mudah diakses. Bab 3 (Basic Data Structures) membahas Stack, Queue, Deque, dan List dengan penekanan pada bagaimana setiap struktur data cocok untuk kategori masalah tertentu. Sangat direkomendasikan sebagai pembacaan pendamping untuk bab-bab awal buku ini.

4. **Sedgewick, R., & Wayne, K. (2011). *Algorithms* (4th ed.). Addison-Wesley.**
   Buku klasik yang telah membentuk cara pandang puluhan generasi insinyur perangkat lunak. Bab 1.3 (Bags, Queues, and Stacks) memberikan pembahasan yang sangat menyeluruh tentang ADT fundamental dengan analisis kinerja yang komprehensif. Situs web companion-nya (algs4.cs.princeton.edu) menyediakan visualisasi interaktif yang sangat membantu pemahaman.

5. **Knuth, D. E. (1997). *The Art of Computer Programming, Volume 1: Fundamental Algorithms* (3rd ed.). Addison-Wesley.**
   Karya monumental Donald Knuth yang merupakan rujukan definitif untuk sisi matematis ilmu komputer. Bab 2 (Information Structures) meletakkan fondasi formal untuk konsep struktur data dengan kedalaman yang tidak tertandingi oleh buku lain. Bacaan ini direkomendasikan untuk pembaca dengan fondasi matematika yang kuat yang ingin memahami asal-usul dan bukti formal dari setiap konsep.

6. **Lutz, M. (2013). *Learning Python* (5th ed.). O'Reilly Media.**
   Referensi komprehensif untuk bahasa Python itu sendiri. Bab 6 (The Dynamic Typing Interlude) menjelaskan model referensi objek Python dengan sangat detail dan jelas, sementara Bab 26 dan 27 membahas dasar-dasar pemrograman berorientasi objek. Buku ini penting untuk membangun pemahaman yang mendalam tentang mekanisme Python yang menjadi wahana implementasi seluruh struktur data dalam buku ini.

7. **Liskov, B., & Zilles, S. (1974). Programming with Abstract Data Types. *ACM SIGPLAN Notices*, 9(4), 50-59.**
   Makalah seminal yang pertama kali memperkenalkan konsep ADT secara formal. Meskipun ditulis pada tahun 1974, makalah ini tetap sangat relevan dan dapat dibaca dalam waktu singkat. Membaca makalah asli ini memberikan perspektif historis yang berharga tentang bagaimana gagasan yang kini tampak "jelas" pada awalnya merupakan terobosan konseptual yang revolusioner.

---

*Bab berikutnya akan mendalami analisis kompleksitas algoritma secara lebih formal, memperkenalkan notasi asimptotik secara lengkap, dan melakukan tinjauan mendalam atas struktur data bawaan Python — list, tuple, dict, dan set — beserta karakteristik kinerja dan kasus penggunaan optimalnya.*

---
