# BACK MATTER
# Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python

---

# GLOSARIUM

Daftar berikut memuat istilah-istilah teknis yang digunakan sepanjang buku ini, disusun secara alfabetis. Istilah dalam bahasa Inggris disertakan sebagai referensi silang dengan literatur internasional.

---

**Abstraksi** (*Abstraction*): Proses menyembunyikan detail implementasi dan hanya memperlihatkan antarmuka atau perilaku yang relevan kepada pengguna. Abstraksi adalah fondasi dari Abstract Data Type (ADT).

**Abstract Data Type (ADT)** (*Abstract Data Type*): Model matematis untuk tipe data yang didefinisikan oleh perilaku (operasi) yang dapat dilakukannya, bukan oleh implementasinya. ADT memisahkan "apa" yang dilakukan struktur data dari "bagaimana" cara melakukannya.

**Adjacency List** (*Adjacency List*): Representasi graf menggunakan kumpulan daftar, di mana setiap simpul memiliki daftar tetangga yang terhubung langsung. Representasi ini efisien untuk graf yang jarang (*sparse*).

**Adjacency Matrix** (*Adjacency Matrix*): Representasi graf menggunakan matriks dua dimensi berukuran V x V, di mana V adalah jumlah simpul. Nilai pada baris i dan kolom j menunjukkan keberadaan atau bobot sisi antara simpul i dan j.

**Algoritma** (*Algorithm*): Sekumpulan langkah-langkah terdefinisi dan terurut untuk menyelesaikan suatu masalah komputasi dalam waktu terbatas. Algoritma harus bersifat pasti, terbatas, dan menghasilkan keluaran yang benar.

**Algoritma Serakah** (*Greedy Algorithm*): Paradigma perancangan algoritma yang membuat pilihan optimal lokal pada setiap langkah dengan harapan mencapai solusi optimal global. Digunakan dalam algoritma Dijkstra dan Prim.

**Amortized Analysis** (*Amortized Analysis*): Teknik analisis kompleksitas yang menghitung biaya rata-rata operasi dalam serangkaian operasi, bukan biaya terburuk satu operasi. Berguna untuk struktur data seperti dynamic array.

**Array** (*Array*): Struktur data linear yang menyimpan elemen-elemen bertipe sama dalam lokasi memori yang berurutan dan dapat diakses melalui indeks. Array memiliki waktu akses O(1) untuk akses acak.

**Array Dinamis** (*Dynamic Array*): Array yang dapat mengubah ukurannya secara otomatis saat elemen ditambah atau dihapus. Dalam Python, tipe data `list` merupakan implementasi array dinamis.

**AVL Tree** (*AVL Tree*): Jenis pohon biner pencarian yang menjaga keseimbangan tinggi dengan memastikan bahwa faktor keseimbangan setiap simpul adalah -1, 0, atau 1. Dinamai dari penemunya Adelson-Velsky dan Landis.

**Balance Factor** (*Balance Factor*): Selisih antara tinggi subpohon kanan dan subpohon kiri dari suatu simpul dalam AVL Tree. Nilai yang diizinkan adalah -1, 0, atau 1; nilai di luar rentang ini memerlukan rotasi.

**Base Case** (*Base Case*): Kondisi penghentian dalam algoritma rekursif yang menyelesaikan masalah secara langsung tanpa pemanggilan rekursif lebih lanjut. Setiap fungsi rekursif harus memiliki setidaknya satu base case.

**Best Case** (*Best Case*): Skenario masukan yang menghasilkan kinerja terbaik (tercepat) dari suatu algoritma. Dinotasikan dengan Omega (Omega) dalam analisis kompleksitas.

**Big-O Notation** (*Big-O Notation*): Notasi matematis untuk mendeskripsikan batas atas pertumbuhan fungsi kompleksitas waktu atau ruang suatu algoritma relatif terhadap ukuran masukan n. Mengabaikan konstanta dan suku-suku yang lebih kecil.

**Binary Search** (*Binary Search*): Algoritma pencarian efisien pada larik terurut yang bekerja dengan membagi rentang pencarian menjadi dua secara berulang. Memiliki kompleksitas waktu O(log n).

**Binary Search Tree (BST)** (*Binary Search Tree*): Pohon biner dengan properti bahwa setiap simpul memiliki nilai lebih besar dari semua simpul di subpohon kiri dan lebih kecil dari semua simpul di subpohon kanan. Mendukung operasi pencarian, penyisipan, dan penghapusan dalam O(h), di mana h adalah tinggi pohon.

**Binary Tree** (*Binary Tree*): Pohon di mana setiap simpul memiliki paling banyak dua anak, yang disebut anak kiri dan anak kiri. Merupakan dasar dari banyak struktur data hierarkis.

**Breadth-First Search (BFS)** (*Breadth-First Search*): Algoritma penelusuran graf yang mengunjungi semua simpul pada jarak tertentu dari simpul sumber sebelum melanjutkan ke simpul yang lebih jauh. Menggunakan antrian sebagai struktur data pembantu dan memiliki kompleksitas O(V + E).

**Bubble Sort** (*Bubble Sort*): Algoritma pengurutan sederhana yang berulang kali membandingkan dan menukar elemen yang berdekatan jika urutannya salah. Memiliki kompleksitas waktu rata-rata dan terburuk O(n^2).

