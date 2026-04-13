# BAB 8
# REKURSI: SENI MENDEFINISIKAN SOLUSI MELALUI DIRINYA SENDIRI

---

> *"To iterate is human; to recurse, divine."*
>
> --- L. Peter Deutsch, pionir implementasi Lisp dan Smalltalk

---

## Tujuan Pembelajaran

Setelah mempelajari bab ini secara tuntas, pembaca diharapkan mampu:

1. **[C2 — Memahami]** Menjelaskan konsep rekursi secara konseptual, termasuk perbedaan antara *base case* dan *recursive case*, serta menggambarkan bagaimana call stack bekerja selama eksekusi fungsi rekursif berlangsung.

2. **[C2 — Memahami]** Membedakan tiga pola dekomposisi rekursi --- *linear recursion*, *binary recursion*, dan *multiple recursion* --- beserta contoh representatif dari masing-masing pola tersebut.

3. **[C3 — Menerapkan]** Mengimplementasikan fungsi rekursif dalam bahasa Python untuk permasalahan klasik, meliputi perhitungan faktorial, bilangan Fibonacci, dan Tower of Hanoi, disertai penanganan kesalahan yang tepat.

4. **[C3 — Menerapkan]** Menerapkan teknik memoization, baik secara manual maupun menggunakan dekorator `functools.lru_cache` bawaan Python, untuk mengoptimalkan fungsi rekursif yang memiliki submasalah yang tumpang tindih (*overlapping subproblems*).

5. **[C4 — Menganalisis]** Menurunkan dan menyelesaikan *recurrence relation* untuk fungsi rekursif menggunakan metode substitusi, serta menginterpretasikan makna kompleksitas waktu dan ruang yang dihasilkan.

6. **[C4 — Menganalisis]** Membandingkan implementasi rekursif dan iteratif dari algoritma yang sama berdasarkan dimensi kompleksitas waktu, kompleksitas ruang, keterbacaan kode, dan risiko *stack overflow*.

7. **[C5 — Mengevaluasi]** Menilai kelayakan penggunaan rekursi versus iterasi untuk permasalahan tertentu, dengan mempertimbangkan faktor batasan rekursi Python, efisiensi memori, dan karakteristik masalah.

---

## 8.1 Pendahuluan: Ketika Solusi Mengandung Dirinya Sendiri

Di antara seluruh konsep dalam ilmu komputer, rekursi menempati posisi yang unik sekaligus istimewa. Ia bukan sekadar teknik pemrograman; ia adalah cara berpikir yang merepresentasikan dunia melalui pola yang berulang dalam skala yang berbeda. Siapa pun yang pernah berdiri di antara dua cermin yang saling berhadapan dan menyaksikan refleksi tanpa batas di dalamnya telah menyaksikan intuisi visual dari rekursi. Siapa pun yang pernah membuka kamus dan mendapati sebuah kata didefinisikan menggunakan kata itu sendiri juga telah bersentuhan dengan prinsip yang sama.

Dalam konteks pemrograman, rekursi (*recursion*) didefinisikan sebagai mekanisme di mana sebuah fungsi memanggil dirinya sendiri --- baik secara langsung (*direct recursion*) maupun melalui rantai fungsi lain yang pada akhirnya kembali ke fungsi pertama (*indirect recursion*) --- sebagai bagian dari penyelesaian masalah yang diberikan. Goodrich, Tamassia, dan Goldwasser (2013, hlm. 196) merumuskannya demikian: *"We say that a function is recursive if it calls itself. Recursion is a technique by which a function makes one or more calls to itself during execution, or by which a data structure relies upon smaller instances of the very same type of structure in its representation."*

Akar konseptual rekursi dapat ditelusuri jauh ke belakang sebelum komputer modern ada. Dalam matematika, definisi rekursif telah lama digunakan untuk mendefinisikan bilangan alami melalui aksioma Peano, untuk mendefinisikan bilangan Fibonacci yang muncul dalam buku *Liber Abaci* karya Leonardo dari Pisa pada tahun 1202, dan untuk landasan formal komputabilitas melalui *lambda calculus* yang dikembangkan Alonzo Church pada dekade 1930-an. Ketika komputer digital muncul dan bahasa pemrograman tingkat tinggi seperti Lisp diperkenalkan pada akhir 1950-an, rekursi segera menjadi salah satu pilar paling ekspresif dalam dunia pemrograman.

Pemahaman yang mendalam tentang rekursi memberikan dua manfaat sekaligus. Pertama, secara praktis, rekursi merupakan landasan bagi beberapa algoritma terpenting dalam ilmu komputer: *merge sort* dan *quick sort* dalam pengurutan, *depth-first search* dalam penelusuran graf, evaluasi ekspresi dalam kompiler, dan seluruh famili algoritma *divide-and-conquer*. Kedua, secara intelektual, berpikir rekursif membentuk kemampuan abstraksi yang menjadi ciri pemikir komputasional yang matang --- kemampuan untuk mendefinisikan solusi suatu masalah dalam bentuk solusi masalah yang lebih kecil dari jenis yang sama.

Bab ini membangun pemahaman rekursi secara bertahap. Bagian pertama meletakkan fondasi konseptual: definisi formal, syarat validitas, dan cara kerja *call stack*. Bagian kedua mengeksplorasi tiga studi kasus klasik --- faktorial, Fibonacci, dan Tower of Hanoi --- lengkap dengan visualisasi, implementasi Python, dan analisis kompleksitas. Bagian ketiga membahas perbandingan menyeluruh antara rekursi dan iterasi, mencakup teknik memoization sebagai jembatan antara keduanya. Bagian terakhir memperkenalkan *recurrence relation* sebagai alat analisis formal kompleksitas algoritma rekursif.

---

## 8.2 Konsep Dasar: Anatomi Fungsi Rekursif

### 8.2.1 Dua Komponen Wajib: Base Case dan Recursive Case

Setiap fungsi rekursif yang valid secara definitif harus mengandung dua komponen: *base case* dan *recursive case*. Absennya salah satu dari keduanya akan menghasilkan fungsi yang salah, baik secara logis maupun secara operasional.

*Base case* (kasus dasar) adalah kondisi di mana fungsi dapat menyelesaikan pekerjaannya secara langsung tanpa harus memanggil dirinya sendiri. Ini adalah "dasar pijakan" rekursi --- titik di mana rantai pemanggilan berhenti dan mulai berbalik arah. Tanpa base case, fungsi akan memanggil dirinya sendiri tanpa henti hingga memenuhi memori yang dialokasikan untuk *call stack*, dan Python akan mengeluarkan `RecursionError: maximum recursion depth exceeded`.

*Recursive case* (kasus rekursif) adalah bagian di mana fungsi memecah masalah yang diberikan menjadi satu atau lebih submasalah yang lebih kecil namun berpola identik, kemudian memanggil dirinya sendiri untuk menyelesaikan submasalah tersebut. Kunci dari *recursive case* yang valid adalah bahwa setiap pemanggilan rekursif harus menggunakan argumen yang "lebih dekat" ke *base case* --- ukuran masalah harus menyusut pada setiap langkah rekursi.

Untuk membuktikan bahwa sebuah rekursi pasti berhenti dalam waktu hingga (*finite time*), kita perlu mengidentifikasi dua hal: (1) ukuran masalah (*problem size*), yaitu suatu kuantitas non-negatif yang selalu berkurang pada setiap pemanggilan rekursif, dan (2) *base case* yang terdefinisi dengan tepat ketika ukuran masalah mencapai nilai minimumnya. Dalam analisis algoritma formal, jaminan penghentian ini berkaitan dengan konsep *well-founded ordering* --- adanya urutan parsial yang tidak memungkinkan rantai penurunan tak hingga.

---

> **Catatan Penting 8.1: Kesalahan Umum dalam Mendefinisikan Rekursi**
>
> Ada dua kesalahan paling umum yang dilakukan pemrogram saat menulis fungsi rekursif. Pertama, **lupa mendefinisikan base case** atau mendefinisikannya dengan kondisi yang tidak pernah dapat dicapai, sehingga rekursi berlanjut tanpa henti. Kedua, **recursive case tidak mengarah ke base case** --- misalnya, fungsi yang secara tidak sengaja memanggil dirinya sendiri dengan argumen yang sama atau bahkan lebih besar. Sebelum mengimplementasikan fungsi rekursif apa pun, selalu tanyakan dua pertanyaan: "Di mana rekursi ini berhenti?" dan "Apakah setiap pemanggilan rekursif dijamin lebih dekat ke titik berhenti itu?"

---

### 8.2.2 Tiga Pola Dekomposisi Rekursi

Goodrich et al. (2013, hlm. 197--199) mengidentifikasi tiga pola umum yang muncul dalam rekursi berdasarkan jumlah pemanggilan rekursif yang dibuat pada setiap langkah:

*Linear recursion* adalah pola di mana setiap eksekusi fungsi menghasilkan tepat satu pemanggilan rekursif. Pola ini merupakan yang paling sederhana dan paling mudah dianalisis. Contoh klasiknya adalah perhitungan faktorial, di mana `faktorial(n)` hanya memanggil `faktorial(n-1)` satu kali. Algoritma seperti ini biasanya memiliki kompleksitas waktu linear, yaitu O(n), karena rantai pemanggilan memiliki panjang tepat n.

*Binary recursion* adalah pola di mana setiap eksekusi fungsi menghasilkan tepat dua pemanggilan rekursif. Pola ini jauh lebih kompleks karena setiap level dalam pohon pemanggilan melipatduakan jumlah submasalah aktif. Contoh klasiknya adalah perhitungan Fibonacci naif dan algoritma *merge sort*. Tanpa optimasi tambahan, *binary recursion* pada masalah dengan submasalah yang tumpang tindih akan menghasilkan kompleksitas waktu eksponensial.

*Multiple recursion* adalah pola di mana setiap eksekusi fungsi menghasilkan lebih dari dua pemanggilan rekursif. Ini adalah pola yang paling kompleks dan biasanya muncul dalam konteks enumerasi kombinatorik (seperti menghasilkan semua permutasi atau *power set*), penelusuran pohon multi-anak, dan beberapa algoritma *backtracking*.

### 8.2.3 Cara Kerja Call Stack

Untuk benar-benar memahami rekursi, pembaca perlu memahami terlebih dahulu mekanisme *call stack* (*tumpukan pemanggilan*) --- struktur data internal yang digunakan oleh sistem *runtime* bahasa pemrograman untuk mengelola eksekusi fungsi-fungsi yang sedang aktif.

