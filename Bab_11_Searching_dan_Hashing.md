# BAB 11
# SEARCHING DAN HASHING: MENEMUKAN DATA DENGAN CEPAT DAN TEPAT

---

> *"Kemampuan menemukan informasi yang tepat, pada waktu yang tepat, adalah ukuran sejati dari kecerdasan sebuah sistem. Algoritma pencarian adalah jembatan antara pertanyaan dan jawaban — dan kualitas jembatan itu menentukan seberapa jauh ilmu pengetahuan dapat menjangkau."*
>
> — Diadaptasi dari Donald E. Knuth, *The Art of Computer Programming*, Volume 3: Sorting and Searching

---

## 11.1 Tujuan Pembelajaran

Setelah mempelajari bab ini secara tuntas, mahasiswa diharapkan mampu:

1. **[C2 - Memahami]** Menjelaskan prinsip kerja linear search dan binary search, beserta kondisi penggunaan yang tepat untuk masing-masing algoritma, berdasarkan karakteristik data dan frekuensi operasi.
2. **[C3 - Menerapkan]** Mengimplementasikan binary search versi iteratif dan rekursif dalam bahasa Python, serta menelusuri eksekusinya secara manual langkah demi langkah pada contoh data yang diberikan.
3. **[C4 - Menganalisis]** Menganalisis kompleksitas waktu dan ruang dari linear search, binary search, dan interpolation search pada kasus terbaik, rata-rata, dan terburuk, serta menyimpulkan implikasi praktisnya.
4. **[C2 - Memahami]** Menjelaskan konsep hash table sebagai paradigma pencarian berbasis pemetaan langsung, dan menguraikan mengapa tabrakan (collision) tidak dapat dihindari sepenuhnya berdasarkan Pigeonhole Principle.
5. **[C3 - Menerapkan]** Merancang fungsi hash menggunakan division method, multiplication method, dan polynomial rolling hash, serta menghitung hash value secara numerik untuk kunci integer dan string.
6. **[C4 - Menganalisis]** Membandingkan teknik penanganan collision chaining dan open addressing (linear probing, quadratic probing) berdasarkan mekanisme kerja, penggunaan memori, dan dampak load factor terhadap performa.
7. **[C5 - Mengevaluasi]** Menentukan algoritma pencarian yang paling sesuai untuk skenario aplikasi tertentu, dengan mempertimbangkan sifat data, pola akses, ketersediaan memori, dan jaminan performa.
8. **[C6 - Mencipta]** Merancang dan mengimplementasikan hash table lengkap dengan operasi insert, search, dan delete menggunakan chaining maupun open addressing dalam bahasa Python.

---

## 11.2 Pendahuluan: Pencarian sebagai Jantung Sistem Komputasi

Bayangkan sebuah perpustakaan nasional dengan koleksi puluhan juta buku. Seseorang datang dengan pertanyaan sederhana: "Di mana saya dapat menemukan buku dengan judul tertentu?" Jawaban atas pertanyaan ini bergantung sepenuhnya pada seberapa baik sistem pengindeksan perpustakaan tersebut dirancang. Perpustakaan tanpa sistem pencarian yang baik, betapapun kaya koleksinya, akan menjadi tidak berguna karena tidak ada yang dapat memanfaatkan isinya secara efisien.

Prinsip yang sama berlaku dalam dunia sistem komputer, bahkan dengan urgensi yang jauh lebih tinggi. Pencarian (searching) adalah salah satu operasi paling fundamental dalam ilmu komputer. Hampir setiap aplikasi perangkat lunak — dari mesin pencari web yang melayani miliaran kueri per hari, sistem basis data e-commerce yang harus merespons dalam milidetik, aplikasi perbankan digital yang memverifikasi transaksi secara real-time, hingga sistem navigasi yang menghitung rute tercepat — semuanya bertumpu pada algoritma pencarian yang efisien sebagai tulang punggungnya.

Ketidakefisienan dalam algoritma pencarian bukan sekadar isu akademis. Dalam sistem yang melayani jutaan pengguna, perbedaan antara algoritma O(n) dan O(log n) bisa berarti perbedaan antara server yang berjalan lancar dengan server yang ambruk karena kelebihan beban. Demikian pula, pilihan antara pencarian berbasis perbandingan dan pencarian berbasis hashing dapat menentukan apakah sebuah sistem mampu memenuhi persyaratan latensi yang ditetapkan atau tidak.

Bab ini memperkenalkan dua keluarga besar strategi pencarian. Keluarga pertama adalah **pencarian berbasis perbandingan** (comparison-based search), yang mencari data melalui serangkaian perbandingan nilai. Di antara keluarga ini, linear search adalah yang paling sederhana namun juga paling umum digunakan untuk data kecil atau tidak terurut. Binary search, sebaliknya, adalah salah satu algoritma paling elegan dalam ilmu komputer — dengan memanfaatkan properti data terurut, ia mampu memangkas ruang pencarian menjadi separuhnya di setiap langkah, menghasilkan kompleksitas O(log n) yang luar biasa efisien. Interpolation search membawa efisiensi lebih jauh lagi, mencapai O(log log n) untuk data yang terdistribusi merata.

Keluarga kedua adalah **pencarian berbasis hashing** (hash-based search), sebuah paradigma yang secara fundamental berbeda. Alih-alih mencari melalui perbandingan, hashing menggunakan fungsi matematis untuk memetakan kunci langsung ke lokasi penyimpanannya. Hasilnya adalah operasi pencarian, penyisipan, dan penghapusan yang berjalan dalam waktu O(1) secara rata-rata — sebuah pencapaian yang tampak mustahil namun sangat nyata dalam praktik. Memahami hashing berarti memahami fondasi dari struktur data yang paling banyak digunakan dalam rekayasa perangkat lunak modern: dictionary, set, cache, dan database index.

---

## 11.3 Algoritma Pencarian Berbasis Perbandingan

### 11.3.1 Linear Search: Kesederhanaan yang Memiliki Tempatnya

Linear search, atau pencarian linier, adalah algoritma pencarian paling sederhana yang dapat dibayangkan. Algoritmanya dapat diungkapkan dalam satu kalimat: periksa setiap elemen satu per satu dari awal hingga elemen yang dicari ditemukan atau seluruh koleksi telah diperiksa habis. Kesederhanaan ini bukan kelemahan; dalam banyak situasi, ia justru menjadi kekuatannya.

**Prinsip Kerja:** Diberikan sekumpulan n elemen dan sebuah kunci pencarian (key), linear search memeriksa elemen ke-0, ke-1, ke-2, dan seterusnya secara berurutan. Jika elemen ke-i sama dengan key, algoritma mengembalikan indeks i. Jika seluruh elemen telah diperiksa tanpa kecocokan, algoritma mengembalikan nilai sentinel (-1 atau None) sebagai penanda bahwa elemen tidak ditemukan.

Perhatikan contoh sederhana berikut. Diberikan array `[34, 7, 23, 32, 5, 62, 78, 43]` dan kunci pencarian `62`, linear search akan memeriksa elemen-elemen secara berurutan: 34 (tidak cocok), 7 (tidak cocok), 23 (tidak cocok), 32 (tidak cocok), 5 (tidak cocok), dan akhirnya 62 (cocok). Elemen ditemukan pada indeks ke-5 setelah enam kali pemeriksaan.

**Gambar 11.1** Visualisasi Proses Linear Search

```
Array  : [ 34 |  7 | 23 | 32 |  5 | 62 | 78 | 43 ]
Indeks :    0    1    2    3    4    5    6    7

Langkah 1: Periksa indeks 0 --> arr[0]=34, 34 != 62, lanjut
Langkah 2: Periksa indeks 1 --> arr[1]=7,  7  != 62, lanjut
Langkah 3: Periksa indeks 2 --> arr[2]=23, 23 != 62, lanjut
Langkah 4: Periksa indeks 3 --> arr[3]=32, 32 != 62, lanjut
Langkah 5: Periksa indeks 4 --> arr[4]=5,  5  != 62, lanjut
Langkah 6: Periksa indeks 5 --> arr[5]=62, 62 == 62, DITEMUKAN di indeks 5
```

**Implementasi Python:**

```python
def linear_search(arr: list, key) -> int:
    """
    Mencari elemen 'key' dalam list 'arr' secara linier.

    Parameter:
        arr  -- list sembarang (tidak harus terurut)
        key  -- nilai yang dicari

    Return:
        Indeks elemen jika ditemukan, -1 jika tidak ditemukan.

    Kompleksitas Waktu : O(n)
    Kompleksitas Ruang : O(1)
    """
    for i in range(len(arr)):
        if arr[i] == key:
            return i          # elemen ditemukan, kembalikan indeks
    return -1                 # elemen tidak ditemukan


def linear_search_all(arr: list, key) -> list:
    """
    Mencari SEMUA kemunculan 'key' dalam list 'arr'.

    Return:
        List indeks semua posisi kemunculan 'key'.
    """
    result = []
    for i in range(len(arr)):
        if arr[i] == key:
            result.append(i)
    return result


# Contoh penggunaan
if __name__ == "__main__":
    data = [34, 7, 23, 32, 5, 62, 78, 43, 23, 11]

    idx = linear_search(data, 62)
    print(f"Mencari 62: ditemukan pada indeks {idx}")   # Output: 5

    idx = linear_search(data, 99)
    print(f"Mencari 99: {idx}")                          # Output: -1

    indices = linear_search_all(data, 23)
    print(f"Semua posisi 23: {indices}")                 # Output: [2, 8]
```

**Tabel 11.1** Analisis Kompleksitas Linear Search

| Kasus       | Kondisi                              | Kompleksitas |
|-------------|--------------------------------------|--------------|
| Terbaik     | Elemen ditemukan di posisi pertama   | O(1)         |
| Rata-rata   | Elemen ditemukan di posisi tengah    | O(n/2) = O(n)|
| Terburuk    | Elemen di posisi terakhir / tidak ada| O(n)         |
| Kompleksitas Ruang | Hanya menggunakan variabel loop | O(1)        |

> **Catatan Penting:** Linear search adalah satu-satunya algoritma pencarian yang dapat bekerja pada data **tidak terurut** dan pada struktur data yang **tidak mendukung akses acak**, seperti linked list. Pada linked list, binary search secara teknis tidak mungkin dilakukan karena untuk mencapai elemen ke-n, kita harus melewati n elemen sebelumnya — dan inilah keunggulan tersembunyi linear search yang sering diabaikan.

