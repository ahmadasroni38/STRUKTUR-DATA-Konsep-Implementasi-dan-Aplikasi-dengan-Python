# BAB 13
# TREE LANJUTAN DAN HEAP: KESEIMBANGAN, PRIORITAS, DAN EFISIENSI

---

> *"Sebuah pohon yang benar-benar seimbang tidak hanya indah secara struktural, tetapi juga merupakan jaminan efisiensi yang dapat dibuktikan secara matematis."*
>
> — G.M. Adelson-Velsky dan E.M. Landis, 1962

---

## 13.1 Tujuan Pembelajaran

Setelah mempelajari bab ini, mahasiswa diharapkan mampu:

1. **(C2 — Memahami)** Menjelaskan permasalahan *skewed tree* pada Binary Search Tree biasa dan mendeskripsikan mengapa BST tidak menjamin performa O(log n) dalam kasus terburuk.
2. **(C2 — Memahami)** Menguraikan konsep *balance factor* pada AVL tree serta mengidentifikasi keempat kasus ketidakseimbangan yang dapat terjadi beserta jenis rotasi yang sesuai.
3. **(C3 — Menerapkan)** Mengimplementasikan AVL tree dalam Python, mencakup rotasi tunggal (LL dan RR) serta rotasi ganda (LR dan RL), dan memverifikasi kebenaran implementasi melalui uji coba penyisipan berurutan.
4. **(C3 — Menerapkan)** Mengimplementasikan struktur data Max-Heap dan Min-Heap menggunakan representasi array, meliputi operasi sift-up (untuk penyisipan) dan sift-down (untuk ekstraksi elemen), serta prosedur build-heap.
5. **(C4 — Menganalisis)** Menganalisis dan melacak setiap langkah proses build-heap dan fase pengurutan heap sort pada suatu array, serta membuktikan mengapa build-heap memiliki kompleksitas O(n) meskipun memanggil sift-down sebanyak n/2 kali.
6. **(C4 — Menganalisis)** Membandingkan karakteristik AVL tree dan heap dari segi kompleksitas operasi, sehingga mampu menentukan struktur data yang paling sesuai untuk konteks permasalahan yang berbeda.
7. **(C5 — Mengevaluasi)** Merancang dan mengimplementasikan priority queue berbasis Min-Heap untuk menyelesaikan permasalahan antrian berprioritas dalam sistem layanan medis, serta mengevaluasi keunggulan pendekatan berbasis heap dibandingkan pendekatan alternatif.

---

## 13.2 Pendahuluan: Ketika Pohon Kehilangan Keseimbangannya

Struktur data Binary Search Tree (BST) yang telah dibahas pada bab-bab sebelumnya menawarkan operasi pencarian, penyisipan, dan penghapusan dengan kompleksitas rata-rata O(log n). Jaminan ini bergantung pada asumsi bahwa pohon tumbuh secara relatif seimbang, sehingga tingginya sebanding dengan logaritma jumlah simpul. Namun, BST biasa tidak memiliki mekanisme bawaan untuk menjaga keseimbangan tersebut.

Pertimbangkan sebuah perpustakaan digital yang menyimpan jutaan buku dalam BST, diurutkan berdasarkan nomor ISBN. Apabila buku-buku ditambahkan secara berurutan dari ISBN terkecil hingga terbesar, BST akan berubah menjadi struktur linear yang menyerupai linked list. Pencarian sebuah buku dalam kondisi ini memerlukan hingga satu juta perbandingan — bukan dua puluh perbandingan seperti yang dijanjikan oleh O(log n) pada pohon seimbang. Permasalahan inilah yang mendorong Georgy Adelson-Velsky dan Evgenii Landis untuk memperkenalkan AVL tree pada tahun 1962, sebagai struktur pohon biner seimbang pertama dalam sejarah ilmu komputer.

Di sisi lain, ada kelas permasalahan yang tidak memerlukan kemampuan pencarian sewenang-waktu seperti BST, tetapi sangat membutuhkan kemampuan mengakses elemen terbesar atau terkecil secara instan dan efisien. Sistem antrian gawat darurat di rumah sakit, penjadwal proses dalam sistem operasi, dan algoritma pencarian jalur terpendek semuanya memerlukan kemampuan untuk selalu mengetahui "elemen paling penting" dalam suatu koleksi data yang terus berubah. Struktur data heap, yang direpresentasikan sebagai *complete binary tree* dalam bentuk array, dirancang secara khusus untuk memenuhi kebutuhan ini dengan jaminan performa yang ketat.

Bab ini membahas kedua struktur data tersebut secara mendalam: AVL tree sebagai representasi pohon pencarian yang selalu seimbang, dan heap sebagai fondasi algoritma pengurutan heap sort serta priority queue yang efisien.

---

## 13.3 Masalah Skewed Tree dan Motivasi Self-Balancing

### 13.3.1 Degradasi Kinerja BST

Untuk memahami urgensi AVL tree, mari kita amati secara seksama apa yang terjadi ketika BST biasa menerima data dalam urutan tertentu. Misalkan kita menyisipkan bilangan 1, 2, 3, 4, 5 secara berurutan ke dalam BST kosong. Karena setiap bilangan baru selalu lebih besar dari semua bilangan sebelumnya, setiap simpul baru akan selalu ditempatkan sebagai anak kanan dari simpul terakhir. Hasilnya adalah struktur yang disebut *right-skewed tree* (pohon condong ke kanan):

```
Gambar 13.1 — Right-Skewed BST (insert: 1, 2, 3, 4, 5)
=========================================================

1
 \
  2
   \
    3
     \
      4
       \
        5

Tinggi = 4, Operasi pencarian worst-case = O(n)
```

Demikian pula, penyisipan data dalam urutan menurun (5, 4, 3, 2, 1) menghasilkan *left-skewed tree*:

```
Gambar 13.2 — Left-Skewed BST (insert: 5, 4, 3, 2, 1)
========================================================

        5
       /
      4
     /
    3
   /
  2
 /
1

Tinggi = 4, Operasi pencarian worst-case = O(n)
```

Bandingkan kedua pohon di atas dengan BST yang seimbang untuk elemen-elemen yang sama:

```
Gambar 13.3 — Balanced BST (elemen: 1, 2, 3, 4, 5)
====================================================

        3
       / \
      2   4
     /     \
    1       5

Tinggi = 2, Operasi pencarian worst-case = O(log n)
```

Perbedaan ini terlihat kecil pada contoh dengan lima elemen, namun menjadi sangat signifikan pada skala besar. Untuk satu juta elemen, pohon seimbang membutuhkan paling banyak sekitar 20 perbandingan untuk menemukan elemen mana pun, sementara skewed tree dapat membutuhkan hingga satu juta perbandingan — perbedaan kinerja sebesar 50.000 kali lipat.

> **Catatan Penting 13.1 — Kapan BST Biasa Aman Digunakan?**
>
> BST biasa masih dapat diandalkan apabila urutan penyisipan data bersifat acak (random). Secara statistik, penyisipan n elemen secara acak menghasilkan BST dengan tinggi rata-rata sekitar 1,39 log n, yang masih dalam kategori O(log n). Namun, dalam banyak aplikasi dunia nyata, data seringkali sudah terurut sebagian (misalnya data timestamp dari log server, nomor antrian yang berurutan, atau rekaman transaksi berurutan), sehingga risiko terbentuknya skewed tree sangat tinggi. Oleh karena itu, self-balancing BST seperti AVL tree menjadi pilihan yang jauh lebih aman untuk sistem produksi.

### 13.3.2 Balance Factor: Ukuran Keseimbangan

AVL tree mengatasi masalah skewed tree dengan cara memantau nilai *balance factor* (faktor keseimbangan) di setiap simpul dan melakukan koreksi otomatis apabila keseimbangan terganggu. Balance factor didefinisikan sebagai selisih tinggi antara subpohon kiri dan subpohon kanan suatu simpul:

```
Balance Factor (BF) = Tinggi(subpohon kiri) - Tinggi(subpohon kanan)
```

Tinggi pohon kosong (None) didefinisikan sebagai 0, sedangkan tinggi sebuah simpul daun adalah 1. Pada setiap simpul AVL tree yang valid, balance factor harus berada dalam rentang {-1, 0, +1}:

**Tabel 13.1 — Interpretasi Balance Factor pada AVL Tree**

| Nilai BF | Makna | Status |
|----------|-------|--------|
| +2 atau lebih | Subpohon kiri terlalu tinggi | Tidak seimbang — perlu rotasi ke kiri |
| +1 | Subpohon kiri sedikit lebih tinggi | Seimbang — tidak perlu rotasi |
| 0 | Subpohon kiri dan kanan sama tinggi | Seimbang sempurna |
| -1 | Subpohon kanan sedikit lebih tinggi | Seimbang — tidak perlu rotasi |
| -2 atau kurang | Subpohon kanan terlalu tinggi | Tidak seimbang — perlu rotasi ke kanan |

Properti fundamental AVL tree dapat dirangkum sebagai berikut: setiap AVL tree adalah BST yang valid, ditambah jaminan bahwa balance factor setiap simpulnya berada dalam rentang {-1, 0, +1}. Jaminan ini secara matematis membuktikan bahwa tinggi AVL tree dengan n simpul selalu tidak melebihi 1,44 log(n+2), sehingga semua operasi (insert, delete, search) selalu berjalan dalam O(log n) bahkan pada kasus terburuk sekalipun.

> **Tahukah Anda? 13.1 — Nama "AVL" dan Sejarahnya**
>
> Nama "AVL" diambil dari inisial dua ilmuwan Soviet yang menemukan struktur data ini: Georgy Maximovich Adelson-Velsky (1922–2014) dan Evgenii Mikhailovich Landis (1921–1997). Makalah mereka berjudul "An Algorithm for the Organization of Information" diterbitkan dalam bahasa Rusia pada tahun 1962 di *Doklady Akademii Nauk SSSR* (Proceedings of the USSR Academy of Sciences). Pada era Perang Dingin, makalah ini baru menjadi dikenal luas di Barat setelah diterjemahkan ke bahasa Inggris pada tahun 1963. AVL tree merupakan struktur *self-balancing binary search tree* pertama yang pernah ditemukan, mendahului Red-Black Tree (1972) dan struktur-struktur lainnya yang muncul di kemudian hari.