Setiap kali sebuah fungsi dipanggil, sistem mengalokasikan sebuah *stack frame* (bingkai tumpukan) baru dan menempatkannya di puncak tumpukan. *Stack frame* ini berisi empat kategori informasi: (1) nilai dari semua parameter yang diterima fungsi, (2) nilai semua variabel lokal yang dideklarasikan di dalam fungsi, (3) *return address* --- alamat instruksi berikutnya yang harus dieksekusi setelah fungsi ini selesai, dan (4) area untuk menyimpan nilai kembalian (*return value*).

Ketika fungsi tersebut memanggil fungsi lain (termasuk dirinya sendiri dalam konteks rekursi), *stack frame* baru ditambahkan di atas *stack frame* yang ada. *Stack frame* pemanggil tetap ada di tumpukan dalam keadaan tergantung (*suspended*) --- semua variabelnya dipertahankan --- hingga fungsi yang dipanggil selesai dan mengembalikan nilainya. Setelah fungsi selesai, *stack frame*-nya dihapus dari puncak tumpukan (*LIFO: Last In, First Out*), dan eksekusi dilanjutkan dari *stack frame* di bawahnya pada titik tepat setelah pemanggilan fungsi tadi.

Proses pertumbuhan tumpukan saat pemanggilan rekursif terjadi disebut fase *winding* (penggulungan), sedangkan proses penyusutan tumpukan saat setiap *stack frame* selesai dan mengembalikan nilainya disebut fase *unwinding* (penguraian). Pemahaman yang jelas tentang dua fase ini adalah kunci untuk men-*debug* program rekursif yang tidak bekerja dengan benar.

---

## 8.3 Faktorial: Rekursi Linear dalam Bentuk Paling Murni

### 8.3.1 Definisi Matematis

Faktorial dari bilangan bulat non-negatif n, dinotasikan n!, adalah salah satu contoh paling sempurna dari definisi rekursif dalam matematika. Ia didefinisikan sebagai:

```
n! = 1,              jika n = 0   (base case)
n! = n * (n - 1)!,   jika n > 0   (recursive case)
```

Definisi ini secara langsung mencerminkan struktur yang akan kita tulis dalam kode. Faktorial 0 adalah 1 (ini adalah konvensi matematis yang memiliki landasan kuat dalam kombinatorik dan teori himpunan). Faktorial dari bilangan positif n adalah n dikalikan dengan faktorial dari n dikurangi 1. Keanggunan dari definisi ini terletak pada kesederhanaan dan presisinya: dengan dua baris, seluruh urutan nilai 1, 1, 2, 6, 24, 120, 720, ... terdefinisi secara sempurna.

### 8.3.2 Implementasi Python

Terjemahan dari definisi matematis di atas ke dalam kode Python adalah langsung dan hampir satu-ke-satu:

```python
def faktorial_rekursif(n: int) -> int:
    """
    Menghitung n! secara rekursif menggunakan definisi induktif.

    Parameter:
        n (int): Bilangan bulat non-negatif

    Kembalian:
        int: Nilai n!

    Raises:
        ValueError: Jika n negatif
    """
    if n < 0:
        raise ValueError("Faktorial tidak terdefinisi untuk bilangan negatif")
    # Base case: faktorial 0 adalah 1
    if n == 0:
        return 1
    # Recursive case: n! = n * (n-1)!
    return n * faktorial_rekursif(n - 1)


# Pengujian
for i in range(7):
    print(f"{i}! = {faktorial_rekursif(i)}")
```

Keluaran program di atas adalah:

```
0! = 1
1! = 1
2! = 2
3! = 6
4! = 24
5! = 120
6! = 720
```

Bandingkan kode di atas dengan implementasi iteratifnya:

```python
def faktorial_iteratif(n: int) -> int:
    """
    Menghitung n! secara iteratif menggunakan akumulator.

    Parameter:
        n (int): Bilangan bulat non-negatif

    Kembalian:
        int: Nilai n!
    """
    if n < 0:
        raise ValueError("Faktorial tidak terdefinisi untuk bilangan negatif")
    hasil = 1
    for i in range(2, n + 1):
        hasil *= i
    return hasil
```

Secara fungsional, kedua implementasi menghasilkan output yang identik untuk semua nilai n yang valid. Perbedaannya terletak pada mekanisme internalnya, yang akan menjadi fokus analisis di bagian berikutnya.

### 8.3.3 Visualisasi Call Stack: faktorial(4)

Untuk membangun intuisi yang kuat tentang cara kerja rekursi, kita akan menelusuri setiap langkah eksekusi `faktorial_rekursif(4)` secara mendetail melalui lensa *call stack*.

**Gambar 8.1 --- Fase Winding: Call Stack Tumbuh ke Atas**

```
Langkah 1: faktorial(4) dipanggil pertama kali
+------------------------------------------+
| FRAME: faktorial(4)      [AKTIF]         |
|  n = 4                                   |
|  n < 0?  Tidak                           |
|  n == 0? Tidak                           |
|  menunggu: return 4 * faktorial(3)       |
+------------------------------------------+  <-- PUNCAK STACK

Langkah 2: faktorial(3) dipanggil dari dalam faktorial(4)
+------------------------------------------+
| FRAME: faktorial(3)      [AKTIF]         |
|  n = 3                                   |
|  n == 0? Tidak                           |
|  menunggu: return 3 * faktorial(2)       |
+------------------------------------------+
| FRAME: faktorial(4)      [SUSPENDED]     |
|  n = 4, menunggu hasil faktorial(3)      |
+------------------------------------------+  <-- DASAR STACK

Langkah 3: faktorial(2) dipanggil dari dalam faktorial(3)
+------------------------------------------+
| FRAME: faktorial(2)      [AKTIF]         |
|  n = 2                                   |
|  n == 0? Tidak                           |
|  menunggu: return 2 * faktorial(1)       |
+------------------------------------------+
| FRAME: faktorial(3)      [SUSPENDED]     |
|  n = 3, menunggu hasil faktorial(2)      |
+------------------------------------------+
| FRAME: faktorial(4)      [SUSPENDED]     |
|  n = 4, menunggu hasil faktorial(3)      |
+------------------------------------------+

Langkah 4: faktorial(1) dipanggil dari dalam faktorial(2)
+------------------------------------------+
| FRAME: faktorial(1)      [AKTIF]         |
|  n = 1                                   |
|  n == 0? Tidak                           |
|  menunggu: return 1 * faktorial(0)       |
+------------------------------------------+
| FRAME: faktorial(2)      [SUSPENDED]     |
| FRAME: faktorial(3)      [SUSPENDED]     |
| FRAME: faktorial(4)      [SUSPENDED]     |
+------------------------------------------+

Langkah 5: faktorial(0) dipanggil --- BASE CASE TERCAPAI
+------------------------------------------+
| FRAME: faktorial(0)      [BASE CASE]     |  <-- PUNCAK STACK
|  n = 0                                   |
|  n == 0? YA --> return 1 langsung        |
|  TIDAK ada pemanggilan rekursif lebih    |
+------------------------------------------+
| FRAME: faktorial(1)      [SUSPENDED]     |
| FRAME: faktorial(2)      [SUSPENDED]     |
| FRAME: faktorial(3)      [SUSPENDED]     |
| FRAME: faktorial(4)      [SUSPENDED]     |
+------------------------------------------+  <-- DASAR STACK
```

**Gambar 8.2 --- Fase Unwinding: Call Stack Menyusut, Nilai Dikembalikan**

```
Langkah 6: faktorial(0) selesai, mengembalikan 1
           Frame faktorial(0) DIHAPUS dari stack
+------------------------------------------+
| FRAME: faktorial(1)      [AKTIF KEMBALI] |
|  n = 1                                   |
|  nilai dari faktorial(0) = 1             |
|  menghitung: return 1 * 1 = 1            |
+------------------------------------------+
| FRAME: faktorial(2)      [SUSPENDED]     |
| FRAME: faktorial(3)      [SUSPENDED]     |
| FRAME: faktorial(4)      [SUSPENDED]     |
+------------------------------------------+

Langkah 7: faktorial(1) selesai, mengembalikan 1
           Frame faktorial(1) DIHAPUS dari stack
+------------------------------------------+
| FRAME: faktorial(2)      [AKTIF KEMBALI] |
|  n = 2                                   |
|  nilai dari faktorial(1) = 1             |
|  menghitung: return 2 * 1 = 2            |
+------------------------------------------+
| FRAME: faktorial(3)      [SUSPENDED]     |
| FRAME: faktorial(4)      [SUSPENDED]     |
+------------------------------------------+

Langkah 8: faktorial(2) selesai, mengembalikan 2
           Frame faktorial(2) DIHAPUS dari stack
+------------------------------------------+
| FRAME: faktorial(3)      [AKTIF KEMBALI] |
|  n = 3                                   |
|  nilai dari faktorial(2) = 2             |
|  menghitung: return 3 * 2 = 6            |
+------------------------------------------+
| FRAME: faktorial(4)      [SUSPENDED]     |
+------------------------------------------+

Langkah 9: faktorial(3) selesai, mengembalikan 6
           Frame faktorial(3) DIHAPUS dari stack
+------------------------------------------+
| FRAME: faktorial(4)      [AKTIF KEMBALI] |
|  n = 4                                   |
|  nilai dari faktorial(3) = 6             |
|  menghitung: return 4 * 6 = 24           |
+------------------------------------------+

Langkah 10: faktorial(4) selesai, mengembalikan 24
            Frame faktorial(4) DIHAPUS --- STACK KOSONG
            HASIL AKHIR: 4! = 24
```

Rantai nilai yang dibangun selama fase *unwinding* dapat divisualisasikan sebagai:

```
faktorial(4)
  = 4 * faktorial(3)
  = 4 * (3 * faktorial(2))
  = 4 * (3 * (2 * faktorial(1)))
  = 4 * (3 * (2 * (1 * faktorial(0))))
  = 4 * (3 * (2 * (1 * 1)))          <-- fase unwinding dimulai
  = 4 * (3 * (2 * 1))
  = 4 * (3 * 2)
  = 4 * 6
  = 24
```

Visualisasi ini mengungkapkan sebuah fakta penting: ekspresi `4 * faktorial(3)` tidak dapat dievaluasi hingga `faktorial(3)` mengembalikan nilainya. Demikian pula `faktorial(3)` menunggu `faktorial(2)`, dan seterusnya. Semua "pekerjaan yang tertunda" ini disimpan di dalam *stack frame* masing-masing, membentuk tumpukan yang terus bertumbuh hingga *base case* dicapai.

### 8.3.4 Analisis Kompleksitas: Metode Substitusi

Misalkan T(n) menyatakan jumlah waktu yang dibutuhkan oleh `faktorial_rekursif(n)`. Dengan mengamati isi fungsi, kita dapat merumuskan relasi antara T(n) dan nilai T untuk input yang lebih kecil. Setiap pemanggilan melakukan: satu pengecekan kondisi O(1), satu operasi perkalian O(1), dan satu pemanggilan rekursif ke `faktorial(n-1)` yang menelan waktu T(n-1). Ini menghasilkan *recurrence relation*:

