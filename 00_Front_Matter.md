# STRUKTUR DATA
## Konsep, Implementasi, dan Aplikasi dengan Python

---

&nbsp;

&nbsp;

&nbsp;

# STRUKTUR DATA
# Konsep, Implementasi, dan Aplikasi dengan Python

*Dari Teori Fundamental hingga Penerapan Industri Modern*

&nbsp;

&nbsp;

**[Nama Penulis]**

&nbsp;

&nbsp;

---

**INSTITUT BISNIS DAN TEKNOLOGI INDONESIA**
**(INSTIKI)**

&nbsp;

Denpasar, 2025

---

&nbsp;

<!-- ============================================================ -->
<!-- HALAMAN HAK CIPTA -->
<!-- ============================================================ -->

&nbsp;

&nbsp;

**Hak Cipta dilindungi undang-undang.**

Dilarang memperbanyak, menyebarluaskan, dan/atau memindahkan sebagian atau seluruh isi buku ini dalam bentuk apapun, baik secara elektronik maupun mekanis, termasuk fotokopi, perekaman, atau dengan sistem penyimpanan dan pengambilan informasi manapun, tanpa izin tertulis dari penulis dan penerbit, kecuali dalam kutipan singkat untuk keperluan ulasan atau kajian ilmiah dengan penyebutan sumber yang jelas.

&nbsp;

**Hak Cipta (c) 2025 oleh [Nama Penulis]**

Diterbitkan oleh:
Institut Bisnis dan Teknologi Indonesia (INSTIKI)
Jalan Gunung Agung No. 99B, Denpasar, Bali 80117
Telepon: (0361) 414812
Surel: info@instiki.ac.id
Laman: https://www.instiki.ac.id

&nbsp;

**Edisi Pertama, 2025**

&nbsp;

---

**Data Katalog Dalam Terbitan (KDT)**
*Perpustakaan Nasional Republik Indonesia*

[Nama Penulis]

Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python /
[Nama Penulis]. -- Edisi 1. -- Denpasar: Institut Bisnis dan Teknologi Indonesia, 2025.

xvi + 520 hlm.; 17 x 24 cm.

ISBN: xxx-xxx-xxxxx-x-x

1. Struktur Data.   2. Algoritma.   3. Python (Bahasa Pemrograman).
I. Judul.

005.73

---

**ISBN:** xxx-xxx-xxxxx-x-x

&nbsp;

**Catatan Penerbit:**

Informasi yang terdapat dalam buku ini bersumber dari pengetahuan dan pengalaman penulis serta referensi yang tercantum dalam daftar pustaka. Penulis dan penerbit telah berupaya semaksimal mungkin memastikan keakuratan isi buku ini pada saat penerbitan. Namun demikian, penulis dan penerbit tidak bertanggung jawab atas kerugian atau kerusakan yang timbul akibat penggunaan informasi yang terdapat dalam buku ini. Nama-nama produk, merek dagang, dan nama perusahaan yang disebutkan dalam buku ini merupakan hak milik masing-masing pemegang hak yang sah.

Kode sumber (source code) yang terdapat dalam buku ini dapat diunduh melalui repositori resmi yang disediakan oleh penulis. Kode sumber tersebut dilisensikan di bawah MIT License kecuali dinyatakan lain.

&nbsp;

Dicetak di Indonesia

---

&nbsp;

&nbsp;

<!-- ============================================================ -->
<!-- PRAKATA -->
<!-- ============================================================ -->

# PRAKATA

Struktur data merupakan salah satu fondasi terpenting dalam ilmu komputer dan rekayasa perangkat lunak. Pemahaman yang kuat terhadap cara mengorganisasi, menyimpan, dan mengelola data secara efisien menjadi prasyarat utama bagi setiap pengembang perangkat lunak yang ingin menghasilkan solusi yang andal, skalabel, dan berkinerja tinggi. Sayangnya, referensi berbahasa Indonesia yang membahas topik ini secara komprehensif—mulai dari konsep dasar hingga penerapan pada kasus nyata industri—masih sangat terbatas. Keterbatasan inilah yang menjadi motivasi utama penulisan buku ini.

Buku *Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python* hadir sebagai upaya untuk mengisi celah tersebut. Buku ini ditulis dengan keyakinan bahwa mahasiswa Indonesia berhak memperoleh materi pembelajaran berkualitas tinggi dalam bahasa ibunya, sehingga energi yang seharusnya digunakan untuk memahami konsep tidak terkuras hanya untuk mencerna bahasa asing. Dengan demikian, diharapkan proses belajar menjadi lebih efektif, menyenangkan, dan bermakna.

**Keunikan dan Pendekatan Buku Ini**

Terdapat beberapa hal yang membedakan buku ini dari referensi serupa yang telah ada. Pertama, buku ini menggunakan **Python** sebagai bahasa implementasi utama. Python dipilih bukan semata-mata karena popularitasnya, melainkan karena sintaksnya yang bersih dan ekspresif memungkinkan penulisan kode yang sangat dekat dengan pseudocode, sehingga pembaca dapat lebih berkonsentrasi pada logika struktur data daripada terganggu oleh kerumitan sintaks bahasa pemrograman. Selain itu, ekosistem Python yang kaya dan relevansinya di industri—mulai dari pengembangan web, ilmu data, hingga kecerdasan buatan—menjadikannya pilihan yang sangat strategis.

