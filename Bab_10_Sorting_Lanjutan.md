# BAB 10
# ALGORITMA SORTING LANJUTAN: DIVIDE-AND-CONQUER DAN PENGURUTAN LINEAR

---

> "Masalah yang tampak besar seringkali dapat diselesaikan dengan elegans jika kita berani memecahnya menjadi bagian-bagian yang lebih sederhana, menyelesaikan setiap bagian, lalu merajut kembali solusinya."
>
> — Jon Bentley, *Programming Pearls* (2000)

---

## Tujuan Pembelajaran

Setelah mempelajari bab ini, mahasiswa mampu:

1. **[C2 — Memahami]** Menjelaskan prinsip kerja paradigma divide-and-conquer dan tahapan divide, conquer, serta combine yang membentuknya.
2. **[C3 — Menerapkan]** Mengimplementasikan algoritma merge sort dan quick sort dalam bahasa Python dengan benar, lengkap dengan prosedur merge dan partisi.
3. **[C3 — Menerapkan]** Mengimplementasikan algoritma counting sort dan radix sort (LSD) sebagai representasi pengurutan berbasis non-perbandingan.
4. **[C4 — Menganalisis]** Menurunkan kompleksitas waktu merge sort dan quick sort menggunakan relasi rekurensi dan Master Theorem.
5. **[C4 — Menganalisis]** Menganalisis implikasi pemilihan strategi pivot terhadap performa quick sort, termasuk kondisi-kondisi yang memicu kasus terburuk O(n²).
6. **[C4 — Menganalisis]** Membandingkan seluruh algoritma sorting yang telah dipelajari berdasarkan kompleksitas waktu, kompleksitas ruang, stabilitas, sifat in-place, dan kesesuaian dengan karakteristik data.
7. **[C5 — Mengevaluasi]** Memilih dan membenarkan algoritma sorting yang paling tepat untuk skenario masalah nyata berdasarkan analisis trade-off yang rasional.
8. **[C6 — Mencipta]** Merancang algoritma sorting adaptif yang secara otomatis mendeteksi karakteristik data dan memilih strategi pengurutan yang paling efisien.

---

## 10.1 Pendahuluan: Mengapa Algoritma O(n log n) Diperlukan

Pada bab-bab sebelumnya telah diperkenalkan tiga algoritma pengurutan dasar: bubble sort, selection sort, dan insertion sort. Ketiga algoritma tersebut memiliki karakter yang sama dalam hal kompleksitas waktu, yaitu O(n²) pada kasus rata-rata dan kasus terburuk. Untuk data berskala kecil, perbedaan ini tidak terasa signifikan. Namun, dalam aplikasi perangkat lunak dunia nyata, situasinya berubah secara dramatis.

Bayangkan sebuah platform e-commerce berskala nasional yang harus mengurutkan 10 juta catatan transaksi setiap malam untuk keperluan pelaporan. Jika digunakan algoritma O(n²), misalnya bubble sort, jumlah operasi yang diperlukan adalah sekitar (10^7)² = 10^14 operasi. Dengan asumsi prosesor modern yang mampu melakukan 10^9 operasi per detik, proses pengurutan ini akan memakan waktu sekitar 10^5 detik, atau lebih dari 27 jam. Jelas ini tidak dapat diterima. Sebaliknya, algoritma O(n log n) hanya memerlukan sekitar 10^7 × log(10^7) ≈ 2,3 × 10^8 operasi — selesai dalam hitungan detik.

Selisih antara O(n²) dan O(n log n) bukan sekadar perbedaan numerik; ini adalah perbedaan antara solusi yang layak digunakan dalam praktik dan solusi yang tidak. Bab ini memperkenalkan kelas algoritma sorting yang jauh lebih efisien melalui dua jalur pendekatan yang berbeda secara filosofis:

Pertama, **algoritma berbasis divide-and-conquer** yang memanfaatkan struktur rekursif untuk memecah masalah besar menjadi sub-masalah yang lebih kecil. Merge sort dan quick sort adalah dua representasi utama kelas ini, keduanya mencapai kompleksitas O(n log n) pada kasus rata-rata.

Kedua, **algoritma berbasis non-perbandingan** yang memanfaatkan informasi tambahan tentang struktur data untuk melampaui batas bawah teoritis O(n log n) yang berlaku bagi semua algoritma berbasis perbandingan. Counting sort dan radix sort adalah representasi kelas ini, keduanya mampu beroperasi dalam waktu linear O(n) pada kondisi yang tepat.

Pemahaman mendalam terhadap keempat algoritma ini, berikut analisis kompleksitas, karakteristik, dan panduan pemilihan yang tepat, merupakan kompetensi fundamental bagi setiap praktisi ilmu komputer.

---

## 10.2 Paradigma Divide-and-Conquer

### 10.2.1 Konsep Dasar dan Tiga Tahapan

Divide-and-conquer (bagi-dan-taklukkan) adalah salah satu paradigma perancangan algoritma yang paling berpengaruh dalam sejarah ilmu komputer. Paradigma ini menyelesaikan masalah melalui tiga tahapan berurutan yang saling bergantung:

**Tahap 1: Divide (Bagi)**
Masalah berukuran n dipecah menjadi sejumlah sub-masalah yang memiliki struktur identik dengan masalah aslinya, tetapi berukuran lebih kecil. Idealnya, pembagian dilakukan sedemikian rupa sehingga setiap sub-masalah memiliki ukuran yang kira-kira sama besar, biasanya n/2 atau n/b untuk suatu konstanta b > 1.

**Tahap 2: Conquer (Taklukkan)**
Setiap sub-masalah diselesaikan secara rekursif. Proses rekursi berlanjut hingga ukuran sub-masalah mencapai suatu ambang batas (basis rekursi) yang cukup kecil untuk diselesaikan secara langsung tanpa pembagian lebih lanjut. Basis rekursi yang paling umum adalah sub-masalah berukuran 0 atau 1.

**Tahap 3: Combine (Gabungkan)**
Solusi dari seluruh sub-masalah digabungkan untuk membentuk solusi bagi masalah aslinya. Bergantung pada algoritma, tahap combine ini bisa menjadi operasi yang mahal (seperti pada merge sort) atau hampir trivial (seperti pada quick sort).

Paradigma ini terinspirasi dari prinsip militer kuno: sebuah kekuatan besar yang tidak dapat dikalahkan secara frontal dapat diatasi dengan cara memecahnya menjadi unit-unit yang lebih kecil dan menghancurkan masing-masing unit secara terpisah. Dalam dunia algoritma, "masalah besar" yang tidak efisien diselesaikan secara langsung dipecah menjadi sub-masalah kecil yang efisien untuk diselesaikan secara rekursif.

> **Catatan Penting**
>
> Tidak semua masalah dapat diselesaikan secara efisien dengan divide-and-conquer. Paradigma ini paling efektif ketika: (1) masalah dapat dipecah menjadi sub-masalah yang benar-benar independen satu sama lain, (2) ukuran sub-masalah berkurang secara proporsional (bukan hanya berkurang satu), dan (3) biaya penggabungan (combine) tidak lebih besar dari biaya yang dihemat melalui pembagian. Jika sub-masalah saling tumpang tindih (overlapping subproblems), paradigma yang lebih tepat adalah pemrograman dinamis (dynamic programming).

### 10.2.2 Relasi Rekurensi

Algoritma divide-and-conquer secara alami menghasilkan relasi rekurensi untuk mengekspresikan kompleksitas waktunya. Bentuk umum relasi rekurensi untuk algoritma yang membagi masalah berukuran n menjadi a sub-masalah masing-masing berukuran n/b adalah:

```
T(n) = a * T(n/b) + f(n)
```

Di mana:
- `a` adalah jumlah sub-masalah yang dihasilkan dari satu pemanggilan rekursif (a >= 1)
- `b` adalah faktor pembagi ukuran masalah pada setiap tingkatan rekursi (b > 1)
- `f(n)` adalah biaya pekerjaan yang dilakukan di luar panggilan rekursif, yaitu biaya divide ditambah biaya combine pada satu level

Relasi ini secara implisit mendefinisikan struktur pohon rekursi: setiap simpul merepresentasikan satu pemanggilan fungsi, dengan a cabang anak yang masing-masing menyelesaikan sub-masalah berukuran n/b.

### 10.2.3 Master Theorem: Derivasi dan Penggunaan

Master Theorem menyediakan solusi asimtotik yang langsung dapat digunakan untuk relasi rekurensi berbentuk T(n) = aT(n/b) + f(n), tanpa perlu melakukan unrolling rekursi secara manual. Teorema ini didasarkan pada perbandingan antara f(n) dan n^(log_b(a)), yang merupakan biaya total pada level daun pohon rekursi.

Secara intuitif, n^(log_b(a)) adalah jumlah daun dalam pohon rekursi. Jika f(n) lebih kecil dari jumlah daun, maka pekerjaan terbanyak terjadi di level daun (Kasus 1). Jika f(n) setara dengan jumlah daun, pekerjaan tersebar merata di semua level (Kasus 2). Jika f(n) lebih besar dari jumlah daun, pekerjaan terbanyak terjadi di akar (Kasus 3).

**Tabel 10.1 — Master Theorem: Tiga Kasus dan Solusinya**

| Kasus | Kondisi | Solusi Asimtotik | Interpretasi |
|-------|---------|------------------|--------------|
| Kasus 1 | f(n) = O(n^(log_b(a) - epsilon)) untuk suatu epsilon > 0 | T(n) = Theta(n^log_b(a)) | Daun mendominasi; pekerjaan di level akar tidak signifikan |
| Kasus 2 | f(n) = Theta(n^(log_b(a)) * log^k(n)) untuk suatu k >= 0 | T(n) = Theta(n^log_b(a) * log^(k+1)(n)) | Pekerjaan seimbang di semua level pohon rekursi |
| Kasus 3 | f(n) = Omega(n^(log_b(a) + epsilon)) untuk suatu epsilon > 0, dan af(n/b) <= cf(n) untuk c < 1 | T(n) = Theta(f(n)) | Akar mendominasi; pekerjaan rekursif tidak signifikan |

Catatan: Kasus 2 yang paling sederhana (k = 0) menghasilkan T(n) = Theta(n^log_b(a) * log n), yang merupakan kasus yang paling sering dijumpai dalam analisis algoritma sorting.

Perlu dicatat bahwa Master Theorem memiliki keterbatasan: teorema ini tidak dapat diterapkan apabila f(n) tidak secara polinom lebih besar atau lebih kecil dari n^(log_b(a)), atau apabila sub-masalah tidak memiliki ukuran yang seragam. Dalam kasus demikian, metode alternatif seperti pohon rekursi atau substitusi harus digunakan.