```
T(n) = T(n - 1) + c,     untuk n > 0   (c adalah konstanta)
T(0) = c_0               (base case, waktu konstan)
```

Kita selesaikan dengan metode substitusi: mulai dari T(n) dan substitusikan berulang kali hingga tampak pola umum:

```
T(n) = T(n - 1) + c
     = [T(n - 2) + c] + c       = T(n - 2) + 2c
     = [T(n - 3) + c] + 2c      = T(n - 3) + 3c
     ...
     = T(n - k) + k * c         (pola umum setelah k langkah substitusi)

Ketika k = n:
     = T(0) + n * c
     = c_0 + n * c
     = O(n)
```

Kompleksitas waktu faktorial rekursif adalah **O(n)**, sama persis dengan versi iteratifnya. Namun, kedua implementasi memiliki profil yang sangat berbeda dari sisi memori. Versi rekursif membutuhkan memori untuk n + 1 *stack frame* yang ada secara bersamaan, sehingga kompleksitas ruangnya adalah **O(n)**. Sebaliknya, versi iteratif hanya membutuhkan beberapa variabel skalar tanpa peduli seberapa besar nilai n, sehingga kompleksitas ruangnya adalah **O(1)**.

---

## 8.4 Bilangan Fibonacci: Binary Recursion dan Bahaya Perhitungan Berulang

### 8.4.1 Definisi Matematis dan Sejarah Singkat

Deret bilangan yang kini dikenal sebagai deret Fibonacci diperkenalkan ke Eropa oleh Leonardo dari Pisa (dijuluki Fibonacci, artinya "putra Bonacci") dalam bukunya *Liber Abaci* pada tahun 1202. Meskipun bilangan-bilangan ini sebenarnya telah dikenal dalam matematika India berabad-abad sebelumnya, kontribusi Fibonacci dalam mempopularisasinya di dunia Barat sangatlah signifikan. Deret ini muncul secara mengejutkan di berbagai fenomena alam: susunan biji bunga matahari, spiral kerang nautilus, percabangan pohon, dan bahkan dalam analisis pasar keuangan.

Definisi rekursif deret Fibonacci adalah:

```
F(0) = 0                          (base case pertama)
F(1) = 1                          (base case kedua)
F(n) = F(n - 1) + F(n - 2),      untuk n >= 2  (recursive case)
```

Perhatikan bahwa Fibonacci memiliki *dua* base case, berbeda dengan faktorial yang hanya memiliki satu. Ini adalah konsekuensi dari *binary recursion*: karena setiap pemanggilan menghasilkan dua sub-pemanggilan, kita membutuhkan dua titik berhenti yang mandiri.

Beberapa suku pertama deret ini adalah: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...

### 8.4.2 Implementasi Rekursif Naif

Terjemahan langsung dari definisi matematis ke Python menghasilkan:

```python
def fibonacci_rekursif(n: int) -> int:
    """
    Menghitung bilangan Fibonacci ke-n secara rekursif (implementasi naif).

    Parameter:
        n (int): Indeks bilangan Fibonacci, n >= 0

    Kembalian:
        int: Bilangan Fibonacci ke-n

    Raises:
        ValueError: Jika n negatif
    """
    if n < 0:
        raise ValueError("Indeks Fibonacci harus non-negatif")
    # Dua base cases
    if n == 0:
        return 0
    if n == 1:
        return 1
    # Recursive case: F(n) = F(n-1) + F(n-2)
    return fibonacci_rekursif(n - 1) + fibonacci_rekursif(n - 2)


# Mencetak 10 suku pertama
print("Deret Fibonacci F(0) hingga F(9):")
for i in range(10):
    print(f"  F({i}) = {fibonacci_rekursif(i)}")
```

Keluaran:

```
Deret Fibonacci F(0) hingga F(9):
  F(0) = 0
  F(1) = 1
  F(2) = 1
  F(3) = 2
  F(4) = 3
  F(5) = 5
  F(6) = 8
  F(7) = 13
  F(8) = 21
  F(9) = 34
```

### 8.4.3 Visualisasi Pohon Rekursi dan Call Stack: fibonacci(5)

Berbeda dengan faktorial yang membentuk rantai linear, rekursi Fibonacci membentuk struktur pohon biner. Gambar 8.3 menampilkan pohon rekursi lengkap untuk `fibonacci_rekursif(5)`.

**Gambar 8.3 --- Pohon Rekursi fibonacci(5)**

```
                              fib(5)
                           /          \
                     fib(4)             fib(3)
                   /        \          /      \
               fib(3)      fib(2)  fib(2)    fib(1)
              /      \     /    \   /    \      |
          fib(2)  fib(1) fib(1) fib(0) fib(1) fib(0)  1
          /    \    |      |      |      |       |
       fib(1) fib(0) 1     1      0      1       0
         |       |
         1       0
```

Pohon ini mengungkapkan sesuatu yang sangat penting: terdapat sejumlah besar komputasi yang dilakukan berulang kali. Node `fib(3)` muncul dua kali, `fib(2)` muncul tiga kali, dan `fib(1)` muncul tidak kurang dari lima kali. Inilah yang disebut *overlapping subproblems* --- properti yang membuat rekursi naif menjadi sangat tidak efisien.

Jejak *call stack* berikut mengilustrasikan urutan pemanggilan dan pengembalian yang sebenarnya terjadi:

**Gambar 8.4 --- Trace Call Stack fibonacci(5)**

```
[Langkah  1] fib(5) dipanggil
             Stack: [ fib(5) ]

[Langkah  2] fib(5) memanggil fib(4)
             Stack: [ fib(5) | fib(4) ]

[Langkah  3] fib(4) memanggil fib(3)
             Stack: [ fib(5) | fib(4) | fib(3) ]

[Langkah  4] fib(3) memanggil fib(2)
             Stack: [ fib(5) | fib(4) | fib(3) | fib(2) ]

[Langkah  5] fib(2) memanggil fib(1) --> BASE CASE: return 1
             fib(1) selesai, frame dihapus
             Stack: [ fib(5) | fib(4) | fib(3) | fib(2) ]

[Langkah  6] fib(2) memanggil fib(0) --> BASE CASE: return 0
             fib(0) selesai, frame dihapus
             Stack: [ fib(5) | fib(4) | fib(3) | fib(2) ]

[Langkah  7] fib(2) = 1 + 0 = 1, selesai, frame dihapus
             Stack: [ fib(5) | fib(4) | fib(3) ]

[Langkah  8] fib(3) memanggil fib(1) --> BASE CASE: return 1
             fib(1) selesai, frame dihapus
             Stack: [ fib(5) | fib(4) | fib(3) ]

[Langkah  9] fib(3) = 1 + 1 = 2, selesai, frame dihapus
             Stack: [ fib(5) | fib(4) ]

[Langkah 10] fib(4) memanggil fib(2) [DIHITUNG ULANG -- sudah pernah dihitung!]
             Stack: [ fib(5) | fib(4) | fib(2) ]

[Langkah 11] fib(2) memanggil fib(1) --> BASE CASE: return 1
             fib(1) selesai, frame dihapus

[Langkah 12] fib(2) memanggil fib(0) --> BASE CASE: return 0
             fib(0) selesai, frame dihapus

[Langkah 13] fib(2) = 1 + 0 = 1, selesai, frame dihapus
             Stack: [ fib(5) | fib(4) ]

[Langkah 14] fib(4) = 2 + 1 = 3, selesai, frame dihapus
             Stack: [ fib(5) ]

[Langkah 15] fib(5) memanggil fib(3) [DIHITUNG ULANG -- sudah pernah dihitung!]
             Stack: [ fib(5) | fib(3) ]
             ... (langkah 4-9 berulang, menghasilkan fib(3) = 2)

[Langkah 16] fib(5) = 3 + 2 = 5, selesai, stack kosong
             HASIL AKHIR: F(5) = 5
```

Penghitungan total jumlah pemanggilan untuk `fib(5)` adalah sebagai berikut:

**Tabel 8.1 --- Jumlah Pemanggilan per Nilai dalam fibonacci(5)**

| Nilai yang Dihitung | Jumlah Pemanggilan | Keterangan              |
|---------------------|--------------------|-------------------------|
| fib(5)              | 1                  | Pemanggilan awal        |
| fib(4)              | 1                  |                         |
| fib(3)              | 2                  | Dihitung ulang 1 kali   |
| fib(2)              | 3                  | Dihitung ulang 2 kali   |
| fib(1)              | 5                  | Dihitung ulang 4 kali   |
| fib(0)              | 3                  | Dihitung ulang 2 kali   |
| **Total**           | **15**             | Untuk n = 5 saja        |

### 8.4.4 Analisis Kompleksitas: Pertumbuhan Eksponensial

*Recurrence relation* untuk `fibonacci_rekursif(n)` adalah:

```
T(n) = T(n - 1) + T(n - 2) + c,    untuk n >= 2
T(0) = T(1) = c_0
```

Untuk menyelesaikan recurrence ini, kita gunakan pendekatan batas bawah. Misalkan T(n) >= c * phi^n di mana phi = (1 + sqrt(5)) / 2 ≈ 1.618 adalah *golden ratio* (rasio emas). Substitusi:

```
T(n) = T(n - 1) + T(n - 2) + c
     >= c * phi^(n-1) + c * phi^(n-2)
     = c * phi^(n-2) * (phi + 1)
     = c * phi^(n-2) * phi^2        (karena phi^2 = phi + 1, properti golden ratio)
     = c * phi^n
```

Dengan demikian, T(n) = **O(phi^n) ≈ O(1.618^n)**, yang merupakan pertumbuhan eksponensial. Untuk memberikan gambaran konkret betapa cepatnya pertumbuhan ini:

**Tabel 8.2 --- Jumlah Pemanggilan Aktual fibonacci_rekursif(n)**

| n   | Jumlah Pemanggilan Perkiraan | Waktu (asumsi 10^9 ops/detik) |
|-----|------------------------------|-------------------------------|
| 10  | ~177                         | < 1 milidetik                 |
| 20  | ~21.891                      | < 1 milidetik                 |
| 30  | ~2.692.537                   | ~3 milidetik                  |
| 35  | ~29.860.703                  | ~30 milidetik sampai 5 detik  |
| 50  | ~2,26 x 10^10                | ~23 detik                     |
| 100 | ~7,92 x 10^20                | ~25 miliar tahun              |

Angka-angka ini menjelaskan dengan gamblang mengapa implementasi naif tidak dapat digunakan untuk nilai n yang besar dalam aplikasi nyata.