**Call Stack** (*Call Stack*): Struktur data tumpukan yang digunakan oleh sistem eksekusi program untuk menyimpan informasi tentang fungsi-fungsi yang aktif (dipanggil namun belum selesai). Setiap pemanggilan fungsi mendorong *frame* ke atas tumpukan.

**Chaining** (*Chaining*): Teknik penanganan tabrakan dalam tabel hash di mana setiap sel tabel menyimpan sebuah linked list dari semua entri yang memetakan ke indeks yang sama. Juga disebut *separate chaining*.

**Circular Linked List** (*Circular Linked List*): Varian linked list di mana simpul terakhir menunjuk kembali ke simpul pertama, membentuk struktur siklik. Berguna untuk aplikasi yang memerlukan penelusuran melingkar.

**Circular Queue** (*Circular Queue*): Implementasi antrian menggunakan array dengan logika melingkar, di mana indeks ekor (*rear*) berpindah ke awal array setelah mencapai ujung. Mengatasi pemborosan ruang pada antrian array biasa.

**Collision** (*Collision*): Kondisi dalam tabel hash ketika dua kunci berbeda menghasilkan nilai hash yang sama, sehingga dipetakan ke indeks yang sama dalam tabel. Harus ditangani dengan teknik seperti chaining atau probing.

**Counting Sort** (*Counting Sort*): Algoritma pengurutan non-komparatif yang bekerja dengan menghitung kemunculan setiap nilai unik dalam larik masukan. Efisien untuk data dengan rentang nilai yang terbatas, dengan kompleksitas O(n + k).

**Deque** (*Deque / Double-Ended Queue*): Struktur data antrian yang mendukung penyisipan dan penghapusan elemen di kedua ujungnya (depan dan belakang). Merupakan generalisasi dari tumpukan dan antrian.

**Depth-First Search (DFS)** (*Depth-First Search*): Algoritma penelusuran graf yang menjelajahi sejauh mungkin sepanjang setiap cabang sebelum mundur (*backtrack*). Dapat diimplementasikan dengan rekursi atau tumpukan eksplisit.

**Dictionary** (*Dictionary*): Tipe data abstrak yang menyimpan pasangan kunci-nilai (*key-value pairs*) dan mendukung pencarian berdasarkan kunci. Dalam Python, diimplementasikan sebagai tabel hash.

**Dijkstra's Algorithm** (*Dijkstra's Algorithm*): Algoritma jalur terpendek pada graf berbobot non-negatif yang menemukan jarak terpendek dari satu simpul sumber ke semua simpul lainnya. Menggunakan antrian prioritas dan memiliki kompleksitas O((V + E) log V).

**Divide and Conquer** (*Divide and Conquer*): Paradigma perancangan algoritma yang membagi masalah menjadi submasalah yang lebih kecil, menyelesaikan submasalah secara rekursif, lalu menggabungkan hasilnya. Digunakan dalam Merge Sort dan Quick Sort.

**Double Hashing** (*Double Hashing*): Teknik open addressing dalam penanganan tabrakan yang menggunakan fungsi hash kedua untuk menentukan langkah probing berikutnya. Mengurangi pengelompokan (*clustering*) dibandingkan linear probing.

**Doubly Linked List** (*Doubly Linked List*): Varian linked list di mana setiap simpul memiliki dua pointer: satu ke simpul berikutnya dan satu ke simpul sebelumnya. Memungkinkan penelusuran dua arah.

**Dynamic Programming** (*Dynamic Programming*): Teknik optimasi yang memecah masalah menjadi submasalah yang tumpang tindih dan menyimpan hasilnya untuk menghindari komputasi berulang. Berkaitan erat dengan memoization.

**Edge** (*Edge*): Hubungan atau koneksi antara dua simpul (*vertex*) dalam sebuah graf. Sisi dapat berbobot (*weighted*) atau tidak berbobot, dan dapat berarah (*directed*) atau tidak berarah (*undirected*).

**Enkapsulasi** (*Encapsulation*): Prinsip pemrograman berorientasi objek yang menggabungkan data dan operasi yang bekerja pada data tersebut ke dalam satu unit (kelas), sekaligus menyembunyikan detail implementasi internal.

**Faktor Muatan** (*Load Factor*): Rasio antara jumlah elemen yang disimpan dalam tabel hash dengan total kapasitas tabel (lambda = n/m). Faktor muatan yang tinggi meningkatkan kemungkinan tabrakan dan menurunkan kinerja.

**FIFO** (*First In First Out*): Prinsip operasi antrian (*queue*) di mana elemen pertama yang dimasukkan adalah elemen pertama yang dikeluarkan. Analog dengan antrean di kehidupan nyata.

**Fungsi Hash** (*Hash Function*): Fungsi yang memetakan kunci dari sembarang ukuran ke nilai integer dalam rentang tetap, digunakan sebagai indeks dalam tabel hash. Fungsi hash yang baik mendistribusikan kunci secara merata.

**Graf** (*Graph*): Struktur data non-linear yang terdiri dari himpunan simpul (*vertex*) dan himpunan sisi (*edge*) yang menghubungkan pasangan simpul. Graf digunakan untuk merepresentasikan jaringan dan hubungan kompleks.