> **Tahukah Anda?**
>
> Master Theorem dipopulerkan oleh Cormen, Leiserson, Rivest, dan Stein dalam buku monumental mereka *Introduction to Algorithms* (CLRS), yang pertama kali terbit pada tahun 1990 dan kini telah memasuki edisi keempat (2022). Buku ini sering disebut sebagai "Injil Algoritma" di kalangan ilmuwan komputer dan insinyur perangkat lunak. Hingga tahun 2024, buku tersebut telah dikutip lebih dari 150.000 kali dalam literatur ilmiah — sebuah catatan yang luar biasa dalam bidang ilmu komputer.

---

## 10.3 Merge Sort: Pengurutan dengan Penggabungan

### 10.3.1 Sejarah dan Motivasi

Merge sort dirancang oleh John von Neumann pada tahun 1945, menjadikannya salah satu algoritma sorting paling awal yang diformulasikan secara ilmiah. Von Neumann, yang juga dikenal sebagai salah satu arsitek utama komputer modern, merancang algoritma ini pada saat ia sedang mengembangkan program untuk komputer EDVAC — mesin digital pertama berbasis stored-program. Fakta bahwa algoritma yang dirancang lebih dari tujuh dekade lalu masih relevan dan banyak digunakan hingga hari ini merupakan bukti ketimelesan dari idenya.

Motivasi utama merge sort adalah sebuah pengamatan sederhana namun kuat: **menggabungkan dua daftar yang sudah terurut menjadi satu daftar terurut jauh lebih mudah daripada mengurutkan satu daftar acak dari awal**. Proses penggabungan (merge) ini hanya memerlukan waktu O(n) dengan menggunakan dua pointer yang secara bersamaan menelusuri kedua daftar dari depan. Dengan memadukan pengamatan ini dengan pendekatan divide-and-conquer, merge sort memecah masalah pengurutan menjadi sub-masalah yang semakin kecil hingga masing-masing trivially sorted (array satu elemen sudah pasti terurut), kemudian membangun kembali solusi melalui serangkaian operasi merge.

### 10.3.2 Mekanisme Kerja Algoritma

Merge sort bekerja melalui dua fase besar yang berlangsung secara rekursif:

**Fase Divide:** Array dipecah terus-menerus menjadi dua bagian yang hampir sama besar hingga setiap bagian hanya berisi satu elemen. Pembagian dilakukan dengan menghitung indeks tengah sebagai titik potong.

**Fase Merge:** Dimulai dari potongan-potongan terkecil, pasangan array yang bersebelahan digabungkan (merge) secara terurut. Proses ini berlanjut dari bawah ke atas pohon rekursi hingga seluruh array kembali tergabung dalam keadaan terurut.

Langkah-langkah formal algoritma merge sort adalah:

1. Jika array memiliki nol atau satu elemen, kembalikan langsung (basis rekursi — array sudah terurut).
2. Hitung indeks tengah: `mid = len(arr) // 2`.
3. Bagi array menjadi dua bagian: `kiri = arr[:mid]` dan `kanan = arr[mid:]`.
4. Urutkan bagian kiri secara rekursif: `kiri_terurut = merge_sort(kiri)`.
5. Urutkan bagian kanan secara rekursif: `kanan_terurut = merge_sort(kanan)`.
6. Gabungkan dua bagian yang sudah terurut: `return merge(kiri_terurut, kanan_terurut)`.

Kunci efisiensi terletak pada prosedur merge di langkah 6. Prosedur ini memelihara dua pointer — satu untuk setiap array yang akan digabungkan — dan secara iteratif memindahkan elemen terkecil dari kedua array ke posisi berikutnya dalam array output. Karena setiap elemen dipindahkan tepat satu kali, prosedur merge memiliki kompleksitas O(n).

### 10.3.3 Pohon Rekursi Merge Sort: Analisis Visual

Untuk memahami bagaimana merge sort mencapai kompleksitas O(n log n), mari telusuri pohon rekursinya secara mendetail menggunakan array A = [38, 27, 43, 3, 9, 82, 10].

**Gambar 10.1 — Pohon Rekursi Merge Sort untuk Array [38, 27, 43, 3, 9, 82, 10]**

```
FASE DIVIDE (pemecahan — dari atas ke bawah):
==============================================

Level 0 (n=7):   [38, 27, 43, 3, 9, 82, 10]
                   |                      |
                  mid=3                  mid=3
                  /                          \
Level 1 (n=3): [38, 27, 43]          [3, 9, 82, 10]  (n=4)
               /         \            /              \
             mid=1       mid=1      mid=2            mid=2
             /               \       /                   \
Level 2: [38]           [27, 43]  [3, 9]            [82, 10]
(n=1)    (basis)        /      \  /    \             /       \
                      mid=1  mid=1 mid=1 mid=1     mid=1    mid=1
                       /        \   /      \        /           \
Level 3:             [27]      [43] [3]    [9]   [82]          [10]
(n=1)               (basis)  (basis)(basis)(basis)(basis)      (basis)

FASE MERGE (penggabungan — dari bawah ke atas):
================================================

[Level 3 -> Level 2]
  Merge([27], [43]):
    27 <= 43: ambil 27 -> output: [27]
    Sisa [43]         -> output: [27, 43]
    Biaya: 1 perbandingan, 2 elemen diproses

  Merge([3], [9]):
    3 <= 9: ambil 3  -> output: [3]
    Sisa [9]         -> output: [3, 9]
    Biaya: 1 perbandingan, 2 elemen diproses

  Merge([82], [10]):
    82 > 10: ambil 10 -> output: [10]
    Sisa [82]         -> output: [10, 82]
    Biaya: 1 perbandingan, 2 elemen diproses

[Level 2 -> Level 1]
  Merge([38], [27, 43]):
    38 > 27:  ambil 27 -> output: [27]
    38 <= 43: ambil 38 -> output: [27, 38]
    Sisa [43]          -> output: [27, 38, 43]
    Biaya: 2 perbandingan, 3 elemen diproses

  Merge([3, 9], [10, 82]):
    3 <= 10: ambil 3  -> output: [3]
    9 <= 10: ambil 9  -> output: [3, 9]
    Sisa [10, 82]     -> output: [3, 9, 10, 82]
    Biaya: 2 perbandingan, 4 elemen diproses

[Level 1 -> Level 0]
  Merge([27, 38, 43], [3, 9, 10, 82]):
    27 >  3:  ambil 3  -> output: [3]
    27 >  9:  ambil 9  -> output: [3, 9]
    27 > 10:  ambil 10 -> output: [3, 9, 10]
    27 <= 82: ambil 27 -> output: [3, 9, 10, 27]
    38 <= 82: ambil 38 -> output: [3, 9, 10, 27, 38]
    43 <= 82: ambil 43 -> output: [3, 9, 10, 27, 38, 43]
    Sisa [82]          -> output: [3, 9, 10, 27, 38, 43, 82]
    Biaya: 6 perbandingan, 7 elemen diproses

HASIL AKHIR: [3, 9, 10, 27, 38, 43, 82]
```

Pengamatan penting dari pohon rekursi ini:

1. **Kedalaman pohon** adalah ceil(log2(n)) = ceil(log2(7)) = 3 level. Secara umum, kedalaman pohon adalah O(log n).
2. **Total pekerjaan per level** adalah O(n): pada setiap level pohon, semua operasi merge secara keseluruhan memproses tepat n elemen. Di Level 2, diproses 2+2+2=6 elemen (mendekati n=7). Di Level 1, diproses 3+4=7 elemen. Di Level 0, diproses 7 elemen.
3. **Total kompleksitas** adalah O(log n) level × O(n) per level = **O(n log n)**.

### 10.3.4 Derivasi Kompleksitas dengan Master Theorem

Relasi rekurensi merge sort diturunkan langsung dari mekanisme algoritmanya:

```
T(n) = 2 * T(n/2) + Theta(n)
```

Penjelasan setiap komponen:
- **2**: terdapat dua panggilan rekursif, satu untuk bagian kiri dan satu untuk bagian kanan.
- **T(n/2)**: setiap panggilan rekursif menyelesaikan sub-masalah berukuran kira-kira n/2 (pembagian hampir seimbang).
- **Theta(n)**: biaya prosedur merge pada setiap level adalah linear, sebab setiap elemen diproses tepat satu kali.

Penerapan Master Theorem:
- Parameter: a = 2, b = 2, f(n) = Theta(n)
- Hitung n^(log_b(a)) = n^(log_2(2)) = n^1 = n
- Bandingkan: f(n) = Theta(n) = Theta(n^(log_2(2)))
- Kondisi yang terpenuhi: **Kasus 2 Master Theorem** (f(n) = Theta(n^(log_b(a))))
- **Kesimpulan: T(n) = Theta(n * log n) = O(n log n)**

Hasil ini berlaku untuk **semua kasus** — terbaik, rata-rata, maupun terburuk — karena struktur pohon rekursi merge sort tidak bergantung pada distribusi data masukan. Berapapun urutan elemen dalam array, merge sort selalu membagi dua, mengurutkan masing-masing bagian, lalu merge. Konsistensi ini adalah salah satu keunggulan terbesar merge sort.

**Analisis Kompleksitas Ruang:** Merge sort membutuhkan array tambahan berukuran O(n) untuk menampung hasil sementara pada setiap operasi merge. Selain itu, tumpukan panggilan rekursif (call stack) membutuhkan O(log n) ruang sesuai kedalaman pohon rekursi. Sehingga total kompleksitas ruang adalah O(n). Kebutuhan memori tambahan ini merupakan kelemahan utama merge sort dibandingkan quick sort yang bersifat in-place.

### 10.3.5 Implementasi Python