### 8.4.5 Optimasi dengan Memoization

Solusi untuk inefisiensi yang teridentifikasi di atas terletak pada gagasan yang sederhana namun sangat kuat: *jangan hitung ulang sesuatu yang sudah pernah dihitung*. Teknik ini dikenal sebagai *memoization* (dari kata Latin *memorandum*, bukan *memorization*) --- penyimpanan hasil pemanggilan fungsi untuk input tertentu agar dapat diambil kembali secara instan ketika input yang sama ditemui lagi.

```python
def fibonacci_memo(n: int, memo: dict = None) -> int:
    """
    Menghitung bilangan Fibonacci ke-n dengan memoization manual.

    Prinsip: simpan setiap F(k) yang telah dihitung ke dalam kamus memo.
    Sebelum menghitung, periksa apakah hasilnya sudah tersedia di memo.

    Parameter:
        n    (int):  Indeks bilangan Fibonacci, n >= 0
        memo (dict): Kamus penyimpan hasil yang telah dihitung sebelumnya

    Kembalian:
        int: Bilangan Fibonacci ke-n
    """
    if memo is None:
        memo = {}

    if n < 0:
        raise ValueError("Indeks Fibonacci harus non-negatif")

    # Cek cache: apakah F(n) sudah pernah dihitung?
    if n in memo:
        return memo[n]   # kembalikan hasil yang tersimpan, tanpa menghitung ulang

    # Base cases
    if n == 0:
        return 0
    if n == 1:
        return 1

    # Hitung, simpan ke memo, kemudian kembalikan
    memo[n] = fibonacci_memo(n - 1, memo) + fibonacci_memo(n - 2, memo)
    return memo[n]
```

Dengan memoization, setiap nilai F(k) untuk 0 <= k <= n hanya dihitung satu kali. Sisa pemanggilan ke F(k) yang sama cukup mengambil hasil dari kamus *memo* dalam waktu O(1). Akibatnya, kompleksitas waktu turun drastis dari O(phi^n) menjadi **O(n)**, sementara kompleksitas ruang adalah O(n) untuk kamus *memo* ditambah O(n) untuk *call stack*.

Python menyediakan cara yang lebih elegan untuk menerapkan *memoization* tanpa harus memodifikasi tanda tangan fungsi, yaitu melalui dekorator `functools.lru_cache`:

```python
import functools

@functools.lru_cache(maxsize=None)
def fibonacci_lru(n: int) -> int:
    """
    Menghitung bilangan Fibonacci ke-n menggunakan LRU Cache bawaan Python.

    Dekorator @lru_cache secara otomatis mengurus penyimpanan dan
    pengambilan hasil yang sudah pernah dihitung.

    Parameter:
        n (int): Indeks bilangan Fibonacci, n >= 0

    Kembalian:
        int: Bilangan Fibonacci ke-n
    """
    if n < 0:
        raise ValueError("Indeks Fibonacci harus non-negatif")
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fibonacci_lru(n - 1) + fibonacci_lru(n - 2)


# Menguji untuk nilai yang sangat besar
print(f"F(100) = {fibonacci_lru(100)}")
# Output: F(100) = 354224848179261915075
```

Terakhir, implementasi iteratif Fibonacci berguna sebagai pembanding karena mencapai kompleksitas waktu O(n) dan ruang O(1) --- hasil terbaik yang dapat dicapai:

```python
def fibonacci_iteratif(n: int) -> int:
    """
    Menghitung bilangan Fibonacci ke-n secara iteratif.

    Hanya menyimpan dua nilai sebelumnya, sehingga kompleksitas ruang O(1).

    Parameter:
        n (int): Indeks bilangan Fibonacci, n >= 0

    Kembalian:
        int: Bilangan Fibonacci ke-n
    """
    if n < 0:
        raise ValueError("Indeks Fibonacci harus non-negatif")
    if n == 0:
        return 0
    if n == 1:
        return 1

    prev2 = 0   # F(0)
    prev1 = 1   # F(1)

    for _ in range(2, n + 1):
        current = prev1 + prev2
        prev2 = prev1
        prev1 = current

    return prev1
```

Perbandingan waktu eksekusi antara ketiga implementasi memberikan perspektif yang sangat konkret tentang dampak pemilihan algoritma:

```python
import time

def ukur_waktu(fungsi, n, label):
    t0 = time.perf_counter()
    hasil = fungsi(n)
    t1 = time.perf_counter()
    print(f"{label:<30}: F({n}) = {hasil}, waktu = {(t1-t0)*1000:.4f} ms")

n = 35
ukur_waktu(fibonacci_rekursif, n, "Rekursif naif")
ukur_waktu(fibonacci_memo,     n, "Rekursif + memoization")
ukur_waktu(fibonacci_iteratif, n, "Iteratif")
```

Contoh keluaran pada mesin tipikal:

```
Rekursif naif                 : F(35) = 9227465, waktu = 4250.1230 ms
Rekursif + memoization        : F(35) = 9227465, waktu =    0.0410 ms
Iteratif                      : F(35) = 9227465, waktu =    0.0089 ms
```

Perbedaan waktu sebesar lebih dari 100.000 kali lipat antara rekursi naif dan rekursi termemoization untuk n = 35 adalah demonstrasi yang mencolok tentang betapa pentingnya memilih algoritma yang tepat.

---

> **Tahukah Anda? --- Bilangan Fibonacci dan Rasio Emas**
>
> Rasio antara dua suku Fibonacci yang berurutan, yaitu F(n+1) / F(n), mendekati nilai phi = (1 + sqrt(5)) / 2 ≈ 1.61803398... seiring meningkatnya n. Nilai ini dikenal sebagai *golden ratio* atau rasio emas, dan telah ditemukan oleh matematikawan Yunani kuno sebagai proporsi yang paling "menyenangkan secara estetika". Fakta yang mengejutkan: eksponensial pertumbuhan kompleksitas waktu Fibonacci naif, yaitu O(phi^n), menggunakan konstanta yang persis sama dengan rasio emas ini. Dengan kata lain, inefisiensi rekursi Fibonacci naif terhubung secara matematis dengan salah satu konstanta paling terkenal dalam matematika.

---

## 8.5 Tower of Hanoi: Keanggunan Rekursi Eksponensial

### 8.5.1 Sejarah dan Deskripsi Permasalahan

Tower of Hanoi adalah teka-teki matematika klasik yang dipublikasikan oleh matematikawan Prancis Edouard Lucas pada tahun 1883. Lucas menyertakan teka-teki ini dengan sebuah legenda: di sebuah kuil di Hanoi, terdapat 64 cakram emas yang dipasang pada sebuah tiang emas, disusun dari yang terbesar di bawah hingga terkecil di atas. Para pendeta kuil tersebut bekerja tanpa henti memindahkan cakram-cakram tersebut ke tiang lain sesuai aturan, dan menurut legenda, ketika mereka selesai, dunia akan berakhir. Berdasarkan formula 2^n - 1, untuk 64 cakram dibutuhkan 2^64 - 1 = 18.446.744.073.709.551.615 langkah --- bahkan jika para pendeta mampu memindahkan satu cakram per detik, mereka membutuhkan lebih dari 585 miliar tahun untuk menyelesaikannya.

Permasalahan Tower of Hanoi melibatkan tiga tiang yang diberi nama **A** (sumber / *source*), **B** (bantuan / *auxiliary*), dan **C** (tujuan / *destination*). Pada awalnya, tiang A memiliki n cakram yang disusun dari yang terbesar di bawah hingga yang terkecil di atas. Tujuannya adalah memindahkan seluruh susunan cakram dari tiang A ke tiang C. Terdapat tiga aturan yang tidak boleh dilanggar:

1. Hanya satu cakram yang boleh dipindahkan dalam setiap langkah.
2. Hanya cakram yang berada di puncak suatu tiang yang dapat dipindahkan.
3. Sebuah cakram yang lebih besar tidak boleh diletakkan di atas cakram yang lebih kecil.

### 8.5.2 Solusi Rekursif: Mengurai Masalah Kompleks

Keindahan Tower of Hanoi terletak pada fakta bahwa masalah yang tampak sangat kompleks memiliki solusi rekursif yang dapat dirumuskan dalam tiga kalimat. Untuk memindahkan n cakram dari tiang A ke tiang C menggunakan tiang B sebagai bantuan:

1. Pindahkan (n - 1) cakram teratas dari A ke B, menggunakan C sebagai bantuan. Ini membutuhkan T(n-1) langkah.
2. Pindahkan satu cakram terbesar (yang tersisa di A) langsung dari A ke C. Ini membutuhkan 1 langkah.
3. Pindahkan (n - 1) cakram yang kini ada di B ke C, menggunakan A sebagai bantuan. Ini membutuhkan T(n-1) langkah.

*Base case*-nya adalah: memindahkan 1 cakram langsung dari tiang sumber ke tiang tujuan, tanpa langkah perantara.

### 8.5.3 Implementasi Python

```python
def hanoi(n: int, sumber: str, tujuan: str, bantuan: str,
          langkah: list = None) -> list:
    """
    Menyelesaikan Tower of Hanoi dan mencatat setiap langkah perpindahan.

    Algoritma rekursif:
      - Base case (n=1): pindahkan langsung dari sumber ke tujuan.
      - Recursive case: (1) pindahkan n-1 cakram ke tiang bantuan,
                        (2) pindahkan cakram ke-n ke tujuan,
                        (3) pindahkan n-1 cakram dari bantuan ke tujuan.

    Parameter:
        n       (int):  Jumlah cakram yang akan dipindahkan
        sumber  (str):  Nama tiang sumber
        tujuan  (str):  Nama tiang tujuan
        bantuan (str):  Nama tiang bantuan
        langkah (list): Akumulator langkah (digunakan secara internal)

    Kembalian:
        list: Daftar string yang mendeskripsikan setiap langkah perpindahan
    """
    if langkah is None:
        langkah = []

    # Base case: satu cakram, pindahkan langsung
    if n == 1:
        langkah.append(f"Pindahkan cakram 1 dari {sumber} ke {tujuan}")
        return langkah

    # Langkah 1: pindahkan n-1 cakram dari sumber ke bantuan
    hanoi(n - 1, sumber, bantuan, tujuan, langkah)

    # Langkah 2: pindahkan cakram ke-n dari sumber ke tujuan
    langkah.append(f"Pindahkan cakram {n} dari {sumber} ke {tujuan}")

    # Langkah 3: pindahkan n-1 cakram dari bantuan ke tujuan
    hanoi(n - 1, bantuan, tujuan, sumber, langkah)

    return langkah


# Demonstrasi untuk n = 3
print("=== Tower of Hanoi: 3 Cakram ===")
hasil = hanoi(3, 'A', 'C', 'B')
for nomor, deskripsi in enumerate(hasil, 1):
    print(f"  Langkah {nomor:2d}: {deskripsi}")
print(f"\nTotal langkah: {len(hasil)} (= 2^3 - 1 = 7)")
```