---

## 13.4 AVL Tree: Rotasi sebagai Mekanisme Penyeimbang

Ketika operasi penyisipan atau penghapusan menyebabkan balance factor suatu simpul menjadi +2 atau -2, AVL tree melakukan operasi *rotasi* untuk mengembalikan keseimbangan. Terdapat empat kasus ketidakseimbangan, masing-masing dengan strategi rotasi yang berbeda.

### 13.4.1 Kasus LL — Rotasi Kanan Tunggal

Kasus LL (Left-Left) terjadi ketika simpul baru disisipkan ke dalam *subpohon kiri dari anak kiri* simpul yang tidak seimbang. Akibatnya, simpul yang tidak seimbang (z) memiliki BF = +2, sedangkan anak kirinya (y) memiliki BF = +1 atau 0. Solusinya adalah melakukan satu kali *rotasi kanan* pada simpul z.

```
Gambar 13.4 — Kasus LL: Sebelum dan Sesudah Rotasi Kanan

SEBELUM Rotasi LL:              SESUDAH Rotasi Kanan (LL):
========================        ==========================

      z (BF=+2)                         y
     / \                               / \
    y   T4              ====>         x   z
   / \                               / \ / \
  x   T3                            T1 T2 T3 T4
 / \
T1  T2

Contoh konkret (insert: 30, 20, 10):

      30 (BF=+2)                        20
     /                                 /  \
    20 (BF=+1)          ====>         10   30
   /
  10
```

Langkah-langkah rotasi kanan pada z:
1. y (anak kiri z) menjadi akar baru subpohon.
2. z menjadi anak kanan y.
3. Subpohon kanan y (T3) berpindah menjadi subpohon kiri z.
4. Tinggi z dan y diperbarui (z diperbarui lebih dulu, karena y sekarang menjadi parent z).

### 13.4.2 Kasus RR — Rotasi Kiri Tunggal

Kasus RR (Right-Right) adalah cerminan simetris dari kasus LL. Kasus ini terjadi ketika simpul baru disisipkan ke dalam *subpohon kanan dari anak kanan* simpul yang tidak seimbang. Simpul yang tidak seimbang (z) memiliki BF = -2, sedangkan anak kanannya (y) memiliki BF = -1 atau 0. Solusinya adalah *rotasi kiri* pada simpul z.

```
Gambar 13.5 — Kasus RR: Sebelum dan Sesudah Rotasi Kiri

SEBELUM Rotasi RR:              SESUDAH Rotasi Kiri (RR):
========================        ==========================

  z (BF=-2)                              y
 / \                                    / \
T1   y              ====>              z   x
    / \                               / \ / \
   T2   x                            T1 T2 T3 T4
       / \
      T3  T4

Contoh konkret (insert: 10, 20, 30):

  10 (BF=-2)                            20
    \                                  /  \
    20 (BF=-1)          ====>         10   30
      \
      30
```

### 13.4.3 Kasus LR — Rotasi Ganda Kiri-Kanan

Kasus LR (Left-Right) adalah kasus yang lebih kompleks. Kasus ini terjadi ketika simpul baru disisipkan ke dalam *subpohon kanan dari anak kiri* simpul yang tidak seimbang. Pada kasus ini, simpul yang tidak seimbang (z) memiliki BF = +2, namun anak kirinya (y) memiliki BF = -1. Satu kali rotasi tidak cukup; dibutuhkan dua rotasi berurutan.

```
Gambar 13.6 — Kasus LR: Proses Rotasi Ganda

LANGKAH 1 — KONDISI AWAL (insert: 30, 10, 20):

      30 (BF=+2)
     /
    10 (BF=-1)
      \
      20


LANGKAH 2 — Rotasi KIRI pada anak kiri (y=10):

      30 (BF=+2)
     /
    20
   /
  10


LANGKAH 3 — Rotasi KANAN pada z (z=30):

      20
     /  \
    10   30
```

Strategi rotasi LR: pertama lakukan rotasi kiri pada anak kiri (mengubah kasus LR menjadi kasus LL), kemudian lakukan rotasi kanan pada simpul yang tidak seimbang.

### 13.4.4 Kasus RL — Rotasi Ganda Kanan-Kiri

Kasus RL (Right-Left) adalah cerminan simetris dari kasus LR. Kasus ini terjadi ketika simpul baru disisipkan ke dalam *subpohon kiri dari anak kanan* simpul yang tidak seimbang. Simpul yang tidak seimbang (z) memiliki BF = -2, dan anak kanannya (y) memiliki BF = +1.

```
Gambar 13.7 — Kasus RL: Proses Rotasi Ganda

LANGKAH 1 — KONDISI AWAL (insert: 10, 30, 20):

  10 (BF=-2)
    \
    30 (BF=+1)
   /
  20


LANGKAH 2 — Rotasi KANAN pada anak kanan (y=30):

  10 (BF=-2)
    \
    20
      \
      30


LANGKAH 3 — Rotasi KIRI pada z (z=10):

      20
     /  \
    10   30
```

**Tabel 13.2 — Ringkasan Empat Kasus Rotasi AVL Tree**

| Kasus | Kondisi pada z | Kondisi pada anak | Jenis Rotasi | Jumlah Rotasi |
|-------|---------------|-------------------|--------------|---------------|
| LL | BF(z) = +2 | BF(anak kiri) >= 0 | Rotasi kanan pada z | 1 |
| RR | BF(z) = -2 | BF(anak kanan) <= 0 | Rotasi kiri pada z | 1 |
| LR | BF(z) = +2 | BF(anak kiri) < 0 | Rotasi kiri pada anak kiri, lalu kanan pada z | 2 |
| RL | BF(z) = -2 | BF(anak kanan) > 0 | Rotasi kanan pada anak kanan, lalu kiri pada z | 2 |

### 13.4.5 Implementasi AVL Tree dalam Python

Implementasi AVL tree menggunakan pendekatan rekursif untuk operasi insert. Setiap kali rekursi kembali dari penyisipan, tinggi simpul saat ini diperbarui dan balance factor diperiksa. Apabila ketidakseimbangan terdeteksi, rotasi yang sesuai dilakukan sebelum fungsi mengembalikan nilainya.

```python
# ============================================================
# Implementasi AVL Tree — Bab 13 Struktur Data
# ============================================================

class AVLNode:
    """Simpul pada AVL Tree."""

    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None
        self.height = 1  # Tinggi awal simpul baru = 1 (simpul daun)


class AVLTree:
    """
    Implementasi self-balancing AVL Tree.
    Menjamin tinggi O(log n) melalui rotasi otomatis.
    Mendukung operasi: insert, search, dan in-order traversal.
    """

    def get_height(self, node):
        """Mengembalikan tinggi simpul; None dianggap tinggi 0."""
        if node is None:
            return 0
        return node.height

    def get_balance_factor(self, node):
        """Menghitung balance factor = tinggi kiri - tinggi kanan."""
        if node is None:
            return 0
        return self.get_height(node.left) - self.get_height(node.right)

    def update_height(self, node):
        """Memperbarui tinggi simpul berdasarkan tinggi anak-anaknya."""
        node.height = 1 + max(
            self.get_height(node.left),
            self.get_height(node.right)
        )

    def rotate_right(self, z):
        """
        Rotasi kanan pada simpul z (menangani kasus LL).
        Mengembalikan akar baru subpohon setelah rotasi.
        """
        y = z.left
        T2 = y.right      # Subpohon kanan y yang akan dipindahkan

        # Lakukan rotasi
        y.right = z
        z.left = T2

        # Perbarui tinggi — z harus diperbarui lebih dulu karena kini
        # menjadi anak dari y
        self.update_height(z)
        self.update_height(y)

        return y  # y menjadi akar baru

    def rotate_left(self, z):
        """
        Rotasi kiri pada simpul z (menangani kasus RR).
        Mengembalikan akar baru subpohon setelah rotasi.
        """
        y = z.right
        T2 = y.left       # Subpohon kiri y yang akan dipindahkan

        # Lakukan rotasi
        y.left = z
        z.right = T2

        # Perbarui tinggi
        self.update_height(z)
        self.update_height(y)

        return y  # y menjadi akar baru

    def insert(self, node, key):
        """
        Menyisipkan key baru ke AVL tree secara rekursif.
        Mengembalikan akar subpohon yang telah diseimbangkan.
        """
        # --- Langkah 1: Sisipkan seperti BST biasa ---
        if node is None:
            return AVLNode(key)

        if key < node.key:
            node.left = self.insert(node.left, key)
        elif key > node.key:
            node.right = self.insert(node.right, key)
        else:
            return node  # Kunci duplikat tidak disisipkan

        # --- Langkah 2: Perbarui tinggi simpul saat ini ---
        self.update_height(node)

        # --- Langkah 3: Periksa balance factor ---
        bf = self.get_balance_factor(node)

        # --- Langkah 4: Lakukan rotasi jika diperlukan ---

        # Kasus LL: subpohon kiri terlalu tinggi, insersi di kiri anak kiri
        if bf > 1 and key < node.left.key:
            return self.rotate_right(node)

        # Kasus RR: subpohon kanan terlalu tinggi, insersi di kanan anak kanan
        if bf < -1 and key > node.right.key:
            return self.rotate_left(node)

        # Kasus LR: subpohon kiri terlalu tinggi, insersi di kanan anak kiri
        if bf > 1 and key > node.left.key:
            node.left = self.rotate_left(node.left)   # Rotasi kiri dulu
            return self.rotate_right(node)             # Lalu rotasi kanan

        # Kasus RL: subpohon kanan terlalu tinggi, insersi di kiri anak kanan
        if bf < -1 and key < node.right.key:
            node.right = self.rotate_right(node.right) # Rotasi kanan dulu
            return self.rotate_left(node)              # Lalu rotasi kiri

        return node  # Tidak ada ketidakseimbangan, kembalikan node

    def inorder(self, node, result=None):
        """In-order traversal menghasilkan elemen dalam urutan terurut."""
        if result is None:
            result = []
        if node:
            self.inorder(node.left, result)
            result.append(node.key)
            self.inorder(node.right, result)
        return result


# --- Demonstrasi AVL Tree ---
if __name__ == "__main__":
    avl = AVLTree()
    root = None

    # Urutan ini akan membentuk skewed tree pada BST biasa
    keys = [10, 20, 30, 40, 50, 25]
    print("Menyisipkan:", keys)
    for k in keys:
        root = avl.insert(root, k)

    print("In-order traversal:", avl.inorder(root))
    print("Tinggi pohon     :", avl.get_height(root))
    print("Balance factor   :", avl.get_balance_factor(root))
    # Output: In-order traversal: [10, 20, 25, 30, 40, 50]
    # Output: Tinggi pohon: 3
```