**Kapan Menggunakan Linear Search:**

Meskipun O(n) terlihat tidak efisien, linear search adalah pilihan yang tepat dalam situasi-situasi berikut. Pertama, ketika data tidak terurut dan pengurutan terlebih dahulu tidak memungkinkan atau terlalu mahal. Kedua, ketika ukuran data kecil (umumnya n < 50 elemen), karena overhead konstan binary search dapat melebihi keuntungan asimptotiknya untuk data yang sangat kecil. Ketiga, ketika pencarian hanya dilakukan sekali atau sangat jarang, sehingga biaya pengurutan tidak sebanding. Keempat, ketika struktur data yang digunakan tidak mendukung akses acak, seperti linked list atau stream data.

---

### 11.3.2 Binary Search: Kekuatan Strategi Bagi-Dua

Binary search adalah salah satu algoritma paling elegan dan efisien dalam ilmu komputer. Dengan satu syarat — data harus dalam keadaan **terurut** — algoritma ini mampu menemukan elemen dalam koleksi sebesar satu juta data hanya dalam maksimal 20 langkah. Efisiensi yang luar biasa ini lahir dari strategi sederhana namun jenius: di setiap langkah, buang tepat setengah dari elemen yang tersisa sebagai kandidat.

**Motivasi Intuitif:** Bayangkan Anda sedang bermain tebak angka. Lawan bicara Anda memikirkan sebuah angka antara 1 sampai 1024, dan Anda boleh bertanya "lebih besar atau lebih kecil?" sebanyak mungkin. Strategi optimal adalah selalu menebak angka di tengah rentang yang tersisa. Dengan strategi ini, dalam 10 tebakan saja Anda pasti dapat menemukan angkanya (karena 2^10 = 1024). Binary search menerapkan strategi inilah secara sistematis pada array yang terurut.

**Prinsip Kerja:**
1. Tentukan elemen tengah (mid) dari rentang pencarian yang aktif (antara low dan high).
2. Bandingkan elemen tengah dengan kunci yang dicari (key):
   - Jika `arr[mid] == key`: elemen ditemukan, kembalikan indeks mid.
   - Jika `key < arr[mid]`: key pasti berada di setengah **kiri** (jika ada), pindahkan high ke mid-1.
   - Jika `key > arr[mid]`: key pasti berada di setengah **kanan** (jika ada), pindahkan low ke mid+1.
3. Ulangi langkah 1-2 hingga elemen ditemukan (low == high dan cocok) atau rentang habis (low > high).

#### 11.3.2.1 Trace Binary Search Iteratif Secara Detail

Berikut adalah penelusuran langkah demi langkah binary search iteratif pada array terurut 15 elemen.

**Gambar 11.2** Array Terurut untuk Demonstrasi Binary Search

```
Indeks :  [ 0]  [ 1]  [ 2]  [ 3]  [ 4]  [ 5]  [ 6]  [ 7]  [ 8]  [ 9]  [10]  [11]  [12]  [13]  [14]
Nilai  :     3     7    11    15    19    23    28    34    42    51    63    71    82    95   107
```

**Skenario A: Mencari key = 42 (elemen ada)**

```
Iterasi 1:
  Status awal   : low=0, high=14
  Hitung mid    : mid = 0 + (14-0)//2 = 7
  Periksa       : arr[7] = 34
  Perbandingan  : key(42) > arr[7](34) --> cari di setengah KANAN
  Perbarui      : low = mid+1 = 8

  [ 3 | 7 |11 |15 |19 |23 |28 |34 |42 |51 |63 |71 |82 |95 |107]
    0   1   2   3   4   5   6  [7]  8   9  10  11  12  13   14
                               ^mid        <---- area baru ---->
                                     low=8              high=14

Iterasi 2:
  Status awal   : low=8, high=14
  Hitung mid    : mid = 8 + (14-8)//2 = 8 + 3 = 11
  Periksa       : arr[11] = 71
  Perbandingan  : key(42) < arr[11](71) --> cari di setengah KIRI
  Perbarui      : high = mid-1 = 10

  [42 |51 |63 |71 |82 |95 |107]
    8   9  10  [11] 12  13   14
  <-- area baru -->^mid
  low=8   high=10

Iterasi 3:
  Status awal   : low=8, high=10
  Hitung mid    : mid = 8 + (10-8)//2 = 8 + 1 = 9
  Periksa       : arr[9] = 51
  Perbandingan  : key(42) < arr[9](51) --> cari di setengah KIRI
  Perbarui      : high = mid-1 = 8

  [42 |51 |63]
    8  [9]  10
  ^    ^mid
  area baru = [8..8]
  low=8 high=8

Iterasi 4:
  Status awal   : low=8, high=8
  Hitung mid    : mid = 8 + (8-8)//2 = 8
  Periksa       : arr[8] = 42
  Perbandingan  : key(42) == arr[8](42) --> DITEMUKAN!
  Return        : indeks 8

Hasil: key=42 ditemukan di indeks 8. Total perbandingan: 4.
Catatan: Linear search membutuhkan 9 perbandingan untuk elemen yang sama.
```

**Skenario B: Mencari key = 50 (elemen tidak ada)**

```
Iterasi 1: low=0, high=14, mid=7.  arr[7]=34.  50>34  --> low=8
Iterasi 2: low=8, high=14, mid=11. arr[11]=71. 50<71  --> high=10
Iterasi 3: low=8, high=10, mid=9.  arr[9]=51.  50<51  --> high=8
Iterasi 4: low=8, high=8,  mid=8.  arr[8]=42.  50>42  --> low=9

Pemeriksaan kondisi loop: low(9) > high(8) --> LOOP BERHENTI.
Return: -1 (elemen tidak ditemukan)

Total perbandingan: 5. Elemen 50 tidak ada dalam array.
```

**Implementasi Python - Binary Search Iteratif:**

```python
def binary_search_iteratif(arr: list, key) -> int:
    """
    Binary search versi iteratif.

    Prasyarat : arr harus terurut secara menaik.
    Parameter :
        arr  -- list terurut
        key  -- nilai yang dicari
    Return    : indeks elemen jika ditemukan, -1 jika tidak.

    Kompleksitas Waktu : O(log n)
    Kompleksitas Ruang : O(1) -- keunggulan dibanding versi rekursif
    """
    low  = 0
    high = len(arr) - 1

    while low <= high:
        # Gunakan low + (high-low)//2, bukan (low+high)//2
        # Teknik ini mencegah integer overflow pada bahasa dengan
        # batas integer tetap seperti C atau Java (tidak relevan di Python,
        # namun merupakan praktik pemrograman yang baik dan portabel).
        mid = low + (high - low) // 2

        if arr[mid] == key:
            return mid            # Ditemukan, kembalikan indeks
        elif arr[mid] < key:
            low = mid + 1         # Key lebih besar, cari di kanan
        else:
            high = mid - 1        # Key lebih kecil, cari di kiri

    return -1                     # Rentang habis, tidak ditemukan
```

#### 11.3.2.2 Trace Binary Search Rekursif Secara Detail

Versi rekursif mengungkapkan struktur bagi-dua binary search secara lebih eksplisit dan elegan. Setiap pemanggilan fungsi merepresentasikan satu level pembagian ruang pencarian.

**Gambar 11.3** Pohon Pemanggilan Rekursif Binary Search untuk key=42

```
binary_search_rekursif(arr, 42, low=0, high=14)
  |-- mid=7, arr[7]=34, 42 > 34
  |
  +--> binary_search_rekursif(arr, 42, low=8, high=14)
         |-- mid=11, arr[11]=71, 42 < 71
         |
         +--> binary_search_rekursif(arr, 42, low=8, high=10)
                |-- mid=9, arr[9]=51, 42 < 51
                |
                +--> binary_search_rekursif(arr, 42, low=8, high=8)
                       |-- mid=8, arr[8]=42, 42 == 42
                       |
                       +--> return 8   <-- BASE CASE: ditemukan
                return 8
         return 8
  return 8

Kedalaman rekursi: 4 level.
Setiap level menggunakan satu stack frame pada call stack.
Total memori call stack: O(log n) = O(log 15) ≈ O(4).
```

**Implementasi Python - Binary Search Rekursif:**

```python
def binary_search_rekursif(arr: list, key,
                            low: int = None,
                            high: int = None) -> int:
    """
    Binary search versi rekursif.

    Prasyarat : arr harus terurut secara menaik.
    Parameter :
        arr  -- list terurut
        key  -- nilai yang dicari
        low  -- batas bawah rentang pencarian (default: 0)
        high -- batas atas rentang pencarian (default: len(arr)-1)
    Return    : indeks elemen jika ditemukan, -1 jika tidak.

    Kompleksitas Waktu : O(log n)
    Kompleksitas Ruang : O(log n) -- karena kedalaman call stack rekursi
    """
    # Inisialisasi nilai default pada pemanggilan pertama
    if low is None:
        low = 0
    if high is None:
        high = len(arr) - 1

    # Base case 1: rentang pencarian habis, elemen tidak ditemukan
    if low > high:
        return -1

    mid = low + (high - low) // 2

    # Base case 2: elemen ditemukan di posisi mid
    if arr[mid] == key:
        return mid

    # Recursive case 1: key lebih kecil, cari di setengah kiri
    elif arr[mid] > key:
        return binary_search_rekursif(arr, key, low, mid - 1)

    # Recursive case 2: key lebih besar, cari di setengah kanan
    else:
        return binary_search_rekursif(arr, key, mid + 1, high)


# Contoh penggunaan dan verifikasi
if __name__ == "__main__":
    sorted_arr = [3, 7, 11, 15, 19, 23, 28, 34, 42, 51, 63, 71, 82, 95, 107]

    print("=== Binary Search Iteratif ===")
    print(f"Mencari 42  : indeks {binary_search_iteratif(sorted_arr, 42)}")   # 8
    print(f"Mencari 3   : indeks {binary_search_iteratif(sorted_arr, 3)}")    # 0
    print(f"Mencari 107 : indeks {binary_search_iteratif(sorted_arr, 107)}")  # 14
    print(f"Mencari 50  : indeks {binary_search_iteratif(sorted_arr, 50)}")   # -1

    print("\n=== Binary Search Rekursif ===")
    print(f"Mencari 42  : indeks {binary_search_rekursif(sorted_arr, 42)}")   # 8
    print(f"Mencari 23  : indeks {binary_search_rekursif(sorted_arr, 23)}")   # 5
    print(f"Mencari 99  : indeks {binary_search_rekursif(sorted_arr, 99)}")   # -1
```