### 8.5.4 Trace Lengkap Tower of Hanoi dengan n = 3

Untuk membangun intuisi yang lengkap, berikut adalah penelusuran semua 7 langkah perpindahan cakram beserta kondisi ketiga tiang setelah setiap langkah.

**Kondisi Awal:**

```
     |          |          |
    [1]         |          |
   [  2 ]       |          |
  [   3  ]      |          |
-----------  ---------  ---------
     A            B          C
```

**Gambar 8.5 --- Trace Lengkap Tower of Hanoi (n = 3)**

```
PEMANGGILAN UTAMA: hanoi(3, A, C, B)

  PEMANGGILAN: hanoi(2, A, B, C)    -- pindahkan 2 cakram dari A ke B

    PEMANGGILAN: hanoi(1, A, C, B)  -- BASE CASE
    LANGKAH 1: Pindahkan cakram 1 dari A ke C

         |          |         [1]
        |          |           |
      [  2  ]      |           |
     [   3  ]      |           |
    ---------  ---------  ---------
         A          B          C

    KEMBALI ke hanoi(2, A, B, C):
    LANGKAH 2: Pindahkan cakram 2 dari A ke B

         |          |         [1]
         |        [  2  ]      |
       [   3  ]     |          |
    ---------  ---------  ---------
         A          B          C

    PEMANGGILAN: hanoi(1, C, B, A)  -- BASE CASE
    LANGKAH 3: Pindahkan cakram 1 dari C ke B

         |         [1]         |
         |        [  2  ]      |
       [   3  ]     |          |
    ---------  ---------  ---------
         A          B          C

  KEMBALI ke hanoi(3, A, C, B):
  LANGKAH 4: Pindahkan cakram 3 dari A ke C

         |         [1]          |
         |        [  2  ]       |
         |          |        [   3   ]
    ---------  ---------  ---------
         A          B          C

  PEMANGGILAN: hanoi(2, B, C, A)    -- pindahkan 2 cakram dari B ke C

    PEMANGGILAN: hanoi(1, B, A, C)  -- BASE CASE
    LANGKAH 5: Pindahkan cakram 1 dari B ke A

        [1]         |           |
         |        [  2  ]       |
         |          |        [   3   ]
    ---------  ---------  ---------
         A          B          C

    KEMBALI ke hanoi(2, B, C, A):
    LANGKAH 6: Pindahkan cakram 2 dari B ke C

        [1]         |           |
         |          |        [  2  ]
         |          |        [   3   ]
    ---------  ---------  ---------
         A          B          C

    PEMANGGILAN: hanoi(1, A, C, B)  -- BASE CASE
    LANGKAH 7: Pindahkan cakram 1 dari A ke C

         |          |          [1]
         |          |        [  2  ]
         |          |        [   3   ]
    ---------  ---------  ---------
         A          B          C

SELESAI: Semua cakram telah berpindah ke tiang C dengan urutan yang benar.
```

**Tabel 8.3 --- Ringkasan 7 Langkah Tower of Hanoi (n = 3)**

| Langkah | Aksi                         | Tiang A         | Tiang B     | Tiang C         |
|---------|------------------------------|-----------------|-------------|-----------------|
| Awal    | ---                          | [3, 2, 1]       | []          | []              |
| 1       | Cakram 1: A ke C             | [3, 2]          | []          | [1]             |
| 2       | Cakram 2: A ke B             | [3]             | [2]         | [1]             |
| 3       | Cakram 1: C ke B             | [3]             | [2, 1]      | []              |
| 4       | Cakram 3: A ke C             | []              | [2, 1]      | [3]             |
| 5       | Cakram 1: B ke A             | [1]             | [2]         | [3]             |
| 6       | Cakram 2: B ke C             | [1]             | []          | [3, 2]          |
| 7       | Cakram 1: A ke C             | []              | []          | [3, 2, 1]       |

### 8.5.5 Analisis Kompleksitas Tower of Hanoi

Misalkan M(n) adalah jumlah minimum perpindahan cakram yang dibutuhkan untuk menyelesaikan Tower of Hanoi dengan n cakram. Berdasarkan struktur algoritmanya:

```
M(1) = 1
M(n) = 2 * M(n - 1) + 1,    untuk n >= 2
```

Penyelesaian dengan metode substitusi:

```
M(n) = 2 * M(n - 1) + 1
     = 2 * [2 * M(n - 2) + 1] + 1      = 4 * M(n - 2) + 2 + 1
     = 4 * [2 * M(n - 3) + 1] + 3      = 8 * M(n - 3) + 4 + 2 + 1
     ...
     = 2^k * M(n - k) + (2^k - 1)

Ketika k = n - 1:
     = 2^(n-1) * M(1) + (2^(n-1) - 1)
     = 2^(n-1) + 2^(n-1) - 1
     = 2 * 2^(n-1) - 1
     = 2^n - 1
```

Terbukti bahwa jumlah minimum perpindahan untuk Tower of Hanoi dengan n cakram adalah **2^n - 1**. Ini bukan sekadar batas atas --- ini adalah batas ketat (*tight bound*) yang terbukti optimal. Tidak ada strategi apa pun yang dapat menyelesaikan Tower of Hanoi dalam jumlah langkah yang lebih sedikit dari 2^n - 1.

**Tabel 8.4 --- Pertumbuhan Langkah Tower of Hanoi**

| n  | Jumlah Langkah (2^n - 1) | Waktu (1 langkah/detik)  |
|----|--------------------------|--------------------------|
| 1  | 1                        | 1 detik                  |
| 3  | 7                        | 7 detik                  |
| 10 | 1.023                    | sekitar 17 menit         |
| 20 | 1.048.575                | sekitar 12 hari          |
| 30 | 1.073.741.823            | sekitar 34 tahun         |
| 64 | 1,8 x 10^19              | sekitar 585 miliar tahun |

---

> **Catatan Penting 8.2: Eksponensial Bukan Selalu Kegagalan**
>
> Kompleksitas O(2^n) pada Tower of Hanoi sering disalahpahami sebagai "algoritma yang buruk". Penting untuk dipahami: jumlah langkah 2^n - 1 adalah **optimal** --- bukan karena algoritmanya kurang pintar, tetapi karena permasalahannya memang membutuhkan sebanyak itu. Tidak ada algoritma apa pun yang dapat menyelesaikan Tower of Hanoi dalam waktu polinomial, karena *output* berupa daftar langkah itu sendiri memiliki panjang 2^n - 1. Ini berbeda dengan, misalnya, Fibonacci naif yang juga berjalan eksponensial tetapi *dapat* dioptimalkan menjadi O(n) karena submasalahnya tumpang tindih. Selalu bedakan: apakah kompleksitas eksponensial adalah sifat *inheren masalah* ataukah hanya *kegagalan algoritmik* yang dapat diperbaiki.

---

## 8.6 Rekursi versus Iterasi: Tinjauan Komparatif

### 8.6.1 Dimensi Perbandingan

Pilihan antara rekursi dan iterasi bukan keputusan yang dapat diambil secara universal --- ia bergantung pada karakteristik masalah yang dihadapi, kendala lingkungan eksekusi, dan prioritas desain yang berlaku. Berikut adalah analisis komparatif dari lima dimensi yang relevan.

**Dimensi 1: Kompleksitas Waktu**

Untuk masalah tanpa *overlapping subproblems* (seperti faktorial), rekursi dan iterasi memiliki kompleksitas waktu yang sama. Untuk masalah dengan *overlapping subproblems* (seperti Fibonacci), rekursi *naif* jauh lebih lambat dari iterasi, tetapi rekursi dengan memoization setara dengan iterasi dalam hal kompleksitas asimptotik.

**Dimensi 2: Kompleksitas Ruang**

Ini adalah dimensi di mana rekursi secara konsisten kalah dari iterasi. Rekursi membutuhkan memori O(d) di mana d adalah kedalaman rekursi maksimum, untuk menyimpan semua *stack frame* yang aktif secara bersamaan. Iterasi umumnya hanya membutuhkan O(1) ruang tambahan untuk variabel kontrol perulangan.

**Dimensi 3: Keterbacaan dan Ekspresi**

Rekursi sering menghasilkan kode yang lebih singkat, lebih ekspresif, dan lebih dekat dengan definisi matematis masalah. Perbandingan implementasi faktorial dan Fibonacci yang telah kita lihat menunjukkan hal ini dengan jelas. Untuk masalah yang secara inheren bersifat rekursif --- seperti traversal pohon, penelusuran graf, dan evaluasi ekspresi --- rekursi adalah pendekatan yang paling natural dan paling mudah dipahami.

**Dimensi 4: Kemudahan Verifikasi Kebenaran**

Karena struktur rekursi mencerminkan induksi matematis, pembuktian kebenaran program rekursif secara formal lebih mudah dilakukan dibandingkan program iteratif. Seorang programmer dapat membuktikan bahwa kode rekursif benar dengan membuktikan: (a) base case benar, dan (b) jika pemanggilan rekursif pada submasalah yang lebih kecil menghasilkan jawaban yang benar, maka langkah rekursif menghasilkan jawaban yang benar untuk masalah yang lebih besar. Ini persis struktur pembuktian induktif.

**Dimensi 5: Risiko Stack Overflow**

Python memiliki batas kedalaman rekursi bawaan sebesar 1.000 frame. Rekursi yang melampaui batas ini akan menghasilkan `RecursionError`. Batas ini dapat diubah menggunakan `sys.setrecursionlimit()`, tetapi ini bukan solusi yang direkomendasikan karena tidak mengatasi masalah fundamental konsumsi memori *stack*. Iterasi tidak memiliki risiko ini.

### 8.6.2 Perbandingan Empiris: Faktorial

```python
import sys
import time

def faktorial_rekursif(n: int) -> int:
    if n == 0:
        return 1
    return n * faktorial_rekursif(n - 1)

def faktorial_iteratif(n: int) -> int:
    hasil = 1
    for i in range(2, n + 1):
        hasil *= i
    return hasil

# Pengujian performa
n = 900   # mendekati batas rekursi Python default (1000)

t0 = time.perf_counter()
r = faktorial_rekursif(n)
t1 = time.perf_counter()

t2 = time.perf_counter()
it = faktorial_iteratif(n)
t3 = time.perf_counter()

print(f"Rekursif  : {(t1-t0)*1e6:.1f} mikrodetik")
print(f"Iteratif  : {(t3-t2)*1e6:.1f} mikrodetik")
print(f"Batas rekursi Python: {sys.getrecursionlimit()} frame")
```

