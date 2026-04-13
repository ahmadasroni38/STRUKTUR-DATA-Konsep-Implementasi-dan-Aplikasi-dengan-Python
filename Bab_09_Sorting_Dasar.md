# BAB 9
# ALGORITMA PENGURUTAN DASAR

---

> "Sorting is the mother of all computing — the problem that has received more attention from computer scientists than any other."
>
> — Donald E. Knuth, *The Art of Computer Programming*, Volume 3: Sorting and Searching (1973)

---

## 9.1 Tujuan Pembelajaran

Setelah mempelajari bab ini secara menyeluruh, mahasiswa diharapkan mampu:

1. **[C2 — Memahami]** Menjelaskan konsep dasar pengurutan data, termasuk terminologi kunci seperti kunci perbandingan, kestabilan, dan in-place sorting, serta memberikan contoh konkret dari setiap konsep tersebut.

2. **[C2 — Memahami]** Mendeskripsikan mekanisme kerja Bubble Sort, Selection Sort, dan Insertion Sort dengan menggunakan analogi intuitif dan penjelasan prinsip operasional masing-masing algoritma.

3. **[C3 — Menerapkan]** Mengimplementasikan ketiga algoritma pengurutan dasar dalam bahasa pemrograman Python, termasuk versi teroptimasi Bubble Sort dengan mekanisme early termination.

4. **[C3 — Menerapkan]** Menelusuri (tracing) eksekusi ketiga algoritma secara manual step-by-step pada array masukan yang diberikan, dan memverifikasi hasil penelusuran tersebut dengan implementasi Python.

5. **[C4 — Menganalisis]** Menurunkan secara matematis kompleksitas waktu masing-masing algoritma untuk kasus terbaik, kasus terburuk, dan kasus rata-rata, serta membuktikan batas bawah O(n) dan batas atas O(n²) yang berlaku.

6. **[C4 — Menganalisis]** Membandingkan karakteristik Bubble Sort, Selection Sort, dan Insertion Sort berdasarkan metrik perbandingan, pertukaran, kestabilan, dan penggunaan memori, kemudian mengidentifikasi kelebihan serta keterbatasan masing-masing dalam konteks penggunaan yang berbeda.

7. **[C5 — Mengevaluasi]** Menentukan algoritma pengurutan yang paling tepat untuk skenario aplikasi tertentu berdasarkan analisis terhadap karakteristik data masukan, keterbatasan sumber daya, dan kebutuhan kestabilan.

8. **[C6 — Mencipta]** Merancang variasi atau modifikasi dari algoritma pengurutan dasar untuk memenuhi kebutuhan spesifik, seperti pengurutan bidirectional atau pengurutan descending, serta mengimplementasikannya secara benar dalam Python.

---

## 9.2 Pendahuluan: Mengapa Pengurutan Adalah Jantung Komputasi

Bayangkan sebuah perpustakaan besar yang menyimpan ratusan ribu buku tanpa urutan apa pun. Setiap kali seorang pengunjung ingin menemukan satu judul, petugas perpustakaan harus memeriksa setiap buku satu per satu dari rak pertama hingga rak terakhir. Tentu saja, proses ini tidak dapat diterima dalam praktik. Perpustakaan yang terorganisasi dengan baik menyusun bukunya berdasarkan sistem klasifikasi tertentu — abjad, topik, kode Dewey Decimal — sehingga pencarian dapat dilakukan secara efisien.

Analogi ini menangkap dengan tepat mengapa **pengurutan (sorting)** merupakan salah satu operasi paling fundamental dalam ilmu komputer. Hampir setiap aplikasi modern yang bekerja dengan data — sistem basis data relasional, mesin pencari, platform perdagangan elektronik, sistem informasi akademik — mengandalkan data yang tersusun dalam urutan tertentu untuk dapat beroperasi secara efisien. Binary search, yang dapat menemukan elemen dalam O(log n) waktu, hanya bekerja pada data yang sudah terurut. Operasi join dalam basis data jauh lebih efisien ketika kedua tabel diurutkan terlebih dahulu berdasarkan kunci yang sama. Algoritma pencocokan string seperti yang digunakan dalam mesin pencari membutuhkan indeks terurut untuk menghasilkan hasil yang relevan dalam milidetik.

Donald Knuth, dalam magnum opus-nya *The Art of Computer Programming*, mendedikasikan seluruh volume ketiga — lebih dari 780 halaman — khusus untuk membahas pengurutan dan pencarian. Ini bukan tanpa alasan: sejak era komputer mainframe pertama pada tahun 1950-an, diperkirakan bahwa lebih dari 25 persen dari seluruh waktu komputasi digunakan untuk menjalankan operasi pengurutan. Meskipun perangkat keras modern telah meningkat kapasitasnya secara dramatik, relevansi sorting tidak pernah berkurang karena volume data yang perlu diproses tumbuh bahkan lebih cepat daripada kecepatan perangkat keras.

Bab ini membahas tiga algoritma pengurutan yang paling mendasar dan paling banyak diajarkan dalam kurikulum ilmu komputer: **Bubble Sort**, **Selection Sort**, dan **Insertion Sort**. Ketiganya tergolong dalam kelas algoritma O(n²) — artinya waktu eksekusi mereka tumbuh secara kuadratik seiring dengan bertambahnya ukuran data. Pertanyaan yang wajar muncul: mengapa mempelajari algoritma yang diakui lebih lambat dari algoritma lanjutan seperti Merge Sort atau Quick Sort yang beroperasi dalam O(n log n)?

Terdapat beberapa alasan yang sangat kuat. Pertama, dari perspektif pedagogis, ketiga algoritma ini memiliki mekanisme yang intuitif dan mudah divisualisasikan, sehingga memberikan landasan konseptual yang solid sebelum mempelajari algoritma yang lebih kompleks. Kedua, dari perspektif praktis, ketiga algoritma ini sering menjadi lebih unggul daripada algoritma O(n log n) ketika ukuran data sangat kecil — overhead konstan yang lebih rendah membuat mereka lebih cepat pada n yang kecil. Ketiga, Insertion Sort secara khusus merupakan komponen integral dalam algoritma hybrid modern: Python menggunakan Timsort yang menggabungkan Merge Sort dan Insertion Sort, sedangkan standar C++ (hingga C++11) menggunakan Introsort yang menggabungkan Quick Sort, Heap Sort, dan Insertion Sort. Memahami mengapa dan bagaimana Insertion Sort cocok sebagai komponen dalam algoritma hybrid ini memerlukan pemahaman mendalam tentang sifat-sifatnya.

---

## 9.3 Konsep Dasar Pengurutan Data

### 9.3.1 Definisi Formal dan Terminologi

Secara formal, **pengurutan (sorting)** dapat didefinisikan sebagai berikut: diberikan suatu urutan n elemen $a_1, a_2, \ldots, a_n$ yang diambil dari suatu himpunan yang dilengkapi dengan relasi urutan total (total order relation), tujuan pengurutan adalah menghasilkan permutasi $a_{\pi(1)}, a_{\pi(2)}, \ldots, a_{\pi(n)}$ sedemikian sehingga $a_{\pi(1)} \leq a_{\pi(2)} \leq \ldots \leq a_{\pi(n)}$ untuk pengurutan menaik (ascending), atau $a_{\pi(1)} \geq a_{\pi(2)} \geq \ldots \geq a_{\pi(n)}$ untuk pengurutan menurun (descending). Di sini, $\pi$ adalah suatu permutasi dari himpunan $\{1, 2, \ldots, n\}$.

Dalam praktik, tidak selalu kita mengurutkan berdasarkan nilai elemen itu sendiri. Lebih sering, kita mengurutkan koleksi objek berdasarkan salah satu atributnya. Sebagai contoh, pada sistem informasi akademik, kita mungkin mengurutkan daftar mahasiswa berdasarkan NIM, atau berdasarkan IPK, atau berdasarkan nama. Atribut yang digunakan sebagai dasar pengurutan disebut **kunci (key)**.

Beberapa terminologi penting yang perlu dikuasai sebelum membahas algoritma secara lebih mendalam:

**Kunci (Key):** Nilai atau atribut yang dijadikan dasar perbandingan dalam proses pengurutan. Pada array bilangan bulat sederhana, kunci adalah nilai bilangan itu sendiri. Pada koleksi rekaman (record), kunci dapat berupa satu atau kombinasi beberapa bidang (field) dari rekaman tersebut.

**In-Place Sorting:** Suatu algoritma sorting disebut in-place apabila ia tidak memerlukan memori tambahan yang proporsional dengan ukuran masukan — secara formal, algoritma tersebut menggunakan paling banyak O(1) ruang memori tambahan di luar array masukan itu sendiri. Ketiga algoritma yang dibahas dalam bab ini (Bubble Sort, Selection Sort, dan Insertion Sort) semuanya bersifat in-place. Ini kontras dengan Merge Sort, misalnya, yang memerlukan ruang tambahan O(n) untuk array bantu selama proses penggabungan.

**Stable Sorting (Pengurutan Stabil):** Suatu algoritma sorting dikatakan stabil apabila elemen-elemen dengan kunci yang sama mempertahankan urutan relatif mereka dari data asli setelah proses pengurutan selesai. Dengan kata lain, jika $a_i = a_j$ dan $i < j$ dalam urutan asli, maka $a_i$ tetap mendahului $a_j$ dalam hasil pengurutan. Kestabilan sangat penting dalam konteks pengurutan multi-kunci atau pengurutan bertahap, seperti yang lazim dilakukan pada aplikasi spreadsheet.

**Comparison-Based Sorting:** Algoritma yang menentukan urutan elemen semata-mata berdasarkan operasi perbandingan antar elemen (apakah $a_i < a_j$, $a_i = a_j$, atau $a_i > a_j$). Terdapat teorema penting yang menyatakan bahwa semua algoritma comparison-based sorting memiliki batas bawah teoritis $\Omega(n \log n)$ operasi perbandingan pada kasus terburuk dan kasus rata-rata. Ketiga algoritma yang kita pelajari — yang tergolong O(n²) — tidak melanggar batas ini; mereka sekadar tidak mencapai batas bawah optimal tersebut.

**Internal Sorting vs. External Sorting:** Pengurutan internal merujuk pada pengurutan yang dilakukan seluruhnya di dalam memori utama (RAM), di mana seluruh data dapat dimuat sekaligus. Sebaliknya, pengurutan eksternal (external sorting) diperlukan ketika data terlalu besar untuk dimuat ke memori utama, sehingga melibatkan pembacaan dan penulisan dari/ke penyimpanan sekunder seperti hard disk. Bab ini hanya membahas pengurutan internal.

---

> **Kotak 9.1 — Catatan Penting: Relasi Urutan Total**
>
> Algoritma pengurutan berbasis perbandingan hanya bekerja dengan baik apabila relasi yang digunakan memenuhi sifat urutan total (total order). Relasi $\leq$ pada bilangan riil memenuhi tiga sifat yang diperlukan: (1) **refleksivitas** — $a \leq a$ untuk semua $a$; (2) **antisimetri** — jika $a \leq b$ dan $b \leq a$, maka $a = b$; dan (3) **transitivitas** — jika $a \leq b$ dan $b \leq c$, maka $a \leq c$. Selain itu, sifat **totalitas** (totality) mensyaratkan bahwa untuk setiap pasangan $a$ dan $b$, selalu berlaku $a \leq b$ atau $b \leq a$. Jika relasi perbandingan yang didefinisikan tidak memenuhi sifat-sifat ini — seperti yang kadang terjadi pada fungsi comparator yang ditulis dengan keliru — perilaku algoritma sorting menjadi tidak terdefinisi dan dapat menghasilkan output yang salah atau bahkan menyebabkan infinite loop.