#### 11.3.2.3 Perbandingan Iteratif dan Rekursif

**Tabel 11.2** Perbandingan Binary Search Iteratif dan Rekursif

| Aspek               | Iteratif                        | Rekursif                              |
|---------------------|---------------------------------|---------------------------------------|
| Kompleksitas Waktu  | O(log n)                        | O(log n)                              |
| Kompleksitas Ruang  | O(1) -- sangat efisien          | O(log n) -- membutuhkan call stack    |
| Keterbacaan Kode    | Sedikit lebih panjang           | Lebih elegan, mengikuti definisi soal |
| Risiko              | Tidak ada stack overflow        | Potensi stack overflow untuk n sangat besar |
| Rekomendasi         | Produksi, n sangat besar        | Pembelajaran, n kecil hingga sedang   |

**Analisis Kompleksitas Binary Search:** Setiap iterasi membelah ruang pencarian menjadi dua. Dimulai dari n elemen, setelah k iterasi tersisa n/2^k elemen. Kondisi berhenti tercapai saat n/2^k = 1, sehingga k = log_2(n). Kompleksitas waktu O(log n) berlaku untuk kasus rata-rata dan terburuk.

Implikasi praktis dari O(log n) sangat dramatis. Untuk n = 1.000.000 elemen, linear search memerlukan hingga satu juta perbandingan. Binary search memerlukan paling banyak log_2(1.000.000) ≈ 20 perbandingan. Untuk n = 1 miliar (10^9), binary search memerlukan paling banyak 30 perbandingan. Pertumbuhan logaritmik inilah yang membuat binary search menjadi algoritma yang sangat skalabel.

> **Tahukah Anda?** Binary search memiliki sejarah yang menarik. Meskipun idenya sederhana, implementasi yang benar ternyata sangat sulit. Sebuah survei terkenal yang dilakukan oleh Jon Bentley pada tahun 1988 menemukan bahwa dari 20 programmer profesional yang diminta mengimplementasikan binary search dalam dua jam, hanya satu yang menghasilkan implementasi yang benar pada percobaan pertama. Kesalahan paling umum adalah dalam menghitung indeks mid: ekspresi `(low + high) // 2` dapat menyebabkan integer overflow pada bahasa seperti C/Java jika low dan high adalah bilangan besar, sehingga ekspresi yang lebih aman adalah `low + (high - low) // 2`.

---

### 11.3.3 Interpolation Search: Mengadaptasi Pengetahuan tentang Data

Interpolation search adalah penyempurnaan dari binary search yang berperilaku lebih cerdas ketika distribusi data diketahui merata. Alih-alih selalu memilih titik tengah rentang pencarian, interpolation search **memperkirakan** di mana dalam rentang tersebut kunci yang dicari kemungkinan besar berada, berdasarkan nilai kunci relatif terhadap nilai batas rentang.

Analogi yang tepat adalah cara seorang manusia mencari kata dalam kamus cetak. Untuk mencari kata "Zebra", seorang pembaca berpengalaman tidak akan membuka halaman tengah kamus — ia langsung membuka mendekati halaman akhir. Sebaliknya, untuk mencari "Abjad", ia akan membuka mendekati halaman pertama. Manusia melakukan interpolasi berdasarkan pengetahuan tentang distribusi alfabet dalam kamus.

**Formula Posisi Perkiraan:**

```
pos = low + floor( (key - arr[low]) * (high - low) / (arr[high] - arr[low]) )
```

Perhatikan bahwa ketika key = arr[low], pos = low. Ketika key = arr[high], pos = high. Untuk nilai di antaranya, pos diinterpolasi secara linear — persis seperti menempatkan titik pada garis di antara dua titik yang diketahui.

**Implementasi Python:**

```python
def interpolation_search(arr: list, key) -> int:
    """
    Interpolation search untuk data numerik yang terdistribusi merata.

    Prasyarat : arr harus terurut secara menaik dan berisi nilai numerik.

    Kompleksitas Waktu : O(log log n) -- jika data terdistribusi merata
                         O(n)         -- kasus terburuk (data tidak merata)
    Kompleksitas Ruang : O(1)
    """
    low  = 0
    high = len(arr) - 1

    while low <= high and arr[low] <= key <= arr[high]:
        # Proteksi: hindari pembagian nol ketika semua elemen dalam rentang sama
        if arr[high] == arr[low]:
            if arr[low] == key:
                return low
            return -1

        # Perkirakan posisi berdasarkan interpolasi linear
        pos = low + int((key - arr[low]) * (high - low) / (arr[high] - arr[low]))

        if arr[pos] == key:
            return pos
        elif arr[pos] < key:
            low = pos + 1
        else:
            high = pos - 1

    return -1
```

**Tabel 11.3** Perbandingan Tiga Algoritma Pencarian Berbasis Perbandingan

| Algoritma            | Terbaik | Rata-rata    | Terburuk | Ruang | Prasyarat Data          |
|----------------------|---------|--------------|----------|-------|-------------------------|
| Linear Search        | O(1)    | O(n)         | O(n)     | O(1)  | Tidak ada               |
| Binary Search        | O(1)    | O(log n)     | O(log n) | O(1)* | Terurut                 |
| Interpolation Search | O(1)    | O(log log n) | O(n)     | O(1)  | Terurut, distribusi merata |

*O(log n) untuk versi rekursif karena overhead call stack.

---

## 11.4 Hash Table dan Hashing: Pencarian dalam Waktu Konstan

### 11.4.1 Motivasi: Melampaui Batas O(log n)

Semua algoritma pencarian berbasis perbandingan yang telah dibahas terbatas oleh sebuah batas bawah teoritikal yang fundamental: dalam model perbandingan, tidak ada algoritma yang dapat memastikan menemukan elemen dalam sebuah koleksi tak terurut lebih cepat dari O(log n) waktu, karena setiap perbandingan hanya dapat mengeliminasi sebagian ruang pencarian. Ini adalah fakta matematika yang telah terbukti secara formal.

Pertanyaannya adalah: apakah O(log n) adalah batas terbaik yang dapat dicapai? Untuk pencarian berbasis perbandingan, jawabannya ya. Tetapi apakah ada paradigma pencarian yang berbeda yang dapat melampaui batasan ini?

Jawabannya adalah **ya**, dan paradigma itu disebut **hashing**.

Gagasan inti hashing dapat dijelaskan dengan sebuah analogi sederhana. Bayangkan sebuah lemari arsip dengan 100 laci bernomor 0 sampai 99. Setiap dokumen baru yang masuk diberikan nomor laci berdasarkan dua digit terakhir dari nomor identifikasinya. Untuk menemukan dokumen dengan ID 10573, kita langsung pergi ke laci nomor 73. Tidak perlu pencarian. Tidak perlu perbandingan. Hanya satu operasi matematis sederhana, kemudian akses langsung.

Hashing menerapkan prinsip yang sama pada struktur data. Sebuah **fungsi hash** h(k) menerima kunci k dan menghasilkan sebuah indeks dalam array yang disebut **hash table**. Penyisipan, pencarian, dan penghapusan semuanya dapat dilakukan dalam waktu O(1) rata-rata — sebuah pencapaian yang mengubah cara kita merancang sistem perangkat lunak.

**Gambar 11.4** Konsep Dasar Hash Table: Pemetaan Kunci ke Indeks

```
Kunci (Universe U)          Fungsi Hash h(k)      Hash Table (m slot)
---------------------        ----------------      -------------------
"Alice"   (NIM001)  -------> h("NIM001") = 3 ---> Slot 3: (NIM001, Alice)
"Budi"    (NIM002)  -------> h("NIM002") = 7 ---> Slot 7: (NIM002, Budi)
"Citra"   (NIM003)  -------> h("NIM003") = 1 ---> Slot 1: (NIM003, Citra)
"Dewi"    (NIM004)  -------> h("NIM004") = 5 ---> Slot 5: (NIM004, Dewi)

Pencarian "Alice" (NIM001): hitung h("NIM001")=3, periksa slot 3 --> DITEMUKAN
Bukan dengan membandingkan satu per satu, melainkan dengan LANGSUNG ke lokasi.
```

**Terminologi Fundamental Hashing:**

- **Hash Table (Tabel Hash):** Array berukuran m yang menyimpan pasangan kunci-nilai.
- **Slot atau Bucket:** Satu posisi dalam hash table, berindeks 0 hingga m-1.
- **Fungsi Hash (Hash Function):** Fungsi h: U → {0, 1, ..., m-1} yang memetakan kunci dari universe U ke indeks slot.
- **Hash Value atau Hash Code:** Hasil komputasi h(k), yaitu indeks slot untuk kunci k.
- **Collision (Tabrakan):** Kondisi ketika dua kunci berbeda k1 dan k2 menghasilkan hash value yang sama: h(k1) = h(k2), padahal k1 ≠ k2.
- **Load Factor (Faktor Muatan):** Rasio jumlah elemen tersimpan (n) terhadap jumlah slot tabel (m), dinyatakan sebagai α = n/m. Load factor mengukur "kepadatan" hash table dan merupakan prediktor utama kinerja operasi.

> **Catatan Penting: Mengapa Collision Tidak Dapat Dihindari Sepenuhnya?** Fakta bahwa collision tidak dapat dihindari bukan karena keterbatasan desain fungsi hash, melainkan karena **Pigeonhole Principle** (Prinsip Sarang Merpati) dalam matematika. Jika kita memiliki |U| kemungkinan kunci dan hanya m < |U| slot dalam hash table, maka secara matematis tidak ada fungsi h: U → {0,...,m-1} yang dapat bersifat injektif (satu-ke-satu) untuk semua kunci. Selalu ada pasangan kunci k1 ≠ k2 dengan h(k1) = h(k2). Oleh karena itu, menangani collision adalah bagian yang tidak terpisahkan dari desain hash table yang baik.

---

### 11.4.2 Merancang Fungsi Hash yang Baik