### 8.6.3 Rekursi Ekor (Tail Recursion) dan Keterbatasannya di Python

*Tail recursion* (rekursi ekor) adalah bentuk khusus rekursi di mana pemanggilan rekursif adalah operasi **terakhir** yang dilakukan fungsi --- tidak ada komputasi yang dilakukan setelah pemanggilan rekursif kembali. Ini penting karena bahasa pemrograman fungsional seperti Haskell, Scheme, dan Erlang mengoptimalkan rekursi ekor menjadi perulangan secara otomatis (*tail-call optimization*, atau TCO), sehingga rekursi ekor di bahasa-bahasa tersebut tidak mengonsumsi *stack frame* tambahan.

```python
# Faktorial standar: BUKAN tail recursive
# Setelah faktorial(n-1) kembali, masih ada perkalian n * (...) yang belum selesai
def faktorial_rekursif(n):
    if n == 0:
        return 1
    return n * faktorial_rekursif(n - 1)  # perkalian SETELAH rekursi kembali


# Faktorial dengan akumulator: bentuk yang mendekati tail recursive
# Setelah faktorial_tail(n-1, ...) kembali, tidak ada komputasi lagi
def faktorial_tail(n: int, akumulator: int = 1) -> int:
    """
    Faktorial dengan parameter akumulator (mendekati tail recursive form).

    Parameter:
        n          (int): Bilangan bulat non-negatif
        akumulator (int): Nilai akumulasi sementara (default 1)

    Kembalian:
        int: Nilai n!
    """
    if n < 0:
        raise ValueError("Faktorial tidak terdefinisi untuk bilangan negatif")
    if n == 0:
        return akumulator
    # Seluruh hasil parsial dibawa dalam akumulator,
    # sehingga pemanggilan rekursif adalah operasi terakhir
    return faktorial_tail(n - 1, n * akumulator)


# Verifikasi
for i in range(7):
    print(f"{i}! = {faktorial_tail(i)}")
```

Sayangnya, Python secara sengaja **tidak mengimplementasikan** *tail-call optimization*. Keputusan ini dibuat oleh Guido van Rossum dengan argumen bahwa TCO akan menyulitkan pembacaan *traceback* kesalahan dan mengaburkan tumpukan pemanggilan yang bermanfaat untuk *debugging*. Akibatnya, meskipun `faktorial_tail` ditulis dalam bentuk yang secara konseptual rekursif ekor, Python tetap mengalokasikan *stack frame* baru untuk setiap pemanggilan. Untuk nilai n yang besar di Python, solusi iteratif tetap menjadi pilihan terbaik.

---

## 8.7 Recurrence Relation: Analisis Formal Kompleksitas Rekursi

### 8.7.1 Definisi dan Metode Penyelesaian

*Recurrence relation* (relasi rekurensi) adalah persamaan yang mendefinisikan nilai suatu fungsi --- biasanya T(n), yang merepresentasikan kompleksitas waktu suatu algoritma rekursif --- dalam bentuk nilai fungsi tersebut untuk input yang lebih kecil. Cormen, Leiserson, Rivest, dan Stein (2022, Bab 4) memperkenalkan tiga metode utama penyelesaian *recurrence relation*:

*Substitution Method* (metode substitusi) bekerja dalam dua tahap: (1) tebak bentuk solusinya, misalnya T(n) = O(n^2), kemudian (2) buktikan tebakan tersebut valid menggunakan substitusi dan induksi matematis. Metode ini membutuhkan intuisi yang berkembang seiring pengalaman.

*Recursion Tree Method* (metode pohon rekursi) melibatkan penggambaran pohon yang merepresentasikan seluruh pekerjaan yang dilakukan oleh algoritma rekursif. Setiap node dalam pohon mewakili biaya pekerjaan yang dilakukan pada level rekursi tersebut, dan solusi diperoleh dengan menjumlahkan biaya seluruh level.

*Master Theorem* memberikan solusi langsung untuk *recurrence* berbentuk T(n) = a * T(n/b) + f(n), di mana a >= 1 dan b > 1. Teorema ini sangat berguna untuk menganalisis algoritma *divide-and-conquer* yang membagi masalah menjadi a submasalah dengan ukuran n/b.

### 8.7.2 Contoh Penerapan Metode Substitusi

Perhatikan *recurrence* berikut yang muncul pada algoritma yang membagi masalah secara linear:

```
T(n) = T(n - 1) + n      (biaya O(n) di setiap level, kedalaman n)
T(1) = O(1)
```

*Tebakan:* T(n) = O(n^2), yaitu T(n) <= c * n^2 untuk konstanta c yang tepat.

*Bukti dengan induksi:*

```
Misalkan T(k) <= c * k^2 untuk semua k < n (hipotesis induktif).

T(n) = T(n - 1) + n
     <= c * (n - 1)^2 + n           (menggunakan hipotesis induktif)
     = c * (n^2 - 2n + 1) + n
     = c * n^2 - 2cn + c + n
     = c * n^2 - n * (2c - 1) + c

Untuk c >= 1: (2c - 1) >= 1 > 0, sehingga -n * (2c - 1) <= 0.
Maka T(n) <= c * n^2.

TERBUKTI: T(n) = O(n^2).
```

### 8.7.3 Rekapitulasi Kompleksitas Semua Algoritma

**Tabel 8.5 --- Rekapitulasi Kompleksitas Algoritma Rekursif yang Dibahas**

| Algoritma                   | Recurrence Relation              | Waktu         | Ruang  |
|-----------------------------|----------------------------------|---------------|--------|
| Faktorial rekursif          | T(n) = T(n-1) + O(1)             | O(n)          | O(n)   |
| Faktorial iteratif          | (tidak berlaku)                  | O(n)          | O(1)   |
| Fibonacci rekursif naif     | T(n) = T(n-1) + T(n-2) + O(1)   | O(phi^n)      | O(n)   |
| Fibonacci + memoization     | T(n) = O(n) (setelah analisis)   | O(n)          | O(n)   |
| Fibonacci iteratif          | (tidak berlaku)                  | O(n)          | O(1)   |
| Tower of Hanoi              | T(n) = 2T(n-1) + O(1)            | O(2^n)        | O(n)   |

Tabel di atas merangkum temuan penting: untuk semua algoritma yang dibahas, kompleksitas ruang rekursif adalah O(n) karena setiap level rekursi menambahkan satu *stack frame*, sedangkan versi iteratif yang setara umumnya membutuhkan O(1) ruang tambahan.

---

## 8.8 Studi Kasus: Rekursi dalam Aplikasi Nyata

### 8.8.1 Enumerasi Power Set

Sebuah aplikasi rekursi yang muncul dalam berbagai konteks nyata --- dari kriptografi hingga pembelajaran mesin --- adalah enumerasi *power set*: menghasilkan semua subhimpunan dari suatu himpunan. Untuk himpunan dengan n elemen, terdapat tepat 2^n subhimpunan (termasuk himpunan kosong dan himpunan itu sendiri).

```python
def power_set(S: list, indeks: int = 0) -> list:
    """
    Menghasilkan semua subhimpunan dari list S (Power Set) secara rekursif.

    Logika rekursif:
    - Base case: semua elemen telah diproses, kembalikan [[]].
    - Recursive case: bagi menjadi subhimpunan yang TIDAK menyertakan S[indeks]
      dan yang MENYERTAKAN S[indeks].

    Parameter:
        S      (list): Himpunan input
        indeks (int):  Indeks elemen yang sedang dipertimbangkan

    Kembalian:
        list: Daftar semua 2^len(S) subhimpunan
    """
    # Base case: semua elemen telah diproses
    if indeks == len(S):
        return [[]]   # hanya ada satu subhimpunan: himpunan kosong

    # Dapatkan power set dari sisa elemen (S[indeks+1:])
    sub_tanpa = power_set(S, indeks + 1)

    # Buat subhimpunan baru dengan menyertakan S[indeks] di depan setiap sub
    sub_dengan = [[S[indeks]] + sub for sub in sub_tanpa]

    # Gabungkan keduanya
    return sub_tanpa + sub_dengan


# Pengujian
S = [1, 2, 3]
hasil = power_set(S)
print(f"S = {S}")
print(f"Jumlah subhimpunan: {len(hasil)} (= 2^{len(S)} = {2**len(S)})")
print("Power Set S:")
for i, sub in enumerate(hasil, 1):
    print(f"  {i:2d}. {sub}")
```

Keluaran:

```
S = [1, 2, 3]
Jumlah subhimpunan: 8 (= 2^3 = 8)
Power Set S:
   1. []
   2. [3]
   3. [2]
   4. [2, 3]
   5. [1]
   6. [1, 3]
   7. [1, 2]
   8. [1, 2, 3]
```

Kompleksitas fungsi ini adalah O(n * 2^n) untuk waktu dan ruang --- optimal karena ukuran output sendiri adalah O(n * 2^n).

### 8.8.2 Pencarian Biner Rekursif

Pencarian biner adalah contoh *linear recursion* yang muncul dalam konteks pencarian pada data terurut. Dalam setiap langkah, masalah dipotong menjadi setengahnya:

```python
def pencarian_biner(arr: list, target: int,
                    kiri: int = None, kanan: int = None) -> int:
    """
    Mencari posisi target dalam list terurut secara rekursif (binary search).

    Kompleksitas: O(log n) waktu, O(log n) ruang (karena call stack).
    Versi iteratif memiliki O(1) ruang.

    Parameter:
        arr    (list): List bilangan yang sudah terurut menaik
        target (int):  Nilai yang dicari
        kiri   (int):  Indeks kiri wilayah pencarian (inklusif)
        kanan  (int):  Indeks kanan wilayah pencarian (inklusif)

    Kembalian:
        int: Indeks posisi target, atau -1 jika tidak ditemukan
    """
    if kiri is None:
        kiri = 0
    if kanan is None:
        kanan = len(arr) - 1

    # Base case 1: wilayah pencarian kosong, target tidak ada
    if kiri > kanan:
        return -1

    tengah = (kiri + kanan) // 2

    # Base case 2: target ditemukan
    if arr[tengah] == target:
        return tengah

    # Recursive case: cari di setengah kiri atau kanan
    if target < arr[tengah]:
        return pencarian_biner(arr, target, kiri, tengah - 1)
    else:
        return pencarian_biner(arr, target, tengah + 1, kanan)


# Pengujian
data = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
print(f"Data: {data}")
for nilai in [23, 38, 99, 2]:
    posisi = pencarian_biner(data, nilai)
    if posisi != -1:
        print(f"  Nilai {nilai} ditemukan di indeks {posisi}")
    else:
        print(f"  Nilai {nilai} tidak ditemukan")
```