**Graf Berarah** (*Directed Graph / Digraph*): Graf di mana setiap sisi memiliki arah dari satu simpul ke simpul lain. Sisi disebut *arc* dan direpresentasikan sebagai pasangan terurut (u, v).

**Graf Berbobot** (*Weighted Graph*): Graf di mana setiap sisi memiliki nilai numerik (bobot) yang merepresentasikan biaya, jarak, atau kapasitas. Digunakan dalam masalah jalur terpendek dan pohon rentang minimum.

**Head** (*Head*): Pointer atau referensi ke simpul pertama dalam sebuah linked list. Memberikan titik masuk untuk mengakses seluruh daftar.

**Heap** (*Heap*): Struktur data pohon biner lengkap yang memenuhi properti heap: setiap simpul induk memiliki nilai yang lebih besar (max-heap) atau lebih kecil (min-heap) dari nilai anak-anaknya. Diimplementasikan efisien menggunakan array.

**Heap Sort** (*Heap Sort*): Algoritma pengurutan berbasis perbandingan yang menggunakan struktur data heap biner. Memiliki kompleksitas waktu O(n log n) di semua kasus dan pengurutan di tempat (*in-place*).

**Heapify** (*Heapify*): Proses mempertahankan atau memulihkan properti heap pada sebuah pohon biner, biasanya dilakukan dari bawah ke atas. Operasi heapify tunggal memiliki kompleksitas O(log n).

**Implementasi** (*Implementation*): Realisasi konkret dari sebuah Abstract Data Type menggunakan bahasa pemrograman dan struktur data nyata. Satu ADT dapat memiliki berbagai implementasi berbeda.

**Infix** (*Infix Notation*): Notasi ekspresi matematika standar di mana operator ditempatkan di antara operand-operandnya, seperti A + B. Memerlukan tanda kurung atau aturan presedensi untuk menentukan urutan evaluasi.

**Inorder Traversal** (*Inorder Traversal*): Penelusuran pohon biner dengan urutan: kunjungi subpohon kiri, kunjungi simpul akar, kunjungi subpohon kanan. Pada BST, inorder traversal menghasilkan urutan terurut.

**Insertion Sort** (*Insertion Sort*): Algoritma pengurutan yang membangun larik terurut satu per satu dengan menyisipkan setiap elemen baru ke posisi yang tepat. Efisien untuk data kecil atau hampir terurut, dengan kompleksitas O(n^2).

**Jalur** (*Path*): Urutan simpul-simpul dalam sebuah graf di mana setiap pasangan simpul yang berurutan dihubungkan oleh sebuah sisi. Panjang jalur diukur dengan jumlah sisi atau jumlah bobot sisi.

**Kunci** (*Key*): Nilai unik yang digunakan untuk mengidentifikasi atau mencari elemen dalam struktur data seperti tabel hash atau BST. Kunci dipetakan oleh fungsi hash ke indeks dalam tabel hash.

**Kompleksitas Ruang** (*Space Complexity*): Ukuran jumlah memori tambahan yang dibutuhkan oleh suatu algoritma sebagai fungsi dari ukuran masukan. Penting untuk dipertimbangkan ketika memori merupakan sumber daya terbatas.

**Kompleksitas Waktu** (*Time Complexity*): Ukuran jumlah operasi atau langkah yang dilakukan oleh suatu algoritma sebagai fungsi dari ukuran masukan n. Digunakan untuk membandingkan efisiensi algoritma secara teoritis.

**LIFO** (*Last In First Out*): Prinsip operasi tumpukan (*stack*) di mana elemen terakhir yang dimasukkan adalah elemen pertama yang dikeluarkan. Analog dengan tumpukan piring di dapur.

**Linear Probing** (*Linear Probing*): Teknik open addressing untuk penanganan tabrakan di mana sel berikutnya yang tersedia dicari secara berurutan (indeks + 1, + 2, dst.). Dapat menyebabkan pengelompokan (*clustering*) primer.

**Linked List** (*Linked List*): Struktur data linear yang terdiri dari simpul-simpul yang saling terhubung melalui pointer. Setiap simpul menyimpan data dan referensi ke simpul berikutnya, memungkinkan ukuran yang dinamis.

**Matriks** (*Matrix*): Array dua dimensi yang mengorganisasikan elemen dalam baris dan kolom. Banyak digunakan dalam komputasi ilmiah, grafis komputer, dan representasi graf.

**Max-Heap** (*Max-Heap*): Heap di mana nilai setiap simpul induk lebih besar atau sama dengan nilai anak-anaknya, sehingga elemen terbesar selalu berada di akar. Berguna untuk implementasi antrian prioritas maksimum.

**Memoization** (*Memoization*): Teknik optimasi yang menyimpan hasil pemanggilan fungsi yang mahal untuk menghindari komputasi berulang ketika dipanggil dengan argumen yang sama. Merupakan implementasi top-down dari dynamic programming.

**Merge Sort** (*Merge Sort*): Algoritma pengurutan berbasis divide-and-conquer yang membagi larik menjadi dua bagian, mengurutkan masing-masing secara rekursif, lalu menggabungkan hasilnya. Memiliki kompleksitas O(n log n) yang stabil.

**Min-Heap** (*Min-Heap*): Heap di mana nilai setiap simpul induk lebih kecil atau sama dengan nilai anak-anaknya, sehingga elemen terkecil selalu berada di akar. Berguna untuk implementasi antrian prioritas minimum.