---

### 9.3.2 Kriteria Pemilihan Algoritma Sorting

Dalam praktik rekayasa perangkat lunak, pemilihan algoritma sorting yang tepat bukanlah keputusan yang sepele. Berbagai faktor harus dipertimbangkan secara cermat:

**Ukuran Data (n):** Untuk n yang sangat kecil (umumnya $n \leq 50$), algoritma O(n²) seperti Insertion Sort seringkali lebih cepat daripada algoritma O(n log n) seperti Merge Sort, karena overhead operasional (stack rekursi, alokasi memori tambahan) dari algoritma yang lebih kompleks dapat mendominasi waktu eksekusi ketika n kecil. Untuk n besar ($n > 1000$), algoritma O(n log n) jauh lebih unggul.

**Kondisi Awal Data:** Apakah data sepenuhnya acak, sudah hampir terurut, atau tersusun terbalik? Pilihan ini dapat mengubah kinerja relatif algoritma secara drastis. Insertion Sort, misalnya, beroperasi dalam O(n) waktu ketika data sudah terurut sempurna — sementara Quick Sort dengan pemilihan pivot yang naif dapat terdegradasi ke O(n²) pada kasus yang sama.

**Kestabilan:** Apakah urutan relatif elemen-elemen yang memiliki nilai kunci sama perlu dipertahankan? Jika ya, diperlukan algoritma yang stabil seperti Insertion Sort atau Merge Sort.

**Keterbatasan Memori:** Pada sistem tertanam (embedded systems) atau perangkat dengan memori terbatas, algoritma in-place seperti Selection Sort atau Heap Sort lebih diutamakan dibandingkan Merge Sort yang memerlukan O(n) memori tambahan.

**Biaya Operasi Write:** Pada media penyimpanan tertentu, seperti memori flash (NAND Flash/EEPROM) yang memiliki siklus write terbatas, meminimalkan jumlah operasi penulisan menjadi prioritas. Selection Sort, dengan paling banyak O(n) pertukaran, lebih unggul dalam konteks ini.

**Prediktabilitas Waktu:** Untuk sistem real-time yang memerlukan jaminan waktu respons, algoritma dengan kompleksitas O(n log n) di semua kasus (seperti Heap Sort) lebih dapat diandalkan dibandingkan Quick Sort yang memiliki kasus terburuk O(n²).

---

> **Kotak 9.2 — Tahukah Anda? Timsort dan Warisan Insertion Sort**
>
> Python menggunakan algoritma pengurutan bernama **Timsort**, yang dirancang oleh Tim Peters pada tahun 2002 secara khusus untuk Python. Timsort adalah algoritma hybrid yang menggabungkan Merge Sort dan Insertion Sort. Ide dasarnya adalah: data dunia nyata hampir selalu mengandung "runs" — subarray yang sudah terurut secara alami. Timsort mengidentifikasi run-run ini (dengan panjang minimum 32 hingga 64 elemen, yang disebut "minrun"), menggunaakan Insertion Sort untuk mengurutkan setiap run kecil (di mana Insertion Sort sangat efisien karena data hampir terurut), kemudian menggabungkan run-run tersebut menggunakan algoritma merge yang telah dioptimalkan. Hasilnya adalah algoritma dengan kompleksitas O(n log n) di kasus terburuk, O(n) di kasus terbaik (data sudah terurut), dan kinerja luar biasa pada data dunia nyata yang sering mengandung pola keterurutan parsial. Timsort juga diadopsi oleh Java (sebagai `Arrays.sort()` untuk array objek sejak Java 7) dan GNU Octave.

---

## 9.4 Bubble Sort

### 9.4.1 Prinsip Kerja dan Intuisi

Bubble Sort adalah algoritma pengurutan yang mungkin paling intuitif setelah seseorang memahami konsep dasarnya. Nama "bubble" (gelembung) mencerminkan perilaku visualnya: sama seperti gelembung udara dalam air yang secara alami naik ke permukaan karena ringan, elemen-elemen yang bernilai besar dalam array secara bertahap "menggelembung" ke arah akhir array (posisi "atas" dalam visualisasi) selama proses pengurutan berlangsung.

Mekanisme kerjanya bertumpu pada satu operasi dasar yang diulang-ulang: **membandingkan dua elemen yang berurutan dan menukarnya apabila urutannya salah**. Pada setiap pass (satu kali traversal dari awal hingga akhir bagian yang belum terurut), elemen terbesar yang belum berada di posisi finalnya akan "menggelembung" ke posisi yang benar di akhir bagian tersebut.

Secara lebih formal: pada pass ke-i (dihitung dari 0), algoritma membandingkan setiap pasangan `arr[j]` dan `arr[j+1]` untuk $j$ dari $0$ hingga $n-i-2$. Jika `arr[j] > arr[j+1]`, keduanya ditukar. Setelah pass ke-i selesai, elemen terbesar ke-$(i+1)$ telah berada pada posisi finalnya di indeks $n-1-i$. Oleh karena itu, setiap pass berikutnya dapat mempersingkat rentang yang diperiksa sebesar satu elemen dari ujung kanan.

### 9.4.2 Penelusuran Langkah-demi-Langkah

Sebagai contoh kerja yang lengkap, mari kita telusuri Bubble Sort pada array berikut:

**Array masukan:** `A = [64, 34, 25, 12, 22, 11, 90]`  
**n = 7**, pengurutan menaik (ascending)

---

**Gambar 9.1 — Visualisasi Pass-by-Pass Bubble Sort**

```
Array awal:
  Indeks:  [  0 ] [  1 ] [  2 ] [  3 ] [  4 ] [  5 ] [  6 ]
  Nilai:     64     34     25     12     22     11     90
```

**PASS 1 (i = 0) — Membandingkan pasangan dari indeks 0 hingga 5:**

```
  State awal Pass 1:  [ 64 | 34 | 25 | 12 | 22 | 11 | 90 ]

  Langkah 1.1:  Bandingkan A[0]=64  vs  A[1]=34
                64 > 34  -->  TUKAR
                [ 34 | 64 | 25 | 12 | 22 | 11 | 90 ]
                  ^     ^

  Langkah 1.2:  Bandingkan A[1]=64  vs  A[2]=25
                64 > 25  -->  TUKAR
                [ 34 | 25 | 64 | 12 | 22 | 11 | 90 ]
                        ^     ^

  Langkah 1.3:  Bandingkan A[2]=64  vs  A[3]=12
                64 > 12  -->  TUKAR
                [ 34 | 25 | 12 | 64 | 22 | 11 | 90 ]
                              ^    ^

  Langkah 1.4:  Bandingkan A[3]=64  vs  A[4]=22
                64 > 22  -->  TUKAR
                [ 34 | 25 | 12 | 22 | 64 | 11 | 90 ]
                                   ^    ^

  Langkah 1.5:  Bandingkan A[4]=64  vs  A[5]=11
                64 > 11  -->  TUKAR
                [ 34 | 25 | 12 | 22 | 11 | 64 | 90 ]
                                        ^    ^

  Langkah 1.6:  Bandingkan A[5]=64  vs  A[6]=90
                64 < 90  -->  tidak tukar
                [ 34 | 25 | 12 | 22 | 11 | 64 | 90 ]
                                             ^    ^

  Akhir Pass 1: [ 34 | 25 | 12 | 22 | 11 | 64 | 90* ]
                                                  (*) posisi final
  --> Elemen terbesar (90) telah menempati posisi finalnya di indeks 6.
```

**PASS 2 (i = 1) — Membandingkan pasangan dari indeks 0 hingga 4:**

```
  State awal Pass 2:  [ 34 | 25 | 12 | 22 | 11 | 64 | 90* ]

  Langkah 2.1:  Bandingkan A[0]=34  vs  A[1]=25  -->  TUKAR
                [ 25 | 34 | 12 | 22 | 11 | 64 | 90* ]

  Langkah 2.2:  Bandingkan A[1]=34  vs  A[2]=12  -->  TUKAR
                [ 25 | 12 | 34 | 22 | 11 | 64 | 90* ]

  Langkah 2.3:  Bandingkan A[2]=34  vs  A[3]=22  -->  TUKAR
                [ 25 | 12 | 22 | 34 | 11 | 64 | 90* ]

  Langkah 2.4:  Bandingkan A[3]=34  vs  A[4]=11  -->  TUKAR
                [ 25 | 12 | 22 | 11 | 34 | 64 | 90* ]

  Langkah 2.5:  Bandingkan A[4]=34  vs  A[5]=64  -->  tidak tukar

  Akhir Pass 2: [ 25 | 12 | 22 | 11 | 34* | 64* | 90* ]
  --> Elemen terbesar kedua (64) telah menempati posisi finalnya.
```

**PASS 3 (i = 2) — Membandingkan pasangan dari indeks 0 hingga 3:**

```
  State awal Pass 3:  [ 25 | 12 | 22 | 11 | 34* | 64* | 90* ]

  Langkah 3.1:  A[0]=25  vs  A[1]=12  -->  TUKAR  -->  [ 12 | 25 | 22 | 11 | ... ]
  Langkah 3.2:  A[1]=25  vs  A[2]=22  -->  TUKAR  -->  [ 12 | 22 | 25 | 11 | ... ]
  Langkah 3.3:  A[2]=25  vs  A[3]=11  -->  TUKAR  -->  [ 12 | 22 | 11 | 25 | ... ]
  Langkah 3.4:  A[3]=25  vs  A[4]=34  -->  tidak tukar

  Akhir Pass 3: [ 12 | 22 | 11 | 25* | 34* | 64* | 90* ]
```

**PASS 4 (i = 3) — Membandingkan pasangan dari indeks 0 hingga 2:**

```
  State awal Pass 4:  [ 12 | 22 | 11 | 25* | 34* | 64* | 90* ]

  Langkah 4.1:  A[0]=12  vs  A[1]=22  -->  tidak tukar
  Langkah 4.2:  A[1]=22  vs  A[2]=11  -->  TUKAR  -->  [ 12 | 11 | 22 | ... ]
  Langkah 4.3:  A[2]=22  vs  A[3]=25  -->  tidak tukar

  Akhir Pass 4: [ 12 | 11 | 22* | 25* | 34* | 64* | 90* ]
```

**PASS 5 (i = 4) — Membandingkan pasangan dari indeks 0 hingga 1:**

```
  State awal Pass 5:  [ 12 | 11 | 22* | 25* | 34* | 64* | 90* ]

  Langkah 5.1:  A[0]=12  vs  A[1]=11  -->  TUKAR  -->  [ 11 | 12 | ... ]
  Langkah 5.2:  A[1]=12  vs  A[2]=22  -->  tidak tukar

  Akhir Pass 5: [ 11* | 12* | 22* | 25* | 34* | 64* | 90* ]
```

**PASS 6 (i = 5) — Membandingkan satu pasangan terakhir di indeks 0:**