Keluaran:

```
Data: [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
  Nilai 23 ditemukan di indeks 5
  Nilai 38 ditemukan di indeks 6
  Nilai 99 tidak ditemukan
  Nilai 2 ditemukan di indeks 0
```

Untuk pencarian biner rekursif, *recurrence*-nya adalah T(n) = T(n/2) + O(1), yang diselesaikan oleh Master Theorem menjadi T(n) = **O(log n)**.

---

## 8.9 Rangkuman Bab

1. **Rekursi** adalah teknik pemrograman di mana sebuah fungsi memanggil dirinya sendiri untuk memecah masalah besar menjadi submasalah yang lebih kecil namun berpola identik. Setiap fungsi rekursif yang valid wajib memiliki *base case* yang menghentikan rekursi dan *recursive case* yang mengarah menuju *base case*, dengan ukuran masalah yang selalu menyusut di setiap langkah.

2. **Call stack** adalah mekanisme inti yang memungkinkan rekursi bekerja. Setiap pemanggilan fungsi mengalokasikan sebuah *stack frame* baru di puncak tumpukan (fase *winding*). Setelah *base case* tercapai, *stack frame* dikembalikan satu per satu sambil menghitung hasil akhir (fase *unwinding*). Kedalaman rekursi maksimum menentukan kebutuhan memori *stack* algoritma tersebut.

3. **Faktorial rekursif** adalah contoh *linear recursion* dengan *recurrence* T(n) = T(n-1) + O(1), yang diselesaikan menjadi T(n) = O(n). Meskipun kompleksitas waktunya sama dengan versi iteratif, versi rekursif menggunakan O(n) memori *stack* dibandingkan O(1) pada versi iteratif.

4. **Fibonacci naif** adalah contoh *binary recursion* yang menunjukkan bahaya *overlapping subproblems*: nilai yang sama dihitung berulang-ulang, menghasilkan kompleksitas waktu eksponensial O(phi^n ≈ 1.618^n). Teknik **memoization** --- menyimpan hasil yang sudah dihitung untuk digunakan kembali --- mampu mereduksi kompleksitas waktu menjadi O(n), setara dengan implementasi iteratif.

5. **Tower of Hanoi** merupakan contoh rekursi eksponensial yang optimal: 2^n - 1 langkah bukan kegagalan algoritma, melainkan cerminan dari ukuran *output* masalah itu sendiri. *Recurrence* T(n) = 2T(n-1) + O(1) diselesaikan menjadi T(n) = O(2^n).

6. **Rekursi versus iterasi** melibatkan *trade-off* yang harus dipertimbangkan berdasarkan konteks. Rekursi unggul dalam keterbacaan, ekspresi natural, dan kemudahan pembuktian kebenaran untuk masalah yang secara inheren rekursif. Iterasi unggul dalam efisiensi ruang (O(1) versus O(n)) dan tidak memiliki risiko *stack overflow*. Di Python, *tail-call optimization* tidak diimplementasikan, sehingga rekursi ekor tetap mengonsumsi *stack frame* seperti rekursi biasa.

7. **Recurrence relation** adalah alat formal untuk menganalisis kompleksitas algoritma rekursif. Metode substitusi, pohon rekursi, dan Master Theorem adalah tiga teknik utama yang memungkinkan perbandingan kuantitatif berbasis bukti antara berbagai pendekatan algoritmik.

---

## Istilah Kunci

**Base case** --- Kondisi dalam fungsi rekursif di mana fungsi mengembalikan nilai secara langsung tanpa melakukan pemanggilan rekursif lebih lanjut; titik berhenti yang menjamin terminasi rekursi.

**Binary recursion** --- Pola rekursi di mana setiap eksekusi fungsi menghasilkan tepat dua pemanggilan rekursif; karakteristik dari algoritma seperti Fibonacci naif dan *merge sort*.

**Call stack** --- Struktur data internal sistem *runtime* yang menyimpan informasi eksekusi (parameter, variabel lokal, *return address*) dari semua fungsi yang sedang aktif dalam bentuk tumpukan LIFO.

**Direct recursion** --- Bentuk rekursi di mana sebuah fungsi memanggil dirinya sendiri secara langsung dalam tubuh fungsinya.

**Golden ratio (phi)** --- Konstanta irasional phi = (1 + sqrt(5)) / 2 ≈ 1.61803, yang muncul sebagai basis pertumbuhan kompleksitas waktu Fibonacci naif dan juga sebagai limit dari rasio suku-suku berurutan dalam deret Fibonacci.

**Indirect recursion** --- Bentuk rekursi di mana fungsi A memanggil fungsi B, yang pada gilirannya memanggil kembali fungsi A, membentuk siklus pemanggilan.

**Linear recursion** --- Pola rekursi di mana setiap eksekusi fungsi menghasilkan tepat satu pemanggilan rekursif; karakteristik dari algoritma seperti faktorial dan pencarian biner.

**Master Theorem** --- Teorema dalam analisis algoritma yang memberikan solusi langsung untuk *recurrence* berbentuk T(n) = a * T(n/b) + f(n), berguna untuk algoritma *divide-and-conquer*.

**Memoization** --- Teknik optimasi yang menyimpan hasil komputasi dari pemanggilan fungsi tertentu sehingga hasil tersebut dapat digunakan kembali ketika fungsi dipanggil dengan argumen yang sama, menghindari komputasi berulang.

**Multiple recursion** --- Pola rekursi di mana setiap eksekusi fungsi menghasilkan lebih dari dua pemanggilan rekursif; karakteristik dari algoritma enumerasi kombinatorik.

**Overlapping subproblems** --- Properti masalah di mana submasalah yang sama perlu diselesaikan lebih dari satu kali dalam proses rekursi naif; ini adalah properti yang membuat *memoization* efektif.

**Recurrence relation** --- Persamaan yang mendefinisikan nilai suatu fungsi dalam bentuk nilai fungsi tersebut untuk input yang lebih kecil; digunakan untuk menganalisis kompleksitas algoritma rekursif secara formal.

**Recursive case** --- Bagian dari fungsi rekursif yang memecah masalah menjadi satu atau lebih submasalah yang lebih kecil dan memanggil fungsi secara rekursif untuk menyelesaikannya.

**RecursionError** --- Kesalahan (*exception*) yang dihasilkan Python ketika kedalaman rekursi melampaui batas yang ditetapkan (bawaan: 1.000 frame), akibat dari tidak tercapainya *base case* atau kedalaman rekursi yang terlalu besar.

**Stack frame** --- Blok memori yang dialokasikan di *call stack* untuk setiap pemanggilan fungsi aktif, berisi parameter, variabel lokal, *return address*, dan area penyimpanan nilai kembalian.

**Stack overflow** --- Kondisi di mana *call stack* kehabisan memori akibat terlalu banyak *stack frame* yang ditumpuk, biasanya karena rekursi yang terlalu dalam atau rekursi tak hingga.

**Substitution method** --- Metode penyelesaian *recurrence relation* dengan menebak bentuk solusi kemudian membuktikan kebenaran tebakan tersebut menggunakan substitusi dan induksi matematis.

**Tail recursion** --- Bentuk rekursi di mana pemanggilan rekursif adalah operasi terakhir yang dilakukan oleh fungsi, tanpa komputasi tambahan setelah pemanggilan tersebut kembali.

**Tower of Hanoi** --- Teka-teki matematika klasik yang diciptakan Edouard Lucas (1883) yang menjadi contoh paradigmatis rekursi eksponensial dengan solusi optimal 2^n - 1 langkah.

**Well-founded ordering** --- Konsep matematika formal yang menjamin terminasi rekursi: adanya urutan parsial pada domain fungsi yang tidak memungkinkan rantai penurunan tak hingga.

**Winding phase** --- Fase pertumbuhan *call stack* pada eksekusi fungsi rekursif, yaitu ketika pemanggilan rekursif terus ditambahkan ke tumpukan hingga *base case* tercapai.

**Unwinding phase** --- Fase penyusutan *call stack* pada eksekusi fungsi rekursif, yaitu ketika *stack frame* dikembalikan satu per satu sambil menghitung nilai akhir setelah *base case* tercapai.

---

## Soal Latihan

### Bagian A: Pilihan Ganda

**Soal A-1 [C2 --- Memahami]**

Perhatikan fungsi berikut:

```python
def f(n):
    if n <= 1:
        return n
    return f(n - 1) + f(n - 2)
```

Apakah nilai yang dikembalikan oleh pemanggilan `f(7)`?

a) 8
b) 13
c) 21
d) 34

---

**Soal A-2 [C2 --- Memahami]**

Berapa jumlah *stack frame* yang ada secara bersamaan di *call stack* pada saat *base case* pertama kali tercapai dalam eksekusi `faktorial_rekursif(6)`?

a) 5 frame
b) 6 frame
c) 7 frame
d) 12 frame

---

**Soal A-3 [C2 --- Memahami]**

Manakah dari pernyataan berikut yang paling tepat menggambarkan perbedaan antara fase *winding* dan fase *unwinding* dalam eksekusi rekursi?

a) Fase *winding* terjadi ketika *base case* tercapai dan nilai mulai dikembalikan; fase *unwinding* terjadi ketika pemanggilan rekursif baru dibuat.
b) Fase *winding* adalah proses penumpukan *stack frame* akibat pemanggilan rekursif; fase *unwinding* adalah proses penghapusan *stack frame* ketika nilai dikembalikan setelah *base case* tercapai.
c) Fase *winding* dan *unwinding* terjadi secara bersamaan pada setiap level rekursi.
d) Fase *winding* hanya terjadi pada *binary recursion*; fase *unwinding* terjadi pada semua jenis rekursi.

---

**Soal A-4 [C3 --- Menerapkan]**

Berapakah jumlah langkah minimum yang diperlukan untuk menyelesaikan Tower of Hanoi dengan 6 cakram?

a) 36
b) 62
c) 63
d) 64

---

**Soal A-5 [C4 --- Menganalisis]**

Mengapa `fibonacci_rekursif(35)` membutuhkan waktu ribuan kali lebih lama dibandingkan `fibonacci_memo(35)`, meskipun keduanya menghasilkan output yang identik?

a) Karena `fibonacci_memo` menggunakan lebih banyak memori sehingga prosesnya lebih paralel.
b) Karena `fibonacci_rekursif` melakukan pemanggilan rekursif yang jumlahnya tumbuh secara eksponensial akibat perhitungan submasalah yang sama berulang kali, sementara `fibonacci_memo` menghitung setiap nilai tepat satu kali.
c) Karena `fibonacci_rekursif` menggunakan *binary recursion* yang selalu lebih lambat dari *linear recursion*.
d) Karena `fibonacci_memo` menggunakan loop internal yang jauh lebih cepat dari rekursi.