Kualitas fungsi hash secara langsung menentukan kinerja hash table secara keseluruhan. Fungsi hash yang baik harus memenuhi dua kriteria utama:

1. **Determinisme:** h(k) harus selalu menghasilkan nilai yang sama untuk input k yang sama, tanpa memandang waktu, urutan, atau konteks pemanggilan.
2. **Distribusi Merata (Uniform Distribution):** Kunci-kunci seharusnya tersebar merata di semua slot, sehingga probabilitas setiap slot dipilih adalah 1/m. Distribusi yang tidak merata menyebabkan "penumpukan" di beberapa slot (clustering) yang mendegradasi kinerja dari O(1) menjadi O(n) pada kasus terburuk.

#### 11.4.2.1 Division Method (Metode Pembagian)

Division method adalah fungsi hash yang paling sederhana dan paling umum digunakan:

```
h(k) = k mod m
```

Di mana m adalah ukuran hash table. Operasinya hanya satu modulo — sangat cepat dalam komputasi.

**Pemilihan m yang Tepat:** Pemilihan nilai m sangat kritis untuk distribusi yang baik. Nilai m yang buruk dapat menyebabkan clustering sistematis. Panduan pemilihan m:

- **Disarankan:** Pilih m sebagai bilangan prima yang tidak terlalu dekat dengan pangkat 2 atau pangkat 10.
- **Hindari:** m = 2^p (hash hanya bergantung pada p bit-bit rendah kunci, mengabaikan informasi dari bit tinggi).
- **Hindari:** m = 10^p (hash hanya bergantung pada p digit terakhir kunci desimal).
- **Praktik umum:** m dipilih sekitar 1.3 kali jumlah elemen yang diperkirakan akan disimpan.

**Contoh Numerik (m = 11, bilangan prima):** Hitung hash value untuk kunci: 14, 27, 38, 42, 55, 60, 73, 88.

```
h(14) = 14 mod 11 = 3
h(27) = 27 mod 11 = 5
h(38) = 38 mod 11 = 5    <-- COLLISION dengan k=27
h(42) = 42 mod 11 = 9
h(55) = 55 mod 11 = 0
h(60) = 60 mod 11 = 5    <-- COLLISION dengan k=27 dan k=38
h(73) = 73 mod 11 = 7
h(88) = 88 mod 11 = 0    <-- COLLISION dengan k=55
```

**Gambar 11.5** Visualisasi Hash Table dengan Division Method (m=11)

```
Slot  | Isi
------+--------------------------------------
  0   | 55, 88          <-- collision (2 elemen)
  1   | (kosong)
  2   | (kosong)
  3   | 14
  4   | (kosong)
  5   | 27, 38, 60      <-- collision (3 elemen)
  6   | (kosong)
  7   | 73
  8   | (kosong)
  9   | 42
 10   | (kosong)
```

Contoh ini menunjukkan bahwa meskipun menggunakan bilangan prima m=11, collision tetap terjadi. Ini adalah konsekuensi dari Pigeonhole Principle, bukan kelemahan fungsi hash tertentu.

#### 11.4.2.2 Multiplication Method (Metode Perkalian)

Multiplication method menggunakan konstanta real A (0 < A < 1):

```
h(k) = floor( m * frac(k * A) )
```

Di mana `frac(x)` adalah bagian pecahan dari x (yaitu x - floor(x)).

Konstanta A yang paling direkomendasikan oleh Donald Knuth adalah nilai emas (golden ratio conjugate):

```
A = (sqrt(5) - 1) / 2 ≈ 0.6180339887
```

**Keunggulan utama multiplication method:** Nilai m tidak kritis — dapat dipilih sembarang, biasanya m = 2^p untuk efisiensi bit-shift pada level implementasi mesin.

**Contoh Numerik (A ≈ 0.6180339887, m = 16):**

```
k = 42:
  42 * 0.6180339887 = 25.9574...
  Bagian pecahan    : frac(25.9574) = 0.9574
  h(42)             = floor(16 * 0.9574) = floor(15.319) = 15

k = 27:
  27 * 0.6180339887 = 16.6869...
  Bagian pecahan    : frac(16.6869) = 0.6869
  h(27)             = floor(16 * 0.6869) = floor(10.991) = 10

k = 14:
  14 * 0.6180339887 = 8.6525...
  Bagian pecahan    : frac(8.6525) = 0.6525
  h(14)             = floor(16 * 0.6525) = floor(10.440) = 10

k = 55:
  55 * 0.6180339887 = 33.9919...
  Bagian pecahan    : frac(33.9919) = 0.9919
  h(55)             = floor(16 * 0.9919) = floor(15.870) = 15
```

#### 11.4.2.3 Polynomial Rolling Hash untuk Kunci String

Kunci berupa string memerlukan fungsi hash yang berbeda. Pendekatan paling naif — menjumlahkan nilai ASCII semua karakter — memiliki kelemahan serius: anagram menghasilkan hash value yang sama ("LISTEN" dan "SILENT" akan dipetakan ke slot yang sama karena jumlah nilai ASCII-nya identik).

Solusi yang jauh lebih baik adalah **polynomial rolling hash**:

```
h(s) = (c_0 * B^(n-1) + c_1 * B^(n-2) + ... + c_(n-1) * B^0) mod m
```

Di mana c_i adalah nilai ordinal karakter ke-i, B adalah basis (umumnya dipilih 31 untuk string huruf kecil, atau 37 untuk alfanumerik), dan m adalah ukuran hash table.

Formula ini dapat dihitung secara efisien menggunakan algoritma Horner:

```
h = 0
untuk setiap karakter c dalam string s:
    h = (h * B + ord(c)) mod m
```

**Implementasi Python:**

```python
def hash_division(k: int, m: int) -> int:
    """Division method: h(k) = k mod m."""
    return k % m


def hash_multiplication(k: int, m: int, A: float = 0.6180339887) -> int:
    """
    Multiplication method: h(k) = floor(m * frac(k * A)).
    Konstanta A defaultnya adalah nilai emas Knuth.
    """
    frac_part = (k * A) % 1.0      # ambil bagian pecahan
    return int(m * frac_part)


def hash_polynomial(key: str, m: int, base: int = 31) -> int:
    """
    Polynomial rolling hash untuk kunci string.
    Menggunakan algoritma Horner untuk efisiensi komputasi.

    Parameter:
        key  -- string kunci
        m    -- ukuran hash table
        base -- basis polinomial (31 untuk huruf kecil)
    Return   : indeks slot (0 hingga m-1)
    """
    hash_val = 0
    for char in key:
        hash_val = (hash_val * base + ord(char)) % m
    return hash_val


# Demonstrasi: membuktikan polynomial hash membedakan anagram
if __name__ == "__main__":
    m = 101
    print("=== Perbandingan Hash String ===")
    print(f"h('LISTEN')  = {hash_polynomial('LISTEN', m)}")
    print(f"h('SILENT')  = {hash_polynomial('SILENT', m)}")  # berbeda!
    print(f"h('ENLIST')  = {hash_polynomial('ENLIST', m)}")  # berbeda!
```

> **Studi Kasus: Fungsi Hash Bawaan Python** Python menggunakan fungsi hash internal yang cukup canggih. Untuk integer, `hash(n)` umumnya mengembalikan n itu sendiri (untuk nilai dalam rentang tertentu). Untuk string dan tipe lainnya, Python menggunakan algoritma **SipHash-1-3** — sebuah algoritma hash yang dirancang tidak hanya untuk distribusi merata, tetapi juga untuk **keamanan kriptografis**: tahan terhadap serangan hash-flooding di mana seorang penyerang sengaja memberikan input yang menyebabkan banyak collision, mendegradasi performa hash table menjadi O(n). Hal ini menjelaskan mengapa nilai `hash()` untuk string di Python bersifat acak per sesi (karena seed hash-nya diacak saat interpreter dimulai).

---

### 11.4.3 Penanganan Collision: Dua Strategi Fundamental

Karena collision tidak terhindarkan, setiap implementasi hash table harus memiliki strategi untuk menanganinya. Terdapat dua keluarga besar strategi collision resolution:

#### 11.4.3.1 Separate Chaining (Rantai Terpisah)

Dalam separate chaining, setiap slot hash table tidak langsung menyimpan satu nilai, melainkan menyimpan **kepala dari sebuah linked list** (atau struktur list lainnya). Semua kunci yang di-hash ke slot yang sama dirangkai dalam list tersebut.

**Prinsip Operasi:**
- **Insert(k, v):** Hitung idx = h(k). Tambahkan pasangan (k, v) ke list di `table[idx]`.
- **Search(k):** Hitung idx = h(k). Telusuri list di `table[idx]` untuk menemukan k.
- **Delete(k):** Hitung idx = h(k). Hapus pasangan dengan kunci k dari list di `table[idx]`.

**Gambar 11.6** Visualisasi Separate Chaining

Misalkan m=7, memasukkan kunci: 50, 700, 76, 85, 92, 73, 101 menggunakan h(k) = k mod 7.

```
Perhitungan:
  h(50)  = 50  mod 7 = 1
  h(700) = 700 mod 7 = 0
  h(76)  = 76  mod 7 = 6
  h(85)  = 85  mod 7 = 1  <-- collision dengan 50
  h(92)  = 92  mod 7 = 1  <-- collision dengan 50, 85
  h(73)  = 73  mod 7 = 3
  h(101) = 101 mod 7 = 3  <-- collision dengan 73

Hash Table dengan Separate Chaining:
+-------+
| Slot  | Linked List
+-------+
|  [0]  | --> [700] --> NULL
+-------+
|  [1]  | --> [50] --> [85] --> [92] --> NULL
+-------+
|  [2]  | --> NULL
+-------+
|  [3]  | --> [73] --> [101] --> NULL
+-------+
|  [4]  | --> NULL
+-------+
|  [5]  | --> NULL
+-------+
|  [6]  | --> [76] --> NULL
+-------+

Load factor: alpha = 7/7 = 1.0
Panjang chain rata-rata: 7/7 = 1.0
```

**Implementasi Python - Hash Table dengan Chaining:**