```python
def merge_sort(arr):
    """
    Mengurutkan array menggunakan algoritma merge sort.

    Parameter:
        arr (list): Array yang akan diurutkan.

    Mengembalikan:
        list: Array baru yang sudah terurut secara menaik.

    Kompleksitas Waktu : O(n log n) -- semua kasus
    Kompleksitas Ruang : O(n) -- array bantu untuk merge
    Stabil             : Ya
    """
    # Basis rekursi: array dengan 0 atau 1 elemen sudah terurut
    if len(arr) <= 1:
        return arr

    # DIVIDE: cari titik tengah dan bagi array menjadi dua bagian
    mid = len(arr) // 2
    kiri = arr[:mid]
    kanan = arr[mid:]

    # CONQUER: urutkan setiap bagian secara rekursif
    kiri_terurut = merge_sort(kiri)
    kanan_terurut = merge_sort(kanan)

    # COMBINE: gabungkan dua bagian yang sudah terurut
    return merge(kiri_terurut, kanan_terurut)


def merge(kiri, kanan):
    """
    Menggabungkan dua array terurut menjadi satu array terurut.

    Parameter:
        kiri  (list): Array kiri yang sudah terurut.
        kanan (list): Array kanan yang sudah terurut.

    Mengembalikan:
        list: Array gabungan yang terurut.

    Kompleksitas Waktu: O(n) di mana n = len(kiri) + len(kanan)
    """
    hasil = []
    i = 0  # pointer untuk array kiri
    j = 0  # pointer untuk array kanan

    # Bandingkan elemen dari kedua array, ambil yang lebih kecil
    while i < len(kiri) and j < len(kanan):
        if kiri[i] <= kanan[j]:
            hasil.append(kiri[i])
            i += 1
        else:
            hasil.append(kanan[j])
            j += 1

    # Tambahkan sisa elemen yang belum diproses
    hasil.extend(kiri[i:])
    hasil.extend(kanan[j:])

    return hasil


def merge_sort_inplace(arr, kiri=0, kanan=None):
    """
    Versi merge sort yang bekerja langsung pada array asli menggunakan indeks.
    Menghindari pembuatan array baru pada setiap pemanggilan rekursif.

    Kompleksitas Waktu : O(n log n)
    Kompleksitas Ruang : O(n) untuk array sementara saat merge
                       + O(log n) untuk call stack rekursi
    """
    if kanan is None:
        kanan = len(arr) - 1

    if kiri < kanan:
        mid = (kiri + kanan) // 2
        merge_sort_inplace(arr, kiri, mid)
        merge_sort_inplace(arr, mid + 1, kanan)
        _merge_inplace(arr, kiri, mid, kanan)


def _merge_inplace(arr, kiri, mid, kanan):
    """Prosedur merge untuk versi in-place menggunakan indeks."""
    kiri_bagian = arr[kiri:mid + 1]
    kanan_bagian = arr[mid + 1:kanan + 1]

    i = 0
    j = 0
    k = kiri  # indeks penulisan pada array asli

    while i < len(kiri_bagian) and j < len(kanan_bagian):
        if kiri_bagian[i] <= kanan_bagian[j]:
            arr[k] = kiri_bagian[i]
            i += 1
        else:
            arr[k] = kanan_bagian[j]
            j += 1
        k += 1

    while i < len(kiri_bagian):
        arr[k] = kiri_bagian[i]
        i += 1
        k += 1

    while j < len(kanan_bagian):
        arr[k] = kanan_bagian[j]
        j += 1
        k += 1


# Demonstrasi
if __name__ == "__main__":
    data = [38, 27, 43, 3, 9, 82, 10]
    print("Array awal          :", data)

    hasil = merge_sort(data)
    print("Setelah merge sort  :", hasil)

    data2 = [38, 27, 43, 3, 9, 82, 10]
    merge_sort_inplace(data2)
    print("Merge sort in-place :", data2)
```

> **Catatan Penting: Stabilitas Merge Sort**
>
> Perhatikan kondisi `kiri[i] <= kanan[j]` (bukan `kiri[i] < kanan[j]`) dalam prosedur merge. Penggunaan operator `<=` memastikan bahwa ketika dua elemen memiliki nilai yang sama, elemen dari sisi kiri (yang aslinya berposisi lebih awal) diambil terlebih dahulu. Perilaku ini adalah yang membuat merge sort bersifat **stabil** — elemen-elemen dengan kunci yang sama mempertahankan urutan relatif mereka dari array asli. Stabilitas ini sangat penting dalam konteks pengurutan berdasarkan beberapa kriteria (multi-key sort) secara bertahap.

---

## 10.4 Quick Sort: Pengurutan dengan Partisi

### 10.4.1 Sejarah dan Filosofi

Quick sort diperkenalkan oleh Sir Charles Antony Richard Hoare pada tahun 1959, ketika ia masih berusia 25 tahun dan sedang bekerja sebagai mahasiswa doktoral di Universitas Moscow. Hoare mengembangkan algoritma ini sebagai solusi untuk masalah penerjemahan kosakata Rusia ke bahasa Inggris yang memerlukan pengurutan efisien. Hoare kemudian menerima Turing Award pada tahun 1980, sebagian atas kontribusinya ini.

Filosofi quick sort bertolak belakang dengan merge sort. Alih-alih menempatkan kerja keras pada tahap combine (seperti merge sort), quick sort menempatkan seluruh kerja keras pada tahap divide melalui suatu prosedur yang disebut **partisi**. Tahap combine quick sort bersifat trivial — bahkan tidak ada — karena setelah semua panggilan rekursif selesai, array sudah terurut dengan sendirinya.

Keindahan quick sort terletak pada sifatnya yang **in-place**: algoritma ini mengurutkan array tanpa membutuhkan array tambahan yang signifikan. Hanya tumpukan rekursi (call stack) yang membutuhkan ruang O(log n) pada kasus rata-rata. Sifat in-place ini, dikombinasikan dengan lokalitas cache yang baik karena akses memori yang sekuensial, menjadikan quick sort secara empiris sangat cepat — seringkali lebih cepat dari merge sort meskipun keduanya sama-sama O(n log n).

### 10.4.2 Prosedur Partisi: Inti Quick Sort

Prosedur partisi (skema Lomuto) bekerja sebagai berikut:

1. Pilih elemen **pivot** (misalnya elemen terakhir).
2. Inisialisasi pointer `i = kiri - 1` (indeks elemen terakhir yang nilai <= pivot).
3. Untuk setiap `j` dari `kiri` hingga `kanan - 1`:
   - Jika `arr[j] <= pivot`: increment `i`, lalu tukar `arr[i]` dan `arr[j]`.
4. Tempatkan pivot ke posisi yang benar: tukar `arr[i + 1]` dan `arr[kanan]`.
5. Kembalikan `i + 1` sebagai posisi akhir pivot.

Setelah partisi selesai, pivot berada pada posisi finalnya yang tepat dalam array terurut, semua elemen di sebelah kiri pivot lebih kecil atau sama dengan pivot, dan semua elemen di sebelah kanan pivot lebih besar dari pivot. Quick sort kemudian memanggil dirinya secara rekursif untuk mengurutkan sub-array kiri dan kanan, **tidak termasuk** pivot yang sudah berada di posisi benarnya.

### 10.4.3 Strategi Pemilihan Pivot: Analisis Komprehensif

Pilihan pivot adalah keputusan paling kritis dalam quick sort. Pivot yang ideal adalah yang menghasilkan partisi paling seimbang — yaitu pivot yang mendarat tepat di posisi tengah array setelah partisi. Namun, tanpa mengetahui distribusi data terlebih dahulu, tidak ada cara pasti untuk memilih pivot yang optimal. Empat strategi berikut menawarkan trade-off yang berbeda antara kesederhanaan implementasi dan kualitas partisi yang diharapkan.

**Strategi 1: Pivot Elemen Pertama atau Terakhir**

Strategi paling sederhana: pilih elemen pertama atau elemen terakhir sebagai pivot. Implementasinya trivial dan tidak memerlukan komputasi tambahan.

Kelemahan kritis: strategi ini menghasilkan kasus terburuk O(n²) pada data yang sudah terurut (naik atau turun). Pada array yang sudah terurut secara menaik dengan pivot = elemen terakhir, setiap operasi partisi menempatkan semua elemen di sub-array kiri dan menghasilkan sub-array kanan yang kosong. Pohon rekursi menjadi degenerate (linier, bukan logaritmik), menghasilkan n level dengan masing-masing O(n) pekerjaan. Ini adalah kasus terburuk yang paling umum terjadi dalam praktik, karena data dunia nyata seringkali sudah hampir terurut.

**Strategi 2: Pivot Acak (Random Pivot)**

Pilih indeks pivot secara acak dari rentang [kiri, kanan] sebelum setiap partisi, lalu tukar elemen terpilih ke posisi terakhir agar prosedur partisi standar dapat digunakan.

Kelebihan: dengan memilih pivot secara acak, probabilitas mendapatkan partisi yang sangat tidak seimbang pada setiap level pohon rekursi menjadi sangat kecil. Analisis probabilistik formal menggunakan indicator random variables menunjukkan bahwa nilai ekspektasi jumlah perbandingan adalah sekitar 2n ln n ≈ 1,39n log2(n) — hanya sekitar 39% lebih banyak dari batas bawah teoritis O(n log n).

Strategi ini menjamin bahwa kasus terburuk O(n²) tidak dapat dipicu oleh pola data masukan tertentu — yang sangat penting untuk menghindari serangan **algorithmic complexity attack**, di mana pihak jahat sengaja memberikan data yang memicu kasus terburuk pada sistem yang menggunakan pivot tetap.

**Strategi 3: Median-of-Three**

Pilih tiga kandidat (elemen pertama, elemen tengah, dan elemen terakhir dari rentang yang sedang dipartisi), tentukan mediannya, dan gunakan median tersebut sebagai pivot.

Contoh: untuk sub-array [38, 27, 43, 3, 9, 82, 10], tiga kandidat adalah 38 (indeks 0), 3 (indeks 3, posisi tengah), dan 10 (indeks 6). Diurutkan: 3, 10, 38. Median = 10. Pivot = 10.

Strategi ini secara deterministik menghilangkan kasus terburuk untuk array yang sudah terurut naik atau turun, karena pada array terurut, median dari ketiga elemen selalu merupakan elemen tengah, yang menghasilkan partisi yang seimbang sempurna. Strategi ini digunakan dalam banyak implementasi standar, termasuk `std::sort` pada pustaka standar C++.

**Strategi 4: Introsort (Hybrid)**

Introsort bukan hanya strategi pemilihan pivot, melainkan sebuah algoritma hybrid yang mengombinasikan quick sort, heap sort, dan insertion sort. Introsort memulai dengan quick sort (dengan median-of-three atau pivot acak), tetapi memantau kedalaman rekursi. Jika kedalaman melebihi ambang batas tertentu (biasanya 2 × floor(log2(n))), algoritma beralih ke heap sort yang menjamin O(n log n) di semua kasus. Untuk sub-array yang sangat kecil (kurang dari sekitar 16 elemen), insertion sort digunakan karena konstanta overhead yang sangat kecil.

Introsort diimplementasikan sebagai `std::sort` di C++ dan sebagai bagian dari Timsort Python, menjadikannya algoritma yang paling sering digunakan dalam praktik modern.

> **Tahukah Anda?**
>
> Python menggunakan **Timsort** sebagai implementasi `sorted()` dan `list.sort()`. Timsort diciptakan oleh Tim Peters pada tahun 2002 khusus untuk Python, kemudian diadopsi oleh Java (sejak Java 7) dan Android. Timsort adalah algoritma hybrid yang menggabungkan merge sort dengan insertion sort, dilengkapi dengan deteksi cerdas terhadap "run" (urutan elemen yang sudah terurut secara alami). Pada data dunia nyata yang seringkali memiliki urutan parsial, Timsort dapat mendekati kompleksitas O(n) — jauh melampaui O(n log n) yang menjadi batas teoritisnya.

### 10.4.4 Analisis Kompleksitas Quick Sort

**Kasus Terbaik — O(n log n):**

Terjadi ketika setiap pemilihan pivot menghasilkan partisi yang seimbang sempurna — pivot selalu mendarat tepat di posisi tengah array. Pohon rekursi memiliki kedalaman log2(n) dan di setiap level terdapat O(n) pekerjaan total. Relasi rekurensi identik dengan merge sort:

```
T(n) = 2 * T(n/2) + O(n)    =>    T(n) = O(n log n)   [Master Theorem Kasus 2]
```

**Kasus Rata-rata — O(n log n):**

Bahkan ketika partisi tidak selalu sempurna seimbang, quick sort tetap menghasilkan O(n log n) secara rata-rata. Analisis formal menggunakan indicator random variables (sebagaimana dipaparkan dalam CLRS) menunjukkan bahwa nilai ekspektasi jumlah perbandingan untuk quick sort dengan pivot acak adalah:

```
E[T(n)] = 2(n+1) * H(n) - 4n ≈ 2n ln(n) ≈ 1.39 * n * log2(n)
```

Di mana H(n) adalah bilangan harmonik ke-n. Konstanta 1,39 ini menunjukkan bahwa quick sort rata-rata memerlukan sekitar 39% lebih banyak perbandingan dibanding merge sort, namun karena overhead yang lebih kecil per operasi dan lokalitas cache yang lebih baik, quick sort seringkali lebih cepat secara aktual.

**Kasus Terburuk — O(n²):**

Terjadi ketika setiap operasi partisi menghasilkan sub-array yang sangat tidak seimbang: satu bagian kosong (0 elemen) dan satu bagian berisi n-1 elemen. Kondisi ini muncul ketika:
- Array sudah terurut naik dan pivot = elemen terakhir
- Array sudah terurut turun dan pivot = elemen pertama
- Semua elemen memiliki nilai yang sama

Relasi rekurensi pada kasus terburuk:

```
T(n) = T(n-1) + T(0) + O(n) = T(n-1) + O(n)
```

Dengan unrolling rekursi:

```
T(n) = O(n) + O(n-1) + O(n-2) + ... + O(1) = O(n * (n+1) / 2) = O(n²)
```

Pohon rekursi pada kasus ini berbentuk rantai linier dengan kedalaman n, bukan pohon logaritmik seperti kasus normal.

**Gambar 10.2 — Perbandingan Pohon Rekursi Quick Sort: Kasus Normal vs. Kasus Terburuk**

```
KASUS NORMAL (partisi seimbang, n=8):      KASUS TERBURUK (data terurut, n=5):
                                           pivot = elemen terakhir
        [n=8]                              [1,2,3,4,5], pivot=5
       /     \                             |
    [n=4]   [n=4]                          [] + [5] + [1,2,3,4], pivot=4
    / \     / \                            |
  [2] [2] [2] [2]                          [] + [4] + [1,2,3], pivot=3
  / \ / \ / \ / \                          |
 [1][1].......                             [] + [3] + [1,2], pivot=2
                                           |
 Kedalaman: log2(n) = 3                    [] + [2] + [1]
 Pekerjaan per level: O(n)                 |
 Total: O(n log n)                         [1] (basis)

                                           Kedalaman: n = 5
                                           Total pekerjaan: 5+4+3+2+1 = O(n^2)
```

### 10.4.5 Implementasi Python

```python
import random


def quick_sort_last_pivot(arr, kiri=0, kanan=None):
    """
    Quick sort dengan pivot = elemen terakhir (skema partisi Lomuto).

    Kompleksitas Waktu:
        Terbaik  : O(n log n)
        Rata-rata: O(n log n)
        Terburuk : O(n^2) -- pada array yang sudah terurut
    Kompleksitas Ruang: O(log n) call stack rata-rata, O(n) terburuk
    Stabil             : Tidak
    In-place           : Ya
    """
    if kanan is None:
        kanan = len(arr) - 1

    if kiri < kanan:
        # DIVIDE: partisi dan dapatkan posisi akhir pivot
        pos_pivot = _partisi_lomuto(arr, kiri, kanan)
        # CONQUER: rekursi pada sub-array kiri dan kanan
        quick_sort_last_pivot(arr, kiri, pos_pivot - 1)
        quick_sort_last_pivot(arr, pos_pivot + 1, kanan)


def _partisi_lomuto(arr, kiri, kanan):
    """
    Skema partisi Lomuto: pivot = elemen terakhir.
    Setelah fungsi ini selesai, pivot berada di posisi finalnya.
    Mengembalikan indeks posisi akhir pivot.
    """
    pivot = arr[kanan]
    i = kiri - 1  # indeks elemen terakhir yang <= pivot

    for j in range(kiri, kanan):
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]  # pindahkan elemen kecil ke kiri

    # Tempatkan pivot pada posisi yang benar (posisi i+1)
    arr[i + 1], arr[kanan] = arr[kanan], arr[i + 1]
    return i + 1


def quick_sort_random_pivot(arr, kiri=0, kanan=None):
    """
    Quick sort dengan pivot acak untuk menghindari kasus terburuk.
    Pivot dipilih secara acak dari rentang [kiri, kanan], lalu
    ditukar ke posisi terakhir sebelum prosedur partisi standar dijalankan.

    Kompleksitas Waktu  : O(n log n) dengan probabilitas tinggi
    Kompleksitas Ruang  : O(log n) call stack rata-rata
    """
    if kanan is None:
        kanan = len(arr) - 1

    if kiri < kanan:
        # Pilih indeks acak dan tukar ke posisi terakhir
        idx_acak = random.randint(kiri, kanan)
        arr[idx_acak], arr[kanan] = arr[kanan], arr[idx_acak]

        pos_pivot = _partisi_lomuto(arr, kiri, kanan)
        quick_sort_random_pivot(arr, kiri, pos_pivot - 1)
        quick_sort_random_pivot(arr, pos_pivot + 1, kanan)


def _median_of_three(arr, kiri, kanan):
    """
    Menentukan median dari arr[kiri], arr[tengah], arr[kanan].
    Sebagai efek samping, mengurutkan ketiga elemen tersebut di tempatnya.
    Mengembalikan nilai median yang dipindahkan ke posisi kanan-1.
    """
    tengah = (kiri + kanan) // 2

    # Urutkan tiga kandidat secara langsung (3 perbandingan maksimum)
    if arr[kiri] > arr[tengah]:
        arr[kiri], arr[tengah] = arr[tengah], arr[kiri]
    if arr[kiri] > arr[kanan]:
        arr[kiri], arr[kanan] = arr[kanan], arr[kiri]
    if arr[tengah] > arr[kanan]:
        arr[tengah], arr[kanan] = arr[kanan], arr[tengah]

    # arr[tengah] sekarang adalah median; pindahkan ke kanan-1 sebagai pivot
    arr[tengah], arr[kanan - 1] = arr[kanan - 1], arr[tengah]
    return arr[kanan - 1]


def quick_sort_median3(arr, kiri=0, kanan=None):
    """
    Quick sort dengan strategi median-of-three.
    Menggunakan insertion sort untuk sub-array kecil sebagai optimasi praktis.

    Kompleksitas Waktu  : O(n log n) rata-rata; menghindari O(n^2) untuk
                          data terurut naik atau turun
    Kompleksitas Ruang  : O(log n) call stack rata-rata
    """
    if kanan is None:
        kanan = len(arr) - 1

    # Gunakan insertion sort untuk sub-array kecil (optimasi empiris)
    if kanan - kiri < 10:
        _insertion_sort_partial(arr, kiri, kanan)
        return

    if kiri < kanan:
        pivot = _median_of_three(arr, kiri, kanan)

        # Skema partisi Hoare yang dimodifikasi
        i = kiri
        j = kanan - 1

        while True:
            i += 1
            while arr[i] < pivot:
                i += 1
            j -= 1
            while arr[j] > pivot:
                j -= 1
            if i >= j:
                break
            arr[i], arr[j] = arr[j], arr[i]

        # Kembalikan pivot ke posisi benar
        arr[i], arr[kanan - 1] = arr[kanan - 1], arr[i]

        quick_sort_median3(arr, kiri, i - 1)
        quick_sort_median3(arr, i + 1, kanan)


def _insertion_sort_partial(arr, kiri, kanan):
    """Insertion sort untuk sub-array arr[kiri..kanan] (inklusif)."""
    for i in range(kiri + 1, kanan + 1):
        kunci = arr[i]
        j = i - 1
        while j >= kiri and arr[j] > kunci:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = kunci


# Demonstrasi
if __name__ == "__main__":
    data = [38, 27, 43, 3, 9, 82, 10]

    a = data.copy()
    quick_sort_last_pivot(a)
    print("Quick sort (last pivot)   :", a)

    b = data.copy()
    quick_sort_random_pivot(b)
    print("Quick sort (random pivot) :", b)

    c = data.copy()
    quick_sort_median3(c)
    print("Quick sort (median-of-3)  :", c)

    # Demonstrasi kasus terburuk pada data terurut dengan last pivot
    data_terurut = list(range(1, 8))
    print("\nData terurut             :", data_terurut)
    quick_sort_last_pivot(data_terurut)
    print("Setelah sort (last pivot) :", data_terurut)
    # Catatan: pada data terurut, last pivot menghasilkan O(n^2) perbandingan
```

> **Studi Kasus: Kerentanan Algorithmic Complexity Attack pada Web Server**
>
> Pada tahun 2003, Alexander Klink dan Julian Wälde mendemonstrasi serangan **Denial of Service (DoS)** terhadap berbagai web framework populer (termasuk PHP, Python 2, Java, dan Ruby) yang memanfaatkan kasus terburuk hash table O(n²). Prinsip yang serupa berlaku untuk algoritma sorting: jika sebuah web server menggunakan quick sort dengan pivot tetap (misalnya elemen terakhir) untuk mengurutkan parameter request HTTP, penyerang dapat sengaja mengirimkan parameter yang sudah tersusun dalam urutan yang memicu kasus terburuk O(n²). Dengan mengirimkan sejumlah request berisi data terurut, penyerang dapat membuat server menghabiskan waktu komputasi yang ekstrem, efektif melumpuhkan layanan. Solusinya sederhana namun kritis: gunakan pivot acak atau strategi deterministic yang terbukti tidak dapat dieksploitasi melalui pola data masukan.

---

## 10.5 Melampaui Batas O(n log n): Algoritma Pengurutan Non-Perbandingan

### 10.5.1 Batas Bawah Teoritis Algoritma Berbasis Perbandingan

Sebelum membahas algoritma non-perbandingan, penting untuk memahami mengapa batas bawah O(n log n) berlaku bagi semua algoritma berbasis perbandingan. Bukti ini menggunakan model **pohon keputusan** (decision tree).

Setiap algoritma sorting berbasis perbandingan pada n elemen dapat direpresentasikan sebagai pohon biner di mana setiap simpul internal merepresentasikan satu perbandingan (misalnya "apakah A[i] <= A[j]?"), dan setiap daun merepresentasikan satu urutan output yang mungkin. Karena terdapat tepat n! permutasi berbeda dari n elemen, pohon keputusan harus memiliki setidaknya n! daun. Ketinggian pohon biner dengan L daun adalah setidaknya log2(L). Dengan demikian, ketinggian pohon keputusan adalah setidaknya log2(n!).