---

**Soal A-6 [C4 --- Menganalisis]**

Sebuah algoritma rekursif memiliki *recurrence relation* T(n) = T(n/2) + O(1). Berapakah kompleksitas waktu algoritma ini?

a) O(1)
b) O(log n)
c) O(n)
d) O(n log n)

---

### Bagian B: Soal Esai dan Implementasi

**Soal B-1 [C2 --- Memahami]**

Jelaskan secara naratif mekanisme kerja *call stack* ketika fungsi rekursif `faktorial_rekursif(3)` dieksekusi. Deskripsikan dengan detail isi setiap *stack frame* pada saat kedalaman maksimum tercapai (ketika *base case* dipanggil), kemudian jelaskan bagaimana fase *unwinding* bekerja langkah demi langkah hingga hasil akhir diperoleh. Sertakan diagram *call stack* ASCII sederhana untuk mendukung penjelasan Anda.

---

**Soal B-2 [C3 --- Menerapkan]**

Implementasikan fungsi rekursif `pangkat(basis, eksponen)` dalam Python yang menghitung `basis^eksponen` untuk eksponen bulat non-negatif. Pastikan fungsi menangani kasus tepi (*edge case*) dengan tepat. Kemudian:

a) Tulis *recurrence relation* untuk kompleksitas waktu fungsi tersebut.
b) Selesaikan *recurrence relation* tersebut menggunakan metode substitusi.
c) Tuliskan implementasi iteratif yang setara dan bandingkan kompleksitas ruang kedua implementasi.
d) Sebagai tantangan, rancang versi yang lebih efisien menggunakan prinsip *fast exponentiation* (eksponen cepat): jika eksponen genap, maka `b^n = (b^(n/2))^2`. Berapakah kompleksitas waktu versi ini?

---

**Soal B-3 [C3 --- Menerapkan]**

Implementasikan fungsi rekursif `jumlah_digit(n)` yang menghitung jumlah semua digit dari bilangan bulat positif n. Contoh: `jumlah_digit(1234)` = 1 + 2 + 3 + 4 = 10. Sertakan:

a) Identifikasi *base case* dan *recursive case* secara eksplisit.
b) Implementasi Python lengkap dengan dokumentasi.
c) Trace eksekusi untuk `jumlah_digit(456)` yang menunjukkan setiap pemanggilan rekursif dan nilai yang dikembalikan.

---

**Soal B-4 [C4 --- Menganalisis]**

Analisis perbedaan antara tiga implementasi Fibonacci --- rekursif naif, rekursif dengan memoization, dan iteratif --- dari segi:

a) Kompleksitas waktu (sertakan penurunan *recurrence relation* untuk yang naif).
b) Kompleksitas ruang.
c) Perilaku untuk nilai n yang sangat besar (misalnya n = 10.000) di Python.
d) Kemudahan dalam membuktikan kebenaran (*correctness*) secara formal.

Buat tabel perbandingan yang merangkum keempat dimensi tersebut.

---

**Soal B-5 [C4 --- Menganalisis]**

Seorang mahasiswa menulis dua versi fungsi untuk menghitung jumlah semua elemen dalam sebuah list:

```python
# Versi 1
def jumlah_list_A(lst):
    if len(lst) == 0:
        return 0
    return lst[0] + jumlah_list_A(lst[1:])

# Versi 2
def jumlah_list_B(lst):
    if len(lst) == 0:
        return 0
    tengah = len(lst) // 2
    return jumlah_list_B(lst[:tengah]) + jumlah_list_B(lst[tengah:])
```

a) Identifikasi pola rekursi (linear/binary/multiple) dari masing-masing versi.
b) Turunkan *recurrence relation* untuk kompleksitas waktu masing-masing.
c) Selesaikan *recurrence relation* tersebut dan tentukan kompleksitas Big-O.
d) Untuk `lst = [1, 2, 3, 4, 5, 6, 7, 8]`, gambarkan pohon rekursi dari Versi 2 dan hitung total jumlah pemanggilan fungsi.

---

**Soal B-6 [C5 --- Mengevaluasi]**

Evaluasi pernyataan berikut dan berikan argumen yang terstruktur: *"Karena Python tidak mendukung tail-call optimization, semua penggunaan rekursi dalam kode Python produksi harus diganti dengan iterasi."* Apakah pernyataan ini valid? Dalam kondisi apa rekursi masih merupakan pilihan yang dibenarkan di Python, dan dalam kondisi apa iterasi harus dipilih? Sertakan minimal dua contoh konkret untuk mendukung argumen Anda.

---

**Soal B-7 [C6 --- Mencipta]**

Rancang dan implementasikan fungsi rekursif `urutan_suku_n(n, a, d)` yang menghasilkan seluruh suku dari deret aritmetika dengan suku pertama `a`, beda `d`, dan banyak suku `n`. Contoh: `urutan_suku_n(5, 2, 3)` menghasilkan `[2, 5, 8, 11, 14]`.

a) Rumuskan definisi rekursif deret aritmetika ini secara matematis.
b) Implementasikan fungsi Python berdasarkan definisi rekursif tersebut.
c) Analisis kompleksitas waktu dan ruang implementasi Anda.
d) Bandingkan dengan implementasi menggunakan *list comprehension* `[a + i*d for i in range(n)]` dari segi keterbacaan, fleksibilitas, dan efisiensi.

---

**Soal B-8 [C6 --- Mencipta]**

Masalah *Josephus Problem*: n orang berdiri melingkar dengan nomor 1 hingga n. Dimulai dari orang ke-1, setiap orang ke-k dieliminasi secara berurutan (berputar kembali ke depan setelah melewati orang terakhir) hingga hanya satu orang tersisa. Tentukan posisi orang yang selamat.

Definisi rekursif Josephus adalah:
```
J(1, k) = 1
J(n, k) = ((J(n-1, k) + k - 1) mod n) + 1
```

a) Implementasikan fungsi `josephus(n, k)` dalam Python berdasarkan definisi rekursif di atas.
b) Verifikasi dengan n=7, k=2 (jawaban yang benar adalah posisi ke-7).
c) Tuliskan *recurrence relation* untuk kompleksitas waktu fungsi ini dan selesaikan.
d) Implementasikan juga versi iteratif dan bandingkan kompleksitas ruang keduanya.

---

## Bacaan Lanjutan

1. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H.** (2013). *Data Structures and Algorithms in Python*. John Wiley & Sons. **Bab 5: Recursion** (hlm. 192--242). Ini adalah sumber utama yang digunakan dalam bab ini. Pembahasan mencakup *linear recursion*, *binary recursion*, *multiple recursion*, serta penerapan rekursi pada masalah-masalah klasik dalam Python. Sangat direkomendasikan sebagai bacaan wajib untuk memperdalam pemahaman konseptual yang dibangun dalam bab ini.

2. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C.** (2022). *Introduction to Algorithms* (4th ed.). MIT Press. **Bab 4: Divide-and-Conquer** (hlm. 76--122). Sumber referensi paling komprehensif untuk analisis kompleksitas algoritma rekursif. Mencakup *substitution method*, *recursion-tree method*, dan *Master Theorem* dengan pembuktian formal yang ketat. Esensial bagi pembaca yang ingin menguasai analisis algoritmik pada level lanjut.

3. **Miller, B. N., & Ranum, D. L.** (2011). *Problem Solving with Algorithms and Data Structures Using Python* (2nd ed.). Franklin, Beedle & Associates. **Bab 5: Recursion** (hlm. 191--244). Tersedia bebas secara daring di *runestone.academy*. Membahas rekursi dari sudut pandang pemecahan masalah dengan Python, mencakup Tower of Hanoi, fraktal Koch, dan memoization. Gaya penyajiannya lebih aksesibel dibandingkan Cormen dan sangat cocok sebagai pelengkap bab ini.

4. **Lee, K. D.** (2014). *Python Programming Fundamentals* (2nd ed.). Springer. **Bab 8: Recursion** (hlm. 179--208). Menyajikan rekursi dalam konteks pemrograman Python secara komprehensif dengan banyak contoh kode yang dapat langsung dijalankan. Penjelasan visual tentang *call stack* di buku ini sangat baik untuk pembaca yang baru pertama kali berkenalan dengan rekursi.

5. **Sedgewick, R., & Wayne, K.** (2011). *Algorithms* (4th ed.). Addison-Wesley Professional. **Bab 2.2: Mergesort** (hlm. 270--289) dan **Bab 2.3: Quicksort** (hlm. 288--307). Menunjukkan rekursi dalam konteks algoritma pengurutan paling penting, yaitu *merge sort* dan *quick sort*. Pembacaan bab-bab ini akan memperlihatkan bagaimana konsep rekursi dalam bab ini diaplikasikan pada masalah pengurutan skala besar.

6. **Skiena, S. S.** (2020). *The Algorithm Design Manual* (3rd ed.). Springer. **Bab 10: Dynamic Programming** (hlm. 335--360). Membahas memoization dan *dynamic programming* sebagai ekstensi alami dari rekursi dengan *overlapping subproblems*. Memberikan perspektif yang lebih luas tentang bagaimana teknik-teknik yang diperkenalkan dalam bab ini --- terutama memoization --- terhubung ke paradigma desain algoritma yang lebih besar.

7. **Hofstadter, D. R.** (1979). *Godel, Escher, Bach: An Eternal Golden Braid*. Basic Books. Sebuah karya lintas disiplin yang mengeksplorasi rekursi, *self-reference*, dan loop aneh (*strange loops*) dalam matematika, musik, dan seni visual. Bukan buku teks teknis, tetapi menjadi bacaan klasik yang membangun intuisi mendalam tentang mengapa rekursi adalah konsep yang begitu fundamental dan universal. Sangat direkomendasikan bagi pembaca yang ingin memahami rekursi tidak hanya sebagai teknik pemrograman, tetapi sebagai prinsip berpikir.

8. **van Rossum, G.** (2009). *Why Python Doesn't Have Tail Call Optimization*. Neopythonic Blog (tersedia daring). Posting blog dari pencipta Python yang menjelaskan alasan desain di balik keputusan untuk tidak mengimplementasikan *tail-call optimization* di Python. Sangat relevan untuk memahami bagian 8.6.3 dalam bab ini dan memberikan wawasan tentang trade-off filosofis dalam desain bahasa pemrograman.

---

*Bab berikutnya akan membahas **Pohon (Tree)** --- struktur data non-linear yang paling alami diimplementasikan dan ditelusuri menggunakan rekursi. Konsep rekursi yang telah Anda kuasai dalam bab ini akan menjadi fondasi yang tak tergantikan untuk memahami operasi-operasi pada pohon biner, pohon pencarian biner, dan heap.*
