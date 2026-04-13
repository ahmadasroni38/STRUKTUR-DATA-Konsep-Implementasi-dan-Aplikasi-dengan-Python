# BAB 3
# ARRAY DAN STRING

---

> *"Algorithms + Data Structures = Programs."*
>
> --- Niklaus Wirth, pemenang ACM Turing Award 1984, dalam judul bukunya yang menjadi landasan ilmu komputer modern (Prentice-Hall, 1976).

---

## Tujuan Pembelajaran

Setelah mempelajari bab ini secara tuntas, mahasiswa diharapkan mampu:

1. **[C2 - Memahami]** Menjelaskan konsep penyimpanan array dalam memori komputer, membedakan alokasi statis dan dinamis, serta menghitung alamat memori elemen array menggunakan formula pengalamatan langsung.

2. **[C3 - Menerapkan]** Mengimplementasikan kelas array satu dimensi dan dua dimensi dalam Python menggunakan pendekatan berorientasi objek, lengkap dengan validasi batas indeks dan penanganan pengecualian.

3. **[C3 - Menerapkan]** Melaksanakan operasi-operasi dasar array secara terprogram, meliputi penelusuran (traverse), pencarian linear, penyisipan (insert), dan penghapusan (delete), disertai analisis kompleksitas waktu dan ruang masing-masing operasi.

4. **[C2 - Memahami]** Menjelaskan pengertian sparse array, menghitung densitas (density) suatu matriks, dan mengidentifikasi kondisi di mana representasi sparse lebih efisien dibandingkan representasi dense.

5. **[C3 - Menerapkan]** Mengimplementasikan representasi sparse array menggunakan format COO (Coordinate) dan dictionary Python, serta membandingkan efisiensi penggunaan memori kedua pendekatan tersebut.

6. **[C3 - Menerapkan]** Melakukan manipulasi string dalam Python menggunakan operasi slicing, pencarian pola, penggantian, penggabungan, dan pemisahan, serta memilih metode yang tepat berdasarkan efisiensi komputasi.

7. **[C4 - Menganalisis]** Menganalisis penerapan array dua dimensi dalam pengolahan citra digital, termasuk konversi RGB ke grayscale, penghitungan statistik piksel, dan deteksi tepi, kemudian mengidentifikasi hubungan antara operasi matriks dan transformasi citra.

8. **[C5 - Mengevaluasi]** Membandingkan dan memilih struktur penyimpanan yang paling sesuai --- antara `list` Python, modul `array`, dan `numpy.ndarray` --- untuk skenario permasalahan dengan mempertimbangkan konsumsi memori, kecepatan komputasi, dan kemudahan penggunaan.

---

## 3.1 Pengantar: Mengapa Array Menjadi Fondasi Komputasi

Setiap program komputer yang bermakna pada akhirnya berurusan dengan kumpulan data. Ketika seorang programmer perlu menyimpan seratus nilai suhu, ribuan kata dalam sebuah dokumen, atau jutaan piksel dalam sebuah foto, ia memerlukan mekanisme yang memungkinkan penyimpanan kolektif sekaligus pengaksesan individual yang efisien. Array hadir sebagai jawaban atas kebutuhan mendasar ini --- sebuah struktur data yang telah ada sejak generasi pertama bahasa pemrograman tingkat tinggi dan masih relevan hingga era komputasi modern.

Array bukanlah sekadar "kumpulan variabel". Sifat khasnya adalah penyimpanan elemen-elemen secara berurutan (contiguous) dalam memori komputer, sehingga setiap elemen dapat diakses dalam waktu konstan O(1) tanpa bergantung pada ukuran array. Sifat inilah yang membedakan array secara fundamental dari struktur data berbasis simpul (node) seperti linked list, di mana pengaksesan elemen ke-n mengharuskan penelusuran dari awal.

Dalam konteks Python, array hadir dalam beberapa bentuk. Tipe data `list` yang dinamis merupakan implementasi array yang paling umum digunakan. Modul `array` bawaan Python menyediakan array bertipe tunggal yang lebih hemat memori. Pustaka NumPy, yang menjadi tulang punggung komputasi ilmiah Python, menyediakan `ndarray` dengan dukungan operasi vektorial berperforma tinggi. Bab ini menelaah seluruh aspek ini secara sistematis, dari konsep representasi memori hingga penerapannya dalam pengolahan citra digital.

Pemahaman mendalam tentang array juga merupakan prasyarat untuk mempelajari struktur data lanjutan. Stack, queue, dan heap sering diimplementasikan di atas array. Hash table menggunakan array sebagai struktur penyimpanan dasarnya. Bahkan pohon biner dapat direpresentasikan secara efisien menggunakan array. Dengan kata lain, penguasaan array adalah gerbang masuk menuju seluruh dunia struktur data.

---

## 3.2 Representasi Array dalam Memori Komputer

### 3.2.1 Definisi Formal dan Sifat Fundamental

Secara formal, array `A` dengan `n` elemen dapat didefinisikan sebagai himpunan terurut:

```
A = [a_0, a_1, a_2, ..., a_(n-1)]
```

di mana setiap elemen `a_i` dapat diakses melalui indeks bilangan bulat `i` dalam rentang `[0, n-1]`. Indeks berbasis nol (zero-based indexing) ini merupakan konvensi yang digunakan oleh sebagian besar bahasa pemrograman modern, termasuk C, Java, dan Python. Satu-satunya pengecualian notable adalah bahasa MATLAB, Fortran, dan Lua yang menggunakan indeks berbasis satu.

Sifat-sifat fundamental array yang membedakannya dari struktur data lain adalah:

1. **Homogenitas Tipe**: Dalam array klasik (C, Java), seluruh elemen memiliki tipe data yang sama, sehingga setiap elemen menempati ruang memori yang identik.
2. **Keterurutan Memori** (Contiguous Allocation): Elemen-elemen disimpan dalam blok memori yang saling berdekatan tanpa celah.
3. **Pengaksesan Acak** (Random Access): Karena keterurutan memori dan ukuran elemen yang seragam, alamat setiap elemen dapat dihitung secara langsung menggunakan formula aritmatika sederhana.

### 3.2.2 Alokasi Memori Statis

Pada alokasi memori statis, ukuran array ditentukan pada saat kompilasi dan bersifat tetap sepanjang masa hidup program. Bahasa C menggunakan model ini untuk array primitif.

Visualisasi di bawah ini menggambarkan bagaimana array integer `int A[5]` dialokasikan dalam memori, dengan asumsi setiap elemen `int` menempati 4 byte dan alamat dasar (base address) berada di `0x1000`.

```
Gambar 3.1 - Layout Memori Array Statis int A[5]

  Alamat     Indeks    Nilai     Offset dari Base
 +----------+--------+---------+-----------------+
 | 0x1000   | A[0]   |   10    |   +0  (0 x 4)  |
 +----------+--------+---------+-----------------+
 | 0x1004   | A[1]   |   20    |   +4  (1 x 4)  |
 +----------+--------+---------+-----------------+
 | 0x1008   | A[2]   |   30    |   +8  (2 x 4)  |
 +----------+--------+---------+-----------------+
 | 0x100C   | A[3]   |   40    |  +12  (3 x 4)  |
 +----------+--------+---------+-----------------+
 | 0x1010   | A[4]   |   50    |  +16  (4 x 4)  |
 +----------+--------+---------+-----------------+

Formula pengalamatan langsung (direct addressing):
  Alamat(A[i]) = Alamat_Dasar + (i x Ukuran_Tipe_Data)
  Alamat(A[3]) = 0x1000 + (3 x 4) = 0x1000 + 12 = 0x100C
```

Formula pengalamatan inilah yang menjamin kompleksitas waktu O(1) untuk akses elemen. Prosesor hanya memerlukan satu operasi aritmatika dan satu operasi pembacaan memori --- tidak bergantung pada nilai `n` atau nilai `i`. Keunggulan ini disebut properti *direct addressing* atau *random access*.

Kelemahan alokasi statis adalah kurangnya fleksibilitas. Jika kapasitas yang dideklarasikan terlalu kecil, program menghadapi kehabisan memori. Jika terlalu besar, terjadi pemborosan memori yang tidak terpakai.

---

> **Catatan Penting 3.1 --- Mengapa Indeks Array Dimulai dari Nol?**
>
> Indeks berbasis nol bukan sekadar konvensi arbitrari, melainkan konsekuensi langsung dari formula pengalamatan memori. Jika indeks pertama adalah 0, maka formula menjadi `Alamat(A[i]) = Base + i * Size` --- sebuah ekspresi yang sederhana dan efisien. Jika indeks pertama adalah 1, formula menjadi `Alamat(A[i]) = Base + (i-1) * Size`, yang memerlukan satu operasi pengurangan tambahan untuk setiap akses. Pada era komputer dengan sumber daya sangat terbatas, penghematan satu operasi per akses array adalah signifikan. Warisan keputusan desain ini diteruskan oleh C, dan diwarisi oleh sebagian besar bahasa modern termasuk Python.

---

### 3.2.3 Alokasi Memori Dinamis dan Dynamic Array

Pada alokasi dinamis, ukuran array dapat ditentukan atau diubah pada saat program berjalan (runtime). Python mengimplementasikan konsep ini secara menyeluruh melalui tipe `list`, yang secara internal merupakan *dynamic array*.

Mekanisme kerja dynamic array dalam Python adalah sebagai berikut. Saat sebuah `list` dibuat, Python mengalokasikan kapasitas awal tertentu dalam memori heap. Saat elemen-elemen ditambahkan dan kapasitas itu habis terpakai, Python secara otomatis mengalokasikan blok memori baru yang lebih besar --- biasanya sekitar 1,125 hingga 2 kali kapasitas sebelumnya --- kemudian menyalin seluruh elemen lama ke blok baru, dan melepaskan blok lama kepada garbage collector.