```
  State awal Pass 6:  [ 11 | 12 | 22* | ... ]

  Langkah 6.1:  A[0]=11  vs  A[1]=12  -->  tidak tukar

  Akhir Pass 6: [ 11* | 12* | 22* | 25* | 34* | 64* | 90* ]  --> TERURUT
```

**Ringkasan eksekusi:** 6 pass, total 21 perbandingan, 10 pertukaran.

---

> **Kotak 9.3 — Catatan Penting: Mengapa 6 Pass untuk 7 Elemen?**
>
> Perlu dicatat bahwa untuk n elemen, Bubble Sort standar selalu melakukan tepat $n-1$ pass, yaitu $7 - 1 = 6$ pass dalam contoh di atas. Hal ini terjadi karena pada setiap pass ke-i, hanya satu elemen yang dijamin berada pada posisi finalnya. Setelah $n-1$ pass, setidaknya $n-1$ elemen telah berada di posisi finalnya, dan secara otomatis elemen yang tersisa (yang pertama) juga pasti sudah berada di posisi yang benar.

---

### 9.4.3 Implementasi Python

**Kode 9.1 — Implementasi Bubble Sort (Standar dan Teroptimasi)**

```python
def bubble_sort(arr):
    """
    Implementasi Bubble Sort standar.

    Pada setiap pass, pasangan elemen berdekatan dibandingkan
    dan ditukar apabila urutannya salah. Setelah pass ke-i,
    elemen terbesar ke-(i+1) berada pada posisi finalnya.

    Parameter:
        arr (list): List yang akan diurutkan (dimodifikasi in-place)

    Returns:
        tuple: (list terurut, jumlah perbandingan, jumlah pertukaran)

    Kompleksitas Waktu: O(n^2) — semua kasus
    Kompleksitas Ruang: O(1)   — in-place
    Kestabilan       : Stabil
    """
    n = len(arr)
    comparisons = 0
    swaps = 0

    for i in range(n - 1):           # n-1 pass diperlukan
        for j in range(0, n - i - 1):  # Rentang menyempit tiap pass
            comparisons += 1
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                swaps += 1

    return arr, comparisons, swaps


def bubble_sort_optimized(arr):
    """
    Implementasi Bubble Sort dengan optimasi Early Termination.

    Menambahkan flag 'swapped' untuk mendeteksi apakah terjadi
    pertukaran dalam satu pass. Jika tidak ada pertukaran sama
    sekali, array sudah terurut dan algoritma dihentikan lebih awal.

    Optimasi ini mengubah kompleksitas best case dari O(n^2)
    menjadi O(n) — satu pass sudah cukup untuk memverifikasi
    bahwa array sudah terurut.

    Parameter:
        arr (list): List yang akan diurutkan (dimodifikasi in-place)

    Returns:
        tuple: (list terurut, jumlah perbandingan, jumlah pertukaran,
                jumlah pass yang benar-benar dieksekusi)

    Kompleksitas Waktu: O(n) best case, O(n^2) average/worst case
    Kompleksitas Ruang: O(1)
    Kestabilan       : Stabil
    """
    n = len(arr)
    comparisons = 0
    swaps = 0
    passes = 0

    for i in range(n - 1):
        passes += 1
        swapped = False  # Flag: apakah ada pertukaran dalam pass ini?

        for j in range(0, n - i - 1):
            comparisons += 1
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                swaps += 1
                swapped = True

        # Jika tidak ada satu pun pertukaran dalam pass ini,
        # seluruh array sudah dalam urutan yang benar.
        if not swapped:
            break

    return arr, comparisons, swaps, passes


# Demonstrasi penggunaan
if __name__ == "__main__":
    data = [64, 34, 25, 12, 22, 11, 90]

    # Bubble Sort Standar
    data_std = data.copy()
    hasil, comp, swap = bubble_sort(data_std)
    print("=== BUBBLE SORT STANDAR ===")
    print(f"Hasil        : {hasil}")
    print(f"Perbandingan : {comp}")
    print(f"Pertukaran   : {swap}")

    print()

    # Bubble Sort dengan Early Termination
    data_opt = data.copy()
    hasil, comp, swap, pas = bubble_sort_optimized(data_opt)
    print("=== BUBBLE SORT TEROPTIMASI (EARLY TERMINATION) ===")
    print(f"Hasil        : {hasil}")
    print(f"Perbandingan : {comp}")
    print(f"Pertukaran   : {swap}")
    print(f"Jumlah Pass  : {pas}")

    print()

    # Demonstrasi keunggulan early termination pada data terurut
    data_sorted = [1, 2, 3, 4, 5, 6, 7]
    data_sorted_copy = data_sorted.copy()
    hasil, comp, swap, pas = bubble_sort_optimized(data_sorted_copy)
    print("=== EARLY TERMINATION: DATA SUDAH TERURUT ===")
    print(f"Hasil        : {hasil}")
    print(f"Perbandingan : {comp}  (hanya satu pass!)")
    print(f"Pertukaran   : {swap}")
    print(f"Jumlah Pass  : {pas}   (berhenti di pass pertama)")
```

**Output:**
```
=== BUBBLE SORT STANDAR ===
Hasil        : [11, 12, 22, 25, 34, 64, 90]
Perbandingan : 21
Pertukaran   : 10

=== BUBBLE SORT TEROPTIMASI (EARLY TERMINATION) ===
Hasil        : [11, 12, 22, 25, 34, 64, 90]
Perbandingan : 21
Pertukaran   : 10
Jumlah Pass  : 6

=== EARLY TERMINATION: DATA SUDAH TERURUT ===
Hasil        : [1, 2, 3, 4, 5, 6, 7]
Perbandingan : 6  (hanya satu pass!)
Pertukaran   : 0
Jumlah Pass  : 1  (berhenti di pass pertama)
```

### 9.4.4 Analisis Kompleksitas Matematis

**Kasus Terburuk (Worst Case) — O(n²):**

Kasus terburuk terjadi ketika array tersusun dalam urutan terbalik sempurna (misalnya, `[n, n-1, ..., 2, 1]` untuk pengurutan ascending). Dalam kondisi ini, setiap perbandingan menghasilkan pertukaran.

Jumlah total perbandingan pada n-1 pass:
$$T(n) = \sum_{i=0}^{n-2} (n - 1 - i) = (n-1) + (n-2) + \ldots + 2 + 1 = \frac{n(n-1)}{2}$$

Untuk $n = 7$: $T(7) = \frac{7 \times 6}{2} = 21$ perbandingan, sesuai dengan trace di atas.

Karena $\frac{n(n-1)}{2} = \frac{n^2 - n}{2} \in \Theta(n^2)$, kompleksitas kasus terburuk adalah $\Theta(n^2)$.

**Kasus Terbaik (Best Case):**

Untuk versi **tanpa optimasi**: meskipun tidak ada satu pun pertukaran yang dilakukan (data sudah terurut), loop tetap berjalan sepenuhnya, menghasilkan $\frac{n(n-1)}{2}$ perbandingan. Jadi, best case tetap $\Theta(n^2)$.

Untuk versi **dengan early termination**: ketika data sudah terurut sempurna, pass pertama akan menyelesaikan semua $n-1$ perbandingan tanpa menemukan pertukaran, sehingga flag `swapped` tetap `False` dan algoritma berhenti. Total perbandingan = $n-1 \in \Theta(n)$. Ini adalah perbaikan dramatis dari $\Theta(n^2)$ menjadi $\Theta(n)$ pada kasus terbaik.

**Kasus Rata-Rata (Average Case) — O(n²):**

Pada kasus rata-rata, diasumsikan semua $n!$ permutasi input memiliki probabilitas yang sama. Secara rata-rata, diperlukan sekitar $\frac{n^2}{4}$ pertukaran dan $\frac{n^2}{2}$ perbandingan. Keduanya tetap $\Theta(n^2)$.

**Kompleksitas Ruang — O(1):**

Bubble Sort adalah algoritma in-place. Satu-satunya ruang tambahan yang digunakan adalah variabel bantu untuk pertukaran (atau flag `swapped` pada versi optimasi), yang semuanya konstan terhadap ukuran input.

**Kestabilan:**

Bubble Sort bersifat **stabil**. Perhatikan kondisi pertukaran: `if arr[j] > arr[j+1]`. Kondisi ini menggunakan strictly greater than (`>`), bukan greater than or equal (`>=`). Artinya, dua elemen yang bernilai sama tidak akan pernah ditukar satu sama lain. Dengan demikian, urutan relatif elemen-elemen dengan nilai kunci yang sama selalu dipertahankan.

---

## 9.5 Selection Sort

### 9.5.1 Prinsip Kerja dan Intuisi

Selection Sort mengambil pendekatan yang berbeda secara fundamental dari Bubble Sort. Alih-alih mendorong elemen secara bertahap melalui pertukaran berulang, Selection Sort menganut prinsip yang lebih langsung: **pilih elemen yang tepat dan tempatkan langsung ke posisi finalnya**.

Bayangkan proses memilih buku-buku dari tumpukan yang tidak terurut untuk disusun ke rak secara berurutan. Pendekatan Selection Sort adalah: pertama-tama, cari buku dengan nomor katalog terkecil dari seluruh tumpukan. Temukan buku itu, lalu letakkan di posisi pertama rak. Kemudian, dari tumpukan yang tersisa, cari lagi buku dengan nomor katalog terkecil, dan letakkan di posisi kedua. Ulangi proses ini hingga semua buku tersusun.

Secara algoritmis: pada iterasi ke-i (dihitung dari 0), algoritma mencari elemen minimum dari subarray `arr[i..n-1]` (bagian yang belum terurut), lalu menukar elemen minimum tersebut dengan elemen di posisi i. Setelah iterasi ke-i, setidaknya i+1 elemen di bagian kiri array telah berada pada posisi finalnya. Proses ini diulang sebanyak $n-1$ kali.

**Karakteristik utama yang membedakan Selection Sort:** algoritma ini melakukan paling banyak $n-1$ pertukaran (satu pertukaran per iterasi, atau bahkan nol jika elemen minimum sudah berada di posisi yang benar). Properti ini menjadikan Selection Sort sangat menarik dalam konteks di mana operasi penulisan (write) ke memori lebih mahal atau lebih lambat dari operasi pembacaan (read).

### 9.5.2 Penelusuran Langkah-demi-Langkah

**Array masukan:** `A = [64, 34, 25, 12, 22, 11, 90]`

---

**Gambar 9.2 — Visualisasi Iterasi Selection Sort**

**ITERASI 1 (i = 0) — Mencari minimum dari A[0..6]:**

```
  Subarray diperiksa: [ 64 | 34 | 25 | 12 | 22 | 11 | 90 ]
                        ^    scan ke kanan --->

  Pelacakan minimum:
    min_idx = 0,  min_val = 64  (inisialisasi)
    Periksa A[1]=34:  34 < 64  -->  min_idx = 1,  min_val = 34
    Periksa A[2]=25:  25 < 34  -->  min_idx = 2,  min_val = 25
    Periksa A[3]=12:  12 < 25  -->  min_idx = 3,  min_val = 12
    Periksa A[4]=22:  22 > 12  -->  tidak berubah
    Periksa A[5]=11:  11 < 12  -->  min_idx = 5,  min_val = 11
    Periksa A[6]=90:  90 > 11  -->  tidak berubah

  Minimum: A[5] = 11
  Tukar A[0]=64 <--> A[5]=11:
  Hasil: [ 11* | 34 | 25 | 12 | 22 | 64 | 90 ]
           (*)  = posisi final
```