**Node** (*Node*): Unit dasar dari banyak struktur data seperti linked list, pohon, dan graf. Setiap simpul menyimpan data dan satu atau lebih pointer ke simpul lain.

**Notasi Asimtotik** (*Asymptotic Notation*): Kumpulan notasi matematis (O, Omega, Theta) yang digunakan untuk mendeskripsikan perilaku fungsi kompleksitas saat ukuran masukan mendekati tak hingga. Digunakan untuk membandingkan efisiensi algoritma.

**Open Addressing** (*Open Addressing*): Strategi penanganan tabrakan dalam tabel hash di mana semua elemen disimpan langsung di dalam array tabel. Ketika terjadi tabrakan, dicari sel kosong berikutnya sesuai urutan probing.

**Pivot** (*Pivot*): Elemen yang dipilih sebagai acuan dalam algoritma Quick Sort untuk mempartisi larik menjadi dua bagian: elemen yang lebih kecil dan elemen yang lebih besar. Pemilihan pivot yang baik sangat memengaruhi kinerja.

**Pointer** (*Pointer*): Variabel yang menyimpan alamat memori dari variabel atau objek lain. Dalam Python, pointer diimplementasikan secara implisit melalui referensi objek.

**Pop** (*Pop*): Operasi pada tumpukan (*stack*) untuk menghapus dan mengembalikan elemen teratas. Juga digunakan pada antrian untuk menghapus elemen dari depan.

**Postfix** (*Postfix Notation / Reverse Polish Notation*): Notasi ekspresi matematika di mana operator ditempatkan setelah kedua operandnya, seperti A B +. Tidak memerlukan tanda kurung dan mudah dievaluasi menggunakan tumpukan.

**Postorder Traversal** (*Postorder Traversal*): Penelusuran pohon biner dengan urutan: kunjungi subpohon kiri, kunjungi subpohon kanan, kunjungi simpul akar. Sering digunakan untuk menghapus pohon atau menghitung ekspresi.

**Prefix** (*Prefix Notation / Polish Notation*): Notasi ekspresi matematika di mana operator ditempatkan sebelum kedua operandnya, seperti + A B. Tidak memerlukan tanda kurung untuk menentukan urutan operasi.

**Preorder Traversal** (*Preorder Traversal*): Penelusuran pohon biner dengan urutan: kunjungi simpul akar, kunjungi subpohon kiri, kunjungi subpohon kanan. Digunakan untuk menyalin pohon atau menghasilkan ekspresi prefix.

**Priority Queue** (*Priority Queue*): Jenis antrian di mana setiap elemen memiliki prioritas dan elemen dengan prioritas tertinggi dikeluarkan terlebih dahulu, bukan berdasarkan urutan kedatangan. Sering diimplementasikan menggunakan heap.

**Push** (*Push*): Operasi pada tumpukan (*stack*) untuk menambahkan elemen baru ke bagian teratas. Merupakan pasangan dari operasi pop.

**Quadratic Probing** (*Quadratic Probing*): Teknik open addressing untuk penanganan tabrakan yang menggunakan fungsi kuadratik untuk menentukan langkah probing berikutnya. Mengurangi pengelompokan primer tetapi dapat menyebabkan pengelompokan sekunder.

**Queue** (*Queue*): Struktur data linear yang mengikuti prinsip FIFO (First In First Out). Operasi utamanya adalah enqueue (menambah di belakang) dan dequeue (menghapus dari depan).

**Quick Sort** (*Quick Sort*): Algoritma pengurutan berbasis divide-and-conquer yang mempartisi larik di sekitar elemen pivot. Rata-rata memiliki kompleksitas O(n log n) tetapi O(n^2) dalam kasus terburuk.

**Radix Sort** (*Radix Sort*): Algoritma pengurutan non-komparatif yang mengurutkan bilangan bulat dengan memproses digit per digit dari yang paling tidak signifikan hingga yang paling signifikan. Memiliki kompleksitas O(d*(n+k)).

**Rekursi** (*Recursion*): Teknik pemrograman di mana sebuah fungsi memanggil dirinya sendiri untuk menyelesaikan versi yang lebih kecil dari masalah yang sama. Setiap fungsi rekursif memerlukan base case untuk menghentikan rekursi.

**Rekursi Ekor** (*Tail Recursion*): Bentuk khusus rekursi di mana pemanggilan rekursif adalah operasi terakhir yang dilakukan oleh fungsi. Dapat dioptimalkan oleh kompiler/interpreter menjadi iterasi untuk menghindari stack overflow.

**Rotasi** (*Rotation*): Operasi restrukturisasi lokal pada pohon biner yang mempertahankan properti BST sambil mengubah keseimbangan tinggi. AVL Tree menggunakan rotasi kiri, kanan, kiri-kanan, dan kanan-kiri.

**Searching** (*Searching*): Proses menemukan elemen tertentu dalam suatu kumpulan data. Algoritma pencarian utama meliputi linear search, binary search, dan pencarian berbasis hash.

**Selection Sort** (*Selection Sort*): Algoritma pengurutan yang bekerja dengan berulang kali memilih elemen terkecil dari bagian larik yang belum terurut dan menempatkannya di posisi yang benar. Memiliki kompleksitas O(n^2).