Perlu diperhatikan bahwa pada implementasi di atas, operasi `insert` bersifat rekursif dan mengembalikan akar subpohon yang diperbarui. Pemanggil harus selalu memperbarui referensi akar: `root = avl.insert(root, key)`. Setiap pemanggilan rekursif memperbarui tinggi dan memeriksa keseimbangan saat "memanjat" kembali ke akar, sehingga rotasi hanya dilakukan pada simpul pertama yang ditemukan dalam kondisi tidak seimbang.

### 13.4.6 Analisis Kompleksitas AVL Tree

Ketinggian AVL tree dengan n simpul terbukti secara matematis tidak melebihi 1,44 log(n+2) - 0,328. Ini berarti semua operasi yang bergantung pada tinggi pohon — yaitu insert, delete, dan search — berjalan dalam O(log n) bahkan pada kasus terburuk. Operasi rotasi sendiri hanya memerlukan O(1) waktu dan ruang, karena hanya melibatkan pembaruan beberapa pointer dan nilai tinggi.

---

## 13.5 Heap: Pohon Biner Lengkap sebagai Array

### 13.5.1 Definisi dan Properti Heap

Heap adalah struktur data *complete binary tree* yang memenuhi *heap property*. Sifat "complete" berarti semua level pohon terisi penuh kecuali level paling bawah, dan simpul-simpul di level paling bawah diisi dari kiri ke kanan tanpa celah. Terdapat dua jenis heap berdasarkan heap property yang diterapkan:

- **Max-Heap:** Nilai setiap simpul lebih besar atau sama dengan nilai semua keturunannya. Konsekuensinya, elemen terbesar selalu berada di akar pohon dan dapat diakses dalam O(1).
- **Min-Heap:** Nilai setiap simpul lebih kecil atau sama dengan nilai semua keturunannya. Konsekuensinya, elemen terkecil selalu berada di akar pohon dan dapat diakses dalam O(1).

Perlu ditegaskan bahwa heap property hanya mengatur hubungan antara parent dan child secara vertikal, bukan hubungan antara simpul-simpul pada level yang sama secara horizontal. Dengan kata lain, heap tidak menjamin urutan di antara subpohon kiri dan subpohon kanan.

> **Catatan Penting 13.2 — Perbedaan Heap dengan BST**
>
> Heap dan BST adalah dua struktur data yang berbeda tujuan. BST dirancang untuk mendukung pencarian sembarang nilai secara efisien (O(log n)), sehingga seluruh kunci harus terorganisasi dalam urutan tertentu di seluruh pohon. Sebaliknya, heap hanya menjamin bahwa elemen terbesar (max-heap) atau terkecil (min-heap) selalu berada di akar. Pencarian sembarang nilai pada heap memerlukan O(n), karena tidak ada properti terurut yang dapat dieksploitasi. Dengan demikian, heap lebih cocok digunakan sebagai priority queue (antrian berprioritas), bukan sebagai kamus (dictionary) atau tabel pencarian.

### 13.5.2 Representasi Heap sebagai Array

Salah satu keunggulan paling menonjol dari heap dibandingkan pohon biner pada umumnya adalah kemampuannya untuk direpresentasikan secara efisien menggunakan array biasa, tanpa memerlukan pointer atau referensi tambahan. Hal ini dimungkinkan oleh sifat "complete" dari heap, yang memastikan tidak ada celah atau simpul yang hilang di antara elemen-elemen array.

Untuk heap yang diindeks mulai dari 0, hubungan antara indeks parent dan child adalah sebagai berikut:

```
Untuk simpul pada indeks i:
  Anak kiri   :  indeks 2*i + 1
  Anak kanan  :  indeks 2*i + 2
  Parent      :  indeks (i - 1) // 2
```

Sebagai ilustrasi, perhatikan max-heap berikut beserta representasi array-nya:

```
Gambar 13.8 — Visualisasi Max-Heap sebagai Pohon dan Array

Max-Heap (tampilan pohon):
============================
                   100  (indeks 0)
                  /     \
          (1) 19           36 (2)
              /  \          /  \
        (3) 17    12      25    5  (6)
                  (4)     (5)
              /   \
          (7) 9   15 (8)

Representasi array:
[100, 19, 36, 17, 12, 25, 5, 9, 15]
   0    1   2   3   4   5  6  7   8

Verifikasi:
  Indeks 0 (100) -> anak kiri: indeks 1 (19), anak kanan: indeks 2 (36)
  Indeks 1  (19) -> anak kiri: indeks 3 (17), anak kanan: indeks 4 (12)
  Indeks 2  (36) -> anak kiri: indeks 5 (25), anak kanan: indeks 6 (5)
  Indeks 3  (17) -> anak kiri: indeks 7 (9),  anak kanan: indeks 8 (15)
```

Representasi array ini sangat efisien dari segi memori karena tidak memerlukan pointer sama sekali, dan efisien dari segi waktu karena perhitungan indeks parent/child hanya melibatkan operasi aritmetika sederhana (perkalian, pembagian, dan penambahan).

> **Tahukah Anda? 13.2 — Heap dalam Standar Industri Python**
>
> Python menyediakan modul `heapq` di dalam pustaka standarnya, yang mengimplementasikan min-heap menggunakan representasi array. Modul ini banyak digunakan dalam dunia industri karena efisiensinya. Fungsi-fungsi utamanya meliputi `heapq.heappush(heap, item)` untuk penyisipan O(log n), `heapq.heappop(heap)` untuk ekstraksi minimum O(log n), dan `heapq.heapify(list)` untuk pembangunan heap dari list sembarang dalam O(n). Untuk keperluan max-heap, konvensi yang umum digunakan adalah menyimpan nilai negatif dari elemen asli, sehingga min-heap berperilaku seperti max-heap.

---

## 13.6 Operasi-Operasi Heap

### 13.6.1 Operasi Sift-Up (Penyisipan Elemen Baru)

Operasi penyisipan pada heap mengikuti prosedur dua langkah yang menjaga kedua sifat heap: sifat complete binary tree dan heap property. Langkah pertama adalah menempatkan elemen baru di posisi paling kanan pada level terbawah array (yaitu di akhir array), untuk menjaga sifat complete binary tree. Langkah kedua adalah membandingkan elemen tersebut dengan parent-nya; jika melanggar heap property, elemen ditukar dengan parent-nya. Proses penukaran ini diulang ke atas (*sift-up* atau *bubble-up*) hingga heap property terpenuhi di seluruh jalur atau elemen mencapai akar.

Berikut adalah trace lengkap penyisipan nilai 50 ke dalam max-heap `[100, 19, 36, 17, 12, 25, 5]`:

```
Gambar 13.9 — Trace Operasi Insert (Sift-Up) pada Max-Heap

Langkah 0 — Kondisi awal heap:
Array: [100, 19, 36, 17, 12, 25, 5]
                   100 (i=0)
                  /    \
          (1) 19         36 (2)
              / \        / \
        (3) 17   12    25   5
                 (4)   (5)  (6)

Langkah 1 — Sisipkan 50 di posisi terakhir (indeks 7):
Array: [100, 19, 36, 17, 12, 25, 5, 50]
Parent dari indeks 7 = (7-1)//2 = 3, nilai = 17
50 > 17 (melanggar heap property) => TUKAR!

Langkah 2 — Setelah tukar indeks 7 dan 3:
Array: [100, 19, 36, 50, 12, 25, 5, 17]
Parent dari indeks 3 = (3-1)//2 = 1, nilai = 19
50 > 19 => TUKAR!

Langkah 3 — Setelah tukar indeks 3 dan 1:
Array: [100, 50, 36, 19, 12, 25, 5, 17]
Parent dari indeks 1 = (1-1)//2 = 0, nilai = 100
50 < 100 => BERHENTI (heap property terpenuhi)

Hasil akhir: [100, 50, 36, 19, 12, 25, 5, 17]
Kompleksitas: O(log n)
```

### 13.6.2 Operasi Sift-Down (Ekstraksi Elemen Terbesar)

Operasi ekstraksi elemen maksimum (extract-max) pada max-heap dilakukan dengan mengambil elemen di akar (yang dijamin merupakan elemen terbesar), kemudian mengisi posisi akar yang kosong dengan elemen terakhir array. Langkah ini menjaga sifat complete binary tree. Kemudian elemen baru di akar digerakkan ke bawah (*sift-down*) dengan cara membandingkannya terhadap anak-anaknya: elemen ditukar dengan anak yang lebih besar, dan proses diulang hingga heap property terpenuhi atau elemen mencapai posisi daun.

Berikut adalah trace operasi extract-max dari heap `[100, 50, 36, 19, 12, 25, 5, 17]`:

```
Gambar 13.10 — Trace Operasi Extract-Max (Sift-Down)

Langkah 0 — Kondisi awal:
Array: [100, 50, 36, 19, 12, 25, 5, 17]
Nilai yang diekstrak = 100

Langkah 1 — Pindahkan elemen terakhir (17) ke akar:
Array: [17, 50, 36, 19, 12, 25, 5]
Anak kiri i=1 (50), anak kanan i=2 (36). Anak terbesar = 50 (i=1)
17 < 50 => TUKAR indeks 0 dan 1!

Langkah 2 — Setelah tukar:
Array: [50, 17, 36, 19, 12, 25, 5]
17 sekarang di indeks 1.
Anak kiri i=3 (19), anak kanan i=4 (12). Anak terbesar = 19 (i=3)
17 < 19 => TUKAR indeks 1 dan 3!

Langkah 3 — Setelah tukar:
Array: [50, 19, 36, 17, 12, 25, 5]
17 sekarang di indeks 3.
Anak kiri i=7 (tidak ada). Simpul daun => BERHENTI.

Hasil akhir: [50, 19, 36, 17, 12, 25, 5]
Nilai yang dikembalikan: 100
Kompleksitas: O(log n)
```