Kedua, buku ini mengintegrasikan **teori dan praktik** secara seimbang. Setiap bab diawali dengan landasan teoritis yang kuat, dilanjutkan dengan analisis kompleksitas algoritmik, kemudian diwujudkan dalam implementasi Python yang lengkap dan dapat langsung dijalankan. Setiap konsep diperjelas dengan ilustrasi visual dan contoh-contoh nyata yang relevan.

Ketiga, buku ini berorientasi **industri**. Di akhir setiap bab terdapat bagian yang menghubungkan konsep yang dipelajari dengan penerapannya pada sistem nyata—misalnya bagaimana antrian digunakan dalam sistem manajemen printer atau antrean layanan pelanggan, bagaimana pohon digunakan dalam sistem berkas, atau bagaimana graf digunakan dalam navigasi dan jejaring sosial. Orientasi ini bertujuan agar mahasiswa memahami relevansi dan nilai praktis dari setiap topik yang dipelajari.

**Sasaran Pembaca dan Prasyarat**

Buku ini dirancang terutama untuk mahasiswa program studi Strata Satu (S1) Teknik Informatika pada semester III yang sedang mengambil mata kuliah Struktur Data. Meskipun demikian, buku ini juga dapat dimanfaatkan oleh mahasiswa dari program studi terkait seperti Sistem Informasi, Ilmu Komputer, dan Rekayasa Perangkat Lunak.

Prasyarat yang perlu dimiliki pembaca adalah:
1. Pengetahuan dasar pemrograman Python (variabel, tipe data, perulangan, fungsi, dan pemrograman berorientasi objek dasar).
2. Pemahaman dasar logika matematika dan konsep himpunan.
3. Kemampuan membaca pseudocode sederhana.

Bagi pembaca yang belum memiliki pengetahuan dasar Python, disarankan untuk terlebih dahulu mempelajari buku atau referensi pengantar pemrograman Python sebelum menggunakan buku ini.

**Cara Menggunakan Buku Ini**

Buku ini dapat digunakan dalam berbagai konteks pembelajaran:

- **Sebagai bahan kuliah**: Dosen dapat menggunakan buku ini sebagai bahan ajar utama dengan mengikuti urutan bab secara sekuensial. Setiap bab dirancang untuk satu hingga dua kali pertemuan kuliah, dilengkapi dengan latihan soal dan proyek mini di akhir bab.

- **Untuk belajar mandiri**: Pembaca yang belajar secara mandiri dapat mengikuti urutan bab dari awal hingga akhir. Tersedia soal latihan dengan tingkat kesulitan berjenjang—dari dasar (Pemahaman), menengah (Penerapan), hingga lanjutan (Analisis dan Tantangan)—untuk mengukur pemahaman secara bertahap.

- **Sebagai buku referensi**: Praktisi dan pengembang perangkat lunak dapat menggunakan buku ini sebagai referensi cepat. Setiap bab bersifat mandiri sehingga pembaca dapat langsung menuju bab yang relevan dengan kebutuhan spesifiknya.

**Peta Topik Antar Bab**

Buku ini disusun dalam empat bagian besar yang saling berkaitan. **Bagian I** (Bab 1-2) membangun fondasi konseptual, memperkenalkan definisi struktur data dan cara menganalisis efisiensi algoritma menggunakan notasi Big-O. **Bagian II** (Bab 3-8) membahas struktur data linear secara mendalam, mencakup array, string, linked list dalam berbagai varian, stack, queue, dan rekursi sebagai teknik algoritmik yang mendasari banyak struktur data lanjutan. **Bagian III** (Bab 9-11) didedikasikan untuk algoritma pengurutan dan pencarian, dua operasi fundamental yang menentukan performa sebagian besar sistem perangkat lunak. **Bagian IV** (Bab 12-14) mengeksplorasi struktur data nonlinear—pohon biner, pohon pencarian biner, heap, serta graf—yang menjadi tulang punggung berbagai aplikasi canggih di dunia nyata.

**Ucapan Terima Kasih**

Penulisan buku ini tidak akan terwujud tanpa dukungan dan kontribusi dari berbagai pihak. Penulis mengucapkan terima kasih yang sebesar-besarnya kepada pimpinan Institut Bisnis dan Teknologi Indonesia (INSTIKI) atas dukungan kelembagaan yang diberikan. Terima kasih kepada seluruh rekan dosen di Program Studi Teknik Informatika INSTIKI atas diskusi-diskusi yang memperkaya perspektif penulis. Terima kasih kepada para mahasiswa yang telah memberikan masukan berharga selama proses perkuliahan berlangsung—pertanyaan-pertanyaan mereka yang tajam sesungguhnya adalah inspirasi terbesar bagi penulisan buku ini.

Penulis menyadari bahwa buku ini masih jauh dari sempurna. Saran dan kritik yang membangun dari pembaca sangat penulis harapkan demi perbaikan pada edisi-edisi mendatang. Saran dapat disampaikan melalui alamat surel yang tercantum di halaman hak cipta.