```python
class HashTableChaining:
    """
    Hash table dengan collision resolution menggunakan separate chaining.
    Setiap slot menyimpan list Python sebagai pengganti linked list eksplisit.
    """

    def __init__(self, size: int = 11):
        """
        Inisialisasi hash table.

        Parameter:
            size -- jumlah slot (disarankan bilangan prima untuk distribusi merata)
        """
        self.size  = size
        self.table = [[] for _ in range(size)]   # list of lists (chain)
        self.count = 0                            # jumlah total elemen

    def _hash(self, key) -> int:
        """Fungsi hash internal: memanfaatkan built-in hash() Python."""
        return hash(key) % self.size

    @property
    def load_factor(self) -> float:
        """Hitung load factor: alpha = n / m."""
        return self.count / self.size

    def insert(self, key, value) -> None:
        """
        Menyisipkan pasangan (key, value) ke hash table.
        Jika key sudah ada, nilainya diperbarui (semantik update).

        Kompleksitas: O(1) rata-rata, O(n) terburuk (semua elemen satu chain).
        """
        idx   = self._hash(key)
        chain = self.table[idx]

        # Periksa apakah key sudah ada (lakukan update jika ya)
        for i, (k, v) in enumerate(chain):
            if k == key:
                chain[i] = (key, value)
                return

        # Key belum ada, sisipkan pasangan baru
        chain.append((key, value))
        self.count += 1

    def search(self, key):
        """
        Mencari nilai berdasarkan key.

        Return: value jika key ditemukan, None jika tidak.
        Kompleksitas: O(1) rata-rata, O(n) terburuk.
        """
        idx   = self._hash(key)
        chain = self.table[idx]

        for k, v in chain:
            if k == key:
                return v

        return None

    def delete(self, key) -> bool:
        """
        Menghapus elemen dengan key tertentu.

        Return: True jika berhasil dihapus, False jika key tidak ditemukan.
        Kompleksitas: O(1) rata-rata, O(n) terburuk.
        """
        idx   = self._hash(key)
        chain = self.table[idx]

        for i, (k, v) in enumerate(chain):
            if k == key:
                chain.pop(i)
                self.count -= 1
                return True

        return False

    def display(self) -> None:
        """Menampilkan isi hash table secara terstruktur."""
        print(f"\nHash Table - Chaining "
              f"(ukuran={self.size}, isi={self.count}, "
              f"load_factor={self.load_factor:.2f})")
        print("-" * 50)
        for i, chain in enumerate(self.table):
            if chain:
                isi = " --> ".join([f"({k}: {v})" for k, v in chain])
                print(f"  [{i:3d}]  {isi}")
            else:
                print(f"  [{i:3d}]  (kosong)")


# Contoh penggunaan
if __name__ == "__main__":
    ht = HashTableChaining(size=7)

    data = [
        (50, "Lima Puluh"),  (700, "Tujuh Ratus"), (76, "Tujuh Enam"),
        (85, "Delapan Lima"), (92, "Sembilan Dua"), (73, "Tujuh Tiga"),
        (101, "Seratus Satu")
    ]
    for k, v in data:
        ht.insert(k, v)

    ht.display()

    print(f"\nMencari key=85  : {ht.search(85)}")   # Delapan Lima
    print(f"Mencari key=999 : {ht.search(999)}")    # None

    ht.delete(85)
    print(f"\nSetelah hapus 85:")
    ht.display()
```

#### 11.4.3.2 Open Addressing: Semua Elemen dalam Array yang Sama

Dalam open addressing, seluruh elemen disimpan langsung di dalam array hash table itu sendiri — tidak ada struktur data eksternal seperti linked list. Ketika terjadi collision di slot h(k), algoritma mencari slot alternatif yang masih kosong melalui proses yang disebut **probing** (penjelajahan).

**Konsekuensi penting:** Karena tidak ada ruang di luar array, load factor α harus selalu dijaga di bawah 1. Seiring α mendekati 1, performa menurun drastis.

**Probing Strategy 1: Linear Probing**

Linear probing mencari slot berikutnya secara berurutan:

```
h(k, i) = (h(k) + i) mod m,   untuk i = 0, 1, 2, ...
```

Dengan kata lain: coba slot h(k), lalu h(k)+1, lalu h(k)+2, dan seterusnya (secara melingkar).

**Gambar 11.7** Trace Penyisipan Linear Probing (m=11, kunci: 22, 30, 3, 14, 33)

```
h(k) = k mod 11:

Sisipkan 22: h(22) = 0. Slot 0 kosong --> simpan di slot 0.
[22| - | - | - | - | - | - | - | - | - | - ]
  0   1   2   3   4   5   6   7   8   9  10

Sisipkan 30: h(30) = 8. Slot 8 kosong --> simpan di slot 8.
[22| - | - | - | - | - | - | - |30 | - | - ]
  0   1   2   3   4   5   6   7   8   9  10

Sisipkan  3: h(3) = 3.  Slot 3 kosong --> simpan di slot 3.
[22| - | - | 3 | - | - | - | - |30 | - | - ]
  0   1   2   3   4   5   6   7   8   9  10

Sisipkan 14: h(14) = 3. COLLISION di slot 3 (isi: 3).
  Probe i=1: slot (3+1)%11 = 4 --> kosong, simpan di slot 4.
[22| - | - | 3 |14 | - | - | - |30 | - | - ]
  0   1   2   3   4   5   6   7   8   9  10

Sisipkan 33: h(33) = 0. COLLISION di slot 0 (isi: 22).
  Probe i=1: slot (0+1)%11 = 1 --> kosong, simpan di slot 1.
[22|33 | - | 3 |14 | - | - | - |30 | - | - ]
  0   1   2   3   4   5   6   7   8   9  10

Load factor akhir: alpha = 5/11 ≈ 0.45
```

**Masalah Primary Clustering:** Linear probing menderita fenomena yang disebut primary clustering. Elemen-elemen yang mengalami collision di area yang sama cenderung membentuk "gugusan" (cluster) panjang yang terus bertumbuh. Ketika sebuah cluster terbentuk, setiap kunci yang di-hash ke slot manapun di dalam cluster akan semakin memperpanjang cluster tersebut. Semakin panjang cluster, semakin lambat operasi insert dan search.

**Probing Strategy 2: Quadratic Probing**

Quadratic probing mengurangi primary clustering dengan melompat secara kuadratik:

```
h(k, i) = (h(k) + c1*i + c2*i^2) mod m,   untuk i = 0, 1, 2, ...
```

Dengan konstanta c1=0 dan c2=1: h(k,i) = (h(k) + i^2) mod m. Urutan probe: h(k), h(k)+1, h(k)+4, h(k)+9, h(k)+16, ...

Quadratic probing menghindari primary clustering tetapi masih dapat mengalami **secondary clustering**: dua kunci dengan hash value yang sama mengikuti urutan probe yang identik.

**Probing Strategy 3: Double Hashing**

Double hashing menggunakan fungsi hash kedua untuk menentukan langkah probe:

```
h(k, i) = (h1(k) + i * h2(k)) mod m
```

Di mana h2(k) harus tidak pernah menghasilkan 0 dan harus relatif prima dengan m. Double hashing adalah strategi terbaik dalam keluarga open addressing karena memberikan distribusi probe yang paling mendekati acak.

**Implementasi Python - Hash Table dengan Open Addressing (Linear Probing):**

```python
class HashTableOpenAddressing:
    """
    Hash table menggunakan open addressing dengan linear probing.
    """

    _DELETED = object()   # Sentinel untuk slot bekas hapus (lazy deletion)

    def __init__(self, capacity: int = 11):
        """
        Inisialisasi hash table.

        Parameter:
            capacity -- ukuran array (disarankan bilangan prima)
        """
        self.capacity = capacity
        self.table    = [None] * capacity    # None = kosong murni
        self.count    = 0

    def _hash(self, key) -> int:
        return hash(key) % self.capacity

    def _probe(self, idx: int, i: int) -> int:
        """Linear probing: slot berikutnya adalah (idx + i) mod capacity."""
        return (idx + i) % self.capacity

    @property
    def load_factor(self) -> float:
        return self.count / self.capacity

    def _find_slot(self, key) -> tuple:
        """
        Cari slot yang tepat untuk key.

        Return: (slot_index, found)
          - found=True  : key ditemukan di slot_index
          - found=False : key tidak ada; slot_index adalah posisi insert ideal
        """
        idx           = self._hash(key)
        first_deleted = None

        for i in range(self.capacity):
            slot = self._probe(idx, i)

            if self.table[slot] is None:
                # Slot kosong: key pasti tidak ada
                insert_at = first_deleted if first_deleted is not None else slot
                return insert_at, False

            if self.table[slot] is self._DELETED:
                # Catat slot deleted pertama (untuk insert berikutnya)
                if first_deleted is None:
                    first_deleted = slot
                continue  # teruskan probing (key mungkin ada di belakang)

            if self.table[slot][0] == key:
                return slot, True   # key ditemukan

        # Semua slot terisi atau deleted
        if first_deleted is not None:
            return first_deleted, False
        raise RuntimeError("Hash table penuh! Lakukan rehashing.")

    def insert(self, key, value) -> None:
        """
        Menyisipkan (key, value). Jika load factor >= 0.7, beri peringatan.
        Kompleksitas: O(1) rata-rata jika alpha rendah.
        """
        if self.load_factor >= 0.7:
            print(f"[PERINGATAN] Load factor={self.load_factor:.2f} >= 0.7. "
                  f"Pertimbangkan untuk melakukan rehashing!")

        slot, found = self._find_slot(key)
        if not found:
            self.count += 1
        self.table[slot] = (key, value)   # insert atau update

    def search(self, key):
        """
        Mencari value berdasarkan key.
        Return: value jika ditemukan, None jika tidak.
        Kompleksitas: O(1) rata-rata.
        """
        slot, found = self._find_slot(key)
        return self.table[slot][1] if found else None

    def delete(self, key) -> bool:
        """
        Menghapus elemen. Menggunakan lazy deletion dengan sentinel _DELETED
        agar urutan probe tidak terputus saat pencarian berikutnya.

        Return: True jika berhasil, False jika key tidak ditemukan.
        """
        slot, found = self._find_slot(key)
        if found:
            self.table[slot] = self._DELETED
            self.count -= 1
            return True
        return False

    def display(self) -> None:
        print(f"\nHash Table - Open Addressing "
              f"(capacity={self.capacity}, isi={self.count}, "
              f"load_factor={self.load_factor:.2f})")
        print("-" * 55)
        for i, slot in enumerate(self.table):
            if slot is None:
                print(f"  [{i:3d}]  (kosong)")
            elif slot is self._DELETED:
                print(f"  [{i:3d}]  [DELETED]")
            else:
                k, v = slot
                print(f"  [{i:3d}]  ({k}: {v})")


# Contoh penggunaan
if __name__ == "__main__":
    ht = HashTableOpenAddressing(capacity=11)

    entries = [(22, "A"), (30, "B"), (3, "C"), (14, "D"), (33, "E")]
    for k, v in entries:
        ht.insert(k, v)

    ht.display()

    print(f"\nMencari key=14 : {ht.search(14)}")   # D
    print(f"Mencari key=99 : {ht.search(99)}")     # None

    ht.delete(14)
    print("\nSetelah hapus key=14 (slot menjadi DELETED):")
    ht.display()
    # Penting: key=33 yang probe melewati bekas slot key=14 tetap ditemukan
    print(f"Mencari key=33 : {ht.search(33)}")     # E (lazy deletion menjaga kebenaran)
```