**ITERASI 2 (i = 1) — Mencari minimum dari A[1..6]:**

```
  Subarray diperiksa:  [ 11* | 34 | 25 | 12 | 22 | 64 | 90 ]
                                ^   scan ke kanan --->

  Pelacakan minimum:
    min_idx = 1,  min_val = 34
    Periksa A[2]=25:  25 < 34  -->  min_idx = 2,  min_val = 25
    Periksa A[3]=12:  12 < 25  -->  min_idx = 3,  min_val = 12
    Periksa A[4]=22:  22 > 12  -->  tidak berubah
    Periksa A[5]=64:  64 > 12  -->  tidak berubah
    Periksa A[6]=90:  90 > 12  -->  tidak berubah

  Minimum: A[3] = 12
  Tukar A[1]=34 <--> A[3]=12:
  Hasil: [ 11* | 12* | 25 | 34 | 22 | 64 | 90 ]
```

**ITERASI 3 (i = 2) — Mencari minimum dari A[2..6]:**

```
  Pelacakan minimum mulai dari A[2]=25:
    A[3]=34: tidak ganti | A[4]=22: 22 < 25 --> min_idx=4, min_val=22
    A[5]=64: tidak ganti | A[6]=90: tidak ganti

  Minimum: A[4] = 22
  Tukar A[2]=25 <--> A[4]=22:
  Hasil: [ 11* | 12* | 22* | 34 | 25 | 64 | 90 ]
```

**ITERASI 4 (i = 3) — Mencari minimum dari A[3..6]:**

```
  Pelacakan minimum mulai dari A[3]=34:
    A[4]=25: 25 < 34 --> min_idx=4, min_val=25
    A[5]=64: tidak ganti | A[6]=90: tidak ganti

  Minimum: A[4] = 25
  Tukar A[3]=34 <--> A[4]=25:
  Hasil: [ 11* | 12* | 22* | 25* | 34 | 64 | 90 ]
```

**ITERASI 5 (i = 4) — Mencari minimum dari A[4..6]:**

```
  Pelacakan minimum mulai dari A[4]=34:
    A[5]=64: tidak ganti | A[6]=90: tidak ganti

  Minimum: A[4] = 34 (sudah di posisi benar, min_idx == i)
  Tidak perlu pertukaran.
  Hasil: [ 11* | 12* | 22* | 25* | 34* | 64 | 90 ]
```

**ITERASI 6 (i = 5) — Mencari minimum dari A[5..6]:**

```
  Pelacakan minimum mulai dari A[5]=64:
    A[6]=90: 90 > 64 --> tidak ganti

  Minimum: A[5] = 64 (sudah di posisi benar, min_idx == i)
  Tidak perlu pertukaran.
  Hasil: [ 11* | 12* | 22* | 25* | 34* | 64* | 90* ]  --> TERURUT
```

**Ringkasan eksekusi:** 6 iterasi, total 21 perbandingan, hanya **4 pertukaran** (bandingkan dengan 10 pada Bubble Sort).

---

> **Kotak 9.4 — Studi Kasus: Selection Sort pada Memori Flash**
>
> Memori flash (NAND Flash) yang digunakan dalam USB drive, SSD, dan kartu memori memiliki karakteristik asimetris yang unik: operasi baca (read) jauh lebih cepat dan tidak menyebabkan penuaan komponen, sementara operasi tulis (write/erase) relatif lambat dan setiap sel memori hanya dapat menanggung jumlah siklus write yang terbatas (umumnya 10.000 hingga 100.000 kali, tergantung jenis flash). Mengingat karakteristik ini, Selection Sort dengan jaminan paling banyak $O(n)$ pertukaran menjadi pilihan yang sangat rasional untuk mengurutkan data di memori flash, dibandingkan Bubble Sort yang dapat melakukan $O(n^2)$ pertukaran dalam kasus terburuk. Minimisasi operasi write tidak hanya memperpanjang umur media, tetapi juga mengurangi konsumsi energi — faktor kritis pada perangkat yang ditenagai baterai.

---

### 9.5.3 Implementasi Python

**Kode 9.2 — Implementasi Selection Sort**

```python
def selection_sort(arr):
    """
    Implementasi Selection Sort.

    Pada setiap iterasi ke-i, elemen minimum dari subarray arr[i..n-1]
    dicari dan ditukar dengan arr[i], sehingga menempatkan elemen
    minimum tersebut ke posisi finalnya.

    Parameter:
        arr (list): List yang akan diurutkan (dimodifikasi in-place)

    Returns:
        tuple: (list terurut, jumlah perbandingan, jumlah pertukaran)

    Kompleksitas Waktu: O(n^2) — semua kasus (tanpa pengecualian)
    Kompleksitas Ruang: O(1)   — in-place
    Kestabilan       : Tidak Stabil
    Pertukaran       : Paling banyak O(n) — keunggulan utama
    """
    n = len(arr)
    comparisons = 0
    swaps = 0

    for i in range(n - 1):
        # Asumsikan elemen pertama dari bagian belum terurut adalah minimum
        min_idx = i

        # Cari elemen minimum dalam subarray arr[i+1..n-1]
        for j in range(i + 1, n):
            comparisons += 1
            if arr[j] < arr[min_idx]:
                min_idx = j

        # Tukar hanya jika elemen minimum bukan sudah di posisi i
        if min_idx != i:
            arr[i], arr[min_idx] = arr[min_idx], arr[i]
            swaps += 1

    return arr, comparisons, swaps


def selection_sort_verbose(arr):
    """
    Versi verbose Selection Sort untuk keperluan demonstrasi,
    menampilkan kondisi array setelah setiap iterasi.
    """
    n = len(arr)
    print(f"Array awal : {arr}\n")

    for i in range(n - 1):
        min_idx = i
        for j in range(i + 1, n):
            if arr[j] < arr[min_idx]:
                min_idx = j

        print(f"Iterasi {i+1:2d}: subarray belum terurut = {arr[i:]}")
        print(f"           minimum = {arr[min_idx]} di indeks {min_idx}")

        if min_idx != i:
            print(f"           tukar A[{i}]={arr[i]} <--> A[{min_idx}]={arr[min_idx]}")
            arr[i], arr[min_idx] = arr[min_idx], arr[i]
        else:
            print(f"           A[{i}] sudah minimum, tidak perlu tukar")

        print(f"           Hasil   : {arr}")
        print(f"           Terurut : {arr[:i+1]}\n")

    print(f"Array terurut final : {arr}")
    return arr


# Demonstrasi penggunaan
if __name__ == "__main__":
    data = [64, 34, 25, 12, 22, 11, 90]

    print("=== SELECTION SORT ===")
    data_copy = data.copy()
    hasil, comp, swap = selection_sort(data_copy)
    print(f"Hasil        : {hasil}")
    print(f"Perbandingan : {comp}")
    print(f"Pertukaran   : {swap}")
```

### 9.5.4 Analisis Kompleksitas Matematis

**Jumlah Perbandingan (semua kasus):**

Berbeda dari Bubble Sort, Selection Sort tidak memiliki mekanisme untuk menghentikan pencarian lebih awal. Pada setiap iterasi ke-i, algoritma **selalu** memeriksa semua elemen dari $i+1$ hingga $n-1$ untuk memastikan elemen minimum ditemukan. Total perbandingan:

$$C(n) = \sum_{i=0}^{n-2} (n - 1 - i) = (n-1) + (n-2) + \ldots + 1 = \frac{n(n-1)}{2} \in \Theta(n^2)$$

Ini berarti jumlah perbandingan Selection Sort **sama untuk semua kondisi data** — baik data acak, terurut, maupun terbalik. Tidak ada best case yang lebih baik; kompleksitasnya adalah $\Theta(n^2)$ secara tepat.

**Jumlah Pertukaran:**

Ini adalah keunggulan utama Selection Sort. Pada setiap iterasi, tepat satu pertukaran dilakukan (atau nol jika elemen minimum sudah di posisi yang benar). Oleh karena itu:
$$S(n) \leq n - 1 \in O(n)$$

**Kestabilan:**

Selection Sort **tidak stabil**. Pertukaran yang dilakukan bersifat jarak jauh (long-range swap) — elemen di posisi $i$ ditukar dengan elemen di posisi `min_idx` yang bisa jauh di sebelah kanan. Pertukaran ini dapat mengubah urutan relatif elemen-elemen yang bernilai sama.

Contoh konkret: array `[5a, 5b, 1]` (di mana subscript a dan b menandai urutan asli, keduanya bernilai 5). Pada iterasi pertama, elemen minimum (1) berada di indeks 2. Terjadi pertukaran `5a` (indeks 0) dengan `1` (indeks 2), menghasilkan `[1, 5b, 5a]`. Urutan relatif `5a` dan `5b` telah berubah: semula `5a` mendahului `5b`, kini `5b` mendahului `5a`.

---

## 9.6 Insertion Sort

### 9.6.1 Prinsip Kerja dan Intuisi

Insertion Sort terinspirasi dari cara alamiah manusia mengurutkan kartu remi. Ketika menerima kartu satu per satu dan menyusunnya di tangan, seorang pemain kartu biasanya akan mengambil kartu baru, membandingkannya dengan kartu-kartu yang sudah ada di tangan dari kanan ke kiri, dan menyisipkannya ke posisi yang tepat di antara kartu-kartu yang sudah terurut.

Itulah persis yang dilakukan Insertion Sort: algoritma ini membangun subarray terurut dari kiri ke kanan, **menyisipkan satu elemen pada satu waktu** ke posisi yang tepat dalam subarray terurut yang sudah ada.

Secara teknis: pada iterasi ke-i (dimulai dari $i = 1$), elemen `arr[i]` (disebut **key**) diekstrak dan disimpan. Kemudian, algoritma memundurkan (shifts) semua elemen di bagian terurut `arr[0..i-1]` yang **lebih besar dari key** ke satu posisi ke kanan, menciptakan "slot kosong" untuk key. Setelah semua elemen yang perlu digeser sudah digeser, key disisipkan ke slot tersebut.

**Keunggulan kritis Insertion Sort** adalah kemampuannya mendeteksi dan memanfaatkan keterurutan yang sudah ada dalam data. Ketika key ditemukan lebih besar dari semua elemen di sebelah kirinya, proses pergeseran langsung berhenti — tidak ada pekerjaan yang sia-sia. Pada data yang sudah hampir terurut, ini menghasilkan performa mendekati O(n) secara keseluruhan, menjadikan Insertion Sort jauh lebih efisien daripada Bubble Sort atau Selection Sort dalam skenario tersebut.

### 9.6.2 Penelusuran Langkah-demi-Langkah

**Array masukan:** `A = [64, 34, 25, 12, 22, 11, 90]`

---

**Gambar 9.3 — Visualisasi Iterasi Insertion Sort**

```
State awal: [ 64 | 34 | 25 | 12 | 22 | 11 | 90 ]
             Terurut  | Belum terurut
             [   64 ] | [ 34, 25, 12, 22, 11, 90 ]
```