```
Tabel 3.1 - Pola Pertumbuhan Kapasitas list Python

  Ukuran (len)   Kapasitas    Keterangan
  ------------   ---------    -----------------------------------------------
       0             0        List baru dibuat, belum ada alokasi
       1             4        append pertama memicu alokasi blok kapasitas 4
       4             4        List penuh
       5             8        append ke-5 memicu realokasi, kapasitas jadi 8
       8             8        List penuh
       9            16        append ke-9 memicu realokasi, kapasitas jadi 16
      16            16        List penuh
      17            25        append ke-17 memicu realokasi berikutnya
```

Strategi pertumbuhan ini memberikan kompleksitas *amortized* O(1) untuk operasi `append`. Artinya, meskipun sesekali terjadi realokasi yang memerlukan waktu O(n), rata-rata biaya per operasi append tetap konstan jika diukur secara keseluruhan atas banyak operasi.

Struktur internal `list` Python dapat divisualisasikan sebagai berikut:

```
Gambar 3.2 - Struktur Internal list Python

  Objek list di memori:
  +----------+----------+----------+
  | ob_size  | ob_alloc |  ob_item | <- Header objek list
  |    5     |    8     |  *ptr    |
  +----------+----------+----+-----+
                              |
                              v   (pointer ke blok data)
  +------+------+------+------+------+------+------+------+
  | *p0  | *p1  | *p2  | *p3  | *p4  |      |      |      |
  +--+---+--+---+--+---+--+---+--+---+------+------+------+
     |      |      |      |      |
     v      v      v      v      v
    [10]   [20]   [30]   [40]   [50]   <- Objek Python di heap

  Keterangan:
  - ob_size  : Jumlah elemen yang terisi (5)
  - ob_alloc : Kapasitas yang dialokasikan (8)
  - ob_item  : Pointer ke array of pointers
  - Setiap slot menyimpan pointer ke objek Python, bukan nilai langsung
```

Hal yang perlu dicatat adalah bahwa `list` Python menyimpan pointer ke objek Python, bukan nilai primitif langsung. Ini memberikan fleksibilitas untuk menyimpan elemen bertipe beragam, namun dengan konsekuensi overhead memori yang lebih besar dibandingkan array typed (seperti `array.array` atau `numpy.ndarray`).

---

> **Tahukah Anda? 3.1 --- Dynamic Array di Balik Performa Python**
>
> Implementasi CPython (implementasi Python yang paling umum digunakan) menggunakan faktor pertumbuhan yang bervariasi, bukan sekadar faktor 2 yang tetap. Formula sebenarnya adalah `new_allocated = (size_t)(newsize + (newsize >> 3) + (newsize < 9 ? 3 : 6))`. Strategi ini meminimalkan pemborosan memori untuk list kecil sambil tetap mempertahankan amortized O(1) untuk list besar. Pengembang Python merancang strategi ini berdasarkan profiling empiris terhadap pola penggunaan list dalam program Python tipikal.

---

### 3.2.4 Modul array Python: Array Bertipe Tunggal

Untuk kebutuhan penyimpanan data numerik homogen yang hemat memori, Python menyediakan modul `array` standar. Berbeda dengan `list`, modul ini menyimpan nilai primitif langsung dalam blok memori yang berurutan, persis seperti array C.

```python
import array as arr

# Membuat array integer bertanda (type code 'i')
bilangan = arr.array('i', [10, 20, 30, 40, 50])

print("Array:", bilangan)
print("Tipe kode:", bilangan.typecode)
print("Ukuran per item (byte):", bilangan.itemsize)
print("Jumlah elemen:", len(bilangan))
print("Akses elemen indeks 2:", bilangan[2])
```

```
Tabel 3.2 - Type Code Modul array Python

  Kode   Tipe C              Ukuran (byte)   Contoh Penggunaan
  ----   ------------------  -------------   ---------------------
  'b'    signed char                  1      Nilai intensitas piksel
  'B'    unsigned char                1      Data biner
  'h'    signed short                 2      Nilai audio 16-bit
  'i'    signed int                   2      Bilangan bulat umum
  'l'    signed long                  4      Bilangan bulat besar
  'f'    float                        4      Data sensor presisi rendah
  'd'    double                       8      Komputasi ilmiah presisi tinggi
```

---

## 3.3 Array Satu Dimensi: Implementasi dan Operasi

### 3.3.1 Deklarasi, Inisialisasi, dan Indeks

Dalam Python, array satu dimensi direpresentasikan paling alami dengan tipe `list`. Beragam cara inisialisasi tersedia, masing-masing dengan idiomnya sendiri:

```python
# Berbagai cara mendeklarasikan array satu dimensi di Python

# Array kosong
array_kosong = []

# Array dengan nilai awal eksplisit
nilai_awal = [10, 20, 30, 40, 50]

# Array dengan nilai default menggunakan pengulangan
array_nol = [0] * 5               # [0, 0, 0, 0, 0]

# Array dengan nilai dihitung menggunakan list comprehension
array_genap = [i * 2 for i in range(6)]   # [0, 2, 4, 6, 8, 10]

# Inisialisasi dari objek range
dari_range = list(range(1, 11))   # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

Python mendukung dua jenis indeks untuk mengakses elemen: indeks positif yang dihitung dari awal (dimulai dari 0) dan indeks negatif yang dihitung dari akhir (dimulai dari -1).

```
Gambar 3.3 - Skema Indeks Positif dan Negatif Array Python

  Elemen :  15    30    45    60    75    90
            +-----+-----+-----+-----+-----+-----+
            |  15 |  30 |  45 |  60 |  75 |  90 |
            +-----+-----+-----+-----+-----+-----+
  Indeks + :  [0]   [1]   [2]   [3]   [4]   [5]
  Indeks - : [-6]  [-5]  [-4]  [-3]  [-2]  [-1]

  Akses elemen:
    data[0]  == data[-6] == 15   (elemen pertama)
    data[2]  == data[-4] == 45   (elemen ketiga)
    data[-1] == data[5]  == 90   (elemen terakhir)
```

Slicing adalah fitur kuat Python yang mengekstrak sub-array tanpa loop eksplisit. Sintaksnya adalah `array[start:stop:step]`, di mana `start` adalah indeks awal (inklusif), `stop` adalah indeks akhir (eksklusif), dan `step` adalah lompatan antar indeks.

```python
data = [15, 30, 45, 60, 75, 90]

# Slicing dasar
print(data[1:4])    # [30, 45, 60]  -- indeks 1, 2, 3
print(data[::2])    # [15, 45, 75]  -- setiap 2 elemen
print(data[::-1])   # [90, 75, 60, 45, 30, 15]  -- balik array
print(data[2:])     # [45, 60, 75, 90]  -- dari indeks 2 hingga akhir
print(data[:3])     # [15, 30, 45]  -- tiga elemen pertama
```

Penting untuk dipahami bahwa slicing menghasilkan *salinan dangkal* (shallow copy) dari array asli. Modifikasi pada hasil slice tidak memengaruhi array asli. Perilaku ini berbeda dari beberapa bahasa lain seperti C++ yang menyediakan referensi ke subarray.

### 3.3.2 Implementasi Kelas Array Satu Dimensi

Meskipun Python menyediakan `list` yang sudah sangat lengkap, membangun kelas array dari awal adalah latihan yang sangat berharga untuk memahami konsep alokasi kapasitas tetap dan validasi batas indeks yang terjadi secara implisit dalam bahasa bertype dinamis.

```python
class Array1D:
    """
    Implementasi array satu dimensi dengan kapasitas tetap.
    Mensimulasikan perilaku array statis dalam bahasa bertipe kuat,
    menggunakan list Python sebagai penyimpanan internal.

    Kompleksitas Ruang: O(n) di mana n adalah kapasitas.
    """

    def __init__(self, kapasitas: int):
        """
        Menginisialisasi array dengan kapasitas tetap.

        Args:
            kapasitas: Ukuran maksimum array (bilangan bulat positif).

        Raises:
            ValueError: Jika kapasitas bukan bilangan positif.

        Kompleksitas: O(n)
        """
        if kapasitas <= 0:
            raise ValueError("Kapasitas harus bilangan positif.")
        self._kapasitas = kapasitas
        self._data = [None] * kapasitas   # Alokasi memori di awal
        self._ukuran = 0                  # Elemen yang terisi

    def __len__(self) -> int:
        """Mengembalikan jumlah elemen yang terisi. O(1)"""
        return self._ukuran

    def kapasitas(self) -> int:
        """Mengembalikan kapasitas total array. O(1)"""
        return self._kapasitas

    def is_penuh(self) -> bool:
        """Memeriksa apakah array sudah penuh. O(1)"""
        return self._ukuran == self._kapasitas

    def is_kosong(self) -> bool:
        """Memeriksa apakah array kosong. O(1)"""
        return self._ukuran == 0

    def get(self, indeks: int):
        """
        Mengambil elemen pada indeks tertentu.

        Args:
            indeks: Posisi elemen yang ingin diambil [0, ukuran-1].

        Returns:
            Nilai elemen pada indeks tersebut.

        Raises:
            IndexError: Jika indeks di luar jangkauan.

        Kompleksitas: O(1)
        """
        self._validasi_indeks(indeks)
        return self._data[indeks]

    def set(self, indeks: int, nilai) -> None:
        """
        Mengatur nilai elemen pada indeks tertentu.

        Args:
            indeks: Posisi elemen yang ingin diubah [0, ukuran-1].
            nilai : Nilai baru yang akan disimpan.

        Raises:
            IndexError: Jika indeks di luar jangkauan.

        Kompleksitas: O(1)
        """
        self._validasi_indeks(indeks)
        self._data[indeks] = nilai

    def tambah(self, nilai) -> None:
        """
        Menambahkan elemen di posisi berikutnya. O(1) amortized.

        Raises:
            OverflowError: Jika array sudah penuh.
        """
        if self.is_penuh():
            raise OverflowError(
                f"Array penuh. Kapasitas maksimum: {self._kapasitas}."
            )
        self._data[self._ukuran] = nilai
        self._ukuran += 1

    def tampilkan(self) -> None:
        """Menampilkan isi array beserta informasi kapasitas."""
        elemen = [str(self._data[i]) for i in range(self._ukuran)]
        print(f"Array[{self._ukuran}/{self._kapasitas}]: [{', '.join(elemen)}]")

    def _validasi_indeks(self, indeks: int) -> None:
        """Memvalidasi indeks; melempar IndexError jika tidak valid."""
        if not (0 <= indeks < self._ukuran):
            raise IndexError(
                f"Indeks {indeks} di luar jangkauan "
                f"[0, {self._ukuran - 1}]."
            )