> **Catatan Penting: Lazy Deletion pada Open Addressing** Penghapusan elemen pada open addressing tidak boleh langsung mengosongkan slot (mengisinya dengan `None`). Jika dilakukan, urutan probe untuk kunci lain yang pernah melewati slot tersebut saat penyisipan akan "terputus", menyebabkan kunci-kunci tersebut tidak dapat ditemukan lagi meskipun sesungguhnya masih ada di tabel. Solusinya adalah **lazy deletion**: tandai slot yang dihapus dengan sebuah sentinel khusus (seperti `_DELETED`). Saat probing, slot `_DELETED` dilewati (lanjutkan probe), tetapi saat insert, slot `_DELETED` dapat digunakan kembali untuk menyimpan elemen baru. Dengan cara ini, integritas urutan probe selalu terjaga.

---

### 11.4.4 Dampak Load Factor terhadap Performa

Load factor α = n/m adalah parameter tunggal yang paling menentukan kinerja hash table dalam praktik. Pemahaman tentang dampaknya sangat penting untuk merancang hash table yang performan.

**Analisis Matematis untuk Separate Chaining:**

Dengan asumsi distribusi hash yang seragam (Simple Uniform Hashing Assumption), panjang rata-rata setiap chain adalah α. Oleh karena itu:

- Pencarian gagal: rata-rata memeriksa α elemen → O(1 + α)
- Pencarian berhasil: rata-rata memeriksa α/2 + 1 elemen → O(1 + α/2)

Jika α = O(1) (artinya m = Ω(n), ukuran tabel sebanding dengan jumlah elemen), semua operasi berjalan dalam O(1). **Dengan chaining, load factor boleh melebihi 1**, meskipun performa mulai menurun secara linear.

**Analisis Matematis untuk Open Addressing:**

Untuk pencarian gagal (worst case dari pencarian), jumlah probe rata-rata pada linear probing:

```
E[probe gagal] ≈ 1 / (1 - α)^2
E[probe berhasil] ≈ (1/2) * (1 + 1/(1 - α))
```

**Tabel 11.4** Dampak Load Factor pada Jumlah Probe Open Addressing

| Load Factor (α) | Probe Gagal (≈) | Probe Berhasil (≈) | Interpretasi                     |
|-----------------|-----------------|---------------------|----------------------------------|
| 0.25            | 1.8             | 1.2                 | Sangat efisien, banyak slot kosong|
| 0.50            | 4.0             | 1.5                 | Keseimbangan baik antara memori dan kecepatan |
| 0.70            | 11.1            | 2.2                 | Ambang batas umum yang direkomendasikan |
| 0.80            | 25.0            | 3.0                 | Mulai lambat, perlu evaluasi     |
| 0.90            | 100.0           | 5.5                 | Sangat lambat, segera rehashing  |
| 0.95            | 400.0           | 10.5                | Tidak dapat diterima dalam produksi |

Tabel ini menunjukkan bahwa pada α = 0.9, performa open addressing turun drastis: pencarian yang gagal rata-rata memerlukan 100 probe — jauh dari O(1) yang diharapkan. Inilah mengapa **rehashing** (membuat tabel baru berukuran 2x dan menyisipkan ulang semua elemen) harus dilakukan sebelum α mencapai ambang batas kritis.

**Perbandingan Chaining vs. Open Addressing:**

**Tabel 11.5** Perbandingan Komprehensif Strategi Collision Resolution

| Aspek                  | Separate Chaining                  | Open Addressing (Linear Probing)     |
|------------------------|------------------------------------|--------------------------------------|
| Batasan Load Factor    | α bisa > 1                         | Wajib α < 1                          |
| Penggunaan Memori      | Lebih besar (overhead pointer/node)| Lebih hemat (semua data dalam array) |
| Kinerja pada α rendah  | Baik                               | Sedikit lebih baik (cache-friendly)  |
| Kinerja pada α tinggi  | Menurun linear                     | Menurun kuadratik/dramatis           |
| Kompleksitas Hapus     | Sederhana (hapus dari list)        | Perlu lazy deletion                  |
| Cache Performance      | Kurang baik (pointer traversal)    | Baik (data contig dalam array)       |
| Implementasi           | Lebih mudah                        | Lebih kompleks                       |
| Cocok untuk            | Load factor tidak terprediksi      | Memori terbatas, α terkontrol        |

---

### 11.4.5 Studi Kasus: Implementasi Kamus Frekuensi Kata

Salah satu aplikasi paling umum dari hash table adalah menghitung frekuensi kemunculan elemen dalam sebuah koleksi. Berikut adalah implementasi kamus frekuensi kata menggunakan hash table, sebuah operasi yang mendasari berbagai aplikasi seperti analisis teks, kompresi data, dan pemrosesan bahasa alami.

```python
class KamusFrekuensi:
    """
    Kamus frekuensi kata berbasis hash table dengan chaining.
    Menghitung berapa kali setiap kata muncul dalam teks.

    Aplikasi nyata: analisis sentimen, deteksi spam, kompresi Huffman,
                    pembuatan indeks mesin pencari.
    """

    def __init__(self, kapasitas_awal: int = 101):
        self._ht = HashTableChaining(size=kapasitas_awal)

    def tambah_teks(self, teks: str) -> None:
        """
        Memproses teks dan menambahkan frekuensi setiap kata.
        Normalisasi: huruf kecil, hilangkan tanda baca umum.
        """
        import re
        # Hilangkan tanda baca dan ubah ke huruf kecil
        kata_bersih = re.findall(r"[a-zA-Z']+", teks.lower())

        for kata in kata_bersih:
            frekuensi_sekarang = self._ht.search(kata)
            if frekuensi_sekarang is None:
                self._ht.insert(kata, 1)
            else:
                self._ht.insert(kata, frekuensi_sekarang + 1)

    def frekuensi(self, kata: str) -> int:
        """Kembalikan frekuensi kata. Return 0 jika kata tidak ditemukan."""
        hasil = self._ht.search(kata.lower())
        return hasil if hasil is not None else 0

    def semua_kata(self) -> list:
        """Kembalikan semua pasangan (kata, frekuensi) sebagai list."""
        pasangan = []
        for chain in self._ht.table:
            pasangan.extend(chain)
        return pasangan

    def top_n(self, n: int = 10) -> list:
        """Kembalikan n kata dengan frekuensi tertinggi."""
        semua = self.semua_kata()
        semua.sort(key=lambda x: x[1], reverse=True)
        return semua[:n]


# Demonstrasi penggunaan
if __name__ == "__main__":
    kamus = KamusFrekuensi()

    teks_sampel = (
        "Struktur data adalah fondasi ilmu komputer. "
        "Pemahaman tentang struktur data memungkinkan pengembang "
        "merancang algoritma yang efisien. Algoritma yang efisien "
        "bergantung pada pemilihan struktur data yang tepat."
    )

    kamus.tambah_teks(teks_sampel)

    print("=== 5 Kata Paling Sering Muncul ===")
    for kata, frek in kamus.top_n(5):
        print(f"  '{kata}': {frek} kali")

    print(f"\nFrekuensi 'struktur' : {kamus.frekuensi('struktur')}")
    print(f"Frekuensi 'hashing'  : {kamus.frekuensi('hashing')}")
```

---

### 11.4.6 Hash Table dalam Python: Implementasi Built-in

Python merupakan contoh nyata dari penggunaan hash table secara ekstensif di level bahasa pemrograman itu sendiri. Pemahaman tentang implementasi internal Python memperkaya cara kita menggunakan tipe data bawaan secara efektif.

**`dict` (Dictionary):** Struktur data `dict` di Python adalah implementasi hash table yang sangat dioptimasi. Sejak Python 3.6, dict menggunakan **compact hash table** yang mempertahankan urutan penyisipan sambil menjaga efisiensi operasi O(1) rata-rata. Python secara otomatis melakukan rehashing ketika load factor melebihi 2/3 (≈ 0.67).

**`set`:** Tipe `set` adalah hash table yang hanya menyimpan kunci tanpa nilai terkait. Operasi `in` pada set berjalan dalam O(1) rata-rata.

```python
# Dictionary Python adalah hash table yang sangat dioptimasi
mahasiswa = {}
mahasiswa["NIM001"] = {"nama": "Budi", "ipk": 3.5}
mahasiswa["NIM002"] = {"nama": "Ani",  "ipk": 3.8}
mahasiswa["NIM003"] = {"nama": "Citra","ipk": 3.6}

# Pencarian: O(1) rata-rata
profil = mahasiswa.get("NIM001")   # {'nama': 'Budi', 'ipk': 3.5}
tidak_ada = mahasiswa.get("NIM999", "Tidak ditemukan")

# Pengecekan keanggotaan: O(1) rata-rata
print("NIM001" in mahasiswa)   # True
print("NIM999" in mahasiswa)   # False

# Set: hash table tanpa nilai
nim_hadir = {"NIM001", "NIM003", "NIM005"}
print("NIM002" in nim_hadir)   # False -- O(1) rata-rata

# Penggabungan set: operasi berbasis hash
nim_tidak_hadir = set(mahasiswa.keys()) - nim_hadir
print(nim_tidak_hadir)   # {'NIM002'}
```