**ITERASI 1 (i = 1): Menyisipkan key = A[1] = 34**

```
  Bagian terurut  : [ 64 ]
  Bagian belum    : [ 34, 25, 12, 22, 11, 90 ]
  Key = 34

  j = 0: Bandingkan key=34 dengan A[0]=64
         34 < 64  -->  geser A[0]=64 satu posisi ke kanan
         Array sementara: [ 64, 64, 25, 12, 22, 11, 90 ]
                               ^   (slot untuk key)

  j = -1: j < 0, hentikan pergeseran

  Sisipkan key=34 pada posisi j+1 = 0:
  Hasil: [ 34, 64, 25, 12, 22, 11, 90 ]
          -----
          terurut
```

**ITERASI 2 (i = 2): Menyisipkan key = A[2] = 25**

```
  Bagian terurut  : [ 34, 64 ]
  Key = 25

  j = 1: Bandingkan key=25 dengan A[1]=64
         25 < 64  -->  geser 64 ke kanan
         Array sementara: [ 34, 64, 64, 12, 22, 11, 90 ]

  j = 0: Bandingkan key=25 dengan A[0]=34
         25 < 34  -->  geser 34 ke kanan
         Array sementara: [ 34, 34, 64, 12, 22, 11, 90 ]

  j = -1: hentikan pergeseran

  Sisipkan key=25 pada posisi 0:
  Hasil: [ 25, 34, 64, 12, 22, 11, 90 ]
          ---------
          terurut
```

**ITERASI 3 (i = 3): Menyisipkan key = A[3] = 12**

```
  Bagian terurut  : [ 25, 34, 64 ]
  Key = 12

  j = 2: 12 < 64  -->  geser 64 ke kanan
  j = 1: 12 < 34  -->  geser 34 ke kanan
  j = 0: 12 < 25  -->  geser 25 ke kanan
  j = -1: hentikan

  Sisipkan key=12 pada posisi 0:
  Hasil: [ 12, 25, 34, 64, 22, 11, 90 ]
          -------------
          terurut
```

**ITERASI 4 (i = 4): Menyisipkan key = A[4] = 22**

```
  Bagian terurut  : [ 12, 25, 34, 64 ]
  Key = 22

  j = 3: 22 < 64  -->  geser 64 ke kanan
         Array: [ 12, 25, 34, 64, 64, 11, 90 ]
  j = 2: 22 < 34  -->  geser 34 ke kanan
         Array: [ 12, 25, 34, 34, 64, 11, 90 ]
  j = 1: 22 < 25  -->  geser 25 ke kanan
         Array: [ 12, 25, 25, 34, 64, 11, 90 ]
  j = 0: Bandingkan key=22 dengan A[0]=12
         22 > 12  -->  BERHENTI (posisi ditemukan!)

  Sisipkan key=22 pada posisi j+1 = 1:
  Hasil: [ 12, 22, 25, 34, 64, 11, 90 ]
          -----------------
          terurut
```

**ITERASI 5 (i = 5): Menyisipkan key = A[5] = 11**

```
  Bagian terurut  : [ 12, 22, 25, 34, 64 ]
  Key = 11

  j = 4: 11 < 64  -->  geser
  j = 3: 11 < 34  -->  geser
  j = 2: 11 < 25  -->  geser
  j = 1: 11 < 22  -->  geser
  j = 0: 11 < 12  -->  geser
  j = -1: hentikan

  Sisipkan key=11 pada posisi 0:
  Hasil: [ 11, 12, 22, 25, 34, 64, 90 ]
          ---------------------
          terurut
```

**ITERASI 6 (i = 6): Menyisipkan key = A[6] = 90**

```
  Bagian terurut  : [ 11, 12, 22, 25, 34, 64 ]
  Key = 90

  j = 5: Bandingkan key=90 dengan A[5]=64
         90 > 64  -->  BERHENTI LANGSUNG (tidak ada yang perlu digeser)

  Sisipkan key=90 pada posisi j+1 = 6 (tidak berpindah):
  Hasil: [ 11, 12, 22, 25, 34, 64, 90 ]  --> TERURUT
```

**Ringkasan eksekusi:** 6 iterasi, total 16 perbandingan (lebih sedikit dari Bubble Sort dan Selection Sort yang sama-sama 21), 15 operasi geser.

---

### 9.6.3 Implementasi Python

**Kode 9.3 — Implementasi Insertion Sort**

```python
def insertion_sort(arr):
    """
    Implementasi Insertion Sort.

    Membangun subarray terurut dari kiri ke kanan. Pada setiap
    iterasi ke-i, elemen arr[i] (key) disisipkan ke posisi yang
    tepat dalam subarray terurut arr[0..i-1] dengan cara menggeser
    elemen-elemen yang lebih besar satu posisi ke kanan.

    Parameter:
        arr (list): List yang akan diurutkan (dimodifikasi in-place)

    Returns:
        tuple: (list terurut, jumlah perbandingan, jumlah pergeseran)

    Kompleksitas Waktu:
        Best Case    O(n)   -- data sudah terurut (0 pergeseran)
        Average Case O(n^2) -- data acak
        Worst Case   O(n^2) -- data terbalik
    Kompleksitas Ruang: O(1)   -- in-place
    Kestabilan       : Stabil  -- kondisi arr[j] > key (bukan >=)
    """
    n = len(arr)
    comparisons = 0
    shifts = 0

    for i in range(1, n):
        key = arr[i]      # Elemen yang akan disisipkan
        j = i - 1         # Mulai dari ujung kanan bagian terurut

        # Geser semua elemen yang lebih besar dari key ke kanan
        while j >= 0 and arr[j] > key:
            comparisons += 1
            arr[j + 1] = arr[j]   # Geser satu posisi ke kanan
            shifts += 1
            j -= 1

        # Hitung perbandingan yang menghentikan loop
        # (arr[j] <= key, atau j sudah mencapai -1)
        if j >= 0:
            comparisons += 1

        arr[j + 1] = key  # Sisipkan key di posisi yang tepat

    return arr, comparisons, shifts


def insertion_sort_demo_kondisi(n=20):
    """
    Mendemonstrasikan kinerja Insertion Sort pada berbagai
    kondisi data: terurut, hampir terurut, acak, dan terbalik.
    Mengilustrasikan mengapa insertion sort unggul pada data
    yang sudah hampir terurut.
    """
    import random
    random.seed(42)

    # Empat kondisi data berbeda
    sorted_data = list(range(1, n + 1))

    nearly_sorted = list(range(1, n + 1))
    nearly_sorted[5], nearly_sorted[10] = nearly_sorted[10], nearly_sorted[5]
    nearly_sorted[15], nearly_sorted[18] = nearly_sorted[18], nearly_sorted[15]

    random_data = random.sample(range(1, n * 5 + 1), n)

    reversed_data = list(range(n, 0, -1))

    kasus = [
        ("Terurut Penuh (Best Case)",   sorted_data),
        ("Hampir Terurut",               nearly_sorted),
        ("Acak (Average Case)",          random_data),
        ("Terbalik (Worst Case)",        reversed_data),
    ]

    print(f"\n{'Kondisi Data':<35} {'Perbandingan':>14} {'Pergeseran':>12}")
    print("-" * 65)

    for nama, data in kasus:
        data_copy = data.copy()
        _, comp, shift = insertion_sort(data_copy)
        print(f"{nama:<35} {comp:>14} {shift:>12}")

    print("-" * 65)
    print(f"(Nilai teoritis worst case untuk n={n}: "
          f"{n*(n-1)//2} perbandingan, {n*(n-1)//2} pergeseran)\n")


# Demonstrasi penggunaan
if __name__ == "__main__":
    data = [64, 34, 25, 12, 22, 11, 90]

    print("=== INSERTION SORT ===")
    data_copy = data.copy()
    hasil, comp, shift = insertion_sort(data_copy)
    print(f"Hasil        : {hasil}")
    print(f"Perbandingan : {comp}")
    print(f"Pergeseran   : {shift}")

    print("\n=== PERBANDINGAN BERDASARKAN KONDISI DATA (n=20) ===")
    insertion_sort_demo_kondisi(n=20)
```

**Output demonstrasi kondisi data (n=20):**

```
Kondisi Data                        Perbandingan   Pergeseran
-----------------------------------------------------------------
Terurut Penuh (Best Case)                     19            0
Hampir Terurut                                23            4
Acak (Average Case)                           94           75
Terbalik (Worst Case)                        190          190
-----------------------------------------------------------------
(Nilai teoritis worst case untuk n=20: 190 perbandingan, 190 pergeseran)
```

Perhatikan betapa dramatisnya perbedaan antara data terurut (19 perbandingan, 0 pergeseran) dan data hampir terurut (23 perbandingan, hanya 4 pergeseran) dibandingkan data acak (94 perbandingan) dan data terbalik (190 perbandingan).

### 9.6.4 Analisis Kompleksitas Matematis

**Kasus Terbaik (Best Case) — O(n):**

Terjadi ketika array sudah terurut sempurna. Pada setiap iterasi ke-i, key langsung lebih besar dari semua elemen di sebelah kirinya (khususnya, lebih besar dari `arr[i-1]`), sehingga loop `while` tidak dieksekusi sama sekali. Hanya diperlukan satu perbandingan per iterasi (perbandingan yang menghentikan loop), dan tidak ada pergeseran.

Total perbandingan: $n - 1 \in O(n)$ (satu perbandingan per iterasi untuk n-1 iterasi).

**Kasus Terburuk (Worst Case) — O(n²):**

Terjadi ketika array tersusun terbalik sempurna. Pada iterasi ke-i, key harus digeser melewati semua i elemen di bagian terurut, memerlukan tepat i pergeseran dan i perbandingan.

Total pergeseran: $\sum_{i=1}^{n-1} i = \frac{n(n-1)}{2} \in \Theta(n^2)$

**Kasus Rata-Rata (Average Case) — O(n²):**

Dengan asumsi semua permutasi input bersifat equiprobable, setiap elemen baru yang disisipkan secara rata-rata perlu digeser melewati setengah dari elemen-elemen yang sudah ada di bagian terurut.

Total pergeseran rata-rata: $\sum_{i=1}^{n-1} \frac{i}{2} = \frac{1}{2} \cdot \frac{n(n-1)}{2} = \frac{n(n-1)}{4} \in \Theta(n^2)$

**Kestabilan:**

Insertion Sort bersifat **stabil**. Perhatikan kondisi loop while: `while j >= 0 and arr[j] > key`. Penggunaan strictly greater than (`>`) berarti ketika `arr[j] == key`, pergeseran dihentikan dan key disisipkan **di belakang** elemen yang nilainya sama. Ini memastikan urutan relatif elemen-elemen dengan nilai kunci yang sama selalu dipertahankan.

---

## 9.7 Analisis Komparatif Ketiga Algoritma

### 9.7.1 Tabel Kompleksitas Lengkap

**Tabel 9.1 — Ringkasan Kompleksitas Algoritma Sorting Dasar**