**Sentinel Node** (*Sentinel Node*): Simpul dummy yang ditempatkan di awal atau akhir linked list untuk menyederhanakan operasi penyisipan dan penghapusan dengan menghilangkan penanganan kasus khusus untuk simpul ujung.

**Singly Linked List** (*Singly Linked List*): Linked list dasar di mana setiap simpul hanya memiliki satu pointer yang menunjuk ke simpul berikutnya. Penelusuran hanya dapat dilakukan dalam satu arah.

**Sorting** (*Sorting*): Proses mengatur elemen-elemen dalam suatu urutan tertentu (ascending atau descending). Merupakan operasi fundamental dalam ilmu komputer dengan banyak algoritma dengan karakteristik yang berbeda.

**Sparse Array** (*Sparse Array*): Array yang sebagian besar elemennya bernilai nol atau kosong. Representasi khusus digunakan untuk menghemat memori, seperti menyimpan hanya elemen non-nol beserta indeksnya.

**Stack** (*Stack*): Struktur data linear yang mengikuti prinsip LIFO (Last In First Out). Operasi utamanya adalah push (menambah di atas) dan pop (menghapus dari atas).

**Stack Overflow** (*Stack Overflow*): Kondisi kesalahan yang terjadi ketika call stack kehabisan ruang, biasanya akibat rekursi yang terlalu dalam tanpa base case yang tepat atau rekursi tak terbatas.

**Stable Sort** (*Stable Sort*): Algoritma pengurutan yang mempertahankan urutan relatif dari elemen-elemen yang memiliki kunci yang sama. Merge Sort dan Insertion Sort adalah contoh algoritma pengurutan stabil.

**Struktur Data** (*Data Structure*): Cara mengorganisasikan dan menyimpan data dalam komputer sehingga dapat diakses dan dimodifikasi secara efisien. Pemilihan struktur data yang tepat sangat memengaruhi kinerja algoritma.

**Struktur Data Linear** (*Linear Data Structure*): Struktur data di mana elemen-elemen disusun secara berurutan dan setiap elemen memiliki tepat satu elemen pendahulu dan satu elemen penerus (kecuali elemen pertama dan terakhir). Contoh: array, linked list, stack, queue.

**Struktur Data Non-Linear** (*Non-Linear Data Structure*): Struktur data di mana elemen-elemen tidak tersusun secara berurutan melainkan dalam hubungan hierarkis atau jaringan. Contoh: pohon (*tree*) dan graf (*graph*).

**Tail** (*Tail*): Pointer atau referensi ke simpul terakhir dalam sebuah linked list. Memungkinkan penyisipan di akhir daftar dengan kompleksitas O(1).

**Tabel Hash** (*Hash Table*): Struktur data yang mengimplementasikan tipe data abstrak *dictionary* menggunakan array dan fungsi hash. Rata-rata mendukung operasi pencarian, penyisipan, dan penghapusan dalam O(1).

**Theta Notation** (*Theta Notation*): Notasi asimtotik yang memberikan batas atas dan batas bawah yang ketat untuk fungsi kompleksitas. Digunakan ketika batas atas dan bawah memiliki orde pertumbuhan yang sama.

**Tinggi Pohon** (*Tree Height*): Panjang jalur terpanjang dari akar ke daun dalam sebuah pohon. Tinggi pohon memengaruhi kompleksitas operasi pada BST dan AVL Tree.

**Topological Sort** (*Topological Sort*): Pengurutan linear simpul-simpul dalam Directed Acyclic Graph (DAG) sedemikian sehingga untuk setiap sisi berarah (u, v), simpul u muncul sebelum v. Berguna untuk menentukan urutan dependensi.

**Traversal** (*Traversal*): Proses mengunjungi setiap elemen dalam struktur data tepat sekali. Untuk pohon, traversal utama meliputi inorder, preorder, postorder, dan level-order.

**Tree** (*Tree*): Struktur data hierarkis non-linear yang terdiri dari simpul-simpul yang terhubung oleh sisi, dengan satu simpul khusus sebagai akar. Setiap simpul kecuali akar memiliki tepat satu induk.

**Vertex** (*Vertex*): Simpul atau titik dalam sebuah graf yang mewakili entitas. Graf terdiri dari himpunan simpul dan himpunan sisi yang menghubungkan pasangan simpul.

**Worst Case** (*Worst Case*): Skenario masukan yang menghasilkan kinerja terburuk (terlambat) dari suatu algoritma. Dinotasikan dengan O dalam analisis kompleksitas dan menjadi jaminan batas atas kinerja.

---

# DAFTAR PUSTAKA

Daftar pustaka disusun berdasarkan gaya APA edisi ketujuh (APA 7th Edition). Sumber-sumber di bawah ini mencakup buku teks, artikel jurnal, prosiding konferensi, dan sumber daring yang dijadikan acuan dalam penyusunan buku ini.

---

## Buku Teks

Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022). *Introduction to algorithms* (4th ed.). MIT Press.

Drozdek, A. (2012). *Data structures and algorithms in C++* (4th ed.). Cengage Learning.

Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013). *Data structures and algorithms in Python*. John Wiley & Sons.

Karumanchi, N. (2016). *Data structures and algorithms made easy in Python: Data structure and algorithmic puzzles*. CareerMonk Publications.

Kleinberg, J., & Tardos, E. (2005). *Algorithm design*. Pearson Education.