Menggunakan pendekatan Stirling, log2(n!) = Theta(n log n). Karena setiap daun dapat dicapai dari akar melalui jalur yang panjangnya sama dengan jumlah perbandingan, terdapat suatu masukan yang memerlukan setidaknya Omega(n log n) perbandingan. Ini membuktikan bahwa tidak ada algoritma berbasis perbandingan yang dapat berjalan lebih cepat dari O(n log n) pada kasus terburuk.

**Namun**, bukti ini hanya berlaku untuk algoritma yang menggunakan perbandingan sebagai satu-satunya cara mengakses informasi tentang elemen-elemen. Apabila kita memiliki informasi tambahan tentang rentang nilai atau struktur data — seperti mengetahui bahwa semua elemen adalah integer non-negatif dalam rentang tertentu — kita dapat merancang algoritma yang sama sekali tidak melakukan perbandingan dan beroperasi dalam waktu lebih cepat dari O(n log n).

### 10.5.2 Counting Sort: Pengurutan Berbasis Frekuensi

Counting sort memanfaatkan fakta bahwa elemen-elemen adalah integer non-negatif dalam rentang [0, k] yang diketahui. Alih-alih membandingkan elemen satu sama lain, counting sort menghitung berapa kali setiap nilai muncul, lalu menggunakan informasi hitungan tersebut untuk menempatkan setiap elemen langsung ke posisi yang tepat dalam array output.

**Algoritma Counting Sort (Versi Stabil):**

1. Temukan nilai maksimum k dalam array.
2. Buat array hitungan `count[0..k]`, inisialisasi semua nilai dengan 0.
3. **Hitung frekuensi:** Untuk setiap elemen `x` dalam array input, lakukan `count[x] += 1`. Setelah langkah ini, `count[x]` berisi berapa kali nilai x muncul dalam array.
4. **Hitung kumulatif (prefix sum):** Untuk setiap i dari 1 sampai k, lakukan `count[i] += count[i-1]`. Setelah langkah ini, `count[x]` berisi jumlah elemen yang bernilai lebih kecil atau sama dengan x, yang ekuivalen dengan posisi akhir (one-indexed) elemen terakhir dengan nilai x dalam output.
5. **Bangun array output (dari kanan ke kiri untuk stabilitas):** Iterasi array input dari indeks terakhir ke pertama. Untuk setiap elemen `arr[i]` dengan nilai `v`: lakukan `count[v] -= 1`, lalu tempatkan `arr[i]` di posisi `output[count[v]]`.

Mengapa iterasi dari kanan ke kiri penting untuk stabilitas? Karena dengan cara ini, elemen yang muncul lebih awal dalam array input (indeks lebih kecil) akan ditempatkan lebih awal pula dalam output ketika nilai mereka sama — mempertahankan urutan relatif aslinya.

**Gambar 10.3 — Trace Counting Sort untuk Array [4, 2, 2, 8, 3, 3, 1]**

```
Array input: A = [4, 2, 2, 8, 3, 3, 1],  k = 8

Langkah 1 -- Hitung frekuensi:
  Indeks:  0  1  2  3  4  5  6  7  8
  count:  [0, 1, 2, 2, 1, 0, 0, 0, 1]
  (Nilai 1 muncul 1x, nilai 2 muncul 2x, nilai 3 muncul 2x, dst.)

Langkah 2 -- Hitung kumulatif (prefix sum):
  count[0] = 0
  count[1] = 0 + 1 = 1   (ada 1 elemen bernilai <= 1)
  count[2] = 1 + 2 = 3   (ada 3 elemen bernilai <= 2)
  count[3] = 3 + 2 = 5   (ada 5 elemen bernilai <= 3)
  count[4] = 5 + 1 = 6   (ada 6 elemen bernilai <= 4)
  count[5] = 6 + 0 = 6
  count[6] = 6 + 0 = 6
  count[7] = 6 + 0 = 6
  count[8] = 6 + 1 = 7   (ada 7 elemen bernilai <= 8, yaitu semua elemen)

  Indeks:  0  1  2  3  4  5  6  7  8
  count:  [0, 1, 3, 5, 6, 6, 6, 6, 7]

Langkah 3 -- Bangun output (iterasi kanan ke kiri):
  i=6: A[6]=1, count[1]=1, output[0]=1, count[1] turun ke 0
       output: [1, _, _, _, _, _, _]
  i=5: A[5]=3, count[3]=5, output[4]=3, count[3] turun ke 4
       output: [1, _, _, _, 3, _, _]
  i=4: A[4]=3, count[3]=4, output[3]=3, count[3] turun ke 3
       output: [1, _, _, 3, 3, _, _]
  i=3: A[3]=8, count[8]=7, output[6]=8, count[8] turun ke 6
       output: [1, _, _, 3, 3, _, 8]
  i=2: A[2]=2, count[2]=3, output[2]=2, count[2] turun ke 2
       output: [1, _, 2, 3, 3, _, 8]
  i=1: A[1]=2, count[2]=2, output[1]=2, count[2] turun ke 1
       output: [1, 2, 2, 3, 3, _, 8]
  i=0: A[0]=4, count[4]=6, output[5]=4, count[4] turun ke 5
       output: [1, 2, 2, 3, 3, 4, 8]

HASIL AKHIR: [1, 2, 2, 3, 3, 4, 8]
```

**Analisis Kompleksitas Counting Sort:**
- Langkah 1 (hitung frekuensi): O(n)
- Langkah 2 (prefix sum): O(k)
- Langkah 3 (bangun output): O(n)
- **Total: O(n + k)**

Ketika k = O(n) — yaitu nilai maksimum sebanding dengan jumlah elemen — kompleksitas menjadi O(n), yakni **linear**. Ini jauh melampaui batas bawah O(n log n) yang berlaku untuk algoritma berbasis perbandingan.

**Batasan Counting Sort:**
1. Hanya berlaku untuk integer non-negatif (atau data yang dapat dipetakan ke integer non-negatif).
2. Tidak efisien ketika k >> n: mengurutkan 10 elemen dengan nilai maksimum 10^6 memerlukan array hitungan berukuran 10^6+1 — pemborosan memori yang ekstrem.
3. Tidak dapat langsung menangani floating-point, string, atau tipe data komposit tanpa transformasi.

### 10.5.3 Radix Sort: Pengurutan Berbasis Digit

Radix sort mengatasi keterbatasan counting sort pada rentang nilai yang sangat lebar dengan cara menguraikan pengurutan menjadi beberapa pass, masing-masing berdasarkan satu digit. Dengan demikian, kompleksitas tidak bergantung pada nilai maksimum k secara langsung, melainkan pada jumlah digit d = floor(log_b(k)) + 1 di mana b adalah basis yang digunakan.

Terdapat dua varian utama radix sort:

**LSD (Least Significant Digit) Radix Sort:** Memproses digit dari yang paling tidak signifikan (satuan) ke yang paling signifikan. Setiap pass harus menggunakan algoritma sorting yang **stabil** (biasanya counting sort) sebagai subrutin, agar urutan yang sudah dicapai pada pass sebelumnya tidak terganggu oleh pass berikutnya.

**MSD (Most Significant Digit) Radix Sort:** Memproses dari digit paling signifikan. Lebih natural untuk pengurutan string (leksikografis), tetapi implementasinya lebih kompleks karena memerlukan rekursi.

**Gambar 10.4 — Trace LSD Radix Sort untuk Array [170, 45, 75, 90, 802, 24, 2, 66]**

```
Array awal: [170, 45, 75, 90, 802, 24, 2, 66]

Pass 1 -- Urutkan berdasarkan digit satuan (exp=1, basis 10):
  Digit satuan masing-masing: [0, 5, 5, 0, 2, 4, 2, 6]
  Kelompok per digit:
    Digit 0: [170, 90]
    Digit 2: [802, 2]
    Digit 4: [24]
    Digit 5: [45, 75]
    Digit 6: [66]
  Setelah pass 1: [170, 90, 802, 2, 24, 45, 75, 66]
  (urutan dalam kelompok dipertahankan -- stabil!)

Pass 2 -- Urutkan berdasarkan digit puluhan (exp=10, basis 10):
  Digit puluhan masing-masing: [7, 9, 0, 0, 2, 4, 7, 6]
  Kelompok per digit:
    Digit 0: [802, 2]    (802 memiliki puluhan=0, demikian juga 2)
    Digit 2: [24]
    Digit 4: [45]
    Digit 6: [66]
    Digit 7: [170, 75]
    Digit 9: [90]
  Setelah pass 2: [802, 2, 24, 45, 66, 170, 75, 90]

Pass 3 -- Urutkan berdasarkan digit ratusan (exp=100, basis 10):
  Digit ratusan masing-masing: [8, 0, 0, 0, 0, 1, 0, 0]
  Kelompok per digit:
    Digit 0: [2, 24, 45, 66, 75, 90]
    Digit 1: [170]
    Digit 8: [802]
  Setelah pass 3: [2, 24, 45, 66, 75, 90, 170, 802]

HASIL AKHIR: [2, 24, 45, 66, 75, 90, 170, 802]
```

**Mengapa stabilitas sangat kritis dalam radix sort?** Perhatikan array setelah Pass 1: [170, 90, 802, 2, 24, 45, 75, 66]. Elemen 170 muncul sebelum 90, keduanya memiliki digit satuan 0. Setelah Pass 2, 170 harus muncul sebelum 75 (keduanya memiliki digit puluhan 7), dan ini baru benar jika Pass 2 menggunakan sorting yang stabil yang mempertahankan urutan relatif dari Pass 1. Jika Pass 2 tidak stabil, 75 bisa muncul sebelum 170, menghasilkan output yang salah.

**Analisis Kompleksitas Radix Sort:**
- Jumlah pass: d = floor(log_b(k)) + 1 = O(log_b(k))
- Biaya per pass (counting sort): O(n + b)
- **Total: O(d * (n + b))**

Jika k = n^c untuk suatu konstanta c (nilai elemen tidak terlalu jauh melampaui jumlah elemen), maka d = O(log n) dan total kompleksitas menjadi O(n log n). Namun jika jumlah digit d dianggap konstan (fixed-width integers), kompleksitas menjadi O(n) — linear.

### 10.5.4 Implementasi Python: Counting Sort dan Radix Sort