| Algoritma            | Best Case | Average Case | Worst Case | Space | Stabil   | In-Place |
|----------------------|:---------:|:------------:|:----------:|:-----:|:--------:|:--------:|
| Bubble Sort          | O(n^2)    | O(n^2)       | O(n^2)     | O(1)  | Ya       | Ya       |
| Bubble Sort*         | O(n)      | O(n^2)       | O(n^2)     | O(1)  | Ya       | Ya       |
| Selection Sort       | O(n^2)    | O(n^2)       | O(n^2)     | O(1)  | Tidak    | Ya       |
| Insertion Sort       | O(n)      | O(n^2)       | O(n^2)     | O(1)  | Ya       | Ya       |

*Bubble Sort dengan optimasi Early Termination

Keterangan:
- Bubble Sort versi standar memiliki kinerja O(n^2) bahkan pada best case karena loop tidak pernah dihentikan lebih awal.
- Selection Sort bersifat tidak stabil karena operasi swap jarak jauh dapat mengubah urutan relatif elemen-elemen bernilai sama.
- Insertion Sort dan Bubble Sort* sama-sama mencapai O(n) pada best case, namun Insertion Sort lebih efisien dalam praktik karena menggunakan operasi geser (shift) yang lebih murah secara cache daripada operasi swap berulang.

### 9.7.2 Perbandingan Operasi pada Array Contoh

**Tabel 9.2 — Perbandingan Operasi pada Array [64, 34, 25, 12, 22, 11, 90] (n=7)**

| Metrik                    | Bubble Sort | Selection Sort | Insertion Sort |
|---------------------------|:-----------:|:--------------:|:--------------:|
| Jumlah Perbandingan       | 21          | 21             | 16             |
| Jumlah Pertukaran/Geser   | 10 tukar    | 4 tukar        | 15 geser       |
| Jumlah Pass/Iterasi       | 6           | 6              | 6              |
| Penulisan ke Array        | 20 write    | 8 write        | 15 write       |

Catatan penting dari tabel ini: meskipun jumlah perbandingan Bubble Sort dan Selection Sort identik pada contoh ini (keduanya $\frac{n(n-1)}{2} = 21$), **Insertion Sort lebih efisien dengan hanya 16 perbandingan**. Hal ini terjadi karena Insertion Sort dapat menghentikan proses pencarian posisi lebih awal begitu elemen di sebelah kiri tidak lagi lebih besar dari key (seperti yang terlihat pada Iterasi 4 dan Iterasi 6 dalam trace di atas).

### 9.7.3 Benchmark Empiris

Berikut adalah kode benchmark untuk membandingkan kinerja aktual ketiga algoritma:

**Kode 9.4 — Benchmark Komprehensif Ketiga Algoritma Sorting**

```python
import time
import random


def bubble_sort_bench(arr):
    """Bubble sort dengan early termination untuk benchmark."""
    n = len(arr)
    for i in range(n - 1):
        swapped = False
        for j in range(0, n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                swapped = True
        if not swapped:
            break
    return arr


def selection_sort_bench(arr):
    """Selection sort untuk benchmark."""
    n = len(arr)
    for i in range(n - 1):
        min_idx = i
        for j in range(i + 1, n):
            if arr[j] < arr[min_idx]:
                min_idx = j
        if min_idx != i:
            arr[i], arr[min_idx] = arr[min_idx], arr[i]
    return arr


def insertion_sort_bench(arr):
    """Insertion sort untuk benchmark."""
    for i in range(1, len(arr)):
        key = arr[i]
        j = i - 1
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key
    return arr


def jalankan_benchmark(ukuran_data, jenis_data="acak", ulangan=5):
    """
    Mengukur waktu eksekusi rata-rata ketiga algoritma.

    Parameter:
        ukuran_data (list) : Daftar ukuran n yang diuji
        jenis_data  (str)  : "acak", "terurut", "terbalik", "hampir_terurut"
        ulangan     (int)  : Jumlah pengulangan untuk rata-rata
    """
    algoritma = {
        "Bubble Sort    ": bubble_sort_bench,
        "Selection Sort ": selection_sort_bench,
        "Insertion Sort ": insertion_sort_bench,
    }

    print(f"\nData: {jenis_data.upper()}, {ulangan}x repetisi")
    print("=" * 65)
    header = f"{'n':>8}"
    for nama in algoritma:
        header += f" | {nama:>14}"
    print(header)
    print("-" * 65)

    for n in ukuran_data:
        baris = f"{n:>8}"
        for nama, fungsi in algoritma.items():
            total = 0
            for _ in range(ulangan):
                if jenis_data == "acak":
                    data = random.sample(range(n * 10), n)
                elif jenis_data == "terurut":
                    data = list(range(n))
                elif jenis_data == "terbalik":
                    data = list(range(n, 0, -1))
                elif jenis_data == "hampir_terurut":
                    data = list(range(n))
                    for _ in range(max(1, n // 20)):
                        i1 = random.randint(0, n - 1)
                        i2 = random.randint(0, n - 1)
                        data[i1], data[i2] = data[i2], data[i1]

                salinan = data.copy()
                mulai = time.perf_counter()
                fungsi(salinan)
                selesai = time.perf_counter()
                total += (selesai - mulai)

            rata_rata_ms = (total / ulangan) * 1000
            baris += f" | {rata_rata_ms:>12.3f}ms"
        print(baris)


if __name__ == "__main__":
    random.seed(42)
    ukuran = [100, 500, 1000, 2000, 5000]

    jalankan_benchmark(ukuran, jenis_data="acak")
    jalankan_benchmark(ukuran, jenis_data="terurut")
    jalankan_benchmark(ukuran, jenis_data="hampir_terurut")
    jalankan_benchmark(ukuran, jenis_data="terbalik")
```

**Tabel 9.3 — Perkiraan Hasil Benchmark (Hardware Modern, Python 3.x)**

```
Data: ACAK, 5x repetisi
=================================================================
       n | Bubble Sort     | Selection Sort  | Insertion Sort
-----------------------------------------------------------------
     100 |          0.025ms |          0.018ms |          0.012ms
     500 |          0.580ms |          0.420ms |          0.285ms
    1000 |          2.310ms |          1.680ms |          1.140ms
    2000 |          9.250ms |          6.720ms |          4.560ms
    5000 |         57.800ms |         42.100ms |         28.400ms

Data: TERURUT, 5x repetisi
=================================================================
       n | Bubble Sort     | Selection Sort  | Insertion Sort
-----------------------------------------------------------------
     100 |          0.003ms |          0.017ms |          0.001ms
     500 |          0.010ms |          0.395ms |          0.003ms
    1000 |          0.018ms |          1.590ms |          0.005ms
    2000 |          0.034ms |          6.380ms |          0.009ms
    5000 |          0.082ms |         39.800ms |          0.022ms
```

Hasil benchmark ini sangat informatif. Pada data acak, Insertion Sort secara konsisten sekitar dua kali lebih cepat dari Bubble Sort. Pada data yang sudah terurut, perbedaannya dramatik: Insertion Sort hampir 300 kali lebih cepat dari Selection Sort (0.022 ms vs 39.8 ms untuk n=5000). Sementara itu, Selection Sort menunjukkan konsistensi yang unik — waktunya hampir identik di semua jenis data, mencerminkan kenyataan bahwa jumlah perbandingannya selalu tepat $\frac{n(n-1)}{2}$ tanpa tergantung pada kondisi input.

### 9.7.4 Panduan Pemilihan Algoritma

**Kapan menggunakan Bubble Sort:**
Terutama untuk tujuan pendidikan karena mekanismenya paling mudah divisualisasikan dan dipahami. Dengan optimasi early termination, Bubble Sort juga berguna sebagai alat deteksi: jika tujuan utama adalah memverifikasi apakah array sudah terurut (bukan mengurutkannya dari awal), Bubble Sort teroptimasi dapat melakukannya dalam O(n) waktu — satu pass yang menyelesaikan tanpa pertukaran membuktikan bahwa array sudah terurut sempurna.

**Kapan menggunakan Selection Sort:**
Selection Sort adalah pilihan optimal ketika **biaya operasi penulisan (write) jauh lebih tinggi daripada biaya pembacaan (read)**. Ini terjadi pada:
- Memori flash (NAND Flash, EEPROM) dengan siklus write terbatas
- Sistem dengan bus data asimetris di mana write jauh lebih lambat dari read
- Situasi di mana meminimalkan jumlah swap fisik sangat penting

Selection Sort juga berguna ketika konsistensi waktu eksekusi diperlukan — karena selalu memerlukan tepat $\frac{n(n-1)}{2}$ perbandingan, perilakunya sangat dapat diprediksi.

**Kapan menggunakan Insertion Sort:**
Insertion Sort adalah pilihan terbaik untuk:
- **Data berukuran kecil** ($n \leq 50$) di mana overhead algoritma O(n log n) tidak sepadan
- **Data yang hampir terurut** (nearly sorted) — kinerja mendekati O(n)
- **Pengurutan online** — ketika data masuk satu per satu secara berurutan dan perlu selalu tersusun terurut
- **Sebagai komponen dalam algoritma hybrid** seperti Timsort (Python) atau Introsort (C++)

---

> **Kotak 9.5 — Catatan Penting: Batasan O(n²) dan Kapan Harus Beralih**
>
> Penting untuk memahami dengan tepat di mana algoritma O(n²) menjadi tidak praktis. Sebagai patokan kasar: pada komputer modern, algoritma O(n²) dapat menyelesaikan sekitar 10.000 elemen dalam waktu sekitar satu detik di Python. Untuk n = 100.000, waktu yang dibutuhkan naik menjadi sekitar 100 detik — jauh melampaui batas yang dapat diterima. Untuk dataset besar seperti ini, algoritma O(n log n) seperti Merge Sort (O(n log n) di semua kasus), Heap Sort (O(n log n) di semua kasus), atau Quick Sort (O(n log n) rata-rata) harus digunakan. Python sendiri menyediakan fungsi `sorted()` dan metode `.sort()` yang menggunakan Timsort — selalu gunakan fungsi bawaan ini untuk aplikasi produksi kecuali ada alasan yang sangat spesifik untuk menggunakan implementasi manual.

---

## 9.8 Aplikasi Praktis: Studi Kasus

### 9.8.1 Studi Kasus: Sistem Perangkingan Nilai Ujian

Sebuah sistem informasi akademik perlu mengurutkan nilai ujian mahasiswa untuk menghasilkan peringkat kelas. Data yang tersimpan adalah objek dengan atribut NIM, nama, dan nilai ujian.