# Demonstrasi penggunaan
if __name__ == "__main__":
    a = Array1D(5)
    print("Kapasitas:", a.kapasitas())
    print("Kosong?  :", a.is_kosong())

    for nilai in [10, 25, 37, 48, 60]:
        a.tambah(nilai)

    a.tampilkan()
    print("Elemen indeks 2:", a.get(2))

    a.set(2, 99)
    a.tampilkan()
```

---

## 3.4 Array Multidimensi: Matriks dan Layout Memori

### 3.4.1 Konsep Array Dua Dimensi

Array multidimensi adalah perluasan konsep array satu dimensi ke dimensi yang lebih tinggi. Array dua dimensi (matriks) tersusun atas `m` baris (row) dan `n` kolom (column), sehingga setiap elemen diidentifikasi oleh pasangan indeks `(i, j)` di mana `0 <= i < m` dan `0 <= j < n`.

```
Gambar 3.4 - Representasi Matriks A berukuran 3x4

              Kolom 0   Kolom 1   Kolom 2   Kolom 3
             +---------+---------+---------+---------+
  Baris 0    | A[0][0] | A[0][1] | A[0][2] | A[0][3] |
             |    1    |    2    |    3    |    4    |
             +---------+---------+---------+---------+
  Baris 1    | A[1][0] | A[1][1] | A[1][2] | A[1][3] |
             |    5    |    6    |    7    |    8    |
             +---------+---------+---------+---------+
  Baris 2    | A[2][0] | A[2][1] | A[2][2] | A[2][3] |
             |    9    |   10    |   11    |   12    |
             +---------+---------+---------+---------+

  Ukuran: m=3 baris, n=4 kolom, total 12 elemen.
```

### 3.4.2 Row-Major vs. Column-Major Order

Memori komputer bersifat linear --- satu dimensi. Untuk menyimpan matriks dua dimensi dalam memori linear, diperlukan pemetaan dari koordinat dua dimensi ke alamat satu dimensi. Dua konvensi utama yang digunakan adalah:

```
Gambar 3.5 - Perbandingan Row-Major dan Column-Major Order

  Matriks 2x3:
  +---+---+---+
  | 1 | 2 | 3 |   <- Baris 0
  +---+---+---+
  | 4 | 5 | 6 |   <- Baris 1
  +---+---+---+

  Row-Major Order (C, Python, Java):
  Urutan di memori: [1, 2, 3, 4, 5, 6]
  Baris 0 disimpan dulu, kemudian Baris 1.

  Formula alamat A[i][j] dengan n kolom:
    Alamat = Base + (i * n + j) * UkuranElemen
    Alamat A[1][2] = Base + (1*3 + 2) * 4 = Base + 20

  Column-Major Order (Fortran, MATLAB, R):
  Urutan di memori: [1, 4, 2, 5, 3, 6]
  Kolom 0 disimpan dulu, kemudian Kolom 1, dst.

  Formula alamat A[i][j] dengan m baris:
    Alamat = Base + (j * m + i) * UkuranElemen
    Alamat A[1][2] = Base + (2*2 + 1) * 4 = Base + 20
```

Pemilihan urutan penyimpanan memiliki implikasi kinerja yang nyata. Prosesor modern menggunakan mekanisme *cache* yang mengambil data dalam blok (cache line). Program yang mengakses elemen secara berurutan dalam memori (cache-friendly access pattern) akan memiliki performa jauh lebih baik daripada yang mengakses secara acak. Inilah alasan mengapa loop berlapis pada matriks Python harus mengiterasi baris di luar dan kolom di dalam --- untuk memaksimalkan lokalitas cache.

### 3.4.3 Implementasi Kelas Array Dua Dimensi

```python
class Array2D:
    """
    Implementasi array dua dimensi (matriks) menggunakan
    list of lists dengan validasi batas indeks.

    Representasi internal: list of lists dengan ukuran m x n.
    Kompleksitas Ruang: O(m * n).
    """

    def __init__(self, baris: int, kolom: int, default=0):
        """
        Membuat matriks baris x kolom dengan nilai default.

        Args:
            baris  : Jumlah baris (bilangan bulat positif).
            kolom  : Jumlah kolom (bilangan bulat positif).
            default: Nilai awal setiap elemen (default: 0).

        Raises:
            ValueError: Jika baris atau kolom bukan bilangan positif.

        Kompleksitas: O(m * n)
        """
        if baris <= 0 or kolom <= 0:
            raise ValueError("Dimensi baris dan kolom harus positif.")
        self._baris = baris
        self._kolom = kolom
        # List comprehension memastikan setiap baris adalah objek terpisah
        self._data = [[default] * kolom for _ in range(baris)]

    @property
    def dimensi(self) -> tuple:
        """Mengembalikan dimensi matriks sebagai tuple (baris, kolom)."""
        return (self._baris, self._kolom)

    def get(self, i: int, j: int):
        """Mengambil elemen pada baris i, kolom j. O(1)"""
        self._validasi(i, j)
        return self._data[i][j]

    def set(self, i: int, j: int, nilai) -> None:
        """Mengatur nilai elemen pada baris i, kolom j. O(1)"""
        self._validasi(i, j)
        self._data[i][j] = nilai

    def tampilkan(self) -> None:
        """Mencetak matriks dalam format tabel yang rapi."""
        m, n = self._baris, self._kolom
        print(f"Matriks {m}x{n}:")
        for baris in self._data:
            elemen_str = "  ".join(f"{elemen:6}" for elemen in baris)
            print(f"  [ {elemen_str} ]")

    def transpose(self) -> 'Array2D':
        """
        Mengembalikan matriks transpose baru.
        Matriks m x n menjadi matriks n x m.

        Kompleksitas Waktu : O(m * n)
        Kompleksitas Ruang : O(m * n) untuk matriks hasil
        """
        hasil = Array2D(self._kolom, self._baris)
        for i in range(self._baris):
            for j in range(self._kolom):
                hasil.set(j, i, self._data[i][j])
        return hasil

    def _validasi(self, i: int, j: int) -> None:
        """Memvalidasi indeks baris dan kolom."""
        if not (0 <= i < self._baris):
            raise IndexError(
                f"Indeks baris {i} di luar jangkauan [0, {self._baris-1}]."
            )
        if not (0 <= j < self._kolom):
            raise IndexError(
                f"Indeks kolom {j} di luar jangkauan [0, {self._kolom-1}]."
            )


# Demonstrasi
def demo_array2d():
    matriks = Array2D(3, 4)
    nilai = 1
    for i in range(3):
        for j in range(4):
            matriks.set(i, j, nilai)
            nilai += 1

    matriks.tampilkan()
    print("\nTranspose:")
    matriks.transpose().tampilkan()
    print("\nElemen [1][2]:", matriks.get(1, 2))


demo_array2d()
```

---

> **Catatan Penting 3.2 --- Perangkap Inisialisasi Array 2D di Python**
>
> Kesalahan umum yang sering dilakukan programmer Python pemula adalah menginisialisasi matriks menggunakan ekspresi `[[0] * n] * m`. Ekspresi ini **tidak** membuat `m` baris yang terpisah, melainkan membuat satu baris yang direferensikan sebanyak `m` kali. Akibatnya, modifikasi pada satu baris akan memengaruhi semua baris sekaligus. Cara yang benar adalah menggunakan list comprehension: `[[0] * n for _ in range(m)]`. List comprehension memastikan setiap iterasi menghasilkan objek baris yang baru dan terpisah.
>
> ```python
> # SALAH - semua baris merujuk objek yang sama
> matriks_salah = [[0] * 3] * 3
> matriks_salah[0][1] = 99
> print(matriks_salah)  # [[0,99,0],[0,99,0],[0,99,0]] -- TIDAK BENAR
>
> # BENAR - setiap baris adalah objek terpisah
> matriks_benar = [[0] * 3 for _ in range(3)]
> matriks_benar[0][1] = 99
> print(matriks_benar)  # [[0,99,0],[0,0,0],[0,0,0]] -- BENAR
> ```

---

## 3.5 Operasi Dasar Array: Analisis dan Implementasi

### 3.5.1 Penelusuran (Traverse)

Penelusuran adalah operasi yang mengunjungi setiap elemen array tepat satu kali untuk tujuan pemrosesan tertentu, seperti pencetakan, akumulasi nilai, atau transformasi. Kompleksitas waktu traverse selalu O(n) karena setiap elemen harus dikunjungi satu kali.

```python
def traverse_dan_proses(data: list, fungsi_proses=None) -> None:
    """
    Melakukan traverse pada array dan menerapkan fungsi
    pemrosesan pada setiap elemen.

    Args:
        data          : Array yang akan di-traverse.
        fungsi_proses : Fungsi yang diterapkan pada setiap elemen.

    Kompleksitas Waktu : O(n)
    Kompleksitas Ruang : O(1)
    """
    if fungsi_proses is None:
        fungsi_proses = print

    for indeks, elemen in enumerate(data):
        print(f"  Indeks [{indeks}]: ", end="")
        fungsi_proses(elemen)


def hitung_statistik(data: list) -> dict:
    """
    Menghitung statistik dasar melalui single traverse. O(n)

    Keunggulan: Hanya satu kali penelusuran untuk menghitung
    empat nilai statistik sekaligus, berbeda dengan pendekatan
    naif yang memanggil min(), max(), sum() secara terpisah
    (tiga kali traverse).
    """
    if not data:
        return {}

    jumlah = 0
    min_val = data[0]
    max_val = data[0]

    for elemen in data:
        jumlah += elemen
        if elemen < min_val:
            min_val = elemen
        if elemen > max_val:
            max_val = elemen

    return {
        "jumlah"  : jumlah,
        "rerata"  : jumlah / len(data),
        "minimum" : min_val,
        "maksimum": max_val
    }