---

## 13.7 Heap Sort: Algoritma Pengurutan Berbasis Heap

### 13.7.1 Algoritma Build-Heap

Sebelum dapat melakukan heap sort, kita perlu mengubah array sembarang menjadi max-heap yang valid. Pendekatan naif adalah menyisipkan elemen satu per satu ke dalam heap menggunakan sift-up, yang memerlukan total O(n log n). Namun, terdapat pendekatan yang jauh lebih efisien: *build-heap* (atau *heapify*), yang bekerja dengan cara memanggil sift-down secara bottom-up pada semua simpul non-daun, dimulai dari simpul non-daun terakhir.

Indeks simpul non-daun terakhir untuk array berukuran n adalah `(n // 2) - 1`. Simpul-simpul dengan indeks lebih besar dari ini adalah simpul daun yang secara otomatis sudah memenuhi heap property.

Berikut adalah trace lengkap build-heap untuk array `[4, 10, 3, 5, 1, 8, 7, 2, 6, 9]`:

```
Gambar 13.11 — Trace Build-Heap

Array awal: [4, 10, 3, 5, 1, 8, 7, 2, 6, 9]
Indeks:      [0,  1, 2, 3, 4, 5, 6, 7, 8, 9]
n = 10, simpul non-daun terakhir = (10//2) - 1 = 4

Representasi pohon awal:
                     4  (i=0)
                   /    \
          (1) 10           3 (2)
              /  \         / \
        (3) 5     1(4)  8(5)  7(6)
            / \   /
        (7)2  6(8) 9(9)

--- i=4 (nilai 1): ---
Anak kiri i=9 (nilai 9). Tidak ada anak kanan.
1 < 9 => tukar indeks 4 dan 9.
Array: [4, 10, 3, 5, 9, 8, 7, 2, 6, 1]

--- i=3 (nilai 5): ---
Anak kiri i=7 (nilai 2), anak kanan i=8 (nilai 6). Terbesar = 6 (i=8).
5 < 6 => tukar indeks 3 dan 8.
Array: [4, 10, 3, 6, 9, 8, 7, 2, 5, 1]

--- i=2 (nilai 3): ---
Anak kiri i=5 (nilai 8), anak kanan i=6 (nilai 7). Terbesar = 8 (i=5).
3 < 8 => tukar indeks 2 dan 5.
Array: [4, 10, 8, 6, 9, 3, 7, 2, 5, 1]

--- i=1 (nilai 10): ---
Anak kiri i=3 (nilai 6), anak kanan i=4 (nilai 9). Terbesar = 9 (i=4).
10 > 9 => TIDAK PERLU TUKAR. Berhenti.
Array: [4, 10, 8, 6, 9, 3, 7, 2, 5, 1] (tidak berubah)

--- i=0 (nilai 4): ---
Anak kiri i=1 (nilai 10), anak kanan i=2 (nilai 8). Terbesar = 10 (i=1).
4 < 10 => tukar indeks 0 dan 1.
Array: [10, 4, 8, 6, 9, 3, 7, 2, 5, 1]
4 sekarang di indeks 1.
Anak kiri i=3 (nilai 6), anak kanan i=4 (nilai 9). Terbesar = 9 (i=4).
4 < 9 => tukar indeks 1 dan 4.
Array: [10, 9, 8, 6, 4, 3, 7, 2, 5, 1]
4 sekarang di indeks 4.
Anak kiri i=9 (nilai 1). Tidak ada anak kanan dalam batas heap.
4 > 1 => TIDAK PERLU TUKAR. Berhenti.

===========================================
HASIL BUILD-HEAP AKHIR:
Array: [10, 9, 8, 6, 4, 3, 7, 2, 5, 1]
Indeks: [0,  1, 2, 3, 4, 5, 6, 7, 8, 9]

Representasi Max-Heap:
                    10  (i=0)
                   /    \
          (1) 9             8 (2)
              / \          / \
        (3) 6     4(4)  3(5)  7(6)
            / \   /
        (7)2  5(8) 1(9)
===========================================
```

### 13.7.2 Mengapa Build-Heap Berjalan dalam O(n)?

Meskipun build-heap memanggil prosedur sift-down sebanyak n/2 kali dan sift-down sendiri berbiaya O(log n), total waktu build-heap adalah O(n), bukan O(n log n). Mengapa?

Kuncinya terletak pada kenyataan bahwa tidak semua pemanggilan sift-down melakukan perjalanan penuh setinggi log n. Simpul-simpul pada level terbawah (daun) tidak perlu di-sift-down sama sekali. Simpul-simpul satu level di atas daun hanya perlu sift-down setinggi maksimal 1 langkah. Secara umum, simpul pada level h dari daun hanya memerlukan sift-down setinggi maksimal h langkah.

Secara matematis, jumlah total langkah build-heap dapat dinyatakan sebagai:

```
T(n) = Sum dari h=0 sampai floor(log n) dari: (n / 2^(h+1)) * h
     = n * Sum dari h=0 sampai tak hingga dari: h / 2^h
     = n * 2
     = O(n)
```

Deret `Sum h/2^h` konvergen ke nilai 2, inilah yang membuat build-heap berjalan dalam O(n) secara total.

### 13.7.3 Fase Pengurutan Heap Sort

Setelah max-heap terbentuk, fase pengurutan dilakukan dengan memanfaatkan sifat bahwa elemen terbesar selalu berada di akar. Pada setiap iterasi: (1) tukar akar (elemen terbesar saat ini) dengan elemen terakhir dalam bagian heap yang aktif, (2) kurangi ukuran heap sebesar satu (elemen yang baru dipindah ke akhir array sudah berada di posisi akhirnya yang benar), dan (3) pulihkan heap property dengan sift-down pada akar baru.

```
Gambar 13.12 — Trace Fase Pengurutan Heap Sort
(Dimulai dari max-heap [10, 9, 8, 6, 4, 3, 7, 2, 5, 1])

Iter 1: Tukar arr[0]=10 <-> arr[9]=1 | Heap_size=9
  Sift-down 1: 9>1 => [9,1,8,6,4,3,7,2,5 | 10]
  Sift-down 1: 6>1 => [9,6,8,1,4,3,7,2,5 | 10]
  Sift-down 1: 5>1 => [9,6,8,5,4,3,7,2,1 | 10]
  Heap: [9,6,8,5,4,3,7,2,1]  | Terurut: [10]

Iter 2: Tukar arr[0]=9 <-> arr[8]=1 | Heap_size=8
  Sift-down 1: 8>1 => [8,6,1,5,4,3,7,2 | 9,10]
  Sift-down 1: 7>1 => [8,6,7,5,4,3,1,2 | 9,10]
  Heap: [8,6,7,5,4,3,1,2]  | Terurut: [9,10]

Iter 3: Tukar arr[0]=8 <-> arr[7]=2 | Heap_size=7
  Sift-down: 7>2 => [7,6,2,5,4,3,1 | 8,9,10]
  Sift-down: 3>2 => [7,6,3,5,4,2,1 | 8,9,10]
  Heap: [7,6,3,5,4,2,1]  | Terurut: [8,9,10]

Iter 4: Tukar arr[0]=7 <-> arr[6]=1 | Heap_size=6
  Sift-down: 6>1 => [6,1,3,5,4,2 | 7,8,9,10]
  Sift-down: 5>1 => [6,5,3,1,4,2 | 7,8,9,10]
  Heap: [6,5,3,1,4,2]  | Terurut: [7,8,9,10]

Iter 5: Tukar arr[0]=6 <-> arr[5]=2 | Heap_size=5
  Sift-down: 5>2 => [5,2,3,1,4 | 6,7,8,9,10]
  Sift-down: 4>2 => [5,4,3,1,2 | 6,7,8,9,10]
  Heap: [5,4,3,1,2]  | Terurut: [6,7,8,9,10]

Iter 6: Tukar arr[0]=5 <-> arr[4]=2 | Heap_size=4
  Sift-down: 4>2 => [4,2,3,1 | 5,6,7,8,9,10]
  Heap: [4,2,3,1]  | Terurut: [5,6,7,8,9,10]

Iter 7: Tukar arr[0]=4 <-> arr[3]=1 | Heap_size=3
  Sift-down: 3>1 => [3,2,1 | 4,5,6,7,8,9,10]
  Heap: [3,2,1]  | Terurut: [4,5,6,7,8,9,10]

Iter 8: Tukar arr[0]=3 <-> arr[2]=1 | Heap_size=2
  Sift-down: 2>1 => [2,1 | 3,4,5,6,7,8,9,10]
  Heap: [2,1]  | Terurut: [3,4,5,6,7,8,9,10]

Iter 9: Tukar arr[0]=2 <-> arr[1]=1 | Heap_size=1
  Heap berukuran 1. SELESAI.

==============================================
HASIL AKHIR HEAP SORT:
Array terurut: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
==============================================
```

Heap sort memiliki keunggulan dibandingkan algoritma pengurutan berbasis perbandingan lainnya: kompleksitas waktu O(n log n) pada semua kasus (terbaik, rata-rata, dan terburuk), dan kompleksitas ruang O(1) karena pengurutan dilakukan di tempat (in-place) tanpa memerlukan array tambahan. Kelemahan utamanya adalah heap sort bersifat tidak stabil (*unstable*), artinya elemen-elemen dengan nilai yang sama tidak dijamin mempertahankan urutan relatif aslinya setelah pengurutan.

**Tabel 13.3 — Perbandingan Algoritma Pengurutan Berbasis Perbandingan**