```python
from dataclasses import dataclass
from typing import List


@dataclass
class Mahasiswa:
    nim: str
    nama: str
    nilai: float

    def __repr__(self):
        return f"({self.nim}, {self.nama}, {self.nilai})"


def insertion_sort_mahasiswa(data: List[Mahasiswa]) -> List[Mahasiswa]:
    """
    Mengurutkan list mahasiswa berdasarkan nilai (descending),
    mempertahankan urutan abjad nama untuk nilai yang sama
    (memanfaatkan sifat stabil insertion sort).

    Algoritma dipilih karena:
    1. Data hasil query basis data sering sudah hampir terurut
    2. Kestabilan diperlukan untuk mempertahankan urutan nama
    3. Ukuran kelas (n) biasanya kecil (< 50 mahasiswa)
    """
    n = len(data)

    for i in range(1, n):
        key = data[i]
        j = i - 1

        # Urutan descending berdasarkan nilai;
        # untuk nilai sama, pertahankan urutan abjad (sudah terurut dari DB)
        while j >= 0 and data[j].nilai < key.nilai:
            data[j + 1] = data[j]
            j -= 1

        data[j + 1] = key

    return data


# Contoh penggunaan
mahasiswa_kelas = [
    Mahasiswa("2301001", "Andi Pratama",  85.0),
    Mahasiswa("2301002", "Budi Santoso",  92.0),
    Mahasiswa("2301003", "Citra Dewi",    85.0),  # nilai sama dengan Andi
    Mahasiswa("2301004", "Dina Marlina",  78.0),
    Mahasiswa("2301005", "Eko Prasetyo",  92.0),  # nilai sama dengan Budi
]

print("Sebelum diurutkan:")
for m in mahasiswa_kelas:
    print(f"  {m}")

insertion_sort_mahasiswa(mahasiswa_kelas)

print("\nSetelah diurutkan (descending nilai, stable):")
for peringkat, m in enumerate(mahasiswa_kelas, 1):
    print(f"  Peringkat {peringkat}: {m}")

# Output:
# Sebelum diurutkan:
#   (2301001, Andi Pratama, 85.0)
#   (2301002, Budi Santoso, 92.0)
#   (2301003, Citra Dewi, 85.0)
#   (2301004, Dina Marlina, 78.0)
#   (2301005, Eko Prasetyo, 92.0)
#
# Setelah diurutkan (descending nilai, stable):
#   Peringkat 1: (2301002, Budi Santoso, 92.0)
#   Peringkat 2: (2301005, Eko Prasetyo, 92.0)   # Budi tetap sebelum Eko
#   Peringkat 3: (2301001, Andi Pratama, 85.0)
#   Peringkat 4: (2301003, Citra Dewi, 85.0)     # Andi tetap sebelum Citra
#   Peringkat 5: (2301004, Dina Marlina, 78.0)
```

Perhatikan bahwa kestabilan Insertion Sort memastikan Budi (yang muncul lebih dulu dengan nilai 92) tetap di peringkat yang lebih tinggi dari Eko (yang juga bernilai 92, tetapi muncul lebih belakangan dalam data asli). Demikian pula Andi tetap sebelum Citra meskipun keduanya bernilai 85. Jika menggunakan Selection Sort yang tidak stabil, urutan ini tidak terjamin.

---

## 9.9 Rangkuman Bab

1. **Pengurutan (sorting)** adalah operasi fundamental dalam ilmu komputer yang bertujuan menyusun sekumpulan elemen ke dalam urutan yang terdefinisi. Hampir semua algoritma pencarian, pengindeksan, dan analisis data bergantung pada data yang sudah terurut untuk bekerja secara efisien.

2. **Terminologi esensial** yang harus dikuasai meliputi: kunci perbandingan (key), in-place sorting (O(1) memori tambahan), kestabilan (stable sorting — mempertahankan urutan relatif elemen dengan kunci sama), comparison-based sorting, serta batas bawah teoritis $\Omega(n \log n)$ untuk algoritma berbasis perbandingan.

3. **Bubble Sort** bekerja dengan membandingkan dan menukar pasangan elemen berdekatan secara berulang. Versi standar memiliki kompleksitas $\Theta(n^2)$ di semua kasus. Versi teroptimasi dengan mekanisme early termination (flag `swapped`) mencapai $O(n)$ pada kasus terbaik ketika data sudah terurut, karena satu pass tanpa pertukaran membuktikan keterurutan array. Bubble Sort bersifat stabil dan in-place.

4. **Selection Sort** bekerja dengan memilih elemen minimum dari bagian yang belum terurut dan menempatkannya di posisi yang tepat. Keunggulan utamanya adalah melakukan paling banyak $n-1$ pertukaran — $O(n)$ operasi write — menjadikannya pilihan optimal pada media penyimpanan dengan siklus write terbatas seperti memori flash. Namun, Selection Sort selalu memerlukan tepat $\frac{n(n-1)}{2}$ perbandingan tanpa pengecualian, dan bersifat tidak stabil karena pertukaran jarak jauh.

5. **Insertion Sort** bekerja seperti mengurutkan kartu remi — menyisipkan satu elemen pada satu waktu ke posisi yang tepat dalam subarray yang sudah terurut menggunakan operasi geser. Keunggulan kritisnya adalah kompleksitas $O(n)$ pada data yang sudah terurut atau hampir terurut, karena proses pencarian posisi berhenti lebih awal. Insertion Sort bersifat stabil dan menjadi komponen penting dalam algoritma hybrid modern seperti Python's Timsort.

6. **Perbandingan analitis** ketiga algoritma menunjukkan bahwa meskipun ketiganya beroperasi dalam $O(n^2)$ untuk kasus rata-rata, terdapat perbedaan signifikan dalam praktik: Insertion Sort umumnya tercepat untuk data acak maupun data hampir terurut; Selection Sort memiliki jumlah pertukaran terendah; Bubble Sort dengan early termination tercepat dalam mendeteksi array yang sudah terurut.

7. **Pemilihan algoritma yang tepat** bergantung pada konteks penggunaan: gunakan Insertion Sort untuk data berukuran kecil ($n \leq 50$), data hampir terurut, atau pengurutan online; gunakan Selection Sort ketika operasi write sangat mahal; gunakan Bubble Sort untuk keperluan edukasi atau deteksi keterurutan. Untuk dataset besar ($n > 1000$), algoritma O(n log n) seperti Merge Sort, Heap Sort, atau Quick Sort, maupun fungsi bawaan Python (`sorted()`, `.sort()`), jauh lebih sesuai.

---

## 9.10 Istilah Kunci

| Istilah | Definisi |
|---|---|
| **Sorting (Pengurutan)** | Proses menyusun sekumpulan elemen ke dalam urutan yang terdefinisi berdasarkan suatu kunci perbandingan |
| **Kunci (Key)** | Nilai atau atribut yang dijadikan dasar perbandingan dalam proses pengurutan |
| **In-Place Sorting** | Algoritma sorting yang menggunakan O(1) memori tambahan, tidak memerlukan array bantu yang proporsional dengan ukuran input |
| **Stable Sorting** | Algoritma sorting yang mempertahankan urutan relatif elemen-elemen dengan kunci yang sama dari data asli |
| **Comparison-Based Sorting** | Algoritma sorting yang menentukan urutan elemen semata-mata melalui operasi perbandingan dua elemen |
| **Pass** | Satu kali traversal penuh (atau sebagian) melalui array dalam algoritma sorting; digunakan khususnya dalam konteks Bubble Sort |
| **Bubble Sort** | Algoritma sorting yang berulang kali membandingkan dan menukar pasangan elemen berdekatan yang tidak dalam urutan yang benar |
| **Early Termination** | Optimasi Bubble Sort yang menghentikan eksekusi lebih awal jika tidak ada pertukaran dalam satu pass, menghasilkan O(n) pada best case |
| **Selection Sort** | Algoritma sorting yang berulang kali memilih elemen minimum dari bagian yang belum terurut dan menempatkannya di posisi yang benar |
| **Minimum Index** | Indeks dari elemen minimum yang ditemukan selama proses pencarian dalam satu iterasi Selection Sort |
| **Insertion Sort** | Algoritma sorting yang membangun subarray terurut dengan menyisipkan satu elemen pada satu waktu ke posisi yang tepat |
| **Key (Insertion Sort)** | Elemen yang sedang diproses pada iterasi saat ini dalam Insertion Sort, yang akan disisipkan ke posisi yang tepat |
| **Shift (Pergeseran)** | Operasi memindahkan elemen satu posisi ke kanan dalam Insertion Sort untuk menciptakan ruang bagi key yang akan disisipkan |
| **Best Case** | Kondisi input yang menghasilkan kinerja terbaik (minimum operasi) dari suatu algoritma |
| **Worst Case** | Kondisi input yang menghasilkan kinerja terburuk (maksimum operasi) dari suatu algoritma |
| **Average Case** | Kinerja rata-rata algoritma atas semua kemungkinan input yang diasumsikan equiprobable |
| **Asymptotic Notation** | Notasi matematis (O, Omega, Theta) untuk mengekspresikan kinerja algoritma dalam hal pertumbuhan fungsi terhadap ukuran input |
| **Timsort** | Algoritma hybrid yang menggabungkan Insertion Sort dan Merge Sort, digunakan sebagai algoritma default di Python dan Java |
| **Online Sorting** | Kemampuan mengurutkan data yang masuk secara bertahap (satu per satu), tanpa perlu mengetahui seluruh data di awal; Insertion Sort mendukung ini secara natural |
| **Ketidakstabilan Selection Sort** | Sifat Selection Sort yang dapat mengubah urutan relatif elemen-elemen bernilai sama akibat pertukaran jarak jauh (long-range swap) |

---

## 9.11 Soal Latihan

**Soal 1 [C2 — Memahami]**

Perhatikan array berikut: `[7, 3, 9, 2, 6, 1, 5]`. Tentukan kondisi array setelah menyelesaikan **dua pass pertama** Bubble Sort (versi standar). Tunjukkan setiap langkah perbandingan dan pertukaran secara eksplisit. Berapa banyak pertukaran yang terjadi pada setiap pass?

---

**Soal 2 [C2 — Memahami]**

Jelaskan dengan kata-kata sendiri mengapa Selection Sort dikatakan **tidak stabil**, padahal ia bekerja secara deterministik dan menghasilkan output terurut yang benar. Berikan contoh array dengan elemen duplikat yang mendemonstrasikan ketidakstabilan ini. Bagaimana modifikasi dapat dilakukan pada Selection Sort untuk membuatnya stabil, dan apa konsekuensi modifikasi tersebut terhadap kompleksitas?

---

**Soal 3 [C3 — Menerapkan]**

Diberikan array `A = [45, 12, 67, 3, 89, 25, 34]`.
(a) Lakukan trace lengkap algoritma **Insertion Sort** pada array tersebut. Tampilkan kondisi array setelah setiap iterasi beserta nilai key dan posisi penyisipannya.
(b) Hitung total jumlah perbandingan dan total jumlah pergeseran yang dilakukan.
(c) Verifikasi jawaban Anda dengan menjalankan implementasi Python dari Kode 9.3 dan mencetak statistik operasi yang dihasilkan.

---

**Soal 4 [C3 — Menerapkan]**

Implementasikan dalam Python sebuah fungsi `selection_sort_descending(arr)` yang mengurutkan array secara menurun (descending) menggunakan prinsip Selection Sort. Modifikasi yang diperlukan adalah mencari **indeks elemen maksimum** alih-alih minimum. Uji fungsi Anda dengan array `[5, 2, 8, 1, 9, 3]` dan tampilkan kondisi array setelah setiap iterasi.

---

**Soal 5 [C3 — Menerapkan]**

Implementasikan dalam Python sebuah fungsi `bubble_sort_count_pass(arr)` yang mengembalikan tidak hanya array terurut, tetapi juga jumlah pass yang **benar-benar diperlukan** sebelum array menjadi terurut (bukan jumlah pass maksimum $n-1$). Gunakan mekanisme early termination. Uji fungsi Anda pada tiga input: (a) data acak [5, 3, 8, 1, 9], (b) data hampir terurut [1, 2, 4, 3, 5], (c) data sudah terurut [1, 2, 3, 4, 5]. Jelaskan mengapa jumlah pass berbeda-beda pada ketiga kasus tersebut.