```

### 3.5.2 Pencarian Linear (Linear Search)

Pencarian linear menelusuri array dari elemen pertama hingga ditemukan elemen yang cocok atau seluruh array telah diperiksa. Ini adalah algoritma pencarian yang paling umum dan tidak mensyaratkan array dalam kondisi terurut.

```python
def pencarian_linear(data: list, target) -> int:
    """
    Mencari elemen target dalam array menggunakan pencarian linear.

    Kompleksitas Waktu:
        Best Case  : O(1)  -- elemen ditemukan di indeks pertama
        Average    : O(n)  -- rata-rata n/2 perbandingan
        Worst Case : O(n)  -- elemen tidak ada atau di posisi terakhir

    Kompleksitas Ruang: O(1)

    Args:
        data  : Array yang akan dicari.
        target: Nilai yang dicari.

    Returns:
        Indeks elemen pertama yang cocok, atau -1 jika tidak ditemukan.
    """
    for i in range(len(data)):
        if data[i] == target:
            return i
    return -1


# Demonstrasi
data = [64, 25, 12, 22, 11]
print(f"Mencari 22 dalam {data}: indeks {pencarian_linear(data, 22)}")
print(f"Mencari 99 dalam {data}: indeks {pencarian_linear(data, 99)}")
```

### 3.5.3 Penyisipan (Insert)

Penyisipan elemen di akhir array (append) adalah operasi amortized O(1) untuk `list` Python. Namun, penyisipan di tengah atau awal memerlukan pergeseran semua elemen di sebelah kanan posisi target satu langkah ke kanan, menghasilkan kompleksitas O(n).

```python
def insert_di_posisi(data: list, posisi: int, nilai) -> None:
    """
    Menyisipkan elemen pada posisi tertentu secara in-place. O(n)

    Langkah-langkah:
    1. Validasi posisi.
    2. Tambahkan ruang di akhir array.
    3. Geser semua elemen dari posisi hingga akhir ke kanan.
    4. Tempatkan nilai baru di posisi yang ditentukan.

    Args:
        data   : Array (list) yang akan dimodifikasi in-place.
        posisi : Indeks tempat nilai baru akan disisipkan.
        nilai  : Nilai yang akan disisipkan.

    Raises:
        IndexError: Jika posisi di luar jangkauan yang valid.
    """
    n = len(data)
    if not (0 <= posisi <= n):
        raise IndexError(
            f"Posisi {posisi} tidak valid untuk array berukuran {n}."
        )

    # Tambah satu slot di akhir
    data.append(None)

    # Geser elemen ke kanan, dimulai dari kanan agar tidak menimpa
    for i in range(n, posisi, -1):
        data[i] = data[i - 1]

    # Tempatkan nilai baru
    data[posisi] = nilai
```

### 3.5.4 Penghapusan (Delete)

Penghapusan elemen di akhir array adalah operasi O(1). Penghapusan di tengah atau awal memerlukan pergeseran semua elemen di sebelah kanan posisi target satu langkah ke kiri.

```python
def delete_dari_posisi(data: list, posisi: int):
    """
    Menghapus elemen pada posisi tertentu secara in-place. O(n)

    Langkah-langkah:
    1. Validasi posisi.
    2. Simpan nilai yang akan dihapus.
    3. Geser elemen dari kiri: setiap elemen di kanan posisi
       bergerak satu langkah ke kiri.
    4. Hapus elemen terakhir (yang kini merupakan duplikat).

    Args:
        data   : Array (list) yang akan dimodifikasi in-place.
        posisi : Indeks elemen yang akan dihapus.

    Returns:
        Nilai elemen yang dihapus.

    Raises:
        IndexError: Jika posisi di luar jangkauan.
    """
    n = len(data)
    if not (0 <= posisi < n):
        raise IndexError(
            f"Posisi {posisi} tidak valid untuk array berukuran {n}."
        )

    nilai_hapus = data[posisi]

    for i in range(posisi, n - 1):
        data[i] = data[i + 1]

    data.pop()  # Hapus slot terakhir yang kini duplikat

    return nilai_hapus
```

### 3.5.5 Ringkasan Kompleksitas Operasi Array

```
Tabel 3.3 - Kompleksitas Waktu Operasi Array

  Operasi                Best Case   Average     Worst Case   Keterangan
  ---------------------- ----------- ----------- ------------ ------------------
  Akses via indeks       O(1)        O(1)        O(1)         Direct addressing
  Pencarian linear       O(1)        O(n)        O(n)         Elemen mungkin ada
  Insert di akhir        O(1)*       O(1)*       O(n)**       * Amortized
  Insert di tengah       O(n)        O(n)        O(n)         Perlu geser elemen
  Insert di awal         O(n)        O(n)        O(n)         Semua elemen geser
  Delete di akhir        O(1)        O(1)        O(1)         pop() tanpa geser
  Delete di tengah       O(n)        O(n)        O(n)         Perlu geser elemen
  Delete di awal         O(n)        O(n)        O(n)         Semua elemen geser
  Traverse               O(n)        O(n)        O(n)         Kunjungi semua
  ---------------------- ----------- ----------- ------------ ------------------
  * Amortized O(1): biaya rata-rata atas banyak operasi.
  ** Worst case saat terjadi realokasi memori.
```

---

## 3.6 Sparse Array: Representasi Efisien untuk Data Jarang

### 3.6.1 Pengertian dan Motivasi

Dalam banyak aplikasi dunia nyata, array atau matriks yang digunakan hanya terisi sebagian kecil dari total kapasitasnya. Matriks adjacency pada graf dengan ribuan simpul tetapi hanya ratusan sisi, matriks fitur dalam pemrosesan bahasa alami, atau matriks interaksi pengguna-produk dalam sistem rekomendasi --- semuanya bersifat *sparse* (jarang). Menyimpan seluruh elemen termasuk nilai nol secara eksplisit pada kasus-kasus seperti ini merupakan pemborosan memori yang tidak dapat dibenarkan.

```
Gambar 3.6 - Perbedaan Dense Matrix dan Sparse Matrix

  Dense Matrix 5x5 (semua 25 elemen disimpan):
  +---+---+---+---+---+
  | 0 | 0 | 3 | 0 | 0 |
  | 0 | 0 | 0 | 0 | 0 |
  | 0 | 7 | 0 | 0 | 0 |
  | 0 | 0 | 0 | 5 | 0 |
  | 0 | 0 | 0 | 0 | 0 |
  +---+---+---+---+---+
  Total elemen : 25
  Elemen non-nol: 3
  Density (kepadatan): 3/25 = 12%

  Sparse Representation (hanya 3 entri yang disimpan):
  (baris=0, kolom=2, nilai=3)
  (baris=2, kolom=1, nilai=7)
  (baris=3, kolom=3, nilai=5)
```

Sebuah matriks umumnya disebut *sparse* apabila densitasnya di bawah 30%. Pada matriks sangat besar --- misalnya matriks adjacency graf dengan satu juta simpul (ukuran 10^6 x 10^6 = 10^12 elemen) --- representasi dense secara harfiah mustahil disimpan dalam memori komputer manapun.

### 3.6.2 Format COO (Coordinate Format)

Format COO menyimpan daftar tripel `(baris, kolom, nilai)` untuk setiap elemen non-nol. Format ini sangat intuitif dan mudah untuk konstruksi inkremental (menambahkan elemen satu per satu).

```python
class SparseMatriksCOO:
    """
    Representasi Sparse Matrix menggunakan COO (Coordinate) Format.

    Struktur penyimpanan: list of tuples (baris, kolom, nilai).
    Hanya elemen non-nol yang disimpan.

    Kompleksitas Ruang: O(nnz) di mana nnz = jumlah elemen non-nol.
    """

    def __init__(self, baris: int, kolom: int):
        self._baris = baris
        self._kolom = kolom
        self._elemen = []   # List of (i, j, nilai)

    def set(self, i: int, j: int, nilai) -> None:
        """
        Menambah atau memperbarui elemen.

        Kompleksitas: O(nnz) untuk memeriksa duplikat.
        """
        if nilai == 0:
            self._elemen = [
                (r, c, v) for r, c, v in self._elemen
                if not (r == i and c == j)
            ]
            return

        for idx, (r, c, v) in enumerate(self._elemen):
            if r == i and c == j:
                self._elemen[idx] = (i, j, nilai)
                return

        self._elemen.append((i, j, nilai))

    def get(self, i: int, j: int):
        """Mengambil nilai elemen; mengembalikan 0 jika tidak ada. O(nnz)"""
        for r, c, v in self._elemen:
            if r == i and c == j:
                return v
        return 0

    def info_memori(self) -> None:
        """Menampilkan perbandingan penggunaan memori dense vs sparse."""
        total_elemen = self._baris * self._kolom
        nnz = len(self._elemen)
        penghematan = (1 - nnz / total_elemen) * 100 if total_elemen > 0 else 0

        print(f"Sparse Matrix {self._baris}x{self._kolom}:")
        print(f"  Total elemen (dense)  : {total_elemen}")
        print(f"  Non-zero elements (nnz): {nnz}")
        print(f"  Density               : {nnz/total_elemen*100:.1f}%")
        print(f"  Penghematan memori    : {penghematan:.1f}%")

    def tampilkan_sparse(self) -> None:
        """Menampilkan representasi sparse dalam format tabel."""
        print("Representasi Sparse (COO):")
        print(f"  {'Baris':<8} {'Kolom':<8} {'Nilai':<8}")
        print(f"  {'-'*24}")
        for r, c, v in sorted(self._elemen):
            print(f"  {r:<8} {c:<8} {v:<8}")