```python
def counting_sort(arr):
    """
    Mengurutkan array integer non-negatif menggunakan counting sort stabil.

    Parameter:
        arr (list): Array integer non-negatif yang akan diurutkan.
    Mengembalikan:
        list: Array baru yang sudah terurut secara menaik.

    Kompleksitas Waktu : O(n + k), k = nilai maksimum dalam arr
    Kompleksitas Ruang : O(n + k)
    Stabil             : Ya (karena iterasi output dari kanan ke kiri)
    """
    if not arr:
        return []

    k = max(arr)                   # nilai maksimum
    count = [0] * (k + 1)         # array hitungan

    for nilai in arr:              # hitung frekuensi
        count[nilai] += 1

    for i in range(1, k + 1):     # hitung prefix sum (kumulatif)
        count[i] += count[i - 1]

    output = [0] * len(arr)
    for i in range(len(arr) - 1, -1, -1):   # iterasi mundur untuk stabilitas
        nilai = arr[i]
        count[nilai] -= 1
        output[count[nilai]] = nilai

    return output


def radix_sort(arr):
    """
    Mengurutkan array integer non-negatif menggunakan LSD radix sort.

    Parameter:
        arr (list): Array integer non-negatif yang akan diurutkan.
    Mengembalikan:
        list: Array baru yang sudah terurut secara menaik.

    Kompleksitas Waktu : O(d * (n + 10)), d = jumlah digit terbanyak
    Kompleksitas Ruang : O(n + 10) per pass
    Stabil             : Ya (bergantung pada counting sort stabil sebagai subrutin)
    """
    if not arr:
        return []

    hasil = arr.copy()
    nilai_maks = max(hasil)

    exp = 1
    while nilai_maks // exp > 0:
        hasil = _counting_sort_by_digit(hasil, exp)
        exp *= 10

    return hasil


def _counting_sort_by_digit(arr, exp):
    """
    Counting sort stabil berdasarkan digit pada posisi tertentu.

    Parameter:
        arr (list): Array yang akan diurutkan.
        exp (int) : Eksponen posisi digit (1=satuan, 10=puluhan, dst.)
    """
    n = len(arr)
    output = [0] * n
    count = [0] * 10              # basis 10: digit 0 hingga 9

    for i in range(n):
        digit = (arr[i] // exp) % 10
        count[digit] += 1

    for i in range(1, 10):
        count[i] += count[i - 1]

    for i in range(n - 1, -1, -1):   # kanan ke kiri untuk stabilitas
        digit = (arr[i] // exp) % 10
        count[digit] -= 1
        output[count[digit]] = arr[i]

    return output


def radix_sort_verbose(arr):
    """Versi radix sort dengan output detail setiap pass untuk keperluan pembelajaran."""
    if not arr:
        return []

    hasil = arr.copy()
    nilai_maks = max(hasil)
    pass_ke = 1
    exp = 1

    print(f"Array awal: {hasil}")
    while nilai_maks // exp > 0:
        hasil = _counting_sort_by_digit(hasil, exp)
        nama_posisi = {1: "satuan", 10: "puluhan", 100: "ratusan"}
        posisi = nama_posisi.get(exp, f"10^{pass_ke-1}")
        print(f"  Pass {pass_ke} (digit {posisi}, exp={exp}): {hasil}")
        exp *= 10
        pass_ke += 1

    return hasil


# Demonstrasi
if __name__ == "__main__":
    data_cs = [4, 2, 2, 8, 3, 3, 1]
    print("Counting sort:", counting_sort(data_cs))

    data_rs = [170, 45, 75, 90, 802, 24, 2, 66]
    print("\n=== Radix Sort ===")
    hasil = radix_sort_verbose(data_rs)
    print(f"Hasil akhir: {hasil}")
```

---

## 10.6 Perbandingan Menyeluruh Semua Algoritma Sorting

Setelah mempelajari semua algoritma sorting dari bab-bab sebelumnya hingga bab ini, kini saatnya merangkum karakteristik masing-masing dalam satu tabel komprehensif untuk memudahkan pemilihan algoritma yang tepat.

**Tabel 10.2 — Perbandingan Komprehensif Semua Algoritma Sorting**

| Algoritma | Kasus Terbaik | Kasus Rata-rata | Kasus Terburuk | Ruang | Stabil | In-place | Strategi | Catatan Praktis |
|-----------|--------------|-----------------|----------------|-------|--------|----------|----------|-----------------|
| Bubble Sort | O(n) | O(n²) | O(n²) | O(1) | Ya | Ya | Exchange | Kasus terbaik hanya jika sudah hampir terurut dengan flag optimasi; tidak praktis untuk data besar |
| Selection Sort | O(n²) | O(n²) | O(n²) | O(1) | Tidak | Ya | Selection | Jumlah swap minimal O(n); cocok bila operasi tulis (write) sangat mahal |
| Insertion Sort | O(n) | O(n²) | O(n²) | O(1) | Ya | Ya | Insertion | Sangat efisien untuk n < 20 atau data hampir terurut; digunakan sebagai komponen Timsort |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Ya | Tidak | Divide & Conquer | Konsisten di semua kasus; ideal untuk linked list dan pengurutan data eksternal |
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) | Tidak | Ya | Divide & Conquer | Tercepat dalam praktik untuk array acak; gunakan pivot acak atau median-of-three |
| Counting Sort | O(n + k) | O(n + k) | O(n + k) | O(n + k) | Ya | Tidak | Non-comparison | Hanya integer non-negatif; sangat efisien bila k = O(n) |
| Radix Sort | O(d(n+b)) | O(d(n+b)) | O(d(n+b)) | O(n + b) | Ya | Tidak | Non-comparison | Efektif untuk integer dengan rentang nilai lebar; b = basis (umumnya 10) |
| Heap Sort | O(n log n) | O(n log n) | O(n log n) | O(1) | Tidak | Ya | Selection (heap) | O(n log n) terburuk dengan O(1) ruang; tidak sebaik quick sort karena lokalitas cache buruk |
| Timsort | O(n) | O(n log n) | O(n log n) | O(n) | Ya | Tidak | Hybrid (Merge+Insertion) | Digunakan Python, Java, Android; sangat baik untuk data nyata yang sering memiliki urutan parsial |

Keterangan:
- **k**: nilai maksimum elemen untuk counting sort
- **d**: jumlah digit untuk radix sort
- **b**: basis (radix), umumnya 10
- **Stabil**: elemen dengan kunci yang sama mempertahankan urutan relatif aslinya
- **In-place**: beroperasi tanpa memori tambahan yang proporsional terhadap n (O(1) atau O(log n) untuk call stack diterima)

### 10.6.1 Panduan Pemilihan Algoritma Berdasarkan Konteks

Tidak ada algoritma sorting yang superior untuk semua skenario. Pemilihan yang tepat memerlukan pertimbangan kontekstual:

**Ukuran data kecil (n <= 20):** Gunakan insertion sort. Meskipun O(n²), overhead rekursi algoritma O(n log n) menjadikannya tidak kompetitif pada skala ini. Konstanta yang sangat kecil dalam insertion sort mengalahkan kompleksitas asimtotik yang lebih baik.

**Data hampir terurut:** Gunakan insertion sort atau Timsort (built-in Python). Insertion sort mencapai O(n) pada data yang sudah sepenuhnya terurut, dan mendekati O(nk) di mana k adalah jumlah inversi — sangat efisien ketika jumlah inversi kecil.

**Memori sangat terbatas:** Gunakan quick sort (in-place) atau heap sort. Merge sort mengonsumsi O(n) memori tambahan yang mungkin tidak tersedia dalam lingkungan embedded atau sistem dengan RAM terbatas.

**Stabilitas diperlukan:** Gunakan merge sort, counting sort, radix sort, atau Timsort. Quick sort dan heap sort bersifat tidak stabil. Stabilitas penting dalam skenario seperti mengurutkan tabel berdasarkan kolom kedua setelah sebelumnya diurutkan berdasarkan kolom pertama.

**Data integer dalam rentang terbatas (k = O(n)):** Gunakan counting sort untuk kecepatan linear O(n + k).

**Data integer dengan rentang lebar:** Gunakan radix sort dengan basis yang sesuai. Efektif untuk mengurutkan angka 64-bit atau data lain yang memiliki banyak digit tetapi jumlah digit tetap konstan.

**Kasus umum tanpa asumsi khusus:** Gunakan quick sort dengan pivot acak atau median-of-three, atau cukup gunakan Timsort Python (`sorted()` atau `.sort()`).

**Data eksternal (tidak muat di memori RAM):** Gunakan merge sort atau varian external merge sort. Pola aksesnya yang sekuensial sangat ramah terhadap I/O disk, tidak seperti quick sort yang memerlukan akses acak.

**Keamanan terhadap serangan adversarial:** Gunakan pivot acak (random pivot) atau Timsort. Jangan gunakan pivot tetap pada sistem yang menerima input dari pengguna yang tidak dipercaya.

### 10.6.2 Benchmark Empiris: Perbandingan Performa Python

Kode berikut mendemonstrasikan cara membandingkan performa empiris berbagai algoritma sorting dalam Python:

```python
import time
import random


def benchmark_sorting(n=10000):
    """
    Membandingkan performa empiris semua algoritma sorting.

    Parameter:
        n (int): Jumlah elemen untuk pengujian.
    """
    data_acak = [random.randint(0, n) for _ in range(n)]

    algoritma = {
        "Merge Sort"             : lambda a: merge_sort(a.copy()),
        "Quick Sort (Acak)"      : lambda a: _qs_random(a.copy()),
        "Counting Sort"          : lambda a: counting_sort(a.copy()),
        "Radix Sort"             : lambda a: radix_sort(a.copy()),
        "Python Built-in sorted" : lambda a: sorted(a),
    }

    print(f"\nBenchmark Sorting: n = {n:,} elemen")
    print(f"{'Algoritma':<28} {'Waktu (detik)':>15}")
    print("-" * 45)

    for nama, fungsi in algoritma.items():
        mulai = time.perf_counter()
        _ = fungsi(data_acak)
        selesai = time.perf_counter()
        print(f"{nama:<28} {selesai - mulai:>15.6f}")


def _qs_random(arr):
    """Pembungkus quick sort random untuk keperluan benchmark."""
    quick_sort_random_pivot(arr, 0, len(arr) - 1)
    return arr


if __name__ == "__main__":
    benchmark_sorting(n=50000)
```

---

## 10.7 Algoritma Sorting Adaptif: Smart Sort

Pemahaman mendalam tentang karakteristik masing-masing algoritma sorting memungkinkan perancangan algoritma **adaptif** yang secara otomatis mendeteksi sifat data masukan dan memilih strategi pengurutan yang paling efisien. Ini merupakan pendekatan yang sama yang mendasari desain Timsort.