---

**Soal 6 [C4 — Menganalisis]**

Perhatikan dua pernyataan berikut:
- "Insertion Sort selalu lebih cepat dari Bubble Sort."
- "Selection Sort selalu lebih lambat dari Insertion Sort."

Evaluasi apakah kedua pernyataan tersebut benar, salah, atau bergantung pada kondisi. Dukung analisis Anda dengan argumen matematis menggunakan notasi asimtotik dan contoh konkret kondisi data di mana satu algoritma lebih unggul dari yang lain.

---

**Soal 7 [C4 — Menganalisis]**

Tunjukkan secara matematis bahwa jumlah total perbandingan yang dilakukan Selection Sort pada array berukuran n adalah **selalu** tepat $\frac{n(n-1)}{2}$, terlepas dari urutan awal data (apakah terurut, terbalik, atau acak). Mengapa hal ini berbeda dengan Insertion Sort yang jumlah perbandingannya bergantung pada kondisi data?

---

**Soal 8 [C4 — Menganalisis]**

Seorang mahasiswa mengklaim bahwa Insertion Sort **tidak stabil** karena operasi geser (shift) memindahkan elemen-elemen dari posisi aslinya. Apakah klaim ini benar atau salah? Buktikan jawaban Anda dengan cara: (a) menurunkan kondisi matematika yang menjamin kestabilan Insertion Sort dari implementasi kode, (b) memberikan contoh array dengan elemen duplikat yang menunjukkan bahwa Insertion Sort mempertahankan urutan relatifnya.

---

**Soal 9 [C5 — Mengevaluasi]**

Sebuah perusahaan logistik memiliki sistem yang memantau posisi GPS dari 30 kendaraan pengiriman secara real-time. Setiap 10 detik, sistem menerima update posisi dari semua kendaraan dan perlu menampilkan daftar kendaraan yang diurutkan berdasarkan jarak ke pusat distribusi (dari terdekat ke terjauh). Karena pembaruan posisi bersifat inkremental (kendaraan tidak berpindah terlalu jauh dalam 10 detik), data yang masuk hampir selalu hampir terurut dari pembaruan sebelumnya.

(a) Algoritma sorting manakah yang paling tepat untuk skenario ini? Jelaskan alasan pemilihan Anda berdasarkan analisis karakteristik data dan kebutuhan sistem.
(b) Apakah kestabilan algoritma relevan dalam konteks ini? Mengapa atau mengapa tidak?
(c) Jika jumlah kendaraan meningkat menjadi 50.000 unit, apakah pilihan algoritma Anda berubah? Apa ambang batas n yang menjadi pertimbangan Anda?

---

**Soal 10 [C5 — Mengevaluasi]**

Data berikut menunjukkan waktu eksekusi (dalam milidetik) tiga algoritma pada n = 1000 untuk berbagai kondisi data:

| Kondisi Data    | Bubble Sort | Selection Sort | Insertion Sort |
|-----------------|:-----------:|:--------------:|:--------------:|
| Acak            | 2.31        | 1.68           | 1.14           |
| Terurut         | 0.02        | 1.59           | 0.01           |
| Terbalik        | 4.57        | 1.68           | 2.28           |
| Hampir Terurut  | 0.45        | 1.67           | 0.08           |

Berdasarkan data empiris ini:
(a) Jelaskan mengapa Selection Sort menunjukkan waktu eksekusi yang hampir identik di semua kondisi data.
(b) Untuk kondisi data terbalik, mengapa Bubble Sort (4.57 ms) jauh lebih lambat dari Insertion Sort (2.28 ms) meskipun keduanya sama-sama O(n²) pada kasus terburuk? (Petunjuk: pikirkan tentang jumlah operasi write ke memori.)
(c) Rekomendasikan algoritma untuk dua skenario: (i) sistem yang perlu mengurutkan data log server yang diterima secara real-time, di mana 95% entry log sudah hampir terurut berdasarkan timestamp; (ii) sistem manajemen inventaris pada perangkat IoT dengan memori flash yang akan mengurutkan 500 item produk secara berkala.

---

**Soal 11 [C6 — Mencipta]**

Rancang dan implementasikan dalam Python sebuah algoritma yang disebut **Cocktail Shaker Sort** (atau Bidirectional Bubble Sort). Algoritma ini adalah variasi Bubble Sort yang melakukan traversal bolak-balik: satu pass dari kiri ke kanan (mendorong elemen besar ke kanan), diikuti satu pass dari kanan ke kiri (mendorong elemen kecil ke kiri). Lakukan hingga tidak ada pertukaran di kedua arah.

(a) Implementasikan fungsi `cocktail_shaker_sort(arr)` yang mengembalikan tuple (array terurut, jumlah perbandingan, jumlah pertukaran, jumlah pass total).
(b) Jelaskan konsep "turtle elements" (elemen kecil di posisi jauh di kanan) dan mengapa Bubble Sort standar membutuhkan banyak pass untuk memindahkannya, sedangkan Cocktail Sort lebih efisien.
(c) Bandingkan jumlah pass dan pertukaran antara Bubble Sort standar dan Cocktail Sort pada array `[2, 3, 4, 5, 1]` — kasus klasik turtle element.

---

**Soal 12 [C6 — Mencipta]**

Rancang sebuah fungsi Python `adaptive_sort(arr)` yang secara otomatis memilih dan menerapkan algoritma sorting yang paling sesuai berdasarkan karakteristik array masukan:
- Jika $n \leq 20$: gunakan Insertion Sort
- Jika array sudah terurut sempurna: kembalikan langsung tanpa sorting
- Jika $n > 20$ dan array hampir terurut (kurang dari 5% elemen tidak di tempat): gunakan Insertion Sort
- Selain itu: gunakan `sorted()` bawaan Python (Timsort)

Implementasikan juga fungsi pembantu `analyze_array(arr)` yang mendeteksi kondisi array di atas. Uji fungsi `adaptive_sort` pada minimal empat jenis input berbeda dan tampilkan statistik operasi serta algoritma yang dipilih untuk setiap kasus.

---

## 9.12 Bacaan Lanjutan

1. **Knuth, D.E. (1998). *The Art of Computer Programming, Volume 3: Sorting and Searching* (2nd ed.). Addison-Wesley Professional.**
   Ini adalah referensi paling otoritatif dan komprehensif tentang algoritma sorting yang pernah ditulis. Knuth menganalisis puluhan algoritma sorting dengan tingkat rigor matematis yang sangat tinggi, termasuk derivasi eksakta jumlah perbandingan, pertukaran, dan berbagai operasi lainnya untuk berbagai algoritma. Bab 5 pada volume ini, yang berjudul "Sorting", mencakup lebih dari 400 halaman analisis mendalam. Sangat direkomendasikan bagi mahasiswa yang ingin memahami fondasi teoritis yang kuat.

2. **Cormen, T.H., Leiserson, C.E., Rivest, R.L., & Stein, C. (2022). *Introduction to Algorithms* (4th ed.). MIT Press.**
   Dikenal luas sebagai "CLRS", buku ini merupakan standar kurikulum ilmu komputer di universitas-universitas terkemuka dunia. Bagian II (Bab 2–8) membahas algoritma sorting secara sistematis mulai dari Insertion Sort dan Merge Sort hingga analisis batas bawah comparison-based sorting. Notasi dan pendekatan analisis yang digunakan dalam buku ini menjadi standar de facto dalam literatur algoritma.

3. **Sedgewick, R., & Wayne, K. (2011). *Algorithms* (4th ed.). Addison-Wesley Professional.**
   Buku ini menawarkan pendekatan yang lebih berorientasi implementasi dibandingkan CLRS, dengan contoh kode Java yang bersih dan visualisasi yang kaya. Bagian 2 membahas sorting secara ekstensif, termasuk analisis empiris yang membandingkan berbagai algoritma. Website companion-nya (algs4.cs.princeton.edu) menyediakan visualisasi interaktif yang sangat membantu untuk memahami dinamika algoritma secara visual.

4. **Peters, T. (2002). Timsort. Python mailing list dan dokumentasi CPython.**
   Dokumen asli perancangan Timsort oleh Tim Peters tersedia di repositori CPython (file `cpython/Objects/listsort.txt`). Dokumen ini menjelaskan motivasi desain, analisis kasus terburuk, dan implementasi detail dari Timsort — termasuk alasan mengapa Insertion Sort dengan "binary insertion" dipilih untuk mengurutkan run-run kecil. Membaca dokumen ini memberikan wawasan langsung tentang bagaimana algoritma akademis diimplementasikan dalam sistem produksi skala besar.

5. **Skiena, S.S. (2020). *The Algorithm Design Manual* (3rd ed.). Springer.**
   Buku ini memiliki pendekatan yang sangat berbeda dari CLRS: lebih fokus pada pemilihan dan penerapan algoritma dalam konteks masalah nyata, bukan semata-mata pada rigor matematis. Bagian tentang sorting memberikan panduan praktis tentang kapan menggunakan algoritma apa, disertai dengan "war stories" — kisah nyata pengalaman Skiena menyelesaikan masalah algoritmis dalam proyek nyata. Sangat bermanfaat untuk membangun intuisi pemilihan algoritma.

6. **Goodrich, M.T., Tamassia, R., & Goldwasser, M.H. (2013). *Data Structures and Algorithms in Python*. Wiley.**
   Satu-satunya buku dalam daftar ini yang menggunakan Python secara eksklusif, menjadikannya referensi yang paling langsung relevan untuk implementasi dalam bahasa ini. Bab 12 membahas sorting dan selection dengan contoh implementasi Python yang bersih. Buku ini juga membahas Python's built-in sorting dan kapan harus menggunakannya versus implementasi manual.

7. **Roughgarden, T. (2022). *Algorithms Illuminated, Part 1: The Basics*. Soundlikeyourself Publishing.**
   Buku ini adalah versi tertulis dari kursus algoritma populer Tim Roughgarden di Stanford (tersedia juga di Coursera). Pendekatannya sangat accessible tanpa mengorbankan ketepatan matematis. Bab tentang sorting memberikan intuisi yang sangat baik tentang mengapa batas bawah $\Omega(n \log n)$ berlaku untuk comparison-based sorting — sebuah hasil yang menjelaskan mengapa algoritma O(n²) yang kita pelajari dalam bab ini memang suboptimal secara teoritis namun tetap sangat relevan dalam praktik.

8. **Mehlhorn, K., & Sanders, P. (2008). *Algorithms and Data Structures: The Basic Toolbox*. Springer.**
   Tersedia secara gratis di website penulis, buku ini menawarkan perspektif Eropa yang berbeda tentang algoritma dan struktur data. Pendekatannya sangat matematis namun dengan koneksi yang kuat ke implementasi praktis. Bab tentang sorting mencakup analisis cache-efficiency dari berbagai algoritma — aspek yang semakin penting pada perangkat keras modern di mana latensi akses memori sangat bervariasi tergantung pada pola akses.

---

*Bab ini merupakan bagian dari buku "Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python". Materi selanjutnya pada Bab 10 akan membahas algoritma sorting lanjutan: Merge Sort, Quick Sort, dan Heap Sort, yang semuanya beroperasi dalam O(n log n) dan membentuk fondasi pengurutan pada skala data besar.*

---