Knuth, D. E. (1997). *The art of computer programming: Volume 1, fundamental algorithms* (3rd ed.). Addison-Wesley.

Knuth, D. E. (1998). *The art of computer programming: Volume 2, seminumerical algorithms* (3rd ed.). Addison-Wesley.

Knuth, D. E. (1998). *The art of computer programming: Volume 3, sorting and searching* (2nd ed.). Addison-Wesley.

Lee, K. D., & Hubbard, S. (2015). *Data structures and algorithms with Python*. Springer.

Miller, B. N., & Ranum, D. L. (2011). *Problem solving with algorithms and data structures using Python* (2nd ed.). Franklin, Beedle & Associates.

Necaise, R. D. (2011). *Data structures and algorithms using Python*. John Wiley & Sons.

Sedgewick, R., & Wayne, K. (2011). *Algorithms* (4th ed.). Addison-Wesley Professional.

Skiena, S. S. (2020). *The algorithm design manual* (3rd ed.). Springer.

Weiss, M. A. (2013). *Data structures and algorithm analysis in C++* (4th ed.). Pearson.

Weiss, M. A. (2014). *Data structures and algorithm analysis in Java* (3rd ed.). Pearson.

## Buku Berbahasa Indonesia

Rinaldi, M. (2007). *Algoritma dan pemrograman dalam bahasa Pascal dan C*. Informatika Bandung.

Setiawan, S. (2018). *Struktur data dan algoritma menggunakan Python*. Penerbit Andi.

Wahyudin, D. (2020). *Algoritma dan struktur data: Konsep dan implementasi dalam Python*. Deepublish.

## Artikel Jurnal dan Prosiding

Aho, A. V., Hopcroft, J. E., & Ullman, J. D. (1983). Data structures and algorithms. *ACM SIGCSE Bulletin*, *15*(1), 20–21. https://doi.org/10.1145/382192.382201

Adelson-Velsky, G. M., & Landis, E. M. (1962). An algorithm for the organization of information. *Proceedings of the USSR Academy of Sciences*, *146*, 263–266.

Dijkstra, E. W. (1959). A note on two problems in connexion with graphs. *Numerische Mathematik*, *1*(1), 269–271. https://doi.org/10.1007/BF01386390

Floyd, R. W. (1964). Algorithm 245: Treesort 3. *Communications of the ACM*, *7*(12), 701. https://doi.org/10.1145/355588.365103

Hoare, C. A. R. (1962). Quicksort. *The Computer Journal*, *5*(1), 10–16. https://doi.org/10.1093/comjnl/5.1.10

Williams, J. W. J. (1964). Algorithm 232: Heapsort. *Communications of the ACM*, *7*(6), 347–348. https://doi.org/10.1145/512274.512284

## Sumber Daring dan MOOC

GeeksforGeeks. (2024). *Data structures*. https://www.geeksforgeeks.org/data-structures/

Kahn Academy. (2024). *Algorithms*. https://www.khanacademy.org/computing/computer-science/algorithms

MIT OpenCourseWare. (2011). *Introduction to algorithms (6.006)*. Massachusetts Institute of Technology. https://ocw.mit.edu/courses/6-006-introduction-to-algorithms-fall-2011/

Python Software Foundation. (2024). *Python documentation: Time complexity*. https://wiki.python.org/moin/TimeComplexity

Real Python. (2024). *Sorting algorithms in Python*. https://realpython.com/sorting-algorithms-python/

Roughgarden, T. (2022). *Algorithms illuminated* [Online course]. Stanford University via Coursera. https://www.coursera.org/learn/algorithms-divide-conquer

Sedgewick, R., & Wayne, K. (2024). *Algorithms, 4th edition* [Online companion]. Princeton University. https://algs4.cs.princeton.edu/

University of California San Diego. (2023). *Data structures and algorithms specialization* [Online course]. Coursera. https://www.coursera.org/specializations/data-structures-algorithms

Visualgo. (2024). *Visualgo: Visualising data structures and algorithms through animation*. https://visualgo.net/

---

# INDEKS

Indeks berikut memuat istilah-istilah teknis penting beserta bab-bab yang membahasnya. Bab utama yang membahas istilah tersebut secara paling mendalam ditandai dengan cetak tebal (**Bab X**).

Untuk setiap entri, bab-bab dituliskan dalam urutan numerik. Tanda bintang (*) menunjukkan bahwa istilah tersebut dibahas secara mendalam dalam bab terkait.

---

**Abstract Data Type (ADT)**, **Bab 1**, Bab 3, Bab 4, Bab 6, Bab 7, Bab 12

**Adjacency List**, Bab 12, **Bab 14**

**Adjacency Matrix**, Bab 12, **Bab 14**

**Algoritma Dijkstra**, Bab 13, **Bab 14**

**Algoritma Kruskal**, **Bab 14**

**Algoritma Prim**, **Bab 14**

**Amortized Analysis**, **Bab 2**, Bab 3

**Array**, **Bab 3**, Bab 4, Bab 6, Bab 7, Bab 9

**Array Dinamis**, **Bab 3**, Bab 7

**Array Multidimensi**, **Bab 3**

**AVL Tree**, Bab 12, **Bab 13**

**Balance Factor**, **Bab 13**

**Base Case**, **Bab 8**, Bab 12