```python
def smart_sort(arr):
    """
    Algoritma sorting adaptif yang memilih strategi terbaik
    berdasarkan karakteristik data yang dideteksi secara dinamis.

    Parameter:
        arr (list): Array yang akan diurutkan.
    Mengembalikan:
        list: Array baru yang terurut secara menaik.
    """
    if not arr or len(arr) <= 1:
        return arr.copy()

    n = len(arr)

    # Keputusan 1: Array sangat kecil -- gunakan insertion sort
    # Justifikasi: overhead rekursi O(n log n) tidak sebanding untuk n kecil.
    if n <= 20:
        return _insertion_sort_copy(arr)

    # Keputusan 2: Cek apakah semua elemen integer non-negatif
    adalah_int_nonnegatif = all(isinstance(x, int) and x >= 0 for x in arr)

    if adalah_int_nonnegatif:
        k = max(arr)
        rasio_k_n = k / n

        # Keputusan 3: k/n <= 10 -- counting sort mendekati O(n)
        if rasio_k_n <= 10:
            return counting_sort(arr)

        # Keputusan 4: k/n <= 1000 -- radix sort lebih baik dari merge sort
        elif rasio_k_n <= 1000:
            return radix_sort(arr)

    # Keputusan 5: Deteksi data hampir terurut melalui sampling
    inversi_sampel = 0
    langkah = max(1, n // 20)     # ambil ~20 sampel
    for i in range(0, n - langkah, langkah):
        if arr[i] > arr[i + langkah]:
            inversi_sampel += 1

    # Jika < 10% sampel adalah inversi, gunakan insertion sort
    if inversi_sampel <= 2:
        return _insertion_sort_copy(arr)

    # Keputusan 6: Default -- merge sort menjamin O(n log n) semua kasus
    return merge_sort(arr)


def _insertion_sort_copy(arr):
    """Insertion sort yang mengembalikan salinan array terurut."""
    hasil = arr.copy()
    for i in range(1, len(hasil)):
        kunci = hasil[i]
        j = i - 1
        while j >= 0 and hasil[j] > kunci:
            hasil[j + 1] = hasil[j]
            j -= 1
        hasil[j + 1] = kunci
    return hasil
```

---

## Rangkuman Bab

1. **Paradigma divide-and-conquer** menyelesaikan masalah melalui tiga tahap berurutan: Divide (membagi masalah menjadi sub-masalah yang lebih kecil), Conquer (menyelesaikan sub-masalah secara rekursif), dan Combine (menggabungkan solusi sub-masalah). Relasi rekurensi yang dihasilkan umumnya berbentuk T(n) = aT(n/b) + f(n), dan dapat diselesaikan menggunakan Master Theorem.

2. **Merge sort** menjamin kompleksitas waktu O(n log n) pada semua kasus (terbaik, rata-rata, dan terburuk), bersifat stabil, dan sangat cocok untuk pengurutan data eksternal serta linked list. Keunggulan konsistensinya diimbangi oleh kebutuhan memori tambahan O(n) untuk prosedur merge. Kompleksitas ini diturunkan dari rekurensi T(n) = 2T(n/2) + O(n) menggunakan Kasus 2 Master Theorem.

3. **Quick sort** adalah algoritma in-place dengan kompleksitas rata-rata O(n log n) yang sangat efisien secara empiris karena konstanta kecil dan lokalitas cache yang baik. Kasus terburuk O(n²) dipicu oleh partisi yang tidak seimbang, yang dapat dihindari secara efektif dengan penggunaan pivot acak atau strategi median-of-three. Pada sistem produksi modern, introsort — hybrid quick sort, heap sort, dan insertion sort — menjadi pilihan standar.

4. **Batas bawah teoritis O(n log n)** berlaku bagi semua algoritma berbasis perbandingan, dibuktikan melalui model pohon keputusan yang menunjukkan bahwa ketinggian pohon dengan n! daun minimal adalah Omega(n log n). Algoritma non-perbandingan dapat melampaui batas ini dengan memanfaatkan informasi struktural tentang data.

5. **Counting sort** beroperasi dalam O(n + k) dengan memanfaatkan distribusi nilai integer, mencapai kompleksitas linear ketika k = O(n). Stabilitas diperoleh dengan mengiterasi array input dari kanan ke kiri saat membangun output. Algoritma ini tidak efisien ketika nilai maksimum k jauh melampaui jumlah elemen n.

6. **Radix sort** menguraikan pengurutan integer menjadi d pass berdasarkan digit, masing-masing menggunakan counting sort yang stabil. Kompleksitasnya O(d(n + b)) efektif untuk dataset integer berskala besar dengan jumlah digit yang terbatas. Stabilitas counting sort sebagai subrutin adalah prasyarat mutlak untuk kebenaran radix sort.

7. **Pemilihan algoritma sorting yang tepat** merupakan keputusan rekayasa yang bergantung pada ukuran data, distribusi nilai, ketersediaan memori, kebutuhan stabilitas, karakteristik distribusi, dan kebutuhan keamanan. Tidak ada satu algoritma yang optimal untuk semua skenario; pemahaman mendalam tentang trade-off setiap algoritma adalah kompetensi esensial bagi setiap insinyur perangkat lunak.

---

## Istilah Kunci

1. **Divide-and-conquer**: Paradigma perancangan algoritma yang memecah masalah menjadi sub-masalah lebih kecil, menyelesaikannya secara rekursif, lalu menggabungkan hasilnya.
2. **Relasi rekurensi** (recurrence relation): Persamaan yang mendefinisikan nilai fungsi berdasarkan nilai fungsi tersebut pada argumen yang lebih kecil; digunakan untuk mengekspresikan kompleksitas algoritma rekursif.
3. **Master Theorem**: Teorema yang menyediakan solusi asimtotik untuk relasi rekurensi berbentuk T(n) = aT(n/b) + f(n) berdasarkan perbandingan f(n) dengan n^(log_b(a)).
4. **Pohon rekursi** (recursion tree): Representasi visual struktur panggilan rekursif suatu algoritma, berguna untuk menganalisis kompleksitas totalnya secara intuitif.
5. **Merge sort**: Algoritma sorting divide-and-conquer yang membagi array menjadi dua bagian, mengurutkan masing-masing secara rekursif, lalu menggabungkannya; menjamin O(n log n) di semua kasus.
6. **Prosedur merge**: Subrutin inti merge sort yang menggabungkan dua array terurut menjadi satu array terurut dalam O(n).
7. **Quick sort**: Algoritma sorting divide-and-conquer yang bekerja in-place melalui prosedur partisi; O(n log n) rata-rata, O(n²) terburuk.
8. **Partisi** (partition): Operasi inti quick sort yang menyusun ulang elemen-elemen array sehingga semua elemen lebih kecil dari pivot berada di kiri dan semua elemen lebih besar berada di kanan.
9. **Pivot**: Elemen yang dipilih sebagai acuan dalam prosedur partisi quick sort; pilihan pivot menentukan kualitas partisi dan performa algoritma.
10. **Skema partisi Lomuto**: Algoritma partisi yang menggunakan elemen terakhir sebagai pivot dan satu pointer yang bergerak maju; lebih mudah dipahami namun sedikit lebih lambat dari skema Hoare.
11. **Skema partisi Hoare**: Algoritma partisi asli yang diusulkan C.A.R. Hoare; menggunakan dua pointer yang bergerak dari kedua ujung menuju tengah; umumnya lebih efisien dari skema Lomuto.
12. **Median-of-three**: Strategi pemilihan pivot quick sort yang mengambil median dari elemen pertama, tengah, dan terakhir; menghilangkan kasus terburuk untuk data yang sudah terurut.
13. **Introsort**: Algoritma hybrid yang menggabungkan quick sort, heap sort, dan insertion sort; menjamin O(n log n) kasus terburuk sambil mempertahankan performa praktis quick sort.
14. **Batas bawah sorting** (sorting lower bound): Bukti bahwa setiap algoritma sorting berbasis perbandingan memerlukan Omega(n log n) perbandingan pada kasus terburuk.
15. **Pohon keputusan** (decision tree): Model abstrak algoritma sorting berbasis perbandingan; digunakan dalam pembuktian batas bawah O(n log n).
16. **Algoritma non-perbandingan** (non-comparison sort): Algoritma sorting yang tidak menggunakan perbandingan langsung antar elemen, sehingga dapat melampaui batas bawah O(n log n).
17. **Counting sort**: Algoritma sorting non-perbandingan untuk integer non-negatif yang bekerja dalam O(n + k) dengan memanfaatkan array hitungan.
18. **Prefix sum** (cumulative sum): Transformasi array yang mengubah setiap elemen menjadi jumlah kumulatif semua elemen sebelumnya; digunakan dalam counting sort untuk menentukan posisi akhir setiap elemen.
19. **Radix sort**: Algoritma sorting non-perbandingan yang mengurutkan integer digit per digit menggunakan counting sort stabil sebagai subrutin.
20. **LSD Radix Sort** (Least Significant Digit): Varian radix sort yang memproses dari digit paling tidak signifikan ke paling signifikan; lebih umum digunakan untuk array integer.
21. **Stabilitas sorting** (sort stability): Properti algoritma sorting di mana elemen dengan kunci yang sama mempertahankan urutan relatif mereka dari array input; penting dalam pengurutan multi-kriteria.
22. **In-place sorting**: Algoritma sorting yang beroperasi tanpa memerlukan memori tambahan yang proporsional terhadap n; hanya menggunakan O(1) atau O(log n) memori tambahan.

---

## Soal Latihan

### Soal Pemahaman dan Analisis (C2 — C4)

**Soal 1 [C2 — Memahami]**
Perhatikan relasi rekurensi berikut: T(n) = 2T(n/2) + Theta(n).

a) Identifikasi nilai a, b, dan f(n) dari relasi tersebut.
b) Hitung n^(log_b(a)) dan bandingkan dengan f(n).
c) Tentukan kasus Master Theorem yang berlaku dan tuliskan solusi asimtotiknya.
d) Algoritma sorting manakah yang menghasilkan relasi rekurensi ini? Jelaskan mengapa.

---

**Soal 2 [C2 — Memahami]**
Jelaskan dengan bahasa Anda sendiri mengapa merge sort bersifat stabil sedangkan quick sort (dengan skema Lomuto) tidak stabil. Dalam kondisi apa sifat stabilitas suatu algoritma sorting menjadi kritis? Berikan minimal dua contoh skenario nyata.

---

**Soal 3 [C3 — Menerapkan]**
Diberikan array `A = [10, 80, 30, 90, 40, 50, 70]`.

a) Gambarkan pohon rekursi lengkap merge sort untuk array ini, termasuk fase divide dan fase merge dengan semua langkah penggabungan secara detail.
b) Hitung total jumlah perbandingan yang dilakukan selama seluruh proses merge.
c) Bandingkan jumlah perbandingan aktual dengan batas atas teoritis n * ceil(log2(n)).

---

**Soal 4 [C3 — Menerapkan]**
Lakukan trace lengkap satu langkah partisi Lomuto pada sub-array `[5, 3, 8, 4, 2, 7, 1, 6]` dengan pivot = elemen terakhir.

a) Tunjukkan keadaan array setelah setiap operasi swap.
b) Identifikasi posisi akhir pivot setelah partisi.
c) Tuliskan dua sub-array yang akan diproses pada langkah rekursif berikutnya.

---

**Soal 5 [C3 — Menerapkan]**
Lakukan trace lengkap counting sort pada array `A = [3, 6, 4, 1, 3, 4, 1, 4]`.