```

### 3.6.3 Representasi Menggunakan Dictionary Python

Python menyediakan cara yang sangat ekspresif untuk merepresentasikan sparse array menggunakan tipe `dict`. Dictionary hash map memberikan kompleksitas akses O(1) rata-rata, yang secara asimtotik lebih baik dari format COO untuk operasi get/set individual.

```python
class SparseArrayDict:
    """
    Representasi Sparse Array menggunakan Dictionary Python.
    Optimal untuk akses acak yang sering dengan density sangat rendah.

    Kunci dictionary: indeks (untuk 1D) atau tuple (i, j) (untuk 2D).
    Nilai: hanya elemen yang berbeda dari nilai default disimpan.

    Kompleksitas Ruang: O(nnz).
    Kompleksitas Akses (get/set): O(1) rata-rata.
    """

    def __init__(self, ukuran: int, default=0):
        self._ukuran = ukuran
        self._default = default
        self._data = {}   # {indeks: nilai}

    def __setitem__(self, indeks: int, nilai) -> None:
        self._validasi(indeks)
        if nilai == self._default:
            self._data.pop(indeks, None)  # Hapus jika kembali ke default
        else:
            self._data[indeks] = nilai

    def __getitem__(self, indeks: int):
        self._validasi(indeks)
        return self._data.get(indeks, self._default)

    def __len__(self) -> int:
        return self._ukuran

    def nnz(self) -> int:
        """Mengembalikan jumlah elemen non-default."""
        return len(self._data)

    def tampilkan(self) -> None:
        print(f"Sparse Array (ukuran={self._ukuran}, nnz={self.nnz()}):")
        print(f"  Penyimpanan internal: {self._data}")
        representasi = [str(self[i]) for i in range(self._ukuran)]
        print(f"  Representasi penuh : [{', '.join(representasi)}]")

    def _validasi(self, indeks: int) -> None:
        if not (0 <= indeks < self._ukuran):
            raise IndexError(
                f"Indeks {indeks} di luar jangkauan [0, {self._ukuran-1}]."
            )
```

---

> **Tahukah Anda? 3.2 --- Sparse Matrix dalam Machine Learning**
>
> Pustaka scikit-learn, salah satu pustaka machine learning Python yang paling populer, menggunakan sparse matrix secara ekstensif di balik layar. Ketika Anda menggunakan `TfidfVectorizer` untuk mengonversi teks menjadi vektor numerik, hasilnya adalah sparse matrix di mana setiap baris merepresentasikan satu dokumen dan setiap kolom merepresentasikan satu kata dalam kosakata. Untuk kosakata berukuran 50.000 kata dan koleksi 100.000 dokumen, matriks ini memiliki 5 miliar elemen secara teori. Namun karena setiap dokumen hanya menggunakan beberapa ratus kata, densitasnya bisa serendah 0,01% --- menjadikan representasi sparse benar-benar tak tergantikan dalam konteks ini.

---

## 3.7 String sebagai Array Karakter: Konsep dan Manipulasi

### 3.7.1 String sebagai Struktur Data

String dalam Python adalah urutan karakter yang bersifat *immutable* --- tidak dapat dimodifikasi setelah dibuat. Setiap upaya "mengubah" string sebenarnya menciptakan objek string baru di memori. Properti immutability ini memiliki implikasi penting: Python dapat mengoptimalkan penyimpanan string yang identik melalui mekanisme *string interning*, dan string dapat digunakan sebagai kunci dictionary (karena hashable).

Dari sudut pandang struktural, string berperilaku seperti array karakter baca-saja (read-only). Seluruh operasi pengindeksan dan slicing yang berlaku pada array berlaku pula pada string.

```python
teks = "Struktur Data"