| Algoritma | Waktu Terbaik | Waktu Rata-rata | Waktu Terburuk | Ruang | Stabil? |
|-----------|--------------|----------------|----------------|-------|---------|
| Heap Sort | O(n log n) | O(n log n) | O(n log n) | O(1) | Tidak |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Ya |
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) | Tidak |
| Insertion Sort | O(n) | O(n²) | O(n²) | O(1) | Ya |

### 13.7.4 Implementasi Lengkap MaxHeap dan Heap Sort dalam Python

```python
# ============================================================
# Implementasi Max-Heap dan Heap Sort — Bab 13 Struktur Data
# ============================================================

class MaxHeap:
    """
    Implementasi Max-Heap menggunakan list Python.
    Properti: nilai setiap simpul >= nilai semua keturunannya.
    Mendukung: insert, extract_max, build_from_list, heap_sort.
    """

    def __init__(self):
        self.heap = []

    def __len__(self):
        return len(self.heap)

    def is_empty(self):
        return len(self.heap) == 0

    def peek(self):
        """Mengembalikan elemen maksimum tanpa menghapusnya. O(1)."""
        if self.is_empty():
            raise IndexError("Heap kosong")
        return self.heap[0]

    def _parent(self, i):
        return (i - 1) // 2

    def _left_child(self, i):
        return 2 * i + 1

    def _right_child(self, i):
        return 2 * i + 2

    def _swap(self, i, j):
        self.heap[i], self.heap[j] = self.heap[j], self.heap[i]

    def _sift_up(self, i):
        """
        Memindahkan elemen ke atas sampai heap property terpenuhi.
        Digunakan setelah insert. Kompleksitas: O(log n).
        """
        while i > 0:
            parent = self._parent(i)
            if self.heap[i] > self.heap[parent]:
                self._swap(i, parent)
                i = parent
            else:
                break

    def _sift_down(self, i, heap_size=None):
        """
        Memindahkan elemen ke bawah sampai heap property terpenuhi.
        Parameter heap_size digunakan saat heap sort untuk membatasi
        batas aktif heap. Kompleksitas: O(log n).
        """
        if heap_size is None:
            heap_size = len(self.heap)

        while True:
            largest = i
            left = self._left_child(i)
            right = self._right_child(i)

            if left < heap_size and self.heap[left] > self.heap[largest]:
                largest = left
            if right < heap_size and self.heap[right] > self.heap[largest]:
                largest = right

            if largest != i:
                self._swap(i, largest)
                i = largest
            else:
                break  # Heap property terpenuhi

    def insert(self, value):
        """Menyisipkan nilai baru ke heap. O(log n)."""
        self.heap.append(value)
        self._sift_up(len(self.heap) - 1)

    def extract_max(self):
        """Mengambil dan menghapus elemen maksimum. O(log n)."""
        if self.is_empty():
            raise IndexError("Heap kosong")
        if len(self.heap) == 1:
            return self.heap.pop()

        max_val = self.heap[0]
        self.heap[0] = self.heap.pop()  # Pindahkan elemen terakhir ke akar
        self._sift_down(0)
        return max_val

    def build_from_list(self, lst):
        """
        Membangun heap dari list sembarang. O(n).
        Lebih efisien daripada menyisipkan satu per satu O(n log n).
        Dimulai dari simpul non-daun terakhir ke akar.
        """
        self.heap = lst[:]
        n = len(self.heap)
        for i in range((n // 2) - 1, -1, -1):
            self._sift_down(i)

    def heap_sort(self, lst):
        """
        Mengurutkan list menggunakan heap sort. O(n log n), O(1) ruang.
        Mengembalikan list terurut dari kecil ke besar.
        """
        self.build_from_list(lst)
        n = len(self.heap)

        for i in range(n - 1, 0, -1):
            self._swap(0, i)          # Akar (maks) ke posisi akhir
            self._sift_down(0, heap_size=i)  # Pulihkan heap dengan ukuran berkurang

        return self.heap[:]

    def display(self):
        print("Heap array:", self.heap)


# --- Demonstrasi MaxHeap ---
if __name__ == "__main__":
    print("=" * 50)
    print("Demonstrasi MaxHeap")
    print("=" * 50)

    mh = MaxHeap()
    for val in [4, 10, 3, 5, 1]:
        mh.insert(val)
        print(f"Insert {val}: {mh.heap}")

    print("\nElemen maksimum:", mh.peek())
    print("Extract-max   :", mh.extract_max())
    print("Setelah extract:", mh.heap)

    print("\nBuild-heap dari [4, 10, 3, 5, 1, 8, 7, 2, 6, 9]:")
    mh2 = MaxHeap()
    mh2.build_from_list([4, 10, 3, 5, 1, 8, 7, 2, 6, 9])
    mh2.display()

    print("\nHeap Sort [4, 10, 3, 5, 1, 8, 7, 2, 6, 9]:")
    mh3 = MaxHeap()
    print("Hasil:", mh3.heap_sort([4, 10, 3, 5, 1, 8, 7, 2, 6, 9]))
```

---

## 13.8 Priority Queue Berbasis Heap

### 13.8.1 Konsep Priority Queue

Priority queue (antrian berprioritas) adalah struktur data abstrak yang mirip dengan antrian biasa, namun dengan perbedaan mendasar: setiap elemen memiliki nilai prioritas, dan operasi pengeluaran selalu mengambil elemen dengan prioritas tertinggi (atau terendah, tergantung konvensi), terlepas dari urutan penyisipannya.

Heap merupakan implementasi yang paling umum dan efisien untuk priority queue, karena menyediakan:
- Penyisipan elemen baru: O(log n)
- Pengambilan elemen dengan prioritas tertinggi: O(log n)
- Melihat elemen dengan prioritas tertinggi (tanpa menghapus): O(1)

Sebagai perbandingan, implementasi priority queue berbasis array terurut hanya membutuhkan O(1) untuk pengambilan elemen prioritas tertinggi, tetapi memerlukan O(n) untuk penyisipan. Sebaliknya, implementasi berbasis array tidak terurut hanya membutuhkan O(1) untuk penyisipan, tetapi O(n) untuk pengambilan. Heap menawarkan keseimbangan terbaik dengan O(log n) untuk kedua operasi.

**Tabel 13.4 — Perbandingan Implementasi Priority Queue**

| Implementasi | Insert | Extract-Priority | Peek-Priority | Ruang |
|--------------|--------|-----------------|---------------|-------|
| Array tidak terurut | O(1) | O(n) | O(n) | O(n) |
| Array terurut | O(n) | O(1) | O(1) | O(n) |
| Linked list terurut | O(n) | O(1) | O(1) | O(n) |
| Heap (Min atau Max) | O(log n) | O(log n) | O(1) | O(n) |

---

## 13.9 Studi Kasus: Sistem Antrian Medis Berbasis Prioritas

### 13.9.1 Latar Belakang Masalah

Di sebuah Unit Gawat Darurat (UGD) rumah sakit, pasien tidak dapat dilayani semata-mata berdasarkan urutan kedatangan. Seorang pasien dengan kondisi darurat — misalnya henti jantung — harus mendapat penanganan segera, meskipun ia baru tiba setelah pasien lain yang datang lebih awal dengan keluhan ringan seperti pilek. Sistem ini dikenal sebagai *triage* dalam dunia medis.

Sistem triage UGD umumnya mengklasifikasikan pasien ke dalam beberapa tingkat prioritas:
- **Prioritas 1 (Merah — Paling Darurat):** Mengancam jiwa, memerlukan penanganan segera. Contoh: henti jantung, kesulitan bernapas berat, perdarahan masif.
- **Prioritas 2 (Kuning — Gawat):** Kondisi serius namun stabil untuk sementara. Contoh: patah tulang, luka dalam, demam sangat tinggi.
- **Prioritas 3 (Hijau — Tidak Gawat):** Kondisi tidak mengancam jiwa, dapat menunggu. Contoh: luka ringan, pilek, pusing ringan.

Dalam sistem ini, apabila dua pasien memiliki tingkat prioritas yang sama, pasien yang datang lebih awal harus dilayani terlebih dahulu (first-come, first-served dalam kelompok prioritas yang sama).

> **Studi Kasus 13.1 — Implementasi Sistem Antrian UGD**
>
> Sebuah klinik kesehatan ingin mengotomatisasi sistem antrian UGD-nya menggunakan priority queue berbasis min-heap. Dalam implementasi ini, nilai prioritas yang lebih kecil merepresentasikan tingkat kegawatan yang lebih tinggi (prioritas 1 lebih darurat dari prioritas 3). Untuk penanganan tie-breaking (prioritas sama), digunakan timestamp kedatangan pasien. Sistem harus mampu: (1) mendaftarkan pasien baru dalam O(log n), (2) memanggil pasien berikutnya sesuai prioritas dalam O(log n), dan (3) menampilkan status antrian kapan saja.

### 13.9.2 Implementasi Sistem Antrian Medis dalam Python