> **Tahukah Anda?** Pada CPython (implementasi Python standar), **setiap nama variabel, nama fungsi, nama atribut objek, dan nama modul** disimpan dalam dictionary internal. Ketika Python mengeksekusi `obj.nama_atribut`, Python melakukan pencarian dalam dictionary `obj.__dict__` menggunakan `"nama_atribut"` sebagai kunci. Ini berarti bahwa hampir setiap operasi dalam program Python melibatkan hash table — secara harfiah puluhan hingga ratusan kali per detik. Inilah mengapa Python sangat berkomitmen pada kinerja hash table-nya.

---

### 11.4.7 Perbandingan Menyeluruh Semua Algoritma Pencarian

**Tabel 11.6** Ringkasan Perbandingan Seluruh Algoritma Pencarian yang Dibahas

| Algoritma            | Terbaik | Rata-rata    | Terburuk | Ruang  | Prasyarat          |
|----------------------|---------|--------------|----------|--------|--------------------|
| Linear Search        | O(1)    | O(n)         | O(n)     | O(1)   | Tidak ada          |
| Binary Search        | O(1)    | O(log n)     | O(log n) | O(1)*  | Terurut            |
| Interpolation Search | O(1)    | O(log log n) | O(n)     | O(1)   | Terurut, merata    |
| Hash Table (chaining)| O(1)    | O(1)         | O(n)     | O(n+m) | Tidak ada          |
| Hash Table (open adr)| O(1)    | O(1)         | O(n)     | O(m)   | α < 1              |

*O(log n) untuk versi rekursif.

**Panduan Pemilihan Algoritma:**

Pemilihan algoritma pencarian yang tepat bergantung pada beberapa faktor yang saling berinteraksi. Pertama, jika data **tidak terurut** dan tidak memungkinkan pengurutan, pilihan terbatas pada linear search atau hash table. Untuk data berjumlah besar dengan operasi pencarian berulang, hash table adalah pilihan yang jelas lebih baik karena O(1) rata-rata versus O(n) linear search.

Kedua, jika data **sudah terurut dan statis** (jarang berubah), binary search adalah pilihan yang sangat baik dengan performa O(log n) yang deterministik dan penggunaan memori O(1) yang efisien. Tidak ada overhead hash table, tidak ada risiko clustering.

Ketiga, jika operasi campuran antara pencarian, penyisipan, dan penghapusan terjadi secara **intensif dan berulang**, hash table adalah pilihan terbaik karena ketiga operasi berjalan dalam O(1) rata-rata. Penyisipan ke sorted array memerlukan O(n) karena perlu menggeser elemen.

Keempat, jika **memori sangat terbatas**, binary search lebih efisien karena hanya menggunakan O(1) ruang tambahan, sedangkan hash table memerlukan slot cadangan untuk menjaga load factor rendah (umumnya 1.3x hingga 2x jumlah elemen aktual).

---

## 11.5 Rangkuman Bab

1. **Linear search** memeriksa elemen satu per satu dengan kompleksitas O(n). Kelebihannya adalah tidak memerlukan data terurut, bekerja pada struktur data apapun termasuk linked list, dan implementasinya trivial. Cocok untuk data kecil, tidak terurut, atau pencarian yang sangat jarang dilakukan.

2. **Binary search** menerapkan strategi divide and conquer dengan membagi ruang pencarian menjadi dua di setiap langkah, menghasilkan kompleksitas O(log n) yang sangat efisien. Syarat mutlaknya adalah data harus terurut. Versi iteratif menggunakan O(1) ruang, sedangkan versi rekursif menggunakan O(log n) untuk call stack. Untuk n = 1 juta elemen, binary search memerlukan paling banyak 20 perbandingan.

3. **Interpolation search** mengadaptasi posisi probe berdasarkan nilai kunci, mencapai O(log log n) pada data terdistribusi merata. Namun pada data tidak merata, performanya bisa turun ke O(n) — lebih buruk dari binary search. Cocok untuk data numerik dengan distribusi yang dapat diprediksi.

4. **Hash table** menggunakan fungsi hash h(k) untuk memetakan kunci langsung ke indeks array, mencapai operasi O(1) rata-rata untuk insert, search, dan delete. Ini merupakan struktur data yang paling sering digunakan untuk operasi kamus (key-value store) dalam rekayasa perangkat lunak modern. Tipe `dict` dan `set` di Python adalah implementasi hash table.

5. **Collision** (tabrakan) adalah kondisi tak terhindarkan ketika dua kunci berbeda menghasilkan hash value yang sama, yang merupakan konsekuensi langsung dari Pigeonhole Principle. Dua strategi utama penanganan collision adalah: (a) **Separate Chaining** — setiap slot menyimpan linked list, memungkinkan α > 1, dan lebih toleran terhadap load factor tinggi; (b) **Open Addressing** — mencari slot alternatif dalam array yang sama melalui probing, mensyaratkan α < 1, namun lebih hemat memori dan cache-friendly.

6. **Load factor (α = n/m)** adalah metrik paling kritis dalam performa hash table. Untuk open addressing, performa menurun drastis saat α mendekati 1: pada α = 0.9, open addressing linear probing rata-rata memerlukan 100 probe untuk pencarian gagal. Panduan umum: pertahankan α ≤ 0.75 untuk chaining dan α ≤ 0.70 untuk open addressing. Lakukan rehashing (buat tabel baru 2x lebih besar dan pindahkan semua elemen) ketika batas ini terlampaui.

7. **Pemilihan algoritma pencarian** harus didasarkan pada analisis kebutuhan: gunakan hash table untuk operasi kamus berulang pada data dinamis (O(1) rata-rata), binary search untuk data statis terurut dengan memori terbatas (O(log n) deterministik), dan linear search hanya untuk data kecil atau data yang tidak dapat diurutkan maupun di-hash.

---

## 11.6 Istilah Kunci

| Istilah | Definisi |
|---------|----------|
| **Linear Search** | Algoritma pencarian yang memeriksa setiap elemen secara berurutan dari awal hingga elemen ditemukan atau seluruh koleksi diperiksa; O(n). |
| **Binary Search** | Algoritma pencarian berbasis divide and conquer yang membagi ruang pencarian menjadi dua di setiap langkah; mensyaratkan data terurut; O(log n). |
| **Interpolation Search** | Penyempurnaan binary search yang memperkirakan posisi kunci secara proporsional berdasarkan nilainya; O(log log n) untuk data merata. |
| **Hash Table** | Struktur data yang menggunakan fungsi hash untuk memetakan kunci ke indeks array, memungkinkan operasi insert/search/delete dalam O(1) rata-rata. |
| **Fungsi Hash** | Fungsi h: U → {0, 1, ..., m-1} yang memetakan kunci dari universe U ke indeks slot dalam hash table. |
| **Hash Value** | Hasil komputasi fungsi hash h(k) untuk kunci k; merupakan indeks slot dalam hash table. |
| **Collision** | Kondisi ketika dua kunci berbeda menghasilkan hash value yang sama: h(k1) = h(k2) meskipun k1 ≠ k2. |
| **Load Factor (α)** | Rasio n/m, di mana n adalah jumlah elemen tersimpan dan m adalah jumlah slot; mengukur kepadatan hash table dan menjadi prediktor utama kinerja. |
| **Pigeonhole Principle** | Prinsip matematika yang menyatakan bahwa jika n item ditempatkan ke dalam m < n wadah, setidaknya satu wadah berisi lebih dari satu item; menjelaskan mengapa collision tidak dapat dihindari. |
| **Separate Chaining** | Teknik collision resolution di mana setiap slot hash table menyimpan sebuah linked list dari semua kunci yang di-hash ke slot tersebut. |
| **Open Addressing** | Teknik collision resolution di mana semua elemen disimpan langsung dalam array hash table, dan slot alternatif dicari melalui probing saat terjadi collision. |
| **Linear Probing** | Strategi open addressing yang mencari slot kosong berikutnya secara berurutan: h(k,i) = (h(k)+i) mod m. |
| **Primary Clustering** | Fenomena pada linear probing di mana elemen-elemen yang mengalami collision membentuk gugusan panjang yang semakin memperburuk performa pencarian. |
| **Lazy Deletion** | Teknik penghapusan pada open addressing di mana slot yang dihapus ditandai dengan sentinel khusus (bukan langsung dikosongkan), untuk menjaga integritas urutan probe. |
| **Rehashing** | Proses membuat hash table baru berukuran lebih besar (umumnya 2x) dan menyisipkan ulang semua elemen dari tabel lama, dilakukan saat load factor melampaui ambang batas. |
| **Division Method** | Fungsi hash h(k) = k mod m; sederhana dan cepat, dengan nilai m yang disarankan berupa bilangan prima. |
| **Multiplication Method** | Fungsi hash h(k) = floor(m * frac(k*A)) menggunakan konstanta A (umumnya konstanta emas Knuth ≈ 0.618); nilai m tidak kritis. |
| **Polynomial Rolling Hash** | Fungsi hash untuk string yang menggunakan representasi polinomial h = (c0*B^(n-1) + ... + c_(n-1)) mod m; membedakan anagram. |
| **Quadratic Probing** | Strategi open addressing yang menggunakan probe kuadratik h(k,i) = (h(k)+i^2) mod m untuk mengurangi primary clustering. |
| **Double Hashing** | Strategi open addressing yang menggunakan fungsi hash kedua untuk menentukan langkah probe: h(k,i) = (h1(k)+i*h2(k)) mod m; memberikan distribusi probe terbaik. |

---

## 11.7 Soal Latihan

**Soal 1 [C2 - Memahami]**
Jelaskan mengapa binary search tidak dapat diterapkan secara benar pada array yang tidak terurut. Berikan contoh konkret dengan array `[8, 3, 11, 5, 17, 2, 14]` dan kunci pencarian `3`, serta tunjukkan langkah demi langkah bagaimana binary search akan memberikan hasil yang salah pada array tersebut. Bandingkan dengan cara kerja linear search pada kasus yang sama.

---

**Soal 2 [C3 - Menerapkan]**
Diberikan array terurut berikut:
`[4, 9, 14, 21, 35, 42, 58, 67, 73, 89, 95, 102]`

Lakukan trace lengkap binary search iteratif untuk:
- (a) Mencari kunci `58`
- (b) Mencari kunci `60` (tidak ada dalam array)

Untuk setiap langkah, tunjukkan nilai `low`, `high`, `mid`, nilai `arr[mid]`, dan keputusan yang diambil. Hitung total jumlah perbandingan pada masing-masing skenario.