**Best Case**, **Bab 2**, Bab 9, Bab 10

**Big-O Notation**, **Bab 2**, Bab 9, Bab 10, Bab 11

**Binary Search**, Bab 8, **Bab 11**

**Binary Search Tree (BST)**, **Bab 12**, Bab 13

**Binary Tree**, **Bab 12**, Bab 13

**Breadth-First Search (BFS)**, Bab 12, **Bab 14**

**Bubble Sort**, **Bab 9**

**Call Stack**, **Bab 8**, Bab 6

**Chaining**, **Bab 11**

**Circular Linked List**, **Bab 5**, Bab 7

**Circular Queue**, **Bab 7**

**Collision**, **Bab 11**

**Complexity**, Bab 1, **Bab 2**, Bab 9, Bab 10

**Counting Sort**, **Bab 10**

**Deque**, **Bab 7**

**Depth-First Search (DFS)**, Bab 12, **Bab 14**

**Dictionary**, Bab 1, **Bab 11**

**Dijkstra's Algorithm**, Bab 13, **Bab 14**

**Divide and Conquer**, **Bab 10**, Bab 8

**Double Hashing**, **Bab 11**

**Doubly Linked List**, **Bab 5**, Bab 7

**Dynamic Array**, **Bab 3**

**Dynamic Programming**, Bab 8, **Bab 10**

**Edge**, **Bab 14**

**Enkapsulasi**, **Bab 1**

**Evaluasi Ekspresi**, **Bab 6**

**Faktor Muatan (Load Factor)**, **Bab 11**

**FIFO**, **Bab 7**

**Fungsi Hash**, **Bab 11**

**Graf**, **Bab 14**

**Graf Berarah**, **Bab 14**

**Graf Berbobot**, **Bab 14**

**Graf Tidak Berarah**, **Bab 14**

**Head**, **Bab 4**, Bab 5, Bab 7

**Heap**, Bab 7, **Bab 13**

**Heap Sort**, **Bab 13**

**Heapify**, **Bab 13**

**In-place Sort**, **Bab 9**, Bab 10

**Indeks Array**, **Bab 3**

**Infix**, **Bab 6**

**Inorder Traversal**, **Bab 12**, Bab 13

**Insertion Sort**, **Bab 9**

**Iterasi**, **Bab 8**, Bab 4

**Kompleksitas Ruang**, **Bab 2**, Bab 8, Bab 10

**Kompleksitas Waktu**, **Bab 2**, Bab 9, Bab 10, Bab 11

**Level-order Traversal**, **Bab 12**, Bab 14

**LIFO**, **Bab 6**

**Linear Probing**, **Bab 11**

**Linear Search**, **Bab 11**, Bab 2

**Linked List**, **Bab 4**, Bab 5, Bab 6, Bab 7, Bab 11

**List Python**, **Bab 3**, Bab 6, Bab 7

**Matriks**, **Bab 3**

**Max-Heap**, **Bab 13**

**Memoization**, **Bab 8**

**Merge Sort**, **Bab 10**

**Min-Heap**, **Bab 13**, Bab 14

**Node**, **Bab 4**, Bab 5, Bab 12, Bab 13, Bab 14

**Notasi Asimtotik**, **Bab 2**

**Notasi Big-O**, **Bab 2**, Bab 9, Bab 10, Bab 11

**Notasi Omega**, **Bab 2**

**Notasi Theta**, **Bab 2**

**Open Addressing**, **Bab 11**

**Overflow**, Bab 6, Bab 7, **Bab 8**

**Pemrograman Berorientasi Objek**, **Bab 1**, Bab 4, Bab 12

**Pencarian Linear**, **Bab 11**, Bab 9

**Pivot**, **Bab 10**

**Pointer**, **Bab 4**, Bab 5

**Pop**, **Bab 6**, Bab 7

**Postfix**, **Bab 6**

**Postorder Traversal**, **Bab 12**

**Prefix**, **Bab 6**

**Preorder Traversal**, **Bab 12**

**Priority Queue**, Bab 7, **Bab 13**, Bab 14

**Push**, **Bab 6**

**Quadratic Probing**, **Bab 11**

**Queue**, **Bab 7**, Bab 14

**Quick Sort**, **Bab 10**

**Radix Sort**, **Bab 10**

**Rekursi**, **Bab 8**, Bab 10, Bab 12

**Rekursi Ekor**, **Bab 8**

**Rotasi AVL**, **Bab 13**

**Rotasi Kanan**, **Bab 13**

**Rotasi Kiri**, **Bab 13**

**Selection Sort**, **Bab 9**

**Sentinel Node**, **Bab 5**

**Sequential Search**, **Bab 11**, Bab 2

**Shell Sort**, **Bab 9**

**Singly Linked List**, **Bab 4**, Bab 5

**Sorting**, **Bab 9**, **Bab 10**, Bab 13

**Sparse Array**, **Bab 3**

**Sparse Matrix**, **Bab 3**

**Stack**, **Bab 6**, Bab 8, Bab 12, Bab 14

**Stack Overflow**, **Bab 8**, Bab 6

**Stable Sort**, **Bab 9**, Bab 10

**Struktur Data**, **Bab 1**

**Struktur Data Linear**, **Bab 1**, Bab 3, Bab 4, Bab 6, Bab 7

**Struktur Data Non-Linear**, **Bab 1**, Bab 12, Bab 14