```python
# ============================================================
# Priority Queue Berbasis Heap — Sistem Antrian Medis
# Bab 13 Struktur Data
# ============================================================

import time

class Pasien:
    """Representasi data pasien di UGD."""

    def __init__(self, nama, prioritas, kondisi):
        self.nama = nama
        self.prioritas = prioritas   # 1=Paling Darurat, 3=Tidak Darurat
        self.kondisi = kondisi
        self.waktu_masuk = time.time()  # Timestamp untuk tie-breaking

    def __lt__(self, other):
        """
        Operator perbandingan untuk heap.
        Prioritas lebih kecil = lebih mendesak (min-heap berdasarkan prioritas).
        Bila prioritas sama, pasien yang datang lebih awal didahulukan.
        """
        if self.prioritas != other.prioritas:
            return self.prioritas < other.prioritas
        return self.waktu_masuk < other.waktu_masuk

    def __repr__(self):
        return (f"Pasien({self.nama}, prioritas={self.prioritas}, "
                f"kondisi='{self.kondisi}')")


class AntreUGD:
    """
    Priority Queue untuk sistem antrian UGD menggunakan Min-Heap.
    Pasien dengan nilai prioritas lebih kecil dilayani lebih dahulu.
    Tie-breaking berdasarkan waktu kedatangan (FCFS dalam satu kelompok).
    """

    LABEL_PRIORITAS = {1: "DARURAT", 2: "GAWAT", 3: "TIDAK GAWAT"}

    def __init__(self):
        self.heap = []
        self.total_dilayani = 0

    def __len__(self):
        return len(self.heap)

    def is_empty(self):
        return len(self.heap) == 0

    def _parent(self, i):
        return (i - 1) // 2

    def _left_child(self, i):
        return 2 * i + 1

    def _right_child(self, i):
        return 2 * i + 2

    def _swap(self, i, j):
        self.heap[i], self.heap[j] = self.heap[j], self.heap[i]

    def _sift_up(self, i):
        while i > 0:
            parent = self._parent(i)
            if self.heap[i] < self.heap[parent]:
                self._swap(i, parent)
                i = parent
            else:
                break

    def _sift_down(self, i):
        n = len(self.heap)
        while True:
            terkecil = i
            left = self._left_child(i)
            right = self._right_child(i)

            if left < n and self.heap[left] < self.heap[terkecil]:
                terkecil = left
            if right < n and self.heap[right] < self.heap[terkecil]:
                terkecil = right

            if terkecil != i:
                self._swap(i, terkecil)
                i = terkecil
            else:
                break

    def daftarkan_pasien(self, nama, prioritas, kondisi):
        """
        Mendaftarkan pasien baru ke antrian UGD.
        Validasi prioritas: hanya 1, 2, atau 3.
        Kompleksitas: O(log n).
        """
        if prioritas not in [1, 2, 3]:
            raise ValueError("Prioritas harus 1 (darurat), 2 (gawat), "
                             "atau 3 (tidak gawat)")

        pasien = Pasien(nama, prioritas, kondisi)
        self.heap.append(pasien)
        self._sift_up(len(self.heap) - 1)
        label = self.LABEL_PRIORITAS[prioritas]
        print(f"  [DAFTAR] {nama:20s} | {label:12s} | {kondisi}")
        return pasien

    def panggil_pasien_berikutnya(self):
        """
        Memanggil pasien dengan prioritas tertinggi.
        Mengembalikan objek Pasien yang dipanggil.
        Kompleksitas: O(log n).
        """
        if self.is_empty():
            print("  [INFO] Tidak ada pasien dalam antrian.")
            return None

        if len(self.heap) == 1:
            pasien = self.heap.pop()
        else:
            pasien = self.heap[0]
            self.heap[0] = self.heap.pop()
            self._sift_down(0)

        self.total_dilayani += 1
        label = self.LABEL_PRIORITAS[pasien.prioritas]
        print(f"  [PANGGIL] {pasien.nama:19s} | {label:12s} | {pasien.kondisi}")
        return pasien

    def lihat_pasien_berikutnya(self):
        """Melihat pasien berikutnya tanpa mengeluarkannya dari antrian."""
        return self.heap[0] if not self.is_empty() else None

    def tampilkan_antrian(self):
        """Menampilkan daftar semua pasien dalam antrian saat ini."""
        if self.is_empty():
            print("  Antrian kosong.")
            return
        print(f"\n  Antrian UGD saat ini ({len(self.heap)} pasien):")
        print("  " + "-" * 60)
        for i, p in enumerate(self.heap):
            label = self.LABEL_PRIORITAS[p.prioritas]
            print(f"  [{i:2d}] {p.nama:20s} | {label:12s} | {p.kondisi}")
        print("  " + "-" * 60)


# --- Simulasi Sistem Antrian UGD ---
if __name__ == "__main__":
    print("=" * 62)
    print("     SIMULASI SISTEM ANTRIAN UGD RUMAH SAKIT")
    print("=" * 62)

    ugd = AntreUGD()

    print("\nTahap 1 — Pasien mendaftar:")
    ugd.daftarkan_pasien("Budi Santoso",  3, "Demam ringan")
    ugd.daftarkan_pasien("Sari Dewi",     2, "Patah tulang tangan")
    ugd.daftarkan_pasien("Ahmad Fauzi",   1, "Henti jantung")
    ugd.daftarkan_pasien("Rina Kusuma",   3, "Sakit kepala")
    ugd.daftarkan_pasien("Doni Pratama",  2, "Luka dalam")
    ugd.daftarkan_pasien("Maya Sari",     1, "Kesulitan bernapas")
    ugd.daftarkan_pasien("Teguh Wahyudi", 3, "Pilek biasa")

    ugd.tampilkan_antrian()

    print("\nTahap 2 — Proses pelayanan pasien:")
    print("  " + "-" * 60)
    while not ugd.is_empty():
        ugd.panggil_pasien_berikutnya()

    print(f"\n  Total pasien dilayani: {ugd.total_dilayani}")
    print("\nCatatan: Urutan pelayanan yang diharapkan:")
    print("  1. Ahmad Fauzi   — DARURAT (Henti jantung)")
    print("  2. Maya Sari     — DARURAT (Kesulitan bernapas)")
    print("  3. Sari Dewi     — GAWAT   (Patah tulang tangan)")
    print("  4. Doni Pratama  — GAWAT   (Luka dalam)")
    print("  5. Budi Santoso  — TIDAK GAWAT (Demam ringan)")
    print("  6. Rina Kusuma   — TIDAK GAWAT (Sakit kepala)")
    print("  7. Teguh Wahyudi — TIDAK GAWAT (Pilek biasa)")
```

### 13.9.3 Analisis Kinerja Sistem

Dengan implementasi min-heap di atas, sistem antrian UGD mencapai kinerja sebagai berikut: pendaftaran pasien baru (operasi enqueue) berjalan dalam O(log n), pemanggilan pasien berikutnya (operasi dequeue) berjalan dalam O(log n), dan pengecekan pasien berikutnya tanpa mengeluarkannya dari antrian (peek) berjalan dalam O(1). Untuk sebuah UGD dengan maksimal 100 pasien dalam antrian pada satu waktu, operasi pendaftaran dan pemanggilan masing-masing memerlukan paling banyak sekitar 7 langkah (log2 100 ≈ 6,64).

---

## 13.10 Analisis Kompleksitas dan Perbandingan Struktur Data

Pemilihan antara AVL tree dan heap bergantung pada pola penggunaan yang dominan dalam aplikasi:

**Tabel 13.5 — Perbandingan Kompleksitas AVL Tree dan Heap**

| Operasi | AVL Tree | Max/Min-Heap | Keterangan |
|---------|----------|--------------|------------|
| Insert | O(log n) | O(log n) | Setara |
| Delete | O(log n) | O(log n) | Setara |
| Search (sembarang) | O(log n) | O(n) | AVL tree unggul jauh |
| Find Max/Min | O(log n) | O(1) | Heap unggul jauh |
| Traversal terurut | O(n) | O(n log n) | AVL tree lebih efisien |
| Build dari array | O(n log n) | O(n) | Heap unggul |
| Heap Sort | Tidak berlaku | O(n log n) | — |
| Penggunaan memori | Lebih tinggi (pointer) | Rendah (array) | Heap lebih efisien |

Kesimpulan praktis: gunakan AVL tree ketika aplikasi membutuhkan pencarian sembarang yang efisien dan traversal terurut. Gunakan heap ketika aplikasi hanya membutuhkan akses ke elemen maksimum atau minimum secara berulang, seperti pada priority queue, heap sort, dan algoritma greedy.

> **Catatan Penting 13.3 — Struktur Data Ganda untuk Kebutuhan Kompleks**
>
> Dalam banyak sistem produksi yang kompleks, satu struktur data saja tidak cukup untuk memenuhi semua kebutuhan secara optimal. Sebagai contoh, sebuah sistem manajemen antrian rumah sakit yang perlu mendukung (a) pencarian pasien berdasarkan nomor rekam medis, (b) memanggil pasien dengan prioritas tertinggi, dan (c) menambahkan pasien baru, dapat menggunakan kombinasi dua struktur data secara bersamaan: min-heap untuk operasi (b) dan (c), serta hash table atau AVL tree untuk operasi (a). Meskipun menggunakan lebih banyak memori, pendekatan ini memberikan kompleksitas O(log n) untuk semua operasi. Praktik penggunaan struktur data ganda yang saling melengkapi ini sangat umum dalam rekayasa perangkat lunak tingkat lanjut.

---

## 13.11 Rangkuman Bab

Bab ini telah membahas dua struktur data pohon lanjutan yang memiliki aplikasi luas dalam ilmu komputer dan rekayasa perangkat lunak:

1. **Permasalahan Skewed Tree.** BST biasa rentan terdegradasi menjadi struktur linier O(n) apabila data disisipkan dalam urutan terurut atau hampir terurut. AVL tree mengatasi kelemahan mendasar ini dengan mempertahankan balance factor setiap simpul dalam rentang {-1, 0, +1} melalui rotasi otomatis, sehingga tinggi pohon selalu terjaga pada O(log n) dan semua operasi (insert, delete, search) berjalan dalam O(log n) bahkan pada kasus terburuk.

2. **Mekanisme Rotasi AVL Tree.** Terdapat empat kasus ketidakseimbangan yang masing-masing ditangani dengan strategi yang berbeda: kasus LL dengan rotasi kanan tunggal, kasus RR dengan rotasi kiri tunggal, kasus LR dengan rotasi ganda (kiri pada anak diikuti kanan pada simpul tidak seimbang), dan kasus RL dengan rotasi ganda (kanan pada anak diikuti kiri pada simpul tidak seimbang). Setiap operasi rotasi berjalan dalam O(1).

3. **Heap sebagai Complete Binary Tree.** Heap adalah struktur data complete binary tree yang dapat direpresentasikan secara efisien sebagai array tanpa pointer, dengan hubungan indeks parent-child yang dinyatakan melalui formula aritmetika sederhana. Max-heap menjamin elemen terbesar selalu berada di akar (O(1) akses), sementara min-heap menjamin hal yang sama untuk elemen terkecil.