# Akses karakter seperti array
print("Karakter pertama :", teks[0])    # 'S'
print("Karakter terakhir:", teks[-1])   # 'a'
print("Panjang string   :", len(teks))  # 13
```

```
Gambar 3.7 - Representasi Indeks String "Struktur Data"

  Karakter:  S    t    r    u    k    t    u    r         D    a    t    a
             +----+----+----+----+----+----+----+----+----+----+----+----+----+
             | S  | t  | r  | u  | k  | t  | u  | r  |    | D  | a  | t  | a |
             +----+----+----+----+----+----+----+----+----+----+----+----+----+
  Indeks + : [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [10][11][12]
  Indeks - :[-13][-12][-11][-10][-9][-8][-7][-6][-5][-4][-3][-2][-1]
```

### 3.7.2 Operasi Slicing pada String

Slicing string menggunakan sintaks identik dengan slicing list: `teks[start:stop:step]`. Berikut adalah contoh-contoh pola slicing yang umum digunakan:

```python
kalimat = "Belajar Struktur Data di INSTIKI"

# Mengekstrak kata-kata berdasarkan posisi karakter
print(kalimat[0:7])    # "Belajar"
print(kalimat[8:16])   # "Struktur"
print(kalimat[17:21])  # "Data"
print(kalimat[25:])    # "INSTIKI"

# Teknik-teknik slicing lanjutan
print(kalimat[::-1])   # Membalik string: "IKITSNI id ataD rutkturtS rajaleBB"
print(kalimat[::2])    # Setiap karakter kedua
print(kalimat[-7:])    # 7 karakter terakhir: "INSTIKI"
print(kalimat[:7])     # 7 karakter pertama: "Belajar"
```

### 3.7.3 Operasi Pencarian String

Python menyediakan beberapa metode pencarian string dengan perilaku yang berbeda-beda:

```python
def demonstrasi_pencarian_string():
    teks = "Ilmu Komputer dan Sistem Informasi di Kampus INSTIKI Bali"

    # Operator 'in' -- pengecekan keberadaan substring, mengembalikan bool
    print(f"'INSTIKI' in teks : {'INSTIKI' in teks}")   # True
    print(f"'UNBALI' in teks  : {'UNBALI' in teks}")    # False

    # find() -- indeks pertama atau -1 jika tidak ditemukan
    print(f"find('Kampus')    : {teks.find('Kampus')}")
    print(f"find('Python')    : {teks.find('Python')}")  # -1

    # index() -- seperti find() tetapi melempar ValueError
    try:
        teks.index('Python')
    except ValueError as e:
        print(f"index('Python') -> ValueError: {e}")

    # rfind() -- pencarian dari kanan (indeks kemunculan terakhir)
    print(f"rfind('i')        : {teks.rfind('i')}")

    # count() -- menghitung kemunculan substring
    print(f"count('i')        : {teks.count('i')}")

    # startswith() dan endswith()
    print(f"startswith('Ilmu'): {teks.startswith('Ilmu')}")
    print(f"endswith('Bali')  : {teks.endswith('Bali')}")
```

```
Tabel 3.4 - Perbandingan Metode Pencarian String Python

  Metode          Nilai Kembali        Perilaku jika tidak ada   Kompleksitas
  --------------- -------------------- ------------------------- ------------
  in              bool                 False                     O(n*m)
  find(sub)       int (indeks)         -1                        O(n*m)
  index(sub)      int (indeks)         ValueError                O(n*m)
  rfind(sub)      int (indeks kanan)   -1                        O(n*m)
  count(sub)      int (cacah)          0                         O(n*m)
  startswith(s)   bool                 False                     O(len(s))
  endswith(s)     bool                 False                     O(len(s))

  n = panjang teks, m = panjang substring yang dicari.
```

### 3.7.4 Penggantian dan Penggabungan String

Karena string Python bersifat immutable, semua operasi "modifikasi" menghasilkan string baru. Hal ini memiliki implikasi performa yang penting, terutama untuk penggabungan berulang dalam loop.

```python
def demonstrasi_penggabungan():
    import time

    n = 10000

    # Metode 1: Concatenation berulang dengan operator + (tidak efisien)
    # Setiap += menciptakan string baru dan menyalin semua karakter
    # Kompleksitas: O(n^2) secara keseluruhan
    mulai = time.time()
    hasil = ""
    for i in range(n):
        hasil += str(i)
    waktu_plus = time.time() - mulai

    # Metode 2: join() (sangat efisien)
    # Python menghitung total panjang dahulu, alokasi satu kali,
    # lalu menyalin semua string. Kompleksitas: O(n) secara keseluruhan
    mulai = time.time()
    hasil = "".join(str(i) for i in range(n))
    waktu_join = time.time() - mulai

    print(f"Penggabungan {n} string:")
    print(f"  Operator +=  : {waktu_plus*1000:.3f} ms")
    print(f"  join()       : {waktu_join*1000:.3f} ms")
    print(f"  join() lebih cepat {waktu_plus/waktu_join:.1f}x")
```

---

> **Catatan Penting 3.3 --- Kapan Gunakan join() vs Operator +**
>
> Aturan praktis: gunakan operator `+` untuk menggabungkan dua atau tiga string secara sesekali. Gunakan `"".join(iterable)` ketika menggabungkan banyak string, terutama dalam loop. Perbedaan performanya bisa mencapai puluhan hingga ratusan kali lipat untuk input berukuran besar karena perbedaan kompleksitas asimtotik: O(n^2) versus O(n). Selain itu, gunakan f-string untuk formatting string yang melibatkan nilai variabel, karena f-string lebih mudah dibaca dan berperforma baik.

---

### 3.7.5 Pemisahan dan Parsing String

Operasi split memecah string menjadi list substring berdasarkan delimiter, sedangkan join merupakan operasi inversnya.

```python
def demonstrasi_split_parsing():
    # split() tanpa argumen: memecah berdasarkan whitespace
    kalimat = "Struktur Data adalah mata kuliah wajib semester tiga"
    kata = kalimat.split()
    print(f"Jumlah kata: {len(kata)}")  # 9

    # split dengan delimiter: parsing data CSV
    csv_line = "Budi,85,A,Lulus"
    kolom = csv_line.split(",")
    nama, nilai, grade, status = kolom
    print(f"Nama: {nama}, Nilai: {nilai}, Grade: {grade}")

    # Parsing data terstruktur
    data_mahasiswa = [
        "Andi,20,Teknik Informatika,3.85",
        "Sari,21,Sistem Informasi,3.72",
        "Budi,20,Teknik Informatika,3.91"
    ]

    print(f"\n{'Nama':<10} {'Usia':<6} {'Prodi':<22} {'IPK':<6}")
    print("-" * 46)
    for baris in data_mahasiswa:
        nama, usia, prodi, ipk = baris.split(",")
        print(f"{nama:<10} {usia:<6} {prodi:<22} {ipk:<6}")
```

---

## 3.8 Studi Kasus: Pengolahan Citra Digital sebagai Aplikasi Array 2D

### 3.8.1 Representasi Citra sebagai Array

Citra digital adalah contoh aplikasi array dua dimensi yang paling mudah divisualisasikan. Sebuah gambar berukuran lebar W piksel dan tinggi H piksel dapat direpresentasikan sebagai matriks berukuran H x W, di mana setiap elemen menyimpan nilai intensitas piksel.

Untuk citra berwarna (RGB), setiap piksel menyimpan tiga nilai dalam rentang [0, 255], satu untuk masing-masing kanal warna: merah (Red), hijau (Green), dan biru (Blue). Struktur data yang digunakan adalah array tiga dimensi berukuran H x W x 3.

```
Gambar 3.8 - Representasi Array Citra Digital

  Citra Grayscale 4x6 piksel:
  +------+------+------+------+------+------+
  |  20  |  40  |  80  | 120  | 180  | 220  |
  +------+------+------+------+------+------+
  |  25  |  45  |  85  | 125  | 185  | 225  |
  +------+------+------+------+------+------+
  |  30  |  50  |  90  | 130  | 190  | 230  |
  +------+------+------+------+------+------+
  |  35  |  55  |  95  | 135  | 195  | 235  |
  +------+------+------+------+------+------+
  Nilai: 0 = hitam pekat, 255 = putih murni

  Citra RGB 2x3 piksel:
  +-----------+-----------+-----------+
  | (255,0,0) | (0,255,0) | (0,0,255) |  <- Merah, Hijau, Biru
  +-----------+-----------+-----------+
  | (255,255,0)|(0,255,255)|(128,128,128)| <- Kuning, Cyan, Abu
  +-----------+-----------+-----------+
  citra[baris][kolom] = (R, G, B)
```

### 3.8.2 Konversi RGB ke Grayscale

Konversi citra berwarna (RGB) ke citra abu-abu (grayscale) adalah salah satu operasi paling fundamental dalam pengolahan citra. Setiap piksel warna (R, G, B) dikonversi menjadi satu nilai grayscale menggunakan formula *luminance* yang mempertimbangkan sensitivitas mata manusia terhadap setiap kanal warna.

Formula standar ITU-R BT.601:

```
Gray = 0.299 * R + 0.587 * G + 0.114 * B
```

Bobot yang lebih besar untuk kanal hijau mencerminkan fakta bahwa mata manusia lebih sensitif terhadap cahaya hijau dibandingkan merah atau biru. Ini adalah contoh menarik di mana desain struktur data dan algoritma dipengaruhi oleh karakteristik fisiologi manusia.

```python
def grayscale_dari_rgb(citra_rgb: list) -> list:
    """
    Mengonversi citra RGB ke grayscale menggunakan formula luminance.

    Formula: Gray = 0.299 * R + 0.587 * G + 0.114 * B
    Standar: ITU-R BT.601

    Args:
        citra_rgb : Array 2D, setiap elemen berupa tuple (R, G, B)
                    dengan nilai dalam rentang [0, 255].

    Returns:
        Array 2D nilai grayscale (integer dalam rentang [0, 255]).

    Kompleksitas Waktu : O(H * W)
    Kompleksitas Ruang : O(H * W) untuk menyimpan citra hasil
    """
    tinggi = len(citra_rgb)
    lebar = len(citra_rgb[0])

    # Alokasi matriks hasil dengan nilai nol
    citra_gray = [[0] * lebar for _ in range(tinggi)]

    for i in range(tinggi):
        for j in range(lebar):
            r, g, b = citra_rgb[i][j]
            # Aplikasi formula luminance, dibulatkan ke integer
            gray = int(0.299 * r + 0.587 * g + 0.114 * b)
            citra_gray[i][j] = gray

    return citra_gray
```

### 3.8.3 Deteksi Tepi Sederhana

Deteksi tepi adalah operasi yang mengidentifikasi batas-batas antara objek dalam sebuah citra. Tepi ditandai dengan perubahan mendadak nilai intensitas piksel. Algoritma deteksi tepi sederhana berbasis gradien menghitung perbedaan nilai piksel dengan tetangganya.

Untuk setiap piksel `(i, j)` (kecuali piksel di batas luar), dihitung gradien horizontal dan vertikal:

```
Gx = |citra[i][j+1] - citra[i][j-1]|   (perbedaan ke kanan vs kiri)
Gy = |citra[i+1][j] - citra[i-1][j]|   (perbedaan ke bawah vs atas)
Magnitudo Tepi = max(Gx, Gy)
```

```python
def deteksi_tepi_sederhana(citra_gray: list) -> list:
    """
    Mendeteksi tepi dalam citra grayscale menggunakan gradien sederhana.

    Algoritma mengakses piksel tetangga (lingkungan 3x3) untuk
    menghitung gradien intensitas pada setiap piksel. Piksel tepi
    (batas luar) dibiarkan bernilai 0 (tidak diproses).

    Args:
        citra_gray : Array 2D nilai grayscale integer [0, 255].

    Returns:
        Array 2D nilai magnitudo tepi [0, 255].

    Kompleksitas Waktu : O(H * W)
    Kompleksitas Ruang : O(H * W)
    """
    tinggi = len(citra_gray)
    lebar = len(citra_gray[0])

    citra_tepi = [[0] * lebar for _ in range(tinggi)]

    # Proses semua piksel kecuali batas luar (yang tidak memiliki
    # tetangga lengkap pada semua sisi)
    for i in range(1, tinggi - 1):
        for j in range(1, lebar - 1):
            gx = abs(citra_gray[i][j + 1] - citra_gray[i][j - 1])
            gy = abs(citra_gray[i + 1][j] - citra_gray[i - 1][j])
            citra_tepi[i][j] = max(gx, gy)

    return citra_tepi


def hitung_statistik_piksel(citra: list) -> dict:
    """
    Menghitung statistik piksel dari citra grayscale melalui
    single traverse. O(H * W).

    Returns:
        Dictionary berisi nilai minimum, maksimum, rata-rata,
        dan histogram sederhana (per kuintil).
    """
    tinggi = len(citra)
    lebar = len(citra[0])
    total_piksel = tinggi * lebar

    semua_nilai = [citra[i][j] for i in range(tinggi) for j in range(lebar)]

    jumlah = sum(semua_nilai)
    return {
        "minimum"    : min(semua_nilai),
        "maksimum"   : max(semua_nilai),
        "rata_rata"  : jumlah / total_piksel,
        "total_piksel": total_piksel
    }
```

---

> **Studi Kasus 3.1 --- Pipeline Pengolahan Citra Lengkap**
>
> Berikut adalah demonstrasi pipeline pengolahan citra yang menggabungkan seluruh konsep di atas: pembuatan citra simulasi RGB, konversi ke grayscale, deteksi tepi, dan penghitungan statistik piksel. Pipeline ini merupakan versi disederhanakan dari alur kerja yang digunakan oleh pustaka pengolahan citra seperti OpenCV dan Pillow.
>
> ```python
> import random
> random.seed(42)
>
> def buat_citra_gradien(tinggi: int, lebar: int) -> list:
>     """Membuat citra RGB simulasi dengan pola gradien."""
>     citra = []
>     for i in range(tinggi):
>         baris = []
>         for j in range(lebar):
>             intensitas = int((j / lebar) * 255)
>             noise = random.randint(-20, 20)
>             intensitas = max(0, min(255, intensitas + noise))
>             baris.append((intensitas, intensitas // 2, 255 - intensitas))
>         citra.append(baris)
>     return citra
>
> # Eksekusi pipeline
> tinggi, lebar = 8, 16
> citra_rgb  = buat_citra_gradien(tinggi, lebar)
> citra_gray = grayscale_dari_rgb(citra_rgb)
> citra_tepi = deteksi_tepi_sederhana(citra_gray)
>
> statistik = hitung_statistik_piksel(citra_gray)
> print("Statistik citra grayscale:")
> for kunci, nilai in statistik.items():
>     print(f"  {kunci:<15}: {nilai:.1f}" if isinstance(nilai, float)
>           else f"  {kunci:<15}: {nilai}")
> ```
>
> Hasil pipeline di atas mendemonstrasikan bagaimana array 2D digunakan untuk merepresentasikan, mentransformasi, dan menganalisis data citra secara efisien menggunakan hanya struktur data dasar Python tanpa pustaka eksternal.

---

### 3.8.4 Representasi ASCII Citra Grayscale

Untuk tujuan visualisasi dalam lingkungan teks (seperti terminal atau notebook), nilai grayscale dapat dipetakan ke karakter ASCII dengan tingkat kepadatan visual yang berbeda-beda:

```python
def cetak_citra_ascii(citra: list, label: str) -> None:
    """
    Menampilkan representasi ASCII dari citra grayscale.

    Karakter diurutkan dari yang paling jarang (terang) ke yang paling
    padat (gelap), memetakan nilai piksel [0, 255] ke karakter visual.
    """
    karakter = " .:-=+*#%@"   # 10 tingkat, ' '=terang, '@'=gelap
    tinggi = len(citra)
    lebar = len(citra[0])

    print(f"\n{label} ({tinggi}x{lebar}):")
    for baris in citra:
        baris_visual = ""
        for piksel in baris:
            idx = min(int(piksel / 256 * len(karakter)), len(karakter) - 1)
            baris_visual += karakter[idx] * 2   # 2x untuk proporsional
        print(f"  |{baris_visual}|")
```

---

## 3.9 Perbandingan: list, array, dan numpy.ndarray

Tabel berikut menyajikan perbandingan komprehensif tiga pilihan utama untuk menyimpan koleksi data numerik dalam Python.

```
Tabel 3.5 - Perbandingan Struktur Penyimpanan Numerik Python

  Aspek              list Python        array.array       numpy.ndarray
  -----------------  -----------------  ----------------  ------------------
  Homogenitas tipe   Tidak (campuran)   Ya (satu tipe)    Ya (satu tipe)
  Tipe C di memori   Tidak (PyObject*)  Ya                Ya
  Memori per elemen  ~28 byte (float)   8 byte (double)   8 byte (float64)
  Kec. operasi arith Lambat (loop Py)   Lambat (loop Py)  Sangat cepat (C/SIMD)
  Multidimensi       Manual (LoL)       Tidak             Ya (ndim bebas)
  Broadcasting       Tidak              Tidak             Ya
  Kemudahan API      Tinggi             Sedang            Sangat tinggi
  Instalasi          Bawaan             Bawaan            Perlu pip install
  -----------------  -----------------  ----------------  ------------------

  Rekomendasi penggunaan:
  - list      : Data heterogen, koleksi kecil, operasi umum non-numerik.
  - array     : Buffer I/O, data biner, penyimpanan hemat tanpa komputasi.
  - numpy     : Semua kebutuhan komputasi numerik dan saintifik skala besar.
```

Pada kenyataannya, sebagian besar aplikasi Python modern yang melibatkan data numerik dalam jumlah besar --- baik itu komputasi saintifik, machine learning, maupun pengolahan citra --- menggunakan NumPy sebagai fondasi, dengan `list` Python digunakan untuk data struktural non-numerik seperti daftar nama, konfigurasi, atau koleksi objek heterogen.

---

## Rangkuman Bab

1. **Array adalah struktur data linear** yang menyimpan elemen dalam lokasi memori berurutan. Properti *direct addressing* --- kemampuan menghitung alamat setiap elemen dengan formula `Alamat(A[i]) = Base + i * UkuranElemen` --- menjamin akses O(1) yang tidak bergantung pada ukuran array maupun posisi elemen.

2. **Python mengimplementasikan dynamic array** melalui tipe `list`, yang secara otomatis menggandakan kapasitas memori saat diperlukan. Strategi ini memberikan kompleksitas amortized O(1) untuk operasi append, meskipun sesekali terjadi realokasi O(n). Untuk data numerik homogen yang hemat memori, modul `array` dan NumPy merupakan pilihan yang lebih efisien.

3. **Array multidimensi direpresentasikan** sebagai list of lists dalam Python, mengikuti konvensi row-major order. Penggunaan list comprehension saat inisialisasi adalah wajib untuk memastikan setiap baris merupakan objek terpisah. Formula pengalamatan row-major `Alamat(A[i][j]) = Base + (i*n + j) * UkuranElemen` menjelaskan mengapa akses berurutan per baris lebih efisien dari segi cache dibandingkan akses per kolom.

4. **Kompleksitas operasi array bervariasi** berdasarkan posisi operasi: akses via indeks O(1), insert/delete di akhir amortized O(1), insert/delete di tengah atau awal O(n) karena diperlukan pergeseran elemen. Pencarian linear pada array tidak terurut adalah O(n) dalam kasus rata-rata dan terburuk.

5. **Sparse array diperlukan** ketika sebagian besar elemen array bernilai default (biasanya nol) dengan densitas di bawah 30%. Format COO menyimpan tripel `(baris, kolom, nilai)` hanya untuk elemen non-nol, sedangkan representasi dictionary memberikan kompleksitas akses O(1) rata-rata. Keduanya menghemat memori secara dramatis pada dataset berskala besar.

6. **String Python adalah urutan karakter immutable** yang berperilaku seperti array baca-saja. Operasi slicing `[start:stop:step]`, metode pencarian (`find`, `index`, `count`), dan penggabungan via `join()` adalah operasi fundamental yang harus dikuasai. Perbedaan antara `join()` yang O(n) dan concatenation berulang yang O(n^2) memiliki implikasi performa nyata pada input besar.

7. **Pengolahan citra digital** merupakan aplikasi klasik array 2D di mana matriks piksel dioperasikan melalui nested loop. Konversi RGB ke grayscale menggunakan formula luminance ITU-R BT.601 dan deteksi tepi berbasis gradien adalah contoh konkret bagaimana operasi matematika sederhana pada array 2D menghasilkan transformasi visual yang bermakna.

---

## Istilah Kunci

| No. | Istilah | Definisi Singkat |
|-----|---------|-----------------|
| 1 | **Array** | Struktur data linear berisi elemen bertipe sama dalam lokasi memori berurutan, dapat diakses melalui indeks bilangan bulat. |
| 2 | **Alokasi Statis** | Penetapan ukuran array pada waktu kompilasi; ukuran tetap dan tidak dapat diubah saat runtime. |
| 3 | **Alokasi Dinamis** | Penentuan atau perubahan ukuran array pada waktu runtime; Python mengimplementasikan ini via `list`. |
| 4 | **Dynamic Array** | Implementasi array yang secara otomatis menambah kapasitas (biasanya 2x) saat penuh, memberikan amortized O(1) untuk append. |
| 5 | **Direct Addressing** | Kemampuan mengakses elemen array dalam O(1) menggunakan formula aritmatika alamat memori. |
| 6 | **Indeks** | Bilangan bulat non-negatif yang mengidentifikasi posisi elemen dalam array; Python mendukung indeks negatif. |
| 7 | **Slicing** | Operasi mengekstrak sub-array dari array/string menggunakan sintaks `[start:stop:step]`. |
| 8 | **Row-Major Order** | Konvensi penyimpanan matriks di mana elemen-elemen dalam satu baris disimpan berurutan dalam memori; digunakan oleh C dan Python. |
| 9 | **Column-Major Order** | Konvensi penyimpanan matriks di mana elemen-elemen dalam satu kolom disimpan berurutan; digunakan oleh Fortran dan MATLAB. |
| 10 | **Sparse Array** | Array di mana sebagian besar elemen bernilai default (biasanya nol); representasi efisien hanya menyimpan elemen non-default. |
| 11 | **Density** | Rasio jumlah elemen non-nol terhadap total kapasitas array, dinyatakan dalam persentase. |
| 12 | **COO Format** | Coordinate Format; representasi sparse matrix yang menyimpan tripel `(baris, kolom, nilai)` untuk setiap elemen non-nol. |
| 13 | **nnz** | Number of Non-Zeros; jumlah elemen non-default dalam sparse array/matrix. |
| 14 | **Traverse** | Operasi mengunjungi setiap elemen array tepat satu kali untuk tujuan pemrosesan; kompleksitas O(n). |
| 15 | **Pencarian Linear** | Algoritma pencarian yang memeriksa elemen satu per satu dari awal hingga target ditemukan; O(n) worst case. |
| 16 | **Amortized Analysis** | Metode analisis kompleksitas yang mengukur biaya rata-rata per operasi atas serangkaian panjang operasi, bukan biaya terburuk satu operasi. |
| 17 | **Immutable** | Sifat objek yang tidak dapat dimodifikasi setelah dibuat; string Python bersifat immutable. |
| 18 | **String Interning** | Optimasi Python yang menyimpan satu salinan string yang identik di memori untuk mengurangi penggunaan memori. |
| 19 | **Grayscale** | Representasi citra menggunakan satu nilai intensitas per piksel (0-255) alih-alih tiga kanal warna. |
| 20 | **Gradien (citra)** | Ukuran laju perubahan intensitas piksel yang digunakan untuk mendeteksi tepi dalam citra digital. |

---

## Soal Latihan

### Bagian A --- Soal Pemahaman dan Analisis (C2-C4)

**Soal 3.1** [C2 --- Memahami]

Perhatikan deklarasi array berikut:

```python
A = [5, 10, 15, 20, 25, 30]
```

Jika alamat dasar array adalah `0x3000` dan setiap elemen menempati 8 byte (tipe `double`):

a. Hitunglah alamat memori dari elemen `A[4]`.
b. Jika diketahui suatu elemen berada di alamat `0x3018`, berapakah indeks elemen tersebut?
c. Tuliskan formula umum pengalamatan dan jelaskan mengapa formula ini menjamin akses O(1).

---

**Soal 3.2** [C2 --- Memahami]

Jelaskan perbedaan antara alokasi memori statis dan dinamis pada array. Dalam konteks Python, bagaimana mekanisme *doubling strategy* pada `list` bekerja, dan mengapa strategi ini menghasilkan kompleksitas amortized O(1) untuk operasi append? Gunakan Tabel 3.1 sebagai referensi dalam penjelasan Anda.

---

**Soal 3.3** [C2 --- Memahami]

Diberikan string `s = "INFORMATIKA2025"`.

a. Tentukan hasil dari ekspresi berikut tanpa menjalankan kode:
   - `s[3:10]`
   - `s[::3]`
   - `s[-4:]`
   - `s[10:3:-2]`
   
b. Tuliskan ekspresi slicing yang menghasilkan string `"AMRO"` dari string `s`.

c. Jelaskan mengapa string Python bersifat immutable dan apa implikasinya terhadap efisiensi memori.

---

**Soal 3.4** [C3 --- Menerapkan]

Implementasikan fungsi `cari_semua(data: list, target) -> list` yang mengembalikan **semua** indeks kemunculan `target` dalam `data` (bukan hanya yang pertama). Jika `target` tidak ditemukan, kembalikan list kosong.

Contoh: `cari_semua([3, 1, 4, 1, 5, 9, 2, 1], 1)` harus mengembalikan `[1, 3, 7]`.

Analisis kompleksitas waktu dan ruang fungsi Anda, dan jelaskan apakah fungsi ini dapat dioptimalkan lebih lanjut jika array dijamin dalam kondisi terurut.

---

**Soal 3.5** [C3 --- Menerapkan]

Implementasikan fungsi `rotasi_kiri(arr: list, k: int) -> list` yang merotasi array ke kiri sebanyak `k` posisi. Misalnya, `rotasi_kiri([1, 2, 3, 4, 5], 2)` menghasilkan `[3, 4, 5, 1, 2]`.

Berikan **dua** implementasi berbeda:
- Implementasi pertama menggunakan slicing Python (mudah, O(n) waktu, O(n) ruang).
- Implementasi kedua menggunakan *reversal algorithm* (O(n) waktu, O(1) ruang tambahan).

Jelaskan langkah-langkah reversal algorithm dan buktikan kebenarannya dengan contoh konkret.

---

**Soal 3.6** [C3 --- Menerapkan]

Implementasikan kelas `Matriks` yang mendukung operasi penjumlahan dan perkalian dua matriks. Sertakan validasi dimensi yang sesuai dan penanganan pengecualian. Analisis kompleksitas waktu dan ruang untuk kedua operasi tersebut.

---

**Soal 3.7** [C4 --- Menganalisis]

Perhatikan dua implementasi penggabungan string berikut:

```python
# Implementasi A
def gabung_a(daftar: list) -> str:
    hasil = ""
    for kata in daftar:
        hasil = hasil + kata
    return hasil

# Implementasi B
def gabung_b(daftar: list) -> str:
    return "".join(daftar)
```

a. Analisis kompleksitas waktu dan ruang masing-masing implementasi. Jelaskan mengapa Implementasi A bersifat O(n^2) dengan menguraikan apa yang terjadi di memori pada setiap iterasi.

b. Ukur perbedaan performa aktual menggunakan modul `time` untuk `n = 1000`, `n = 10000`, dan `n = 100000` string pendek. Presentasikan hasil dalam tabel.

c. Apakah ada skenario di mana Implementasi A dapat lebih dipilih? Jelaskan.

---

**Soal 3.8** [C4 --- Menganalisis]

Diberikan matriks persegi A berukuran n x n. Rancang dan implementasikan algoritma untuk memeriksa apakah matriks A merupakan matriks simetris (A[i][j] == A[j][i] untuk semua i, j). Jelaskan mengapa pemeriksaan hanya perlu dilakukan pada elemen di atas (atau di bawah) diagonal utama, dan buktikan bahwa total perbandingan yang diperlukan adalah n(n-1)/2.

---

### Bagian B --- Soal Evaluasi dan Sintesis (C5-C6)

**Soal 3.9** [C5 --- Mengevaluasi]

Anda diminta mengelola data koordinat GPS untuk 10 juta titik dalam sebuah aplikasi peta. Setiap titik memiliki latitude (float), longitude (float), dan altitude (float). Evaluasi pilihan penyimpanan berikut:

- (A) `list` of tuples Python
- (B) `array.array` terpisah untuk setiap dimensi
- (C) `numpy.ndarray` berukuran 10^7 x 3

Untuk setiap pilihan, perkirakan penggunaan memori dalam megabyte, kecepatan operasi kueri "temukan semua titik dalam radius 5 km dari suatu koordinat", dan kemudahan implementasi. Berikan rekomendasi beserta justifikasi teknis yang lengkap.

---

**Soal 3.10** [C5 --- Mengevaluasi]

Sebuah sistem rekomendasi film menyimpan matriks rating pengguna-film berukuran 100.000 x 50.000 (100 ribu pengguna, 50 ribu film). Setiap pengguna rata-rata hanya memberikan rating untuk 200 film.

a. Hitung density matriks tersebut.
b. Perkirakan penggunaan memori untuk representasi dense (asumsikan setiap rating bertipe float 8 byte) versus representasi sparse dengan format COO (asumsikan setiap entri non-nol memerlukan 24 byte untuk menyimpan baris, kolom, dan nilai).
c. Rancang kelas `SparseRatingMatrix` yang mendukung operasi: tambah rating, ambil semua rating untuk satu pengguna, dan ambil semua rating untuk satu film. Analisis kompleksitas setiap operasi.

---

**Soal 3.11** [C6 --- Mencipta]

Rancang dan implementasikan kelas `StringBuffer` yang mensimulasikan *mutable string* (karena string Python bersifat immutable). Kelas harus mendukung:

- `append(teks)`: Menambahkan teks di akhir. Amortized O(k).
- `insert(posisi, teks)`: Menyisipkan teks pada posisi tertentu. O(n + k).
- `delete(posisi, panjang)`: Menghapus `panjang` karakter mulai dari posisi. O(n).
- `replace(lama, baru)`: Mengganti semua kemunculan. O(n).
- `ke_string()`: Mengonversi ke string Python. O(n).
- *Method chaining* (setiap metode modifier mengembalikan `self`).

Sertakan pengujian unit yang memvalidasi setiap operasi, termasuk kasus tepi (string kosong, posisi batas, penggantian yang tidak ditemukan).

---

**Soal 3.12** [C6 --- Mencipta]

Rancang sistem representasi dan pemrosesan citra grayscale sederhana menggunakan kelas `CitraGrayscale`. Kelas harus mampu:

- Menyimpan citra sebagai array 2D nilai integer [0, 255].
- Menerapkan operasi *thresholding* biner: setiap piksel > threshold menjadi 255, sisanya 0.
- Menerapkan filter *mean blur* 3x3: setiap piksel diganti dengan rata-rata piksel dalam jendela 3x3 di sekitarnya.
- Menghitung histogram: distribusi frekuensi nilai piksel dalam 8 rentang (bins).
- Menyimpan dan memuat citra dari format teks (setiap baris berisi nilai piksel dipisahkan spasi).

Analisis kompleksitas setiap operasi dan uji implementasi Anda dengan citra sederhana yang dapat Anda buat secara manual.

---

## Bacaan Lanjutan

1. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013). *Data Structures and Algorithms in Python*. John Wiley & Sons. Bab 3: Array-Based Sequences (hal. 92-143).**
   Bab ini merupakan referensi utama untuk materi array dalam konteks Python. Pembahasan mencakup Python sequence types, implementasi dan analisis amortized dynamic array, serta struktur data berbasis array seperti stack, queue, dan deque. Penulis menyajikan analisis amortized dengan metode *accounting* dan *potential* yang sangat mudah dipahami. Sangat direkomendasikan sebagai bacaan utama yang melengkapi bab ini.

2. **Sedgewick, R., & Wayne, K. (2011). *Algorithms* (4th ed.). Addison-Wesley. Bab 1.1: Basic Programming Model (hal. 4-37).**
   Sedgewick menyajikan array dalam konteks bahasa Java dengan pendekatan yang sangat berbeda: lebih menekankan pada analisis empiris dan visualisasi performa. Bagian array satu dimensi dan multidimensi ditulis dengan gaya yang sangat mengalir dan disertai banyak contoh aplikasi nyata. Buku ini juga tersedia secara gratis dalam versi daring di situs *algs4.cs.princeton.edu*.

3. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022). *Introduction to Algorithms* (4th ed.). MIT Press. Bab 10: Elementary Data Structures (hal. 258-275).**
   CLRS merupakan referensi standar untuk analisis formal kompleksitas algoritmik. Bab 10 membahas representasi array dan matriks dalam pseudocode yang bahasa-agnostik, dengan penekanan pada pembuktian formal. Edisi keempat (2022) menambahkan konten baru tentang struktur data untuk data-parallel computing. Cocok untuk mahasiswa yang ingin memperdalam fondasi teori.

4. **Harris, C. R., et al. (2020). Array programming with NumPy. *Nature*, 585, 357-362.**
   Artikel jurnal Nature ini merupakan referensi ilmiah utama untuk NumPy. Para penulis --- termasuk para pengembang inti NumPy --- menjelaskan desain arsitektur ndarray, konsep broadcasting, dan bagaimana NumPy telah menjadi infrastruktur komputasi ilmiah Python selama dua dekade. Tersedia bebas akses di *doi.org/10.1038/s41586-020-2649-2*. Memberikan wawasan mendalam tentang mengapa desain array NumPy sangat berhasil.

5. **Gonzalez, R. C., & Woods, R. E. (2018). *Digital Image Processing* (4th ed.). Pearson. Bab 2: Digital Image Fundamentals (hal. 46-101).**
   Buku teks pengolahan citra yang paling banyak digunakan secara global. Bab 2 menjelaskan representasi citra digital sebagai matriks, model warna RGB dan konversi grayscale, serta operasi piksel dasar. Memberikan konteks teknis yang komprehensif untuk aplikasi array dalam pengolahan citra yang dibahas di Subbab 3.8.

6. **Hetland, M. L. (2014). *Python Algorithms: Mastering Basic Algorithms in the Python Language* (2nd ed.). Apress. Bab 3: Counting 101 (hal. 51-78).**
   Buku ini mengisi celah antara teori algoritma dan praktik Python yang jarang diisi buku lain. Bab 3 membahas analisis kompleksitas dengan pendekatan yang sangat praktis dan berorientasi Python. Penulis memberikan perhatian khusus pada bagaimana *built-in* Python seperti `list`, `dict`, dan `str` mengimplementasikan operasi-operasinya secara internal. Sangat berguna untuk memahami "biaya tersembunyi" operasi Python.

7. **Skiena, S. S. (2020). *The Algorithm Design Manual* (3rd ed.). Springer. Bab 3: Data Structures (hal. 79-134).**
   Skiena mengambil pendekatan yang sangat berbeda: ia memulai dari masalah nyata dan bekerja mundur menuju pemilihan struktur data yang tepat. Bab 3 membahas array, string, dan matrix dengan banyak "perang cerita" (war stories) yang menggambarkan bagaimana pemilihan struktur data yang salah menyebabkan kegagalan sistem nyata. Gaya naratifnya sangat memikat dan memberikan motivasi kontekstual yang kuat untuk mempelajari topik ini.

---

*Bab ini merupakan bagian dari buku teks "Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python", disusun untuk Program Studi Teknik Informatika dan Sistem Informasi, Institut Bisnis dan Teknologi Indonesia (INSTIKI). Bab selanjutnya membahas Linked List sebagai alternatif struktural bagi array dalam skenario di mana penyisipan dan penghapusan yang efisien menjadi prioritas.*