**Subpohon**, **Bab 12**, Bab 13

**Tail**, **Bab 4**, Bab 5, Bab 7

**Tabel Hash**, **Bab 11**

**Tinggi Pohon**, **Bab 12**, Bab 13

**Topological Sort**, **Bab 14**

**Traversal**, **Bab 12**, Bab 14

**Tree**, **Bab 12**, Bab 13

**Tuple Python**, **Bab 3**

**Underflow**, **Bab 6**, Bab 7

**Vertex**, **Bab 14**

**Worst Case**, **Bab 2**, Bab 9, Bab 10, Bab 11

---

# TENTANG PENULIS

---

## [FOTO PENULIS]

*[Tempat untuk foto penulis berukuran 3 x 4 cm atau 4 x 6 cm dalam format potret profesional]*

---

## [NAMA LENGKAP PENULIS], [GELAR AKADEMIS]

### Riwayat Pendidikan

- **[Gelar Doktor/S3]** — [Nama Program Studi], [Nama Universitas], [Kota], [Negara], [Tahun Lulus]
  *Judul Disertasi: "[Judul Disertasi]"*

- **[Gelar Magister/S2]** — [Nama Program Studi], [Nama Universitas], [Kota], [Negara], [Tahun Lulus]
  *Judul Tesis: "[Judul Tesis]"*

- **[Gelar Sarjana/S1]** — [Nama Program Studi], [Nama Universitas], [Kota], [Negara], [Tahun Lulus]
  *Judul Skripsi: "[Judul Skripsi]"*

---

### Posisi dan Institusi Saat Ini

**[Jabatan Fungsional]** pada **[Nama Program Studi]**
[Nama Fakultas]
Institut Teknologi dan Bisnis STIKI Indonesia (INSTIKI)
Jl. Tukad Pakerisan No. 97, Panjer, Denpasar Selatan, Bali 80226

---

### Bidang Riset dan Minat Akademis

Penulis memiliki minat akademis dan keahlian riset pada bidang-bidang berikut:

- [Bidang Riset Utama 1, misalnya: Algoritma dan Struktur Data]
- [Bidang Riset Utama 2, misalnya: Kecerdasan Buatan dan Machine Learning]
- [Bidang Riset Utama 3, misalnya: Rekayasa Perangkat Lunak]
- [Bidang Riset Lainnya, misalnya: Komputasi Ilmiah]

---

### Karya dan Publikasi Sebelumnya

#### Buku Ajar

- [Nama Penulis]. ([Tahun]). *[Judul Buku Ajar]*. [Nama Penerbit].
- [Nama Penulis]. ([Tahun]). *[Judul Buku Ajar]*. [Nama Penerbit].

#### Artikel Jurnal

- [Nama Penulis]. ([Tahun]). [Judul Artikel]. *[Nama Jurnal]*, *[Volume]*([Nomor]), [Halaman]. https://doi.org/[DOI]
- [Nama Penulis]. ([Tahun]). [Judul Artikel]. *[Nama Jurnal]*, *[Volume]*([Nomor]), [Halaman]. https://doi.org/[DOI]

#### Prosiding Konferensi

- [Nama Penulis]. ([Tahun]). [Judul Makalah]. Dalam *[Nama Prosiding/Konferensi]* (hlm. [Halaman]). [Nama Penerbit/Penyelenggara].

#### Hak Kekayaan Intelektual

- [Judul HKI], Nomor Pencatatan: [Nomor], [Tahun]

---

### Informasi Kontak

- **Surel Institusi:** [nama.penulis@instiki.ac.id]
- **Surel Pribadi:** [nama.penulis@email.com]
- **NIDN:** [Nomor Induk Dosen Nasional]
- **Scopus Author ID:** [ID Scopus jika ada]
- **Google Scholar:** [URL Profil Google Scholar]
- **SINTA:** [URL Profil SINTA]
- **ORCID:** https://orcid.org/[XXXX-XXXX-XXXX-XXXX]
- **ResearchGate:** https://www.researchgate.net/profile/[nama-profil]

---

*Penulis menerima masukan, saran, dan koreksi dari pembaca untuk penyempurnaan edisi berikutnya. Silakan menghubungi penulis melalui surel atau mengunjungi halaman institusi untuk informasi lebih lanjut.*

---

## Tim Reviewer dan Kontributor

### Reviewer Ahli

- **[Nama Reviewer 1]**, [Gelar] — [Institusi]
- **[Nama Reviewer 2]**, [Gelar] — [Institusi]
- **[Nama Reviewer 3]**, [Gelar] — [Institusi]

### Editor

- **[Nama Editor]**, [Gelar] — [Institusi/Penerbit]

### Desain Sampul

- **[Nama Desainer]** — [Institusi/Studio]

---

*Hak Cipta dilindungi Undang-Undang. Dilarang memperbanyak atau memindahkan sebagian atau seluruh isi buku ini dalam bentuk apapun, baik secara elektronis maupun mekanis, termasuk memfotokopi, merekam, atau dengan sistem penyimpanan lainnya, tanpa izin tertulis dari penulis dan penerbit.*

---

**Cetakan Pertama, [Tahun Terbit]**

**Penerbit:** [Nama Penerbit]

**ISBN:** [Nomor ISBN]

---

*Dicetak di Indonesia*