a) Tunjukkan isi array `count` setelah langkah hitung frekuensi.
b) Tunjukkan isi array `count` setelah langkah prefix sum.
c) Tunjukkan proses pembangunan array output langkah demi langkah (dari kanan ke kiri).
d) Verifikasi bahwa algoritma bersifat stabil dengan melacak posisi akhir dua elemen bernilai 4 yang pertama.

---

**Soal 6 [C3 — Menerapkan]**
Lakukan trace lengkap LSD radix sort pada array `[329, 457, 657, 839, 436, 720, 355]`.

a) Tunjukkan keadaan array setelah setiap pass (satuan, puluhan, ratusan).
b) Jelaskan mengapa urutan relatif elemen-elemen dengan digit satuan yang sama pada Pass 1 harus dipertahankan dengan benar pada Pass 2.

---

**Soal 7 [C4 — Menganalisis]**
Jelaskan secara matematis mengapa quick sort dengan pivot = elemen terakhir menghasilkan kasus terburuk O(n²) pada array yang sudah terurut secara menaik.

a) Turunkan relasi rekurensi yang terjadi pada kondisi ini.
b) Selesaikan relasi rekurensi tersebut menggunakan metode unrolling untuk mendapatkan O(n²).
c) Gambarkan pohon rekursi untuk input `[1, 2, 3, 4, 5]` dan identifikasi mengapa pohon ini tidak berbentuk logaritmik.

---

**Soal 8 [C4 — Menganalisis]**
Dua relasi rekurensi berikut diberikan:

- Relasi I: T(n) = 4T(n/2) + Theta(n)
- Relasi II: T(n) = 2T(n/2) + Theta(n²)

Untuk masing-masing relasi:
a) Identifikasi kasus Master Theorem yang berlaku (tunjukkan perhitungan n^(log_b(a)) dan perbandingan dengan f(n)).
b) Tuliskan solusi asimtotiknya.
c) Beri contoh algoritma nyata (tidak harus algoritma sorting) yang menghasilkan relasi serupa.

---

### Soal Evaluasi dan Perancangan (C5 — C6)

**Soal 9 [C5 — Mengevaluasi]**
Sebuah perusahaan fintech memiliki dua kebutuhan pengurutan data:

**Skenario A:** Mengurutkan 8 juta catatan transaksi berdasarkan `transaction_id` (integer 64-bit, rentang 0 hingga 10^15) secara real-time setiap 5 menit. Stabilitas tidak diperlukan. RAM tersedia sebesar 16 GB. Latensi adalah prioritas utama.

**Skenario B:** Mengurutkan 300 nama nasabah berdasarkan kode nasabah (integer 1 hingga 999) pada halaman antarmuka web. Stabilitas diperlukan (nasabah dengan kode sama harus ditampilkan dalam urutan pendaftaran aslinya). Memori sangat terbatas (hanya 512 KB tersedia).

Untuk masing-masing skenario:
a) Evaluasi semua algoritma yang relevan berdasarkan kompleksitas waktu, kompleksitas ruang, dan stabilitas.
b) Tentukan algoritma yang paling tepat dengan justifikasi yang lengkap.
c) Identifikasi satu kelemahan potensial dari pilihan Anda dan bagaimana mengatasinya.

---

**Soal 10 [C5 — Mengevaluasi]**
Seorang pengembang mengklaim bahwa ia dapat mengurutkan array berisi 1 juta integer acak dalam rentang 1 hingga 1000 menggunakan counting sort dalam waktu lebih cepat dari merge sort. Evaluasi klaim ini:

a) Hitung estimasi jumlah operasi counting sort: O(n + k) untuk n = 10^6, k = 1000.
b) Hitung estimasi jumlah operasi merge sort: O(n log n) untuk n = 10^6.
c) Apakah klaim tersebut valid secara teoritis? Jelaskan alasannya.
d) Apakah ada batasan lain (selain kompleksitas waktu) yang perlu dipertimbangkan untuk kasus ini?

---

**Soal 11 [C6 — Mencipta]**
Rancang sebuah variasi merge sort yang disebut "Bottom-up Merge Sort" (tanpa rekursi). Alih-alih membagi array dari atas ke bawah secara rekursif, algoritma ini mulai dari bawah: pertama menggabungkan pasangan elemen yang bersebelahan, kemudian menggabungkan pasangan sub-array berukuran 2, lalu berukuran 4, dan seterusnya.

a) Tuliskan pseudocode atau implementasi Python lengkap untuk Bottom-up Merge Sort.
b) Buktikan bahwa algoritma ini memiliki kompleksitas waktu O(n log n) dan kompleksitas ruang O(n).
c) Bandingkan keunggulan dan kelemahan Bottom-up Merge Sort dibandingkan rekursif Merge Sort.
d) Dalam skenario apa Bottom-up Merge Sort lebih disukai?

---

**Soal 12 [C6 — Mencipta]**
Rancang algoritma `multi_key_sort(data, keys)` yang mengurutkan daftar dictionary berdasarkan beberapa kunci (multi-key sort) menggunakan prinsip sorting stabil secara berurutan (radix sort untuk kunci komposit).

Contoh input: `data = [{"nama": "Budi", "usia": 25}, {"nama": "Ani", "usia": 30}, {"nama": "Citra", "usia": 25}]`, `keys = ["usia", "nama"]` (urutkan berdasarkan usia terlebih dahulu, lalu nama untuk usia yang sama).

a) Jelaskan strategi pengurutan multi-kunci menggunakan prinsip "sort by least significant key first" (prinsip yang sama dengan LSD radix sort).
b) Implementasikan fungsi `multi_key_sort` dalam Python.
c) Uji fungsi Anda dengan contoh data di atas dan verifikasi hasilnya.
d) Jelaskan mengapa setiap tahap pengurutan harus menggunakan algoritma yang stabil.

---

## Bacaan Lanjutan

1. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022). *Introduction to Algorithms* (4th ed.). MIT Press. Bab 7: Quicksort (hal. 182–209) dan Bab 8: Sorting in Linear Time (hal. 210–232).**

   Referensi paling otoritatif untuk analisis formal algoritma sorting. Bab 7 memaparkan analisis probabilistik quick sort menggunakan indicator random variables secara lengkap, termasuk derivasi ekspektasi jumlah perbandingan. Bab 8 membuktikan batas bawah Omega(n log n) melalui model pohon keputusan dan membahas counting sort, radix sort, serta bucket sort secara formal dengan semua bukti kompleksitas.

2. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013). *Data Structures and Algorithms in Python*. John Wiley & Sons. Bab 12: Sorting and Selection (hal. 545–606).**

   Buku referensi yang menggunakan Python sebagai bahasa implementasi, sangat relevan untuk kelas ini. Bab 12 membahas merge sort, quick sort, dan bucket sort dengan implementasi Python yang bersih dan lengkap. Buku ini juga membahas topik lanjutan seperti selection algorithm (menemukan elemen ke-k terkecil) yang berkaitan erat dengan prosedur partisi quick sort.

3. **Skiena, S. S. (2020). *The Algorithm Design Manual* (3rd ed.). Springer. Bab 4: Sorting and Searching (hal. 107–153).**

   Buku yang menekankan perspektif praktis dan intuisi engineering, bukan hanya bukti formal. Skiena memberikan panduan konkret tentang kapan setiap algoritma sorting menjadi pilihan optimal berdasarkan karakteristik masalah nyata. Buku ini juga memuat katalog masalah algoritmik yang luas, menjadikannya bacaan yang sangat berharga bagi praktisi.

4. **Sedgewick, R., & Wayne, K. (2011). *Algorithms* (4th ed.). Addison-Wesley Professional. Bab 2: Sorting (hal. 244–341).**

   Penyajian sorting yang sangat komprehensif dengan banyak visualisasi intuitif dan analisis empiris. Buku ini membahas tidak hanya algoritma dasar tetapi juga optimasi praktis dan varian-varian penting. Sedgewick juga memperkenalkan 3-way quicksort (Dutch National Flag problem) yang sangat efisien untuk data dengan banyak nilai duplikat.

5. **Kleinberg, J., & Tardos, E. (2005). *Algorithm Design*. Pearson. Bab 5: Divide and Conquer (hal. 210–265).**

   Membahas paradigma divide-and-conquer secara formal dan mendalam, termasuk Master Theorem dengan bukti yang lengkap dan elegan. Buku ini menggunakan merge sort sebagai contoh utama namun juga membahas aplikasi divide-and-conquer pada masalah lain seperti perhitungan integer besar dan closest pair of points, memberikan perspektif yang lebih luas tentang kekuatan paradigma ini.

6. **Peters, T. (2002). *Timsort*. Python Documentation / PEP.**
   Tersedia di: https://hg.python.org/cpython/file/tip/Objects/listsort.txt

   Dokumen teknis asli yang ditulis Tim Peters menjelaskan desain dan motivasi Timsort secara mendetail. Dokumen ini membahas mengapa algoritma hybrid diperlukan, bagaimana "run" alami dalam data nyata dapat dieksploitasi, dan berbagai optimasi yang membuat Timsort efisien untuk data dunia nyata. Dokumen ini merupakan bacaan yang sangat informatif bagi siapa saja yang ingin memahami mengapa `sorted()` Python sangat efisien.

7. **Knuth, D. E. (1998). *The Art of Computer Programming, Volume 3: Sorting and Searching* (2nd ed.). Addison-Wesley. Bab 5: Sorting.**

   Karya monumental yang merupakan analisis paling mendalam dan komprehensif tentang algoritma sorting yang pernah ditulis. Knuth memberikan analisis matematika yang sangat teliti, termasuk derivasi eksak (bukan hanya asimtotik) jumlah perbandingan untuk berbagai algoritma. Meskipun notasi dan gaya penulisannya agak kuno, buku ini tetap menjadi referensi definitif bagi mereka yang ingin memahami sorting pada tingkat matematis yang paling dalam.

8. **Blelloch, G. E. (2010). *Prefix Sums and Their Applications*. Carnegie Mellon University Technical Report CMU-CS-90-190.**

   Makalah teknis yang membahas teknik prefix sum (cumulative sum) secara mendalam, beserta berbagai aplikasinya di luar sorting. Prefix sum adalah primitif komputasi yang fundamental yang muncul dalam counting sort, radix sort, dan banyak algoritma paralel. Makalah ini memberikan perspektif yang lebih luas tentang pentingnya teknik ini dalam komputasi modern, termasuk implementasi parallel prefix sum pada GPU yang menjadi dasar banyak operasi komputasi paralel.

---

*Bab ini merupakan bagian dari buku "Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python", disusun untuk Program Studi Informatika, Institut Bisnis dan Teknologi Indonesia (INSTIKI). Semua implementasi kode menggunakan Python 3.x dan telah diuji dengan Python 3.11.*

*Tanggal penyusunan: 10 April 2026*