Semoga buku ini memberi manfaat yang nyata bagi perkembangan pendidikan ilmu komputer di Indonesia.

&nbsp;

Denpasar, 2025

&nbsp;

**[Nama Penulis]**

---

&nbsp;

&nbsp;

<!-- ============================================================ -->
<!-- DAFTAR ISI -->
<!-- ============================================================ -->

# DAFTAR ISI

[Halaman Judul](#halaman-judul) ..... i

[Halaman Hak Cipta](#halaman-hak-cipta) ..... ii

[Prakata](#prakata) ..... iii

[Daftar Isi](#daftar-isi) ..... vi

[Daftar Gambar](#daftar-gambar) ..... xi

[Daftar Tabel](#daftar-tabel) ..... xiv

---

## BAB 1: PENGANTAR STRUKTUR DATA ..... 1

1.1 Definisi dan Konsep Dasar Struktur Data ..... 2

1.2 Mengapa Struktur Data Penting? ..... 5

1.3 Klasifikasi Struktur Data ..... 8

&nbsp;&nbsp;&nbsp;&nbsp;1.3.1 Struktur Data Primitif ..... 9

&nbsp;&nbsp;&nbsp;&nbsp;1.3.2 Struktur Data Non-Primitif ..... 10

&nbsp;&nbsp;&nbsp;&nbsp;1.3.3 Struktur Data Linear dan Non-Linear ..... 12

1.4 Hubungan Struktur Data dan Algoritma ..... 14

1.5 Tipe Data Abstrak (Abstract Data Type / ADT) ..... 17

1.6 Python sebagai Bahasa Implementasi ..... 21

&nbsp;&nbsp;&nbsp;&nbsp;1.6.1 Tipe Data Bawaan Python ..... 22

&nbsp;&nbsp;&nbsp;&nbsp;1.6.2 Pemrograman Berorientasi Objek dalam Python ..... 25

1.7 Lingkungan Pengembangan ..... 29

1.8 Studi Kasus: Pemilihan Struktur Data yang Tepat ..... 32

Rangkuman ..... 35

Latihan Soal ..... 36

---

## BAB 2: ANALISIS KOMPLEKSITAS ALGORITMA ..... 39

2.1 Pendahuluan: Mengapa Menganalisis Efisiensi? ..... 40

2.2 Konsep Kompleksitas Waktu dan Ruang ..... 43

2.3 Notasi Asimptotik ..... 47

&nbsp;&nbsp;&nbsp;&nbsp;2.3.1 Notasi Big-O (O) ..... 48

&nbsp;&nbsp;&nbsp;&nbsp;2.3.2 Notasi Omega (O) ..... 53

&nbsp;&nbsp;&nbsp;&nbsp;2.3.3 Notasi Theta (Th) ..... 55

2.4 Kelas-Kelas Kompleksitas Umum ..... 57

&nbsp;&nbsp;&nbsp;&nbsp;2.4.1 O(1) — Kompleksitas Konstan ..... 58

&nbsp;&nbsp;&nbsp;&nbsp;2.4.2 O(log n) — Kompleksitas Logaritmik ..... 59

&nbsp;&nbsp;&nbsp;&nbsp;2.4.3 O(n) — Kompleksitas Linear ..... 61

&nbsp;&nbsp;&nbsp;&nbsp;2.4.4 O(n log n) — Kompleksitas Linearitmik ..... 63

&nbsp;&nbsp;&nbsp;&nbsp;2.4.5 O(n^2) — Kompleksitas Kuadratik ..... 64

&nbsp;&nbsp;&nbsp;&nbsp;2.4.6 O(2^n) dan O(n!) — Kompleksitas Eksponensial ..... 66

2.5 Analisis Kasus Terbaik, Rata-Rata, dan Terburuk ..... 68

2.6 Analisis Kompleksitas Ruang ..... 72

2.7 Teknik Analisis Algoritma ..... 75

2.8 Pengukuran Kinerja dengan Python ..... 79

2.9 Studi Kasus: Membandingkan Dua Algoritma ..... 83

Rangkuman ..... 87

Latihan Soal ..... 88

---

## BAB 3: ARRAY DAN STRING ..... 91

3.1 Konsep Dasar Array ..... 92

3.2 Array Satu Dimensi ..... 95

&nbsp;&nbsp;&nbsp;&nbsp;3.2.1 Deklarasi dan Inisialisasi ..... 96

&nbsp;&nbsp;&nbsp;&nbsp;3.2.2 Operasi Dasar pada Array ..... 98

3.3 Array Multi Dimensi ..... 105

&nbsp;&nbsp;&nbsp;&nbsp;3.3.1 Array Dua Dimensi (Matriks) ..... 106

&nbsp;&nbsp;&nbsp;&nbsp;3.3.2 Operasi Matriks ..... 109

3.4 List Python sebagai Array Dinamis ..... 114

3.5 Array dengan Modul `array` dan NumPy ..... 119

3.6 Konsep dan Representasi String ..... 123

3.7 Operasi-Operasi pada String ..... 126

3.8 Algoritma Pencocokan Pola String ..... 132

&nbsp;&nbsp;&nbsp;&nbsp;3.8.1 Algoritma Brute Force ..... 133

&nbsp;&nbsp;&nbsp;&nbsp;3.8.2 Algoritma Knuth-Morris-Pratt (KMP) ..... 136

3.9 Studi Kasus: Matriks Sparse ..... 141

Rangkuman ..... 145

Latihan Soal ..... 146

---

## BAB 4: SINGLY LINKED LIST ..... 149

4.1 Keterbatasan Array dan Motivasi Linked List ..... 150

4.2 Konsep Linked List ..... 153

4.3 Struktur Node ..... 156

4.4 Operasi pada Singly Linked List ..... 159

&nbsp;&nbsp;&nbsp;&nbsp;4.4.1 Penyisipan Node ..... 160

&nbsp;&nbsp;&nbsp;&nbsp;4.4.2 Penghapusan Node ..... 167

&nbsp;&nbsp;&nbsp;&nbsp;4.4.3 Penelusuran (Traversal) ..... 173

&nbsp;&nbsp;&nbsp;&nbsp;4.4.4 Pencarian Node ..... 175

4.5 Implementasi Lengkap Singly Linked List ..... 177

4.6 Analisis Kompleksitas ..... 184

4.7 Perbandingan Array dan Linked List ..... 186

4.8 Studi Kasus: Daftar Putar Musik ..... 189

Rangkuman ..... 193

Latihan Soal ..... 194

---

## BAB 5: LINKED LIST LANJUTAN ..... 197

5.1 Doubly Linked List ..... 198

&nbsp;&nbsp;&nbsp;&nbsp;5.1.1 Struktur Node Doubly Linked List ..... 199

&nbsp;&nbsp;&nbsp;&nbsp;5.1.2 Operasi pada Doubly Linked List ..... 201

&nbsp;&nbsp;&nbsp;&nbsp;5.1.3 Implementasi Lengkap ..... 208

5.2 Circular Linked List ..... 214

&nbsp;&nbsp;&nbsp;&nbsp;5.2.1 Circular Singly Linked List ..... 215

&nbsp;&nbsp;&nbsp;&nbsp;5.2.2 Circular Doubly Linked List ..... 220

5.3 Analisis Kompleksitas dan Perbandingan Varian ..... 225

5.4 Linked List pada Pustaka Standar Python ..... 228

5.5 Studi Kasus: Manajemen Memori Sederhana ..... 231

Rangkuman ..... 236

Latihan Soal ..... 237

---

## BAB 6: STACK ..... 239

6.1 Konsep dan Definisi Stack ..... 240

6.2 Prinsip LIFO ..... 243

6.3 Operasi Dasar Stack ..... 245

&nbsp;&nbsp;&nbsp;&nbsp;6.3.1 Push ..... 246

&nbsp;&nbsp;&nbsp;&nbsp;6.3.2 Pop ..... 247

&nbsp;&nbsp;&nbsp;&nbsp;6.3.3 Peek/Top ..... 248

6.4 Implementasi Stack dengan Array ..... 249

6.5 Implementasi Stack dengan Linked List ..... 255

6.6 Analisis Kompleksitas ..... 260

6.7 Aplikasi Stack ..... 261

&nbsp;&nbsp;&nbsp;&nbsp;6.7.1 Evaluasi Ekspresi Postfix ..... 262

&nbsp;&nbsp;&nbsp;&nbsp;6.7.2 Konversi Notasi Ekspresi ..... 267

&nbsp;&nbsp;&nbsp;&nbsp;6.7.3 Pengecekan Keseimbangan Tanda Kurung ..... 272

&nbsp;&nbsp;&nbsp;&nbsp;6.7.4 Mekanisme Undo/Redo ..... 275

6.8 Stack dalam Python: Modul `collections.deque` ..... 278

6.9 Studi Kasus: Navigasi Peramban Web ..... 281

Rangkuman ..... 285

Latihan Soal ..... 286

---

## BAB 7: QUEUE ..... 289

7.1 Konsep dan Definisi Queue ..... 290

7.2 Prinsip FIFO ..... 293

7.3 Operasi Dasar Queue ..... 295

&nbsp;&nbsp;&nbsp;&nbsp;7.3.1 Enqueue ..... 296

&nbsp;&nbsp;&nbsp;&nbsp;7.3.2 Dequeue ..... 297

&nbsp;&nbsp;&nbsp;&nbsp;7.3.3 Peek/Front ..... 298

7.4 Implementasi Queue dengan Array ..... 299

7.5 Circular Queue ..... 305

7.6 Implementasi Queue dengan Linked List ..... 311

7.7 Deque (Double-Ended Queue) ..... 316

7.8 Priority Queue ..... 321

7.9 Analisis Kompleksitas ..... 327

7.10 Queue dalam Python: `collections.deque` dan `queue.Queue` ..... 329

7.11 Studi Kasus: Sistem Simulasi Antrian Layanan ..... 333

Rangkuman ..... 338

Latihan Soal ..... 339

---

## BAB 8: REKURSI ..... 341

8.1 Konsep Rekursi ..... 342

8.2 Anatomi Fungsi Rekursif ..... 345

&nbsp;&nbsp;&nbsp;&nbsp;8.2.1 Base Case ..... 346

&nbsp;&nbsp;&nbsp;&nbsp;8.2.2 Recursive Case ..... 347

8.3 Rekursi vs. Iterasi ..... 349

8.4 Analisis Kompleksitas Fungsi Rekursif ..... 353

&nbsp;&nbsp;&nbsp;&nbsp;8.4.1 Pohon Rekursi ..... 354

&nbsp;&nbsp;&nbsp;&nbsp;8.4.2 Master Theorem ..... 357

8.5 Contoh-Contoh Rekursi Klasik ..... 360

&nbsp;&nbsp;&nbsp;&nbsp;8.5.1 Faktorial ..... 361

&nbsp;&nbsp;&nbsp;&nbsp;8.5.2 Deret Fibonacci ..... 363

&nbsp;&nbsp;&nbsp;&nbsp;8.5.3 Menara Hanoi ..... 366

8.6 Memoization dan Dynamic Programming ..... 370

8.7 Tail Recursion ..... 376

8.8 Studi Kasus: Fraktal dan Kurva Koch ..... 379

Rangkuman ..... 383

Latihan Soal ..... 384

---

## BAB 9: ALGORITMA SORTING DASAR ..... 387

9.1 Pendahuluan: Masalah Pengurutan ..... 388

9.2 Terminologi dan Klasifikasi Algoritma Sorting ..... 391

9.3 Bubble Sort ..... 394

&nbsp;&nbsp;&nbsp;&nbsp;9.3.1 Algoritma dan Implementasi ..... 395

&nbsp;&nbsp;&nbsp;&nbsp;9.3.2 Analisis Kompleksitas ..... 399

9.4 Selection Sort ..... 402

&nbsp;&nbsp;&nbsp;&nbsp;9.4.1 Algoritma dan Implementasi ..... 403

&nbsp;&nbsp;&nbsp;&nbsp;9.4.2 Analisis Kompleksitas ..... 407

9.5 Insertion Sort ..... 409

&nbsp;&nbsp;&nbsp;&nbsp;9.5.1 Algoritma dan Implementasi ..... 410

&nbsp;&nbsp;&nbsp;&nbsp;9.5.2 Analisis Kompleksitas ..... 414

9.6 Shell Sort ..... 416

9.7 Perbandingan Algoritma Sorting Dasar ..... 421

9.8 Studi Kasus: Mengurutkan Data Siswa ..... 424

Rangkuman ..... 428

Latihan Soal ..... 429

---

## BAB 10: ALGORITMA SORTING LANJUTAN ..... 431

10.1 Divide and Conquer dalam Pengurutan ..... 432

10.2 Merge Sort ..... 435

&nbsp;&nbsp;&nbsp;&nbsp;10.2.1 Algoritma dan Implementasi ..... 436

&nbsp;&nbsp;&nbsp;&nbsp;10.2.2 Analisis Kompleksitas ..... 441

10.3 Quick Sort ..... 444

&nbsp;&nbsp;&nbsp;&nbsp;10.3.1 Pemilihan Pivot ..... 445

&nbsp;&nbsp;&nbsp;&nbsp;10.3.2 Algoritma dan Implementasi ..... 447

&nbsp;&nbsp;&nbsp;&nbsp;10.3.3 Analisis Kompleksitas ..... 452

10.4 Heap Sort ..... 455

10.5 Counting Sort ..... 461

10.6 Radix Sort ..... 466

10.7 Perbandingan Menyeluruh Algoritma Sorting ..... 471

10.8 Fungsi `sort()` dan `sorted()` pada Python ..... 474

10.9 Studi Kasus: Implementasi Timsort ..... 477

Rangkuman ..... 481

Latihan Soal ..... 482

---

## BAB 11: ALGORITMA SEARCHING DAN HASHING ..... 485

11.1 Masalah Pencarian ..... 486

11.2 Linear Search ..... 489

11.3 Binary Search ..... 493

&nbsp;&nbsp;&nbsp;&nbsp;11.3.1 Implementasi Iteratif ..... 494

&nbsp;&nbsp;&nbsp;&nbsp;11.3.2 Implementasi Rekursif ..... 497

&nbsp;&nbsp;&nbsp;&nbsp;11.3.3 Analisis Kompleksitas ..... 499

11.4 Interpolation Search ..... 501

11.5 Konsep Hashing ..... 505

11.6 Fungsi Hash ..... 508

11.7 Collision Resolution ..... 513

&nbsp;&nbsp;&nbsp;&nbsp;11.7.1 Chaining (Open Hashing) ..... 514

&nbsp;&nbsp;&nbsp;&nbsp;11.7.2 Open Addressing ..... 518

11.8 Implementasi Hash Table ..... 522

11.9 Dictionary Python sebagai Hash Table ..... 528

11.10 Analisis Kompleksitas Hash Table ..... 531

11.11 Studi Kasus: Sistem Deteksi Duplikat Data ..... 534

Rangkuman ..... 538

Latihan Soal ..... 539

---

## BAB 12: TREE DAN BINARY SEARCH TREE ..... 541

12.1 Konsep dan Terminologi Tree ..... 542

12.2 Representasi Tree ..... 548

12.3 Binary Tree ..... 552

&nbsp;&nbsp;&nbsp;&nbsp;12.3.1 Definisi dan Properti ..... 553

&nbsp;&nbsp;&nbsp;&nbsp;12.3.2 Jenis-Jenis Binary Tree ..... 555

12.4 Traversal Binary Tree ..... 558

&nbsp;&nbsp;&nbsp;&nbsp;12.4.1 Preorder Traversal ..... 559

&nbsp;&nbsp;&nbsp;&nbsp;12.4.2 Inorder Traversal ..... 562

&nbsp;&nbsp;&nbsp;&nbsp;12.4.3 Postorder Traversal ..... 565

&nbsp;&nbsp;&nbsp;&nbsp;12.4.4 Level-Order Traversal ..... 568

12.5 Binary Search Tree (BST) ..... 571

&nbsp;&nbsp;&nbsp;&nbsp;12.5.1 Properti BST ..... 572

&nbsp;&nbsp;&nbsp;&nbsp;12.5.2 Operasi Sisipan ..... 574

&nbsp;&nbsp;&nbsp;&nbsp;12.5.3 Operasi Pencarian ..... 578

&nbsp;&nbsp;&nbsp;&nbsp;12.5.4 Operasi Penghapusan ..... 581

12.6 Analisis Kompleksitas BST ..... 587

12.7 Studi Kasus: Sistem Berkas Hierarkis ..... 590

Rangkuman ..... 594

Latihan Soal ..... 595

---

## BAB 13: TREE LANJUTAN DAN HEAP ..... 597

13.1 Permasalahan BST Tidak Seimbang ..... 598

13.2 AVL Tree ..... 601

&nbsp;&nbsp;&nbsp;&nbsp;13.2.1 Faktor Keseimbangan ..... 602

&nbsp;&nbsp;&nbsp;&nbsp;13.2.2 Rotasi AVL ..... 604

&nbsp;&nbsp;&nbsp;&nbsp;13.2.3 Implementasi ..... 609

13.3 Red-Black Tree (Konseptual) ..... 615

13.4 B-Tree (Konseptual) ..... 619

13.5 Trie (Prefix Tree) ..... 623

13.6 Konsep dan Sifat Heap ..... 629

13.7 Min-Heap dan Max-Heap ..... 633

13.8 Operasi pada Heap ..... 636

&nbsp;&nbsp;&nbsp;&nbsp;13.8.1 Heapify ..... 637

&nbsp;&nbsp;&nbsp;&nbsp;13.8.2 Insert ..... 640

&nbsp;&nbsp;&nbsp;&nbsp;13.8.3 Extract-Min / Extract-Max ..... 643

13.9 Implementasi Heap dengan Array ..... 646

13.10 Modul `heapq` Python ..... 651

13.11 Priority Queue dengan Heap ..... 654

13.12 Studi Kasus: Autocomplete dengan Trie ..... 657

Rangkuman ..... 661

Latihan Soal ..... 662

---

## BAB 14: GRAPH ..... 665

14.1 Konsep dan Definisi Graf ..... 666

14.2 Terminologi Graf ..... 669

14.3 Jenis-Jenis Graf ..... 673

14.4 Representasi Graf ..... 677

&nbsp;&nbsp;&nbsp;&nbsp;14.4.1 Matriks Ketetanggaan (Adjacency Matrix) ..... 678

&nbsp;&nbsp;&nbsp;&nbsp;14.4.2 Daftar Ketetanggaan (Adjacency List) ..... 682

14.5 Penelusuran Graf ..... 686

&nbsp;&nbsp;&nbsp;&nbsp;14.5.1 Breadth-First Search (BFS) ..... 687

&nbsp;&nbsp;&nbsp;&nbsp;14.5.2 Depth-First Search (DFS) ..... 693

14.6 Deteksi Siklus ..... 699

14.7 Topological Sort ..... 703

14.8 Shortest Path ..... 708

&nbsp;&nbsp;&nbsp;&nbsp;14.8.1 Algoritma Dijkstra ..... 709

&nbsp;&nbsp;&nbsp;&nbsp;14.8.2 Algoritma Bellman-Ford ..... 715

14.9 Minimum Spanning Tree ..... 719

&nbsp;&nbsp;&nbsp;&nbsp;14.9.1 Algoritma Kruskal ..... 720

&nbsp;&nbsp;&nbsp;&nbsp;14.9.2 Algoritma Prim ..... 725

14.10 Graf dalam Python: Pustaka NetworkX ..... 729

14.11 Studi Kasus: Sistem Navigasi dan Rekomendasi ..... 733

Rangkuman ..... 738

Latihan Soal ..... 739

---

[Daftar Gambar](#daftar-gambar) ..... xi

[Daftar Tabel](#daftar-tabel) ..... xiv

[Glosarium](#glosarium) ..... 741

[Daftar Pustaka](#daftar-pustaka) ..... 755

[Indeks](#indeks) ..... 763

---

&nbsp;

&nbsp;

<!-- ============================================================ -->
<!-- DAFTAR GAMBAR -->
<!-- ============================================================ -->

# DAFTAR GAMBAR

**Bab 1: Pengantar Struktur Data**

Gambar 1.1: Klasifikasi struktur data berdasarkan sifat penyimpanan ..... 11

Gambar 1.2: Hierarki tipe data dalam ilmu komputer ..... 13

Gambar 1.3: Hubungan antara algoritma, struktur data, dan program ..... 15

Gambar 1.4: Diagram konsep Abstract Data Type (ADT) ..... 19

Gambar 1.5: Contoh diagram kelas Python dengan pewarisan ..... 27

**Bab 2: Analisis Kompleksitas Algoritma**

Gambar 2.1: Grafik perbandingan pertumbuhan fungsi kompleksitas ..... 47

Gambar 2.2: Ilustrasi batas atas (Big-O) secara grafis ..... 50

Gambar 2.3: Ilustrasi batas bawah (Big-Omega) secara grafis ..... 54

Gambar 2.4: Ilustrasi batas ketat (Big-Theta) secara grafis ..... 56

Gambar 2.5: Perbandingan kinerja algoritma O(1), O(log n), O(n), O(n log n), O(n^2) ..... 67

**Bab 3: Array dan String**

Gambar 3.1: Representasi memori array satu dimensi ..... 94

Gambar 3.2: Ilustrasi operasi sisipan pada array ..... 100

Gambar 3.3: Ilustrasi operasi penghapusan pada array ..... 103

Gambar 3.4: Representasi matriks dua dimensi dalam memori ..... 108

Gambar 3.5: Contoh matriks sparse dan representasi alternatifnya ..... 143

**Bab 4: Singly Linked List**

Gambar 4.1: Perbandingan alokasi memori array dan linked list ..... 152

Gambar 4.2: Struktur node singly linked list ..... 157

Gambar 4.3: Ilustrasi penyisipan node di awal linked list ..... 162

Gambar 4.4: Ilustrasi penyisipan node di tengah linked list ..... 165

Gambar 4.5: Ilustrasi penyisipan node di akhir linked list ..... 167

Gambar 4.6: Ilustrasi penghapusan node dari linked list ..... 170

**Bab 5: Linked List Lanjutan**

Gambar 5.1: Struktur node doubly linked list ..... 200

Gambar 5.2: Ilustrasi traversal dua arah pada doubly linked list ..... 204

Gambar 5.3: Struktur circular singly linked list ..... 216

Gambar 5.4: Struktur circular doubly linked list ..... 221

**Bab 6: Stack**

Gambar 6.1: Ilustrasi prinsip LIFO pada stack ..... 241

Gambar 6.2: Animasi operasi push dan pop pada stack ..... 246

Gambar 6.3: Representasi stack menggunakan array ..... 252

Gambar 6.4: Representasi stack menggunakan linked list ..... 257

Gambar 6.5: Contoh evaluasi ekspresi postfix langkah demi langkah ..... 264

**Bab 7: Queue**

Gambar 7.1: Ilustrasi prinsip FIFO pada queue ..... 291

Gambar 7.2: Ilustrasi masalah "wasted space" pada queue linear ..... 303

Gambar 7.3: Ilustrasi circular queue ..... 308

Gambar 7.4: Struktur deque dan operasi kedua ujungnya ..... 318

Gambar 7.5: Ilustrasi priority queue ..... 323

**Bab 8: Rekursi**

Gambar 8.1: Diagram call stack proses rekursif faktorial ..... 348

Gambar 8.2: Pohon rekursi untuk Fibonacci(5) ..... 365

Gambar 8.3: Ilustrasi Menara Hanoi tiga disk ..... 368

Gambar 8.4: Pohon memoization untuk Fibonacci ..... 373

Gambar 8.5: Contoh kurva fraktal Koch ..... 381

**Bab 9: Algoritma Sorting Dasar**

Gambar 9.1: Ilustrasi langkah-langkah Bubble Sort ..... 397

Gambar 9.2: Ilustrasi langkah-langkah Selection Sort ..... 405

Gambar 9.3: Ilustrasi langkah-langkah Insertion Sort ..... 412

Gambar 9.4: Perbandingan jumlah perbandingan pada tiga algoritma sorting dasar ..... 422

**Bab 10: Algoritma Sorting Lanjutan**

Gambar 10.1: Diagram pohon rekursi Merge Sort ..... 438

Gambar 10.2: Ilustrasi proses merging pada Merge Sort ..... 440

Gambar 10.3: Ilustrasi pemilihan pivot dan partisi Quick Sort ..... 449

Gambar 10.4: Kasus terburuk Quick Sort dengan pivot pertama ..... 453

Gambar 10.5: Perbandingan kinerja empiris algoritma sorting lanjutan ..... 473

**Bab 11: Algoritma Searching dan Hashing**

Gambar 11.1: Ilustrasi Linear Search ..... 490

Gambar 11.2: Ilustrasi Binary Search dengan metode bagi dua ..... 495

Gambar 11.3: Ilustrasi fungsi hash dan tabel hash ..... 507

Gambar 11.4: Collision resolution dengan chaining ..... 515

Gambar 11.5: Collision resolution dengan open addressing (linear probing) ..... 519

**Bab 12: Tree dan Binary Search Tree**

Gambar 12.1: Terminologi dasar tree (root, parent, child, leaf) ..... 544

Gambar 12.2: Contoh binary tree lengkap dan sempurna ..... 556

Gambar 12.3: Ilustrasi preorder, inorder, dan postorder traversal ..... 560

Gambar 12.4: Ilustrasi level-order traversal menggunakan queue ..... 568

Gambar 12.5: Proses penyisipan node pada BST ..... 576

Gambar 12.6: Tiga kasus penghapusan node pada BST ..... 583

**Bab 13: Tree Lanjutan dan Heap**

Gambar 13.1: Contoh BST tidak seimbang akibat data terurut ..... 600

Gambar 13.2: Empat jenis rotasi pada AVL Tree ..... 606

Gambar 13.3: Contoh struktur Trie untuk kamus kata ..... 625

Gambar 13.4: Representasi Max-Heap sebagai pohon biner ..... 631

Gambar 13.5: Pemetaan Max-Heap ke array ..... 648

**Bab 14: Graph**

Gambar 14.1: Contoh graf berarah dan tidak berarah ..... 674

Gambar 14.2: Representasi adjacency matrix ..... 680

Gambar 14.3: Representasi adjacency list ..... 684

Gambar 14.4: Ilustrasi proses BFS dengan antrian ..... 689

Gambar 14.5: Ilustrasi proses DFS dengan stack ..... 695

Gambar 14.6: Contoh topological sort pada DAG ..... 705

Gambar 14.7: Ilustrasi algoritma Dijkstra langkah demi langkah ..... 712

Gambar 14.8: Contoh Minimum Spanning Tree dengan Kruskal ..... 722

---

&nbsp;

&nbsp;

<!-- ============================================================ -->
<!-- DAFTAR TABEL -->
<!-- ============================================================ -->

# DAFTAR TABEL

**Bab 2: Analisis Kompleksitas Algoritma**

Tabel 2.1: Ringkasan kelas-kelas kompleksitas waktu ..... 57

Tabel 2.2: Perbandingan jumlah operasi untuk berbagai kelas kompleksitas (n = 10, 100, 1000) ..... 67

Tabel 2.3: Aturan-aturan dasar notasi Big-O ..... 76

**Bab 3: Array dan String**

Tabel 3.1: Kompleksitas operasi pada array statis ..... 104

Tabel 3.2: Perbandingan list Python dan array NumPy ..... 122

Tabel 3.3: Metode-metode umum string Python beserta kompleksitasnya ..... 130

**Bab 4: Singly Linked List**

Tabel 4.1: Kompleksitas operasi pada singly linked list ..... 185

Tabel 4.2: Perbandingan array dan singly linked list ..... 187

**Bab 5: Linked List Lanjutan**

Tabel 5.1: Kompleksitas operasi pada doubly linked list ..... 226

Tabel 5.2: Perbandingan varian-varian linked list ..... 227

**Bab 6: Stack**

Tabel 6.1: Kompleksitas operasi stack pada berbagai implementasi ..... 260

Tabel 6.2: Aturan konversi ekspresi infix ke postfix ..... 269

**Bab 7: Queue**

Tabel 7.1: Kompleksitas operasi queue pada berbagai implementasi ..... 328

Tabel 7.2: Perbandingan queue, deque, dan priority queue ..... 330

**Bab 8: Rekursi**

Tabel 8.1: Perbandingan rekursi dan iterasi ..... 351

Tabel 8.2: Kompleksitas waktu dan ruang Fibonacci tanpa dan dengan memoization ..... 374

**Bab 9: Algoritma Sorting Dasar**

Tabel 9.1: Perbandingan kompleksitas algoritma sorting dasar ..... 422

Tabel 9.2: Karakteristik algoritma sorting (stabil, in-place, adaptif) ..... 423

**Bab 10: Algoritma Sorting Lanjutan**

Tabel 10.1: Perbandingan kompleksitas algoritma sorting lanjutan ..... 472

Tabel 10.2: Tabel perbandingan menyeluruh seluruh algoritma sorting dalam buku ini ..... 472

**Bab 11: Algoritma Searching dan Hashing**

Tabel 11.1: Perbandingan kompleksitas Linear Search dan Binary Search ..... 500

Tabel 11.2: Kompleksitas operasi hash table pada kasus terbaik, rata-rata, dan terburuk ..... 531

**Bab 12: Tree dan Binary Search Tree**

Tabel 12.1: Terminologi-terminologi penting pada tree ..... 547

Tabel 12.2: Kompleksitas operasi BST pada kasus rata-rata dan terburuk ..... 588

**Bab 13: Tree Lanjutan dan Heap**

Tabel 13.1: Perbandingan kompleksitas BST, AVL Tree, dan Red-Black Tree ..... 614

Tabel 13.2: Kompleksitas operasi pada heap ..... 650

Tabel 13.3: Perbandingan struktur data untuk implementasi priority queue ..... 656

**Bab 14: Graph**

Tabel 14.1: Perbandingan representasi adjacency matrix dan adjacency list ..... 686

Tabel 14.2: Perbandingan BFS dan DFS ..... 698

Tabel 14.3: Kompleksitas algoritma-algoritma shortest path ..... 718

Tabel 14.4: Ringkasan algoritma-algoritma graf dan kasus penggunaannya ..... 739

---

*Akhir Daftar Tabel*