4. **Operasi Heap.** Penyisipan elemen dilakukan dengan meletakkan elemen di akhir array kemudian menjalankan sift-up O(log n). Ekstraksi elemen maksimum/minimum dilakukan dengan memindahkan elemen terakhir ke akar kemudian menjalankan sift-down O(log n). Build-heap membangun heap dari array sembarang dalam O(n) — lebih efisien dari penyisipan bertahap O(n log n) — melalui pendekatan bottom-up yang mengeksploitasi struktur level pohon.

5. **Heap Sort.** Algoritma heap sort terdiri dari dua fase: (1) build-heap O(n) untuk mengorganisasi array menjadi max-heap, dan (2) fase pengurutan O(n log n) dengan berulang kali memindahkan elemen terbesar ke bagian akhir array yang sudah terurut. Heap sort memiliki kompleksitas waktu O(n log n) dan ruang O(1) pada semua kasus, namun bersifat tidak stabil.

6. **Priority Queue Berbasis Heap.** Heap merupakan implementasi priority queue yang paling efisien, menyediakan operasi insert dan extract-priority masing-masing dalam O(log n). Dibandingkan dengan implementasi berbasis array terurut atau tidak terurut, heap menawarkan keseimbangan terbaik untuk sistem yang membutuhkan frekuensi tinggi pada kedua operasi tersebut.

7. **Pemilihan Struktur Data yang Tepat.** AVL tree unggul dalam pencarian sembarang O(log n) dan traversal terurut, sedangkan heap unggul dalam akses elemen prioritas tertinggi/terendah O(1) dan efisiensi memori karena representasi array. Untuk aplikasi yang membutuhkan keduanya, kombinasi dua struktur data adalah pendekatan yang lazim digunakan dalam sistem produksi.

---

## 13.12 Istilah Kunci

1. **AVL Tree** (*Adelson-Velsky dan Landis Tree*) — Jenis self-balancing binary search tree yang menjamin bahwa balance factor setiap simpul bernilai -1, 0, atau +1, sehingga tinggi pohon selalu O(log n).
2. **Balance Factor** (*Faktor Keseimbangan*) — Selisih tinggi subpohon kiri dan subpohon kanan suatu simpul; diformulasikan sebagai BF = Tinggi(kiri) - Tinggi(kanan).
3. **Build-Heap** — Prosedur membangun heap valid dari array sembarang dalam O(n) menggunakan pendekatan bottom-up dengan sift-down pada semua simpul non-daun.
4. **Complete Binary Tree** (*Pohon Biner Lengkap*) — Pohon biner di mana semua level terisi penuh kecuali level terakhir, dan simpul-simpul di level terakhir diisi dari kiri ke kanan.
5. **Extract-Max / Extract-Min** — Operasi mengambil dan menghapus elemen terbesar (max-heap) atau terkecil (min-heap) dari heap, diikuti dengan pemulihan heap property melalui sift-down.
6. **Heap** — Struktur data complete binary tree yang memenuhi heap property, umumnya direpresentasikan sebagai array untuk efisiensi memori.
7. **Heap Property** (*Properti Heap*) — Aturan urutan nilai antar simpul dalam heap: pada max-heap setiap simpul lebih besar atau sama dengan semua keturunannya; pada min-heap sebaliknya.
8. **Heap Sort** — Algoritma pengurutan berbasis heap dengan kompleksitas O(n log n) pada semua kasus dan ruang O(1), terdiri dari fase build-heap dan fase pengurutan berulang.
9. **Max-Heap** — Heap di mana nilai setiap simpul lebih besar atau sama dengan nilai anak-anaknya, sehingga elemen terbesar selalu berada di akar.
10. **Min-Heap** — Heap di mana nilai setiap simpul lebih kecil atau sama dengan nilai anak-anaknya, sehingga elemen terkecil selalu berada di akar.
11. **Priority Queue** (*Antrian Berprioritas*) — Struktur data abstrak di mana setiap elemen memiliki nilai prioritas dan operasi pengeluaran selalu mengambil elemen dengan prioritas tertinggi.
12. **Rotasi Ganda** — Operasi penyeimbangan AVL tree yang melibatkan dua kali rotasi berurutan; digunakan untuk kasus LR (rotasi kiri kemudian kanan) dan kasus RL (rotasi kanan kemudian kiri).
13. **Rotasi Tunggal** — Operasi penyeimbangan AVL tree yang hanya memerlukan satu kali rotasi; rotasi kanan untuk kasus LL dan rotasi kiri untuk kasus RR.
14. **Self-Balancing BST** (*BST yang Menyeimbangkan Diri*) — Jenis BST yang secara otomatis menjaga keseimbangannya setelah setiap operasi insert atau delete melalui mekanisme struktural tertentu.
15. **Sift-Down** (*Pergeseran ke Bawah*) — Operasi memindahkan elemen dari posisi tertentu ke bawah dalam heap dengan menukar elemen tersebut dengan anak yang lebih besar (max-heap) atau lebih kecil (min-heap) secara berulang hingga heap property terpenuhi.
16. **Sift-Up** (*Pergeseran ke Atas*) — Operasi memindahkan elemen dari posisi tertentu ke atas dalam heap dengan menukar elemen tersebut dengan parent-nya secara berulang hingga heap property terpenuhi.
17. **Skewed Tree** (*Pohon Condong*) — Kondisi patologis pada BST di mana sebagian besar atau seluruh simpul hanya memiliki satu anak (kiri atau kanan), sehingga tinggi pohon mendekati n dan kinerja operasi terdegradasi ke O(n).
18. **Stable Sort** (*Pengurutan Stabil*) — Algoritma pengurutan yang menjamin elemen-elemen dengan nilai sama mempertahankan urutan relatif aslinya setelah pengurutan; heap sort bersifat tidak stabil.
19. **Triage** — Sistem klasifikasi pasien berdasarkan tingkat kegawatan kondisi medis, yang menjadi dasar implementasi priority queue pada sistem antrian UGD.
20. **In-place Sort** (*Pengurutan di Tempat*) — Algoritma pengurutan yang tidak memerlukan ruang memori tambahan yang proporsional terhadap ukuran input; heap sort adalah contoh algoritma in-place dengan O(1) ruang tambahan.

---

## 13.13 Soal Latihan

### Pilihan Ganda

**Soal 1** *(C2 — Memahami)*

Sebuah simpul dalam AVL tree memiliki balance factor = +2 dan anak kirinya memiliki balance factor = -1. Jenis rotasi yang diperlukan untuk menyeimbangkan pohon tersebut adalah...

a. Rotasi kanan tunggal (kasus LL)
b. Rotasi kiri tunggal (kasus RR)
c. Rotasi kiri-kanan ganda (kasus LR)
d. Rotasi kanan-kiri ganda (kasus RL)

*(Jawaban: c — Balance factor +2 pada simpul menunjukkan ketidakseimbangan ke kiri, dan balance factor -1 pada anak kirinya menunjukkan elemen baru berada di subpohon kanan anak kiri, yang merupakan definisi kasus LR.)*

---

**Soal 2** *(C2 — Memahami)*

Diketahui max-heap direpresentasikan sebagai array `[95, 70, 85, 40, 65, 80, 75]`. Apakah nilai pada indeks 5 (nilai 80) benar-benar memenuhi heap property? Berapa indeks parent dari elemen tersebut?

a. Ya, memenuhi; indeks parent = 1
b. Ya, memenuhi; indeks parent = 2
c. Tidak memenuhi; indeks parent = 2
d. Ya, memenuhi; indeks parent = 3