---

**Soal 3 [C3 - Menerapkan]**
Implementasikan sebuah fungsi Python `binary_search_first_occurrence(arr, key)` yang menemukan **indeks pertama** (paling kiri) dari kunci yang dicari dalam array terurut yang mungkin mengandung elemen duplikat. Misalnya, pada array `[1, 2, 3, 3, 3, 4, 5]`, pencarian kunci `3` harus mengembalikan indeks `2`, bukan `3` atau `4`. Analisis kompleksitas waktu dan ruang implementasi Anda.

---

**Soal 4 [C2 - Memahami]**
Diberikan hash table berukuran m=13 menggunakan division method (h(k) = k mod 13). Hitung hash value untuk setiap kunci berikut: 26, 39, 15, 47, 52, 60, 78, 91. Tandai semua collision yang terjadi. Berapa jumlah collision total? Mengapa collision tidak dapat dihindari sepenuhnya meski m dipilih sebagai bilangan prima?

---

**Soal 5 [C3 - Menerapkan]**
Implementasikan fungsi hash menggunakan multiplication method dengan konstanta A = 0.6180339887 dan m = 8. Hitung hash value untuk kunci: 10, 22, 35, 47, 58, 63. Bandingkan hasilnya dengan division method menggunakan m = 7. Metode mana yang menghasilkan distribusi lebih merata untuk set kunci ini? Jelaskan alasannya.

---

**Soal 6 [C3 - Menerapkan]**
Diberikan hash table dengan m=11 menggunakan division method dan **separate chaining**. Sisipkan kunci-kunci berikut secara berurutan: `{44, 55, 22, 99, 33, 77, 11, 66, 88}`. Gambarkan state hash table setelah semua penyisipan selesai, termasuk isi setiap chain. Hitung load factor akhir dan panjang chain rata-rata.

---

**Soal 7 [C3 - Menerapkan]**
Diberikan hash table kosong berukuran m=11 menggunakan division method dan **open addressing dengan linear probing**. Sisipkan kunci-kunci berikut secara berurutan: `{10, 21, 32, 43, 54}`. Setelah semua penyisipan, lakukan operasi penghapusan pada kunci `21`. Kemudian cari kunci `32` dan `43`. Tunjukkan mengapa lazy deletion diperlukan agar pencarian `43` tetap berhasil setelah kunci `21` dihapus.

---

**Soal 8 [C4 - Menganalisis]**
Sebuah hash table dengan open addressing (linear probing) memiliki kapasitas m=20 dan saat ini menyimpan n=16 elemen (load factor = 0.8). Berdasarkan formula perkiraan:
- Jumlah probe rata-rata untuk pencarian **gagal** ≈ 1/(1-α)^2
- Jumlah probe rata-rata untuk pencarian **berhasil** ≈ (1/2)(1 + 1/(1-α))

Hitung jumlah probe rata-rata untuk kedua jenis pencarian. Apakah hash table ini memerlukan rehashing? Jika ya, jika dilakukan rehashing ke tabel baru berukuran m=41 (bilangan prima terdekat di atas 2*20), berapa load factor barunya dan berapa perkiraan probe rata-rata yang baru?

---

**Soal 9 [C4 - Menganalisis]**
Analis sebuah perusahaan e-commerce melaporkan bahwa sistem pencarian produk mereka mulai lambat. Sistem ini menggunakan hash table dengan separate chaining untuk mengindeks 500.000 SKU produk. Investigasi menemukan bahwa ukuran hash table (m) adalah 100.003 (bilangan prima). Hitung load factor saat ini. Berdasarkan analisis load factor, apakah performa sistem dapat dijelaskan dari sisi teori? Rekomendasikan ukuran hash table yang baru jika perusahaan berencana menambah inventori hingga 750.000 produk dalam setahun ke depan, dengan target load factor ≤ 0.7.

---

**Soal 10 [C5 - Mengevaluasi]**
Bandingkan dan evaluasi pemilihan struktur data untuk dua skenario berikut. Untuk setiap skenario, rekomendasikan satu struktur data (sorted array + binary search, atau hash table dengan chaining, atau hash table dengan open addressing) dan justifikasikan pilihan Anda berdasarkan analisis kompleksitas, penggunaan memori, dan karakteristik operasi:

(a) **Sistem katalog perpustakaan universitas** yang menyimpan 2 juta judul buku, di mana operasi pencarian berdasarkan ISBN dilakukan ratusan kali per hari, tetapi penambahan buku baru sangat jarang (rata-rata 5 buku per minggu).

(b) **Cache DNS (Domain Name System)** yang menyimpan pemetaan nama domain ke alamat IP, di mana jutaan lookup dilakukan per detik, entri cache kedaluwarsa dan perlu dihapus secara reguler, dan entri baru ditambahkan setiap saat.

---

**Soal 11 [C5 - Mengevaluasi]**
Tinjau implementasi `HashTableOpenAddressing` yang telah dibangun di bab ini. Identifikasi setidaknya **tiga kelemahan desain** yang perlu diperbaiki agar implementasi tersebut layak digunakan dalam lingkungan produksi. Untuk setiap kelemahan yang Anda identifikasi, usulkan solusi konkret dan tuliskan pseudocode atau kode Python untuk solusi tersebut.

---

**Soal 12 [C6 - Mencipta]**
Rancang dan implementasikan sebuah kelas Python `LRUCache` (Least Recently Used Cache) menggunakan kombinasi hash table dan struktur data lain yang sesuai. LRU Cache memiliki kapasitas tetap dan ketika cache penuh, elemen yang paling lama tidak diakses akan dibuang untuk memberi ruang bagi elemen baru. Spesifikasi:

- `__init__(self, kapasitas: int)` — inisialisasi cache dengan kapasitas tertentu.
- `get(self, key) -> int` — kembalikan nilai jika key ada dalam cache, -1 jika tidak.
- `put(self, key: int, value: int) -> None` — sisipkan pasangan key-value. Jika cache penuh, buang elemen LRU.

Kedua operasi harus berjalan dalam O(1) rata-rata. Jelaskan pilihan struktur data Anda dan buktikan bahwa kompleksitas yang dijanjikan tercapai.

---

## 11.8 Bacaan Lanjutan

**[1] Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022). *Introduction to Algorithms* (4th ed.). MIT Press.**
Bab 11 (*Hash Tables*) dan Bab 2 (*Getting Started*) memberikan fondasi teoritikal yang paling komprehensif tentang hashing, termasuk bukti formal tentang Simple Uniform Hashing Assumption dan analisis probabilistik kompleksitas rata-rata. Bab 11 juga membahas universal hashing sebagai jaminan distribusi yang lebih kuat dari SUHA. Wajib baca bagi mahasiswa yang ingin memahami landasan matematika secara mendalam.

**[2] Knuth, D. E. (1998). *The Art of Computer Programming, Volume 3: Sorting and Searching* (2nd ed.). Addison-Wesley.**
Karya klasik yang tetap relevan hingga kini. Knuth mendedikasikan seluruh Bab 6 untuk pencarian dan Bagian 6.4 untuk hashing, termasuk analisis matematis yang sangat rinci tentang division method, multiplication method, dan open addressing. Nilai historis dan ketelitian analitisnya tidak tertandingi.

**[3] Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013). *Data Structures and Algorithms in Python*. Wiley.**
Bab 10 (*Maps, Hash Tables, and Skip Lists*) menyajikan materi hashing dalam konteks Python dengan gaya yang sangat accessible. Buku ini menggunakan Python secara konsisten dan membahas implementasi dict Python secara internal. Sangat direkomendasikan bagi pembaca yang ingin menjembatani teori dan praktik Python.

**[4] Sedgewick, R. & Wayne, K. (2011). *Algorithms* (4th ed.). Addison-Wesley.**
Bab 3 (*Searching*) mencakup binary search, BST, red-black BST, dan hash table dengan cara yang sangat visual dan intuitif. Buku ini terkenal dengan ilustrasi algoritmik yang superior. Tersedia juga versi online gratis dengan animasi interaktif di situs web resminya, sangat cocok untuk memvisualisasikan proses hashing dan probing.

**[5] Mitzenmacher, M. & Upfal, E. (2017). *Probability and Computing: Randomization and Probabilistic Techniques in Algorithms and Data Analysis* (2nd ed.). Cambridge University Press.**
Bab 5 memberikan analisis probabilistik mendalam tentang hashing, termasuk topik-topik lanjutan seperti Bloom filters, cuckoo hashing, dan consistent hashing yang digunakan dalam sistem terdistribusi skala besar. Diperlukan pengetahuan probabilitas dasar.

**[6] Skiena, S. S. (2020). *The Algorithm Design Manual* (3rd ed.). Springer.**
Bab 14 (*Hashing*) membahas hashing dari perspektif praktis seorang insinyur perangkat lunak berpengalaman. Skiena memberikan panduan pragmatis tentang kapan menggunakan hash table versus struktur data lain, disertai contoh-contoh dari dunia nyata dan diskusi tentang trade-off yang sering diabaikan buku teks standar.

**[7] Python Software Foundation. *Python Documentation: Time Complexity* dan *Built-in Functions: hash()*.** `https://wiki.python.org/moin/TimeComplexity`
Dokumentasi resmi Python tentang kompleksitas waktu tipe data bawaan (list, dict, set) memberikan informasi praktis yang langsung dapat diterapkan. Memahami jaminan kinerja yang diberikan Python untuk tipe-tipe dasarnya adalah pengetahuan esensial bagi setiap pengembang Python. Dokumentasi tentang `hash()` menjelaskan mengapa Python mengacak seed hash per sesi untuk keamanan (hash randomization).

**[8] Bernstein, D. J. (2012). *SipHash: A Fast Short-Input PRF*. USENIX Security.**
Makalah teknis yang mendeskripsikan algoritma SipHash yang digunakan Python sebagai fungsi hash default untuk string dan bytes. Membaca makalah ini memberikan wawasan mendalam tentang persyaratan kriptografis fungsi hash dalam lingkungan yang rentan terhadap serangan hash-flooding — sebuah topik yang semakin relevan dalam pengembangan aplikasi web dan layanan jaringan modern.

---

*Bab 11 — Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python*
*Institut Teknologi dan Bisnis STIKOM Bali (INSTIKI)*