*(Jawaban: b — Parent dari indeks 5 = (5-1)//2 = 2. Nilai di indeks 2 adalah 85, dan 80 < 85, sehingga heap property terpenuhi.)*

---

**Soal 3** *(C3 — Menerapkan)*

Setelah operasi `extract_max()` pada max-heap `[50, 30, 40, 10, 20, 35, 25]`, representasi array heap yang benar setelah proses sift-down selesai adalah...

a. `[40, 30, 35, 10, 20, 25]`
b. `[40, 30, 25, 10, 20, 35]`
c. `[35, 30, 25, 10, 20, 40]`
d. `[40, 20, 35, 10, 30, 25]`

*(Jawaban: a — Langkah: (1) Ambil 50; (2) Pindah 25 ke akar: `[25, 30, 40, 10, 20, 35]`; (3) Sift-down: 40>25, tukar: `[40, 30, 25, 10, 20, 35]`; (4) 25 di indeks 2, anak kiri indeks 5 = 35 > 25, tukar: `[40, 30, 35, 10, 20, 25]`. Selesai.)*

---

**Soal 4** *(C4 — Menganalisis)*

Pernyataan-pernyataan berikut berkaitan dengan heap sort. Manakah kombinasi pernyataan yang BENAR?
1. Heap sort memiliki kompleksitas O(n log n) pada semua kasus (terbaik, rata-rata, dan terburuk).
2. Heap sort bersifat in-place dengan ruang tambahan O(1).
3. Heap sort bersifat stabil (stable sort).
4. Fase build-heap memiliki kompleksitas O(n).

a. Pernyataan 1, 2, dan 3
b. Pernyataan 1, 2, dan 4
c. Pernyataan 1, 3, dan 4
d. Pernyataan 2, 3, dan 4

*(Jawaban: b — Pernyataan 3 salah. Heap sort bersifat tidak stabil (unstable) karena operasi tukar dalam fase pengurutan dapat mengubah urutan relatif elemen-elemen yang bernilai sama.)*

---

**Soal 5** *(C2 — Memahami)*

Dalam representasi array sebuah heap dengan n = 15 elemen (indeks 0 sampai 14), berapakah indeks simpul non-daun terakhir? Dengan demikian, berapa jumlah simpul daun dalam heap ini?

a. Indeks 6, jumlah daun = 7
b. Indeks 7, jumlah daun = 8
c. Indeks 6, jumlah daun = 8
d. Indeks 7, jumlah daun = 7

*(Jawaban: c — Simpul non-daun terakhir = (15//2) - 1 = 7 - 1 = 6. Simpul daun adalah indeks 7 sampai 14, berjumlah 8.)*

---

### Soal Esai

**Soal 6** *(C3 — Menerapkan)*

Sisipkan elemen-elemen berikut secara berurutan ke dalam AVL tree yang awalnya kosong: **15, 10, 20, 8, 12, 16, 25, 6**. Untuk setiap langkah penyisipan, gambarkan struktur pohon yang terbentuk, hitung balance factor setiap simpul, dan tentukan apakah diperlukan rotasi serta jenis rotasi yang dilakukan. Tunjukkan pohon akhir beserta balance factor masing-masing simpul.

---

**Soal 7** *(C4 — Menganalisis)*

Diberikan array `[7, 3, 9, 2, 8, 1, 5, 4, 6]`. Lakukan proses build-heap secara manual untuk mengubah array ini menjadi max-heap. Tunjukkan isi array setelah setiap pemanggilan sift-down, beserta gambar struktur pohon pada kondisi awal dan kondisi akhir. Kemudian buktikan secara intuitif mengapa kompleksitas build-heap adalah O(n), bukan O(n log n), meskipun sift-down dipanggil sebanyak n/2 kali.

---

**Soal 8** *(C4 — Menganalisis)*

Lanjutkan dari hasil build-heap Soal 7. Lakukan dua iterasi pertama dari fase pengurutan heap sort. Tunjukkan isi array setelah setiap tukar dan sift-down, serta jelaskan bagaimana heap sort memastikan elemen-elemen yang sudah berada di posisi akhir yang benar tidak akan "terganggu" oleh iterasi berikutnya.

---

**Soal 9** *(C5 — Mengevaluasi)*

Bandingkan penggunaan **heap (min-heap)** versus **AVL tree** untuk mengimplementasikan sistem penjadwalan proses pada sistem operasi, di mana: (a) setiap saat perlu mengetahui proses dengan prioritas tertinggi untuk dieksekusi, (b) proses baru dapat ditambahkan kapan saja, (c) proses dapat dihapus dari antrian bahkan sebelum dieksekusi (misalnya karena di-terminate oleh pengguna), dan (d) kadang perlu mencari proses tertentu berdasarkan ID proses. Untuk setiap kebutuhan, jelaskan struktur data mana yang lebih sesuai dan berikan justifikasi berdasarkan kompleksitas operasi. Apakah ada skenario di mana kombinasi keduanya diperlukan?

---

**Soal 10** *(C5 — Mengevaluasi)*

Sebuah sistem rekomendasi musik menggunakan max-heap untuk menyimpan lagu-lagu berdasarkan skor relevansi (nilai float 0.0–1.0). Sistem perlu menampilkan 10 rekomendasi teratas secara real-time ketika pengguna membuka aplikasi, sekaligus memperbarui skor lagu-lagu tertentu berdasarkan umpan balik pengguna (skor dapat naik atau turun). Operasi "perbarui skor" ini disebut *update-key* dan berbeda dari *decrease-key* karena nilai baru dapat lebih besar atau lebih kecil. Rancang strategi implementasi untuk operasi update-key ini pada max-heap, analisis kompleksitasnya, dan diskusikan apakah heap masih menjadi pilihan terbaik untuk kasus ini atau ada struktur data alternatif yang lebih sesuai.

---

**Soal 11** *(C6 — Mencipta)*

Rancang dan implementasikan dalam Python sebuah kelas `PriorityQueueMerge` yang mendukung operasi *merge* (penggabungan) dua priority queue menjadi satu priority queue baru. Pendekatan pertama menggunakan heap biasa dengan operasi insert satu per satu (O(n log n)). Pendekatan kedua menggunakan metode yang lebih efisien. Bandingkan kompleksitas kedua pendekatan tersebut, implementasikan keduanya dalam Python, dan uji dengan contoh yang memverifikasi kebenaran hasil merge.

---

**Soal 12** *(C6 — Mencipta)*

Sebuah perusahaan logistik memerlukan sistem pengelolaan pengiriman paket dengan ketentuan: setiap paket memiliki tujuan, berat, dan tingkat urgensi (1–5, di mana 1 paling urgen). Dalam satu hari, puluhan ribu paket masuk dan keluar dari sistem. Sistem perlu mendukung: (1) penambahan paket baru, (2) pengambilan paket paling urgen untuk dikirim, (3) pencarian paket berdasarkan nomor resi, (4) pembatalan paket yang belum dikirim, dan (5) laporan semua paket terurut berdasarkan urgensi. Rancang arsitektur solusi menggunakan struktur data yang telah dipelajari dalam buku ini (heap, AVL tree, hash table, atau kombinasinya). Gambarkan diagram arsitektur, jelaskan struktur data yang digunakan untuk setiap operasi, dan analisis kompleksitas keseluruhan sistem. Sertakan potongan kode Python untuk setidaknya dua operasi inti.

---

## 13.14 Bacaan Lanjutan

1. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022).** *Introduction to Algorithms* (4th ed.). MIT Press. **Bab 6 (Heapsort) dan Bab 13 (Red-Black Trees).**
   *Buku ini merupakan referensi paling komprehensif dan otoritatif dalam bidang algoritma. Bab 6 membahas struktur heap, algoritma build-heap dengan bukti O(n) yang ketat menggunakan analisis amortized, heapsort, dan priority queue. Pembaca yang ingin memahami lebih dalam tentang self-balancing tree dapat membaca Bab 13 tentang Red-Black Tree sebagai alternatif AVL tree yang digunakan dalam implementasi praktis seperti `std::map` di C++.*

2. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013).** *Data Structures and Algorithms in Python*. John Wiley & Sons. **Bab 9 (Priority Queues) dan Bab 11 (Search Trees).**
   *Buku ini secara khusus menggunakan Python sebagai bahasa implementasi, sehingga sangat relevan untuk pembaca buku ini. Bab 9 mencakup implementasi priority queue berbasis heap dalam Python dengan antarmuka kelas yang bersih, beserta analisis kompleksitas yang rinci. Bab 11 membahas AVL tree dengan contoh kode yang komprehensif dan visualisasi yang membantu. Direkomendasikan sebagai buku pendamping utama.*

3. **Sedgewick, R., & Wayne, K. (2011).** *Algorithms* (4th ed.). Addison-Wesley Professional. **Bab 2.4 (Priority Queues) dan Bab 3.3 (Balanced Search Trees).**
   *Buku ini dikenal dengan pendekatannya yang sangat visual dan berorientasi implementasi. Bab 2.4 menyajikan heap dan priority queue dengan animasi dan trace yang sangat jelas, cocok untuk membangun intuisi. Bab 3.3 membahas 2-3 tree dan Red-Black tree sebagai alternatif AVL tree. Situs web buku ini (algs4.cs.princeton.edu) menyediakan visualisasi interaktif yang sangat membantu untuk memahami rotasi dan operasi heap secara dinamis.*

4. **Knuth, D. E. (1998).** *The Art of Computer Programming, Volume 3: Sorting and Searching* (2nd ed.). Addison-Wesley. **Seksi 5.2.3 (Sorting by Selection) dan Seksi 6.2.3 (Balanced Trees).**
   *Referensi klasik yang memberikan analisis matematis paling mendalam tentang algoritma pengurutan dan struktur data pohon. Seksi 5.2.3 memuat analisis historis dan matematis heap sort yang ditemukan oleh J.W.J. Williams (1964) dan diperbaiki oleh R.W. Floyd. Meskipun bukan bacaan ringan, buku ini adalah sumber primer yang tidak tertandingi untuk pembaca yang ingin menguasai fondasi matematika dari topik ini.*

5. **Kleinberg, J., & Tardos, E. (2005).** *Algorithm Design*. Pearson Education. **Bab 4 (Greedy Algorithms), Seksi 4.4 (Shortest Paths in a Graph).**
   *Buku ini menonjol dalam menjelaskan aplikasi priority queue dalam konteks algoritma greedy. Seksi 4.4 membahas algoritma Dijkstra untuk jalur terpendek, di mana min-heap dengan operasi decrease-key menjadi komponen kunci untuk mencapai kompleksitas O((V + E) log V). Sangat direkomendasikan untuk memahami mengapa priority queue berbasis heap sangat penting dalam penyelesaian masalah graf.*

6. **Miller, B. N., & Ranum, D. L. (2011).** *Problem Solving with Algorithms and Data Structures Using Python* (2nd ed.). Franklin, Beedle & Associates. **Bab 7 (Trees and Tree Algorithms) dan Bab 8 (Graphs).**
   *Tersedia secara bebas di runestone.academy, buku ini adalah sumber yang paling mudah diakses dan paling ramah bagi mahasiswa. Penjelasannya langkah-demi-langkah dengan ilustrasi yang banyak dan kode Python yang dapat langsung dijalankan di browser. Sangat direkomendasikan sebagai titik awal sebelum membaca referensi yang lebih teknis.*

7. **Brass, P. (2008).** *Advanced Data Structures*. Cambridge University Press. **Bab 2 (Search Trees) dan Bab 5 (Heaps).**
   *Untuk pembaca yang ingin melangkah lebih jauh dari materi standar, buku ini membahas varian-varian lanjutan seperti B-tree, Fibonacci heap, dan leftist heap. Fibonacci heap khususnya sangat relevan karena mendukung operasi decrease-key dalam O(1) amortized, yang meningkatkan kompleksitas algoritma Dijkstra menjadi O(V log V + E). Bab ini juga membahas analisis amortized secara menyeluruh.*

8. **Okasaki, C. (1998).** *Purely Functional Data Structures*. Cambridge University Press. **Bab 3 (Leftist Heaps dan Binomial Heaps).**
   *Buku yang sangat berbeda dari referensi-referensi sebelumnya: membahas struktur data dalam paradigma pemrograman fungsional murni. Leftist heap dan binomial heap yang dibahas di sini mendukung operasi merge dua heap dalam O(log n) — jauh lebih efisien dari heap biasa. Referensi ini sangat bermanfaat bagi mahasiswa yang tertarik pada desain struktur data yang lebih ekspresif dan komposabel.*

---

*Bab ini merupakan bagian dari buku "Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python", disusun untuk Program Studi Informatika, Institut Teknologi dan Bisnis STIKI Indonesia (INSTIKI). Seluruh implementasi kode Python dalam bab ini telah diuji menggunakan Python 3.10 ke atas.*

*Revisi: April 2026*
