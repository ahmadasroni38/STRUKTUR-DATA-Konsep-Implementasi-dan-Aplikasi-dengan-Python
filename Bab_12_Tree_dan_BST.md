# BAB 12
# TREE DAN BINARY SEARCH TREE

---

> *"Dalam alam semesta komputasi, pohon bukan sekadar metafora — ia adalah arsitektur alamiah bagi data yang bertingkat, berhierarki, dan saling bergantung. Memahami pohon berarti memahami cara kerja sistem berkas, basis data, dan kecerdasan buatan itu sendiri."*
>
> — Donald E. Knuth, *The Art of Computer Programming*, Vol. 1

---

## Tujuan Pembelajaran

Setelah mempelajari bab ini, mahasiswa diharapkan mampu:

1. **[C2 — Memahami]** Menjelaskan terminologi dasar tree secara tepat dan konsisten, meliputi root, leaf, internal node, parent, child, sibling, ancestor, descendant, subtree, depth, level, dan height, serta membedakan konsep depth dan height secara formal.

2. **[C2 — Memahami]** Membedakan empat klasifikasi binary tree — binary tree biasa, full binary tree, complete binary tree, dan perfect binary tree — berdasarkan sifat strukturalnya masing-masing dan mengidentifikasi properti matematis yang menyertai setiap klasifikasi.

3. **[C3 — Menerapkan]** Memformulasikan BST invariant secara formal dan menerapkannya untuk memverifikasi keabsahan suatu binary tree sebagai BST, termasuk mendeteksi pelanggaran invariant pada contoh yang diberikan.

4. **[C3 — Menerapkan]** Mengimplementasikan operasi insert, search, dan delete pada Binary Search Tree dalam bahasa Python menggunakan pendekatan berbasis kelas berorientasi objek, dengan menangani ketiga kasus penghapusan secara benar.

5. **[C4 — Menganalisis]** Menerapkan dan membandingkan ketiga metode traversal — inorder, preorder, dan postorder — pada suatu BST, serta menganalisis secara formal mengapa inorder traversal selalu menghasilkan data dalam urutan terurut.

6. **[C4 — Menganalisis]** Menganalisis kompleksitas waktu dan ruang operasi-operasi BST pada kasus terbaik, rata-rata, dan terburuk, serta mengidentifikasi kondisi degenerasi BST dan dampaknya terhadap kinerja.

7. **[C5 — Mengevaluasi]** Mengevaluasi kesesuaian penggunaan BST dibandingkan struktur data lain (array terurut, linked list) dalam skenario aplikasi nyata seperti sistem berkas hierarkis dan kamus data.

8. **[C6 — Mencipta]** Merancang dan mengimplementasikan struktur pohon untuk merepresentasikan sistem berkas direktori, termasuk operasi penambahan, pencarian, dan penelusuran menggunakan traversal yang sesuai.

---

## 12.1. Pendahuluan: Mengapa Dunia Membutuhkan Struktur Hierarkis

Seluruh bab sebelumnya dalam buku ini telah membahas struktur data yang bersifat linear: array menyimpan elemen dalam barisan berindeks, linked list menghubungkan simpul satu per satu, stack mengoperasikan elemen secara LIFO, dan queue secara FIFO. Struktur-struktur linear tersebut sangat efektif untuk memodelan antrian, tumpukan, dan daftar. Namun, dunia nyata kerap menyajikan data yang tidak linear — data yang memiliki hubungan hierarkis, di mana satu entitas dapat memiliki beberapa entitas turunan, dan setiap entitas turunan dapat pula memiliki turunan-turunan berikutnya.

Pertimbangkan beberapa contoh konkret. Sistem berkas pada komputer mengorganisasikan berkas dan direktori dalam hierarki: direktori root berisi subdirektori, setiap subdirektori berisi subdirektori dan berkas-berkas lain, dan seterusnya hingga berkas daun yang tidak memiliki anak. Struktur organisasi perusahaan memiliki direktur utama di puncak, di bawahnya terdapat manajer divisi, di bawah manajer terdapat supervisor, dan seterusnya. Ekspresi matematika seperti `(a + b) * (c - d)` secara alami terwakili sebagai pohon dengan operator sebagai simpul dalam dan operan sebagai simpul daun. Klasifikasi biologis menempatkan kerajaan, filum, kelas, ordo, famili, genus, dan spesies dalam hierarki yang ketat.

Seluruh contoh di atas berbagi satu karakteristik fundamental: terdapat satu entitas "induk" yang tidak memiliki induk sendiri (disebut akar), dan setiap entitas lain memiliki tepat satu induk namun dapat memiliki nol atau lebih anak. Inilah yang dalam ilmu komputer disebut **tree** atau pohon — struktur data non-linear yang merepresentasikan hubungan hierarkis antar elemen.

Di antara berbagai jenis tree yang dikenal dalam ilmu komputer, **Binary Search Tree (BST)** merupakan salah satu yang paling fundamental dan berdampak besar. BST tidak sekadar merepresentasikan hierarki, tetapi juga mendefinisikan aturan pengurutan yang memungkinkan pencarian data dilakukan dalam waktu O(log n) rata-rata — sebuah pencapaian yang jauh melampaui pencarian linear O(n) pada struktur tak terurut. Efisiensi ini menjadikan BST sebagai tulang punggung berbagai sistem: indeks basis data, kamus data, tabel simbol pada kompiler, dan banyak lagi.

Bab ini membangun pemahaman secara bertahap: dimulai dari terminologi dasar tree, kemudian klasifikasi binary tree, dilanjutkan ke BST invariant, operasi-operasi BST beserta implementasi Python-nya, traversal dan implikasinya, analisis kompleksitas, hingga studi kasus sistem berkas yang menjembatani teori dengan aplikasi nyata.

---

## 12.2. Terminologi Dasar Tree

Sebelum membahas operasi pada tree, penguasaan terminologi yang presisi sangat penting. Terminologi ini bukan sekadar nama — setiap istilah mendefinisikan konsep yang akan digunakan dalam analisis dan implementasi.

### 12.2.1. Struktur Dasar Tree

Sebuah tree terdiri dari kumpulan **simpul** (node) yang dihubungkan oleh **tepi** (edge). Tidak seperti graf umum, tree memiliki sifat khusus: ia bersifat asiklik (tidak ada siklus) dan terhubung (setiap simpul dapat dicapai dari simpul mana pun). Selain itu, tree berarah dari atas ke bawah: setiap tepi menghubungkan induk ke anak.

Perhatikan diagram tree berikut sebagai referensi untuk seluruh diskusi terminologi dalam subbab ini.

```
Gambar 12.1. Contoh Tree dengan Delapan Simpul

                     [A]          <- Root (Akar)
                    /   \
                  [B]   [C]       <- Level 1
                 /   \     \
               [D]   [E]   [F]   <- Level 2
              /   \
            [G]   [H]             <- Level 3 (Leaf nodes)
```

**Tabel 12.1. Terminologi Dasar Tree**

| Istilah | Definisi Formal | Contoh pada Gambar 12.1 |
|---|---|---|
| **Root (Akar)** | Simpul tunggal yang tidak memiliki induk; titik masuk ke seluruh tree | Node A |
| **Leaf (Daun)** | Simpul yang tidak memiliki anak sama sekali; simpul terminal | Node E, F, G, H |
| **Internal Node** | Simpul yang memiliki minimal satu anak | Node A, B, C, D |
| **Parent (Induk)** | Simpul yang langsung berada satu tingkat di atas simpul tertentu | A adalah parent dari B dan C |
| **Child (Anak)** | Simpul yang langsung berada satu tingkat di bawah simpul tertentu | B dan C adalah children dari A |
| **Sibling (Saudara)** | Simpul-simpul yang memiliki induk yang sama | B dan C bersaudara; G dan H bersaudara |
| **Ancestor** | Semua simpul pada jalur dari root ke simpul tertentu (tidak termasuk simpul itu sendiri) | A, B, D adalah ancestors dari G |
| **Descendant** | Semua simpul yang dapat dicapai dari simpul tertentu menuju ke bawah | B, D, E, G, H adalah descendants dari A (melalui cabang B) |
| **Subtree** | Sebuah simpul beserta seluruh descendants-nya | Subtree berakar di B mencakup {B, D, E, G, H} |
| **Edge (Tepi)** | Tautan yang menghubungkan dua simpul dengan relasi parent-child | Tautan A-B, A-C, B-D, dst. |
| **Path (Jalur)** | Urutan simpul yang dihubungkan oleh tepi-tepi berurutan | Jalur dari A ke G: A -> B -> D -> G |
| **Degree (Derajat)** | Jumlah anak yang dimiliki suatu simpul | Degree(A) = 2, Degree(D) = 2, Degree(C) = 1, Degree(E) = 0 |

---

> **Catatan Penting 12.1**
>
> Perhatikan perbedaan antara "ancestor" dan "parent". Parent adalah ancestor langsung (satu tingkat di atas), sedangkan ancestor mencakup semua simpul dari root hingga induk langsung. Dengan demikian, semua parent adalah ancestor, tetapi tidak semua ancestor adalah parent. Demikian pula, "child" adalah descendant langsung, sedangkan descendant mencakup seluruh cabang di bawah suatu simpul.

---

### 12.2.2. Depth dan Level

**Depth** (kedalaman) suatu simpul adalah jumlah tepi pada jalur dari root ke simpul tersebut. Root memiliki depth 0 (konvensi yang digunakan oleh Cormen et al., 2009, dan mayoritas literatur modern).

Berdasarkan Gambar 12.1:
- Depth(A) = 0  (root)
- Depth(B) = 1, Depth(C) = 1
- Depth(D) = 2, Depth(E) = 2, Depth(F) = 2
- Depth(G) = 3, Depth(H) = 3

**Level** suatu simpul dalam beberapa konvensi didefinisikan sebagai depth + 1, sehingga root berada pada Level 1. Namun, dalam literatur lain level dan depth digunakan secara sinonim. Buku ini mengikuti konvensi Cormen et al. di mana root berada pada depth 0.

```
Gambar 12.2. Ilustrasi Depth dan Level pada Tree

Level 0 / Depth 0:          [A]
                            /   \
Level 1 / Depth 1:        [B]   [C]
                          /   \     \
Level 2 / Depth 2:      [D]   [E]   [F]
                        /   \
Level 3 / Depth 3:    [G]   [H]
```

### 12.2.3. Height (Tinggi)

**Height** (tinggi) suatu simpul adalah jumlah tepi pada jalur terpanjang dari simpul tersebut ke leaf yang paling dalam di bawahnya. Setiap leaf memiliki height 0. **Height of the tree** adalah height dari root-nya.

```
Gambar 12.3. Height Setiap Simpul pada Tree Gambar 12.1

    [A] h=3
   /       \
[B] h=2   [C] h=1
/       \        \
[D] h=1 [E] h=0  [F] h=0
/      \
[G] h=0 [H] h=0
```

Rumus rekursif untuk menghitung height:

```
height(node) = 0                                    jika node adalah leaf
height(node) = 1 + max(height(child_i))             untuk semua anak node
```

Berdasarkan Gambar 12.1:
- Height(G) = Height(H) = Height(E) = Height(F) = 0  (semua leaf)
- Height(D) = 1 + max(0, 0) = 1
- Height(C) = 1 + max(0) = 1
- Height(B) = 1 + max(1, 0) = 2
- **Height(A) = Height of Tree = 1 + max(2, 1) = 3**

---

> **Tahukah Anda? 12.1**
>
> Ada dua konvensi berbeda dalam mendefinisikan height pohon kosong. Cormen et al. mendefinisikan height pohon kosong (tanpa node) sebagai -1, agar rumus height(node) = 1 + max(height(left), height(right)) tetap konsisten untuk node yang salah satunya adalah None. Konvensi lain mendefinisikannya sebagai 0. Dalam implementasi Python pada bab ini, kita mengikuti konvensi Cormen et al. sehingga `height(None) = -1`.

---

## 12.3. Klasifikasi Binary Tree

**Binary tree** adalah tree yang setiap simpulnya memiliki paling banyak dua anak, yang secara konvensional disebut anak kiri (left child) dan anak kanan (right child). Perbedaan "kiri" dan "kanan" bukan sekadar posisi visual — ia memiliki makna semantik, khususnya pada BST.

### 12.3.1. Binary Tree Biasa

Binary tree biasa tidak memiliki syarat tambahan selain batasan dua anak. Setiap simpul boleh memiliki 0, 1, atau 2 anak.

```
Gambar 12.4. Contoh Binary Tree Biasa

       [10]
      /    \
   [5]    [15]
  /    \
[3]   [7]
```

### 12.3.2. Full Binary Tree (Pohon Biner Penuh)

Setiap simpul pada full binary tree memiliki tepat 0 atau 2 anak — tidak ada simpul yang memiliki tepat satu anak.

```
Gambar 12.5. Full Binary Tree

         [1]
        /   \
      [2]   [3]
      / \   / \
    [4] [5][6] [7]
```

**Properti matematis:** Jika sebuah full binary tree memiliki L leaf, maka jumlah internal node adalah L - 1, sehingga total simpul adalah 2L - 1.

### 12.3.3. Complete Binary Tree (Pohon Biner Lengkap)

Pada complete binary tree, semua level terisi penuh kecuali level terakhir, dan simpul-simpul pada level terakhir ditempatkan serapat mungkin dari sisi kiri.

```
Gambar 12.6. Complete Binary Tree

         [1]
        /   \
      [2]   [3]
      / \   /
    [4] [5][6]
```

**Properti matematis:** Complete binary tree dengan n simpul memiliki height = floor(log2(n)). Struktur ini sangat penting karena menjadi dasar implementasi heap (priority queue) yang efisien menggunakan array.

### 12.3.4. Perfect Binary Tree (Pohon Biner Sempurna)

Perfect binary tree adalah binary tree yang setiap internal node-nya memiliki tepat dua anak dan seluruh leaf berada pada level yang sama.

```
Gambar 12.7. Perfect Binary Tree dengan Height 2

         [1]
        /   \
      [2]   [3]
      / \   / \
    [4] [5][6] [7]
```

**Properti matematis:** Perfect binary tree dengan height h memiliki tepat 2^(h+1) - 1 simpul dan 2^h leaf. Ini adalah kasus "ideal" BST yang menghasilkan kinerja pencarian terbaik O(log n).

**Tabel 12.2. Perbandingan Klasifikasi Binary Tree**

| Jenis | Jumlah Anak per Node | Kondisi Level Terakhir | Penggunaan Utama |
|---|---|---|---|
| Binary Tree Biasa | 0, 1, atau 2 | Bebas | Representasi umum |
| Full Binary Tree | 0 atau 2 | Bebas | Ekspresi matematis |
| Complete Binary Tree | 0, 1, atau 2 | Terisi dari kiri | Heap / Priority Queue |
| Perfect Binary Tree | 0 atau 2 | Semua leaf di level sama | Analisis kompleksitas ideal |

---

## 12.4. Binary Search Tree: Definisi dan Invariant

**Binary Search Tree (BST)** adalah binary tree yang memenuhi **BST property** (juga disebut BST invariant) berikut:

---

> **Definisi 12.1 — BST Property**
>
> Untuk setiap simpul N dengan nilai V dalam sebuah BST:
> 1. Semua nilai pada **subpohon kiri** N adalah **kurang dari V**.
> 2. Semua nilai pada **subpohon kanan** N adalah **lebih besar dari V**.
> 3. Subpohon kiri dan subpohon kanan N masing-masing juga merupakan BST.

---

Kondisi ketiga bersifat rekursif: BST property tidak hanya berlaku pada root, melainkan pada setiap simpul di seluruh pohon. Ini adalah perbedaan penting yang sering diabaikan. Perhatikan contoh berikut.

```
Gambar 12.8. Contoh BST yang Valid

         [50]
        /    \
      [30]   [70]
      /  \   /  \
   [20] [40][60] [80]
```

Verifikasi BST property:
- Simpul 50: subpohon kiri {20, 30, 40} seluruhnya < 50; subpohon kanan {60, 70, 80} seluruhnya > 50. VALID.
- Simpul 30: subpohon kiri {20} < 30; subpohon kanan {40} > 30. VALID.
- Simpul 70: subpohon kiri {60} < 70; subpohon kanan {80} > 70. VALID.

```
Gambar 12.9. Contoh Binary Tree yang BUKAN BST

         [50]
        /    \
      [30]   [70]
      /  \   /  \
   [20] [60][40] [80]
         ^    ^
         |    Pelanggaran: 40 berada di subpohon kanan 50,
         |    padahal 40 < 50 (seharusnya di subpohon kiri 50)
         Pelanggaran: 60 berada di subpohon kiri 50,
         padahal 60 > 50 (seharusnya di subpohon kanan 50)
```

Pohon pada Gambar 12.9 secara struktural adalah binary tree yang sah, tetapi melanggar BST property sehingga tidak dapat disebut BST. Algoritma pencarian BST tidak akan berfungsi dengan benar pada pohon seperti ini.

---

> **Catatan Penting 12.2 — Pelanggaran BST Property yang Sering Terlewat**
>
> Pelanggaran BST property tidak selalu terjadi pada anak langsung (direct child). Perhatikan kasus berikut: misalkan root bernilai 50 dan memiliki anak kanan bernilai 70. Node 70 memiliki anak kiri bernilai 45. Secara lokal, 45 < 70 tampak benar. Namun, 45 juga harus lebih besar dari 50 (karena berada di subpohon kanan 50), dan 45 < 50 melanggar BST property. Oleh karena itu, validasi BST tidak cukup hanya memeriksa relasi parent-child — setiap simpul harus diperiksa terhadap batas atas dan batas bawah yang diwariskan dari leluhurnya.

---

## 12.5. Konstruksi BST: Operasi Insert

### 12.5.1. Algoritma Insert

Penyisipan simpul baru pada BST mengikuti prinsip sederhana: lacak posisi yang sesuai dengan mematuhi BST property pada setiap langkah.

**Algoritma 12.1 — BST Insert**
```
PROCEDURE BST-INSERT(T, v):
  node_baru <- TreeNode(v)
  IF T.root == None THEN
    T.root <- node_baru
    RETURN
  current <- T.root
  WHILE True DO
    IF v < current.data THEN
      IF current.left == None THEN
        current.left <- node_baru
        RETURN
      ELSE
        current <- current.left
    ELSE IF v > current.data THEN
      IF current.right == None THEN
        current.right <- node_baru
        RETURN
      ELSE
        current <- current.right
    ELSE
      RETURN  // Duplikat diabaikan
```

### 12.5.2. Trace Insert Langkah demi Langkah

Berikut adalah penelusuran mendetail konstruksi BST dari urutan [50, 30, 70, 20, 40, 60, 80].

**Langkah 1 — Insert 50:** Pohon kosong; 50 menjadi root.
```
[50]
```

**Langkah 2 — Insert 30:** 30 < 50, masuk ke kiri. Kiri 50 kosong: tempatkan di sana.
```
   [50]
   /
 [30]
```

**Langkah 3 — Insert 70:** 70 > 50, masuk ke kanan. Kanan 50 kosong: tempatkan di sana.
```
   [50]
   /  \
 [30] [70]
```

**Langkah 4 — Insert 20:** 20 < 50 -> kiri ke [30]; 20 < 30 -> kiri [30] kosong: tempatkan.
```
     [50]
     /  \
   [30] [70]
   /
 [20]
```

**Langkah 5 — Insert 40:** 40 < 50 -> kiri ke [30]; 40 > 30 -> kanan [30] kosong: tempatkan.
```
     [50]
     /  \
   [30] [70]
   /  \
 [20] [40]
```

**Langkah 6 — Insert 60:** 60 > 50 -> kanan ke [70]; 60 < 70 -> kiri [70] kosong: tempatkan.
```
        [50]
       /    \
     [30]   [70]
     /  \   /
   [20] [40][60]
```

**Langkah 7 — Insert 80:** 80 > 50 -> kanan ke [70]; 80 > 70 -> kanan [70] kosong: tempatkan.
```
Gambar 12.10. BST Akhir setelah Insert [50, 30, 70, 20, 40, 60, 80]

           [50]
          /    \
       [30]    [70]
       /  \    /  \
     [20] [40][60] [80]
```

BST ini merupakan perfect binary tree dengan height 2 — kasus ideal yang memberikan kinerja pencarian O(log n) = O(log 7) ≈ O(2.8), atau maksimal 3 perbandingan untuk mencari nilai apa pun.

---

> **Studi Kasus 12.1 — Urutan Insert dan Struktur Pohon**
>
> Struktur akhir BST sangat bergantung pada urutan data yang dimasukkan. Misalkan kita memasukkan tujuh nilai yang sama tetapi dalam urutan berbeda:
>
> - Urutan [50, 30, 70, 20, 40, 60, 80] menghasilkan perfect binary tree dengan height 2.
> - Urutan [20, 30, 40, 50, 60, 70, 80] (terurut menaik) menghasilkan pohon yang menyerupai linked list dengan height 6.
> - Urutan [80, 70, 60, 50, 40, 30, 20] (terurut menurun) juga menghasilkan pohon seperti linked list dengan height 6 (ke kiri).
>
> Pelajaran: BST rentan terhadap input terurut. Ini adalah motivasi utama pengembangan AVL Tree dan Red-Black Tree yang secara otomatis menyeimbangkan diri.

---

## 12.6. Operasi Search pada BST

### 12.6.1. Algoritma Search

Pencarian pada BST memanfaatkan BST property untuk membuang separuh ruang pencarian pada setiap langkah — persis seperti binary search pada array terurut.

**Algoritma 12.2 — BST Search**
```
PROCEDURE BST-SEARCH(node, target):
  IF node == None THEN
    RETURN False  // Tidak ditemukan
  IF target == node.data THEN
    RETURN True   // Ditemukan
  ELSE IF target < node.data THEN
    RETURN BST-SEARCH(node.left, target)
  ELSE
    RETURN BST-SEARCH(node.right, target)
```

**Trace pencarian 40 pada BST Gambar 12.10:**
```
Langkah 1: Periksa root [50]. 40 < 50 -> masuk ke kiri.
Langkah 2: Periksa [30].   40 > 30 -> masuk ke kanan.
Langkah 3: Periksa [40].   40 == 40 -> DITEMUKAN. (3 perbandingan)
```

**Trace pencarian 45 (tidak ada) pada BST Gambar 12.10:**
```
Langkah 1: Periksa root [50]. 45 < 50 -> masuk ke kiri.
Langkah 2: Periksa [30].   45 > 30 -> masuk ke kanan.
Langkah 3: Periksa [40].   45 > 40 -> masuk ke kanan.
Langkah 4: kanan [40] = None -> TIDAK DITEMUKAN. (3 perbandingan + 1 pengecekan null)
```

---

## 12.7. Operasi Delete pada BST

Penghapusan simpul pada BST adalah operasi yang paling kompleks di antara operasi-operasi BST. Kompleksitasnya berasal dari keharusan mempertahankan BST property setelah simpul dihapus. Terdapat tiga kasus yang harus ditangani secara berbeda.

### 12.7.1. Kasus 1 — Menghapus Node Leaf (Simpul Daun)

**Kondisi:** Simpul yang dihapus tidak memiliki anak kiri maupun anak kanan.

**Tindakan:** Hapus simpul tersebut dan set pointer dari induknya ke `None`. Ini adalah kasus paling sederhana karena tidak ada subpohon yang perlu dipindahkan.

```
Gambar 12.11. Delete Kasus 1: Menghapus Node Leaf [20]

SEBELUM:                    SESUDAH:
         [50]                        [50]
        /    \                      /    \
     [30]    [70]               [30]    [70]
     /  \    /  \                  \    /  \
  [20] [40][60] [80]              [40][60] [80]

Tindakan: left child [30] diset ke None.
BST property tetap terpenuhi karena tidak ada nilai yang dipindahkan.
```

### 12.7.2. Kasus 2 — Menghapus Node dengan Satu Anak

**Kondisi:** Simpul yang dihapus memiliki tepat satu anak (kiri atau kanan, tidak keduanya).

**Tindakan:** Hubungkan langsung anak simpul yang dihapus ke induk simpul yang dihapus (operasi "bypass" atau "splicing out"). BST property terjaga karena seluruh subpohon di bawah anak tersebut sudah berada dalam rentang yang benar.

```
Gambar 12.12. Delete Kasus 2: Menghapus Node [30] yang Hanya Punya Anak Kanan [40]
(menggunakan hasil Kasus 1 di atas)

SEBELUM:                    SESUDAH:
         [50]                        [50]
        /    \                      /    \
     [30]    [70]               [40]    [70]
        \    /  \                       /  \
        [40][60] [80]                [60] [80]

Tindakan: Induk [30] adalah [50]. Left child [50] diset ke [40] (anak kanan [30]).
Node [30] di-bypass, [40] langsung terhubung ke [50].
```

### 12.7.3. Kasus 3 — Menghapus Node dengan Dua Anak

**Kondisi:** Simpul yang dihapus memiliki anak kiri dan anak kanan.

**Strategi:** Tidak mungkin langsung menghubungkan kedua subpohon ke induk (karena induk hanya memiliki satu slot). Solusinya adalah menggantikan nilai simpul yang dihapus dengan nilai **inorder successor**-nya.

**Definisi 12.2 — Inorder Successor**
Inorder successor dari simpul N adalah simpul dengan nilai terkecil yang lebih besar dari N.data. Dalam BST, inorder successor selalu merupakan simpul paling kiri (minimum) pada subpohon kanan N.

**Mengapa inorder successor paling banyak punya satu anak?** Karena ia adalah simpul paling kiri pada subpohonnya — ia tidak mungkin memiliki anak kiri (jika ada, anak kiri itu yang akan menjadi nilai terkecil, bukan ia). Oleh karena itu, menghapus inorder successor selalu dapat direduksi menjadi Kasus 1 atau Kasus 2.

```
Gambar 12.13. Delete Kasus 3: Menghapus Root [50] yang Punya Dua Anak

LANGKAH 1: BST awal.
           [50]
          /    \
       [30]    [70]
       /  \    /  \
     [20] [40][60] [80]

LANGKAH 2: Cari inorder successor [50].
  -> Pergi ke subpohon kanan: [70]
  -> Terus ke kiri dari [70]: [60]
  -> [60] tidak punya anak kiri.
  -> Inorder successor = [60]

LANGKAH 3: Salin nilai [60] ke posisi [50] (node "dihapus" kini bernilai 60).
           [60]          <- nilai berubah dari 50 menjadi 60
          /    \
       [30]    [70]
       /  \    /  \
     [20] [40][60] [80]  <- node [60] asli di sini yang akan dihapus

LANGKAH 4: Hapus inorder successor asli dari subpohon kanan.
  -> [60] di subpohon kanan adalah leaf (Kasus 1).
  -> left child [70] diset ke None.

HASIL AKHIR:
           [60]
          /    \
       [30]    [70]
       /  \       \
     [20] [40]   [80]

Verifikasi BST property:
  - Node 60: kiri {20, 30, 40} seluruhnya < 60. Kanan {70, 80} seluruhnya > 60. VALID.
  - Node 30: kiri {20} < 30. Kanan {40} > 30. VALID.
  - Node 70: tidak punya kiri. Kanan {80} > 70. VALID.
```

---

> **Catatan Penting 12.3 — Inorder Predecessor sebagai Alternatif**
>
> Selain inorder successor, beberapa implementasi menggunakan **inorder predecessor** — simpul dengan nilai terbesar di subpohon kiri (simpul paling kanan pada subpohon kiri). Kedua pendekatan menghasilkan BST yang valid. Konvensi dalam buku ini mengikuti Cormen et al. yang menggunakan inorder successor karena lebih banyak digunakan dalam literatur dan lebih intuitif.

---

## 12.8. Traversal BST: Mengunjungi Seluruh Simpul

Traversal adalah proses mengunjungi setiap simpul dalam tree tepat satu kali dengan urutan tertentu. Dalam binary tree, tiga metode traversal utama membentuk fondasi berbagai algoritma dan aplikasi.

Gunakan BST berikut sebagai referensi untuk seluruh trace traversal:

```
Gambar 12.14. BST Referensi untuk Traversal

           [50]
          /    \
       [30]    [70]
       /  \    /  \
     [20] [40][60] [80]
```

### 12.8.1. Inorder Traversal: Kiri - Root - Kanan (L-N-R)

**Algoritma:** Kunjungi subpohon kiri secara rekursif, kemudian kunjungi simpul saat ini, kemudian kunjungi subpohon kanan secara rekursif.

```
PROCEDURE INORDER(node):
  IF node != None THEN
    INORDER(node.left)
    VISIT(node)
    INORDER(node.right)
```

**Trace lengkap inorder pada BST Gambar 12.14:**

```
inorder([50]):
  inorder([30]):
    inorder([20]):
      inorder(None)   <- kiri kosong, tidak ada aksi
      KUNJUNGI [20]   -> output: 20
      inorder(None)   <- kanan kosong, tidak ada aksi
    KUNJUNGI [30]     -> output: 30
    inorder([40]):
      inorder(None)   <- kiri kosong
      KUNJUNGI [40]   -> output: 40
      inorder(None)   <- kanan kosong
  KUNJUNGI [50]       -> output: 50
  inorder([70]):
    inorder([60]):
      inorder(None)   <- kiri kosong
      KUNJUNGI [60]   -> output: 60
      inorder(None)   <- kanan kosong
    KUNJUNGI [70]     -> output: 70
    inorder([80]):
      inorder(None)   <- kiri kosong
      KUNJUNGI [80]   -> output: 80
      inorder(None)   <- kanan kosong

Hasil Inorder: 20, 30, 40, 50, 60, 70, 80
```

**Mengapa inorder traversal pada BST selalu menghasilkan data terurut?**

Ini bukan kebetulan melainkan akibat langsung yang dapat dibuktikan dari BST property. Bukti informal berikut memberikan intuisi:

Misalkan N adalah sembarang simpul dengan nilai V. Berdasarkan BST property:
- Seluruh simpul di subpohon kiri N memiliki nilai < V.
- Seluruh simpul di subpohon kanan N memiliki nilai > V.

Dalam inorder traversal, seluruh subpohon kiri N dikunjungi sebelum N dikunjungi, dan seluruh subpohon kanan N dikunjungi setelah N dikunjungi. Secara rekursif, klaim yang sama berlaku untuk setiap simpul di subpohon kiri dan kanan. Akibatnya, ketika N dikunjungi, seluruh nilai yang lebih kecil dari V sudah di-output, dan seluruh nilai yang lebih besar dari V belum di-output. Dengan demikian, barisan output membentuk urutan menaik.

Secara formal, dapat dibuktikan dengan induksi matematika pada tinggi pohon: basis (pohon dengan satu simpul) trivial; langkah induksi menggunakan hipotesis induktif bahwa inorder subpohon kiri menghasilkan barisan terurut, dan inorder subpohon kanan menghasilkan barisan terurut, dan seluruh nilai di subpohon kiri lebih kecil dari nilai root yang lebih kecil dari seluruh nilai di subpohon kanan.

**Implikasi praktis:** Inorder traversal dapat digunakan sebagai mekanisme **tree sort** — masukkan n elemen ke BST, kemudian jalankan inorder traversal. Hasilnya adalah barisan terurut. Kompleksitas: O(n log n) rata-rata untuk n insert, kemudian O(n) untuk traversal.

### 12.8.2. Preorder Traversal: Root - Kiri - Kanan (N-L-R)

**Algoritma:** Kunjungi simpul saat ini terlebih dahulu, kemudian subpohon kiri, kemudian subpohon kanan.

```
PROCEDURE PREORDER(node):
  IF node != None THEN
    VISIT(node)
    PREORDER(node.left)
    PREORDER(node.right)
```

**Trace preorder pada BST Gambar 12.14:**

```
preorder([50]):
  KUNJUNGI [50]     -> output: 50
  preorder([30]):
    KUNJUNGI [30]   -> output: 30
    preorder([20]):
      KUNJUNGI [20] -> output: 20
    preorder([40]):
      KUNJUNGI [40] -> output: 40
  preorder([70]):
    KUNJUNGI [70]   -> output: 70
    preorder([60]):
      KUNJUNGI [60] -> output: 60
    preorder([80]):
      KUNJUNGI [80] -> output: 80

Hasil Preorder: 50, 30, 20, 40, 70, 60, 80
```

**Kegunaan preorder:** Urutan preorder selalu dimulai dengan root. Sifat ini memiliki implikasi penting: jika kita menyimpan urutan preorder BST dan kemudian menyisipkan kembali nilai-nilai tersebut ke BST kosong dengan operasi insert biasa, kita akan mendapatkan BST yang identik secara struktural. Preorder juga digunakan dalam algoritma penyalinan pohon (*tree cloning*) dan serialisasi struktur pohon ke dalam format datar.

### 12.8.3. Postorder Traversal: Kiri - Kanan - Root (L-R-N)

**Algoritma:** Kunjungi subpohon kiri terlebih dahulu, kemudian subpohon kanan, dan terakhir simpul saat ini.

```
PROCEDURE POSTORDER(node):
  IF node != None THEN
    POSTORDER(node.left)
    POSTORDER(node.right)
    VISIT(node)
```

**Trace postorder pada BST Gambar 12.14:**

```
postorder([50]):
  postorder([30]):
    postorder([20]):
      KUNJUNGI [20] -> output: 20
    postorder([40]):
      KUNJUNGI [40] -> output: 40
    KUNJUNGI [30]   -> output: 30
  postorder([70]):
    postorder([60]):
      KUNJUNGI [60] -> output: 60
    postorder([80]):
      KUNJUNGI [80] -> output: 80
    KUNJUNGI [70]   -> output: 70
  KUNJUNGI [50]     -> output: 50

Hasil Postorder: 20, 40, 30, 60, 80, 70, 50
```

**Kegunaan postorder:** Dalam postorder traversal, setiap simpul selalu diproses setelah seluruh anak-anaknya diproses. Sifat "anak sebelum induk" ini membuatnya ideal untuk: (1) penghapusan seluruh tree — dengan menghapus anak sebelum induk, tidak ada dangling reference; (2) evaluasi ekspresi pohon — operand (daun) dievaluasi sebelum operator (internal node); (3) penghitungan ukuran atau penggunaan memori subpohon secara bottom-up.

### 12.8.4. Ringkasan Ketiga Traversal

```
Gambar 12.15. Ringkasan Traversal pada BST Gambar 12.14

BST:
           [50]
          /    \
       [30]    [70]
       /  \    /  \
     [20] [40][60] [80]

Inorder   (L-N-R): 20  30  40  50  60  70  80  <- TERURUT (BST property)
Preorder  (N-L-R): 50  30  20  40  70  60  80  <- Root pertama
Postorder (L-R-N): 20  40  30  60  80  70  50  <- Root terakhir
```

**Tabel 12.3. Perbandingan Ketiga Metode Traversal**

| Metode | Pola Kunjungan | Sifat Khas | Kegunaan Utama |
|---|---|---|---|
| Inorder (L-N-R) | Kiri, Root, Kanan | Menghasilkan urutan terurut pada BST | Pengurutan, pembuatan daftar terurut |
| Preorder (N-L-R) | Root, Kiri, Kanan | Root selalu pertama dikunjungi | Penyalinan pohon, serialisasi, rekonstruksi |
| Postorder (L-R-N) | Kiri, Kanan, Root | Root selalu terakhir dikunjungi | Penghapusan pohon, evaluasi ekspresi |

---

## 12.9. Implementasi Python: Kelas TreeNode dan BinarySearchTree

### 12.9.1. Kelas TreeNode

```python
class TreeNode:
    """
    Merepresentasikan satu simpul (node) dalam Binary Search Tree.

    Atribut:
        data  : nilai yang disimpan di node ini (dapat bertipe apa pun yang comparable)
        left  : referensi ke anak kiri (TreeNode atau None)
        right : referensi ke anak kanan (TreeNode atau None)
    """

    def __init__(self, data):
        self.data  = data
        self.left  = None
        self.right = None

    def __repr__(self):
        return f"TreeNode({self.data})"
```

### 12.9.2. Kelas BinarySearchTree

```python
class BinarySearchTree:
    """
    Implementasi Binary Search Tree (BST) dengan operasi lengkap:
      - insert    : menyisipkan nilai baru ke dalam BST
      - search    : mencari nilai; mengembalikan True/False
      - delete    : menghapus nilai (menangani 3 kasus)
      - inorder   : traversal Kiri-Root-Kanan (menghasilkan urutan terurut)
      - preorder  : traversal Root-Kiri-Kanan
      - postorder : traversal Kiri-Kanan-Root
      - height    : menghitung tinggi pohon
      - size      : menghitung jumlah simpul
      - minimum   : mencari nilai terkecil
      - maximum   : mencari nilai terbesar
      - display   : menampilkan pohon secara visual
    """

    def __init__(self):
        """Inisialisasi BST kosong dengan root = None."""
        self.root = None

    # ------------------------------------------------------------------
    # OPERASI INSERT
    # ------------------------------------------------------------------

    def insert(self, data):
        """Menyisipkan data baru ke dalam BST. Duplikat diabaikan."""
        if self.root is None:
            self.root = TreeNode(data)
        else:
            self._insert_recursive(self.root, data)

    def _insert_recursive(self, node, data):
        """Helper rekursif untuk operasi insert."""
        if data < node.data:
            if node.left is None:
                node.left = TreeNode(data)
            else:
                self._insert_recursive(node.left, data)
        elif data > node.data:
            if node.right is None:
                node.right = TreeNode(data)
            else:
                self._insert_recursive(node.right, data)
        # Jika data == node.data: duplikat, tidak dilakukan penyisipan

    # ------------------------------------------------------------------
    # OPERASI SEARCH
    # ------------------------------------------------------------------

    def search(self, data):
        """
        Mencari data dalam BST.

        Returns:
            True  jika data ditemukan
            False jika data tidak ada dalam BST
        """
        return self._search_recursive(self.root, data)

    def _search_recursive(self, node, data):
        """Helper rekursif untuk operasi search."""
        if node is None:
            return False        # Mencapai daun tanpa menemukan data
        if data == node.data:
            return True         # Data ditemukan
        elif data < node.data:
            return self._search_recursive(node.left, data)
        else:
            return self._search_recursive(node.right, data)

    # ------------------------------------------------------------------
    # OPERASI DELETE
    # ------------------------------------------------------------------

    def delete(self, data):
        """
        Menghapus simpul dengan nilai data dari BST.
        Menangani tiga kasus: leaf, satu anak, dua anak.
        """
        self.root = self._delete_recursive(self.root, data)

    def _delete_recursive(self, node, data):
        """
        Helper rekursif untuk operasi delete.

        Kasus 1: node adalah leaf         -> kembalikan None
        Kasus 2: node memiliki satu anak  -> kembalikan anak tersebut
        Kasus 3: node memiliki dua anak   -> gantikan dengan inorder successor
        """
        if node is None:
            return None     # Data tidak ditemukan dalam BST

        if data < node.data:
            # Data berada di subpohon kiri
            node.left = self._delete_recursive(node.left, data)
        elif data > node.data:
            # Data berada di subpohon kanan
            node.right = self._delete_recursive(node.right, data)
        else:
            # Simpul yang akan dihapus ditemukan

            # Kasus 1: Simpul adalah leaf (tidak punya anak)
            if node.left is None and node.right is None:
                return None

            # Kasus 2a: Hanya punya anak kanan
            elif node.left is None:
                return node.right

            # Kasus 2b: Hanya punya anak kiri
            elif node.right is None:
                return node.left

            # Kasus 3: Punya dua anak
            else:
                # Temukan inorder successor (nilai minimum di subpohon kanan)
                successor = self._find_minimum(node.right)
                # Salin nilai successor ke simpul yang akan "dihapus"
                node.data = successor.data
                # Hapus inorder successor dari subpohon kanan
                node.right = self._delete_recursive(node.right, successor.data)

        return node

    def _find_minimum(self, node):
        """Mencari simpul dengan nilai terkecil di subtree (simpul paling kiri)."""
        current = node
        while current.left is not None:
            current = current.left
        return current

    def _find_maximum(self, node):
        """Mencari simpul dengan nilai terbesar di subtree (simpul paling kanan)."""
        current = node
        while current.right is not None:
            current = current.right
        return current

    # ------------------------------------------------------------------
    # MINIMUM DAN MAXIMUM (antarmuka publik)
    # ------------------------------------------------------------------

    def minimum(self):
        """Mengembalikan nilai terkecil dalam BST, atau None jika kosong."""
        if self.root is None:
            return None
        return self._find_minimum(self.root).data

    def maximum(self):
        """Mengembalikan nilai terbesar dalam BST, atau None jika kosong."""
        if self.root is None:
            return None
        return self._find_maximum(self.root).data

    # ------------------------------------------------------------------
    # TRAVERSAL
    # ------------------------------------------------------------------

    def inorder(self):
        """
        Inorder traversal: Kiri -> Root -> Kanan.
        Pada BST, menghasilkan data dalam urutan terurut menaik.

        Returns:
            list: elemen-elemen BST dalam urutan terurut
        """
        result = []
        self._inorder_recursive(self.root, result)
        return result

    def _inorder_recursive(self, node, result):
        """Helper rekursif untuk inorder traversal."""
        if node is not None:
            self._inorder_recursive(node.left, result)
            result.append(node.data)
            self._inorder_recursive(node.right, result)

    def preorder(self):
        """
        Preorder traversal: Root -> Kiri -> Kanan.

        Returns:
            list: elemen-elemen BST dalam urutan preorder
        """
        result = []
        self._preorder_recursive(self.root, result)
        return result

    def _preorder_recursive(self, node, result):
        """Helper rekursif untuk preorder traversal."""
        if node is not None:
            result.append(node.data)
            self._preorder_recursive(node.left, result)
            self._preorder_recursive(node.right, result)

    def postorder(self):
        """
        Postorder traversal: Kiri -> Kanan -> Root.

        Returns:
            list: elemen-elemen BST dalam urutan postorder
        """
        result = []
        self._postorder_recursive(self.root, result)
        return result

    def _postorder_recursive(self, node, result):
        """Helper rekursif untuk postorder traversal."""
        if node is not None:
            self._postorder_recursive(node.left, result)
            self._postorder_recursive(node.right, result)
            result.append(node.data)

    # ------------------------------------------------------------------
    # UTILITAS
    # ------------------------------------------------------------------

    def height(self):
        """
        Menghitung tinggi pohon.

        Returns:
            int: tinggi pohon (-1 untuk pohon kosong, konvensi Cormen et al.)
        """
        return self._height_recursive(self.root)

    def _height_recursive(self, node):
        """Helper rekursif untuk menghitung height."""
        if node is None:
            return -1   # Pohon kosong memiliki height -1
        left_h  = self._height_recursive(node.left)
        right_h = self._height_recursive(node.right)
        return 1 + max(left_h, right_h)

    def size(self):
        """
        Menghitung jumlah simpul dalam pohon.

        Returns:
            int: jumlah simpul
        """
        return self._size_recursive(self.root)

    def _size_recursive(self, node):
        """Helper rekursif untuk menghitung size."""
        if node is None:
            return 0
        return 1 + self._size_recursive(node.left) + self._size_recursive(node.right)

    def is_empty(self):
        """Mengembalikan True jika pohon kosong."""
        return self.root is None

    def display(self):
        """Menampilkan representasi visual pohon secara horizontal."""
        if self.root is None:
            print("BST kosong")
            return
        self._display_recursive(self.root, "", False)

    def _display_recursive(self, node, prefix, is_left):
        """Helper rekursif untuk menampilkan pohon (kanan di atas, kiri di bawah)."""
        if node is not None:
            self._display_recursive(
                node.right,
                prefix + ("│   " if is_left else "    "),
                False
            )
            print(prefix + ("└── " if is_left else "┌── ") + str(node.data))
            self._display_recursive(
                node.left,
                prefix + ("    " if is_left else "│   "),
                True
            )
```

### 12.9.3. Program Demonstrasi Lengkap

```python
# ============================================================
# DEMONSTRASI LENGKAP BINARY SEARCH TREE
# Bab 12 - Buku Ajar Struktur Data - INSTIKI
# ============================================================

def main():
    print("=" * 60)
    print("DEMONSTRASI BINARY SEARCH TREE (BST)")
    print("=" * 60)

    # ---- 1. Membangun BST ----
    bst = BinarySearchTree()
    data_input = [50, 30, 70, 20, 40, 60, 80]

    print("\n[1] OPERASI INSERT")
    print("-" * 40)
    for nilai in data_input:
        bst.insert(nilai)
        print(f"  Insert {nilai} -> Inorder sejauh ini: {bst.inorder()}")

    print(f"\nStruktur BST setelah semua insert:")
    bst.display()

    # ---- 2. Informasi pohon ----
    print("\n[2] INFORMASI POHON")
    print("-" * 40)
    print(f"  Jumlah simpul : {bst.size()}")
    print(f"  Tinggi pohon  : {bst.height()}")
    print(f"  Nilai minimum : {bst.minimum()}")
    print(f"  Nilai maksimum: {bst.maximum()}")

    # ---- 3. Operasi Search ----
    print("\n[3] OPERASI SEARCH")
    print("-" * 40)
    for target in [40, 45, 80, 100]:
        hasil  = bst.search(target)
        status = "DITEMUKAN" if hasil else "TIDAK DITEMUKAN"
        print(f"  Search({target:3d}): {status}")

    # ---- 4. Traversal ----
    print("\n[4] TRAVERSAL")
    print("-" * 40)
    print(f"  Inorder   (L-N-R): {bst.inorder()}")
    print(f"  Preorder  (N-L-R): {bst.preorder()}")
    print(f"  Postorder (L-R-N): {bst.postorder()}")

    # ---- 5. Operasi Delete ----
    print("\n[5] OPERASI DELETE (TIGA KASUS)")
    print("-" * 40)

    # Kasus 1: Hapus leaf [20]
    bst.delete(20)
    print(f"  Hapus 20 (leaf)       -> Inorder: {bst.inorder()}")

    # Kasus 2: Hapus node dengan 1 anak [30] (sekarang hanya punya anak kanan [40])
    bst.delete(30)
    print(f"  Hapus 30 (satu anak)  -> Inorder: {bst.inorder()}")

    # Kasus 3: Hapus node dengan 2 anak [70] (punya kiri [60] dan kanan [80])
    bst.delete(70)
    print(f"  Hapus 70 (dua anak)   -> Inorder: {bst.inorder()}")

    print(f"\nStruktur BST setelah semua penghapusan:")
    bst.display()

    # ---- 6. Verifikasi inorder = terurut ----
    print("\n[6] VERIFIKASI: Inorder BST selalu menghasilkan urutan terurut")
    print("-" * 40)
    import random
    random.seed(42)
    angka_acak = random.sample(range(1, 101), 10)
    print(f"  Data acak dimasukkan : {angka_acak}")

    bst2 = BinarySearchTree()
    for x in angka_acak:
        bst2.insert(x)

    print(f"  Hasil inorder BST    : {bst2.inorder()}")
    print(f"  Python sorted()      : {sorted(angka_acak)}")
    print(f"  Identik?             : {bst2.inorder() == sorted(angka_acak)}")


if __name__ == "__main__":
    main()
```

**Output yang diharapkan:**

```
============================================================
DEMONSTRASI BINARY SEARCH TREE (BST)
============================================================

[1] OPERASI INSERT
----------------------------------------
  Insert 50 -> Inorder sejauh ini: [50]
  Insert 30 -> Inorder sejauh ini: [30, 50]
  Insert 70 -> Inorder sejauh ini: [30, 50, 70]
  Insert 20 -> Inorder sejauh ini: [20, 30, 50, 70]
  Insert 40 -> Inorder sejauh ini: [20, 30, 40, 50, 70]
  Insert 60 -> Inorder sejauh ini: [20, 30, 40, 50, 60, 70]
  Insert 80 -> Inorder sejauh ini: [20, 30, 40, 50, 60, 70, 80]

[2] INFORMASI POHON
----------------------------------------
  Jumlah simpul : 7
  Tinggi pohon  : 2
  Nilai minimum : 20
  Nilai maksimum: 80

[3] OPERASI SEARCH
----------------------------------------
  Search( 40): DITEMUKAN
  Search( 45): TIDAK DITEMUKAN
  Search( 80): DITEMUKAN
  Search(100): TIDAK DITEMUKAN

[4] TRAVERSAL
----------------------------------------
  Inorder   (L-N-R): [20, 30, 40, 50, 60, 70, 80]
  Preorder  (N-L-R): [50, 30, 20, 40, 70, 60, 80]
  Postorder (L-R-N): [20, 40, 30, 60, 80, 70, 50]

[5] OPERASI DELETE (TIGA KASUS)
----------------------------------------
  Hapus 20 (leaf)       -> Inorder: [30, 40, 50, 60, 70, 80]
  Hapus 30 (satu anak)  -> Inorder: [40, 50, 60, 70, 80]
  Hapus 70 (dua anak)   -> Inorder: [40, 50, 60, 80]

[6] VERIFIKASI: Inorder BST selalu menghasilkan urutan terurut
----------------------------------------
  Data acak dimasukkan : [18, 73, 98, 9, 33, 16, 64, 98, 58, 61]
  Hasil inorder BST    : [9, 16, 18, 33, 58, 61, 64, 73, 98]
  Python sorted()      : [9, 16, 18, 33, 58, 61, 64, 73, 98]
  Identik?             : True
```

---

## 12.10. Analisis Kompleksitas Operasi BST

### 12.10.1. Faktor Penentu Kinerja: Tinggi Pohon

Semua operasi utama BST — insert, search, delete — bekerja dengan menelusuri satu jalur dari root ke suatu simpul. Panjang jalur terpanjang adalah tinggi pohon h. Oleh karena itu, kompleksitas semua operasi ini adalah O(h).

Kinerja BST sepenuhnya bergantung pada nilai h, yang ditentukan oleh urutan penyisipan data.

### 12.10.2. Kasus Terbaik: O(log n) — Pohon Seimbang

Terjadi ketika BST memiliki bentuk mendekati perfect binary tree. Tinggi pohon h ≈ log₂(n).

```
Gambar 12.16. BST Seimbang — Kasus Terbaik (n = 7, h = 2)

           [50]          <- Level 0
          /    \
       [30]    [70]      <- Level 1
       /  \    /  \
     [20] [40][60] [80]  <- Level 2

h = 2 = floor(log2(7))
Search memerlukan maksimal 3 perbandingan untuk n = 7 simpul.
```

### 12.10.3. Kasus Terburuk: O(n) — Pohon Miring (Degenerate Tree)

Terjadi ketika data dimasukkan dalam urutan terurut (menaik atau menurun). Pohon menyerupai linked list; h = n - 1.

```
Gambar 12.17. BST Miring — Kasus Terburuk (Insert terurut menaik)

[10]
   \
   [20]
      \
      [30]
         \
         [40]
            \
            [50]

h = 4 = n - 1 untuk n = 5
Search(50) memerlukan 5 perbandingan = O(n)
```

### 12.10.4. Kasus Rata-Rata: O(log n) — Input Acak

Jika data disisipkan dalam urutan acak, secara probabilistik tinggi BST adalah O(log n). Analisis formal menunjukkan bahwa *expected height* BST dengan n kunci acak adalah sekitar 2.99 log₂ n (Cormen et al., 2009, Bab 12.4).

**Tabel 12.4. Ringkasan Kompleksitas Operasi BST**

| Operasi | Kasus Terbaik | Rata-rata | Kasus Terburuk | Ruang (Call Stack) |
|---|---|---|---|---|
| Search | O(1) | O(log n) | O(n) | O(h) |
| Insert | O(1) | O(log n) | O(n) | O(h) |
| Delete | O(1) | O(log n) | O(n) | O(h) |
| Traversal | O(n) | O(n) | O(n) | O(h) |
| Minimum | O(1) | O(log n) | O(n) | O(1) |
| Maximum | O(1) | O(log n) | O(n) | O(1) |

*O(h) pada call stack: O(log n) untuk pohon seimbang; O(n) untuk pohon miring.*

---

> **Catatan Penting 12.4 — Motivasi Self-Balancing BST**
>
> Kelemahan BST biasa pada kasus terburuk O(n) mendorong pengembangan varian yang secara otomatis menyeimbangkan diri. Dua yang paling terkenal adalah:
>
> - **AVL Tree** (Adelson-Velsky dan Landis, 1962): menjaga invariant bahwa perbedaan height antara subpohon kiri dan kanan setiap simpul tidak lebih dari 1. Menjamin O(log n) untuk semua operasi.
> - **Red-Black Tree** (Guibas dan Sedgewick, 1978): menggunakan pewarnaan simpul (merah/hitam) dan aturan pewarnaan untuk menjaga keseimbangan. Digunakan dalam implementasi `std::map` di C++ dan `TreeMap` di Java.
>
> Kedua struktur ini dibahas pada bab selanjutnya sebagai lanjutan BST.

---

## 12.11. Studi Kasus: Sistem Berkas sebagai Tree

### 12.11.1. Latar Belakang

Sistem berkas (file system) pada semua sistem operasi modern menggunakan struktur tree untuk mengorganisasikan direktori dan berkas. Pemahaman tentang tree secara langsung membantu dalam memahami cara kerja sistem operasi, dan sebaliknya, sistem berkas merupakan aplikasi nyata yang sangat intuitif untuk memotivasi konsep tree.

### 12.11.2. Pemetaan Konsep Tree ke Sistem Berkas

```
Gambar 12.18. Struktur Direktori sebagai Tree

/                          <- root (direktori paling atas)
├── home/
│   ├── alice/
│   │   ├── documents/
│   │   │   ├── thesis.pdf     <- leaf (berkas)
│   │   │   └── notes.txt      <- leaf (berkas)
│   │   └── downloads/
│   │       └── data.zip       <- leaf (berkas)
│   └── bob/
│       └── projects/
│           └── main.py        <- leaf (berkas)
├── etc/
│   └── config.conf            <- leaf (berkas)
└── var/
    └── log/
        └── system.log         <- leaf (berkas)
```

**Pemetaan terminologi:**
- Root tree = direktori root ("/")
- Internal node = direktori (folder)
- Leaf = berkas (tidak memiliki anak)
- Edge = relasi "berisi" antara direktori induk dan isinya
- Depth = kedalaman direktori (banyak level dari root)
- Height = kedalaman maksimal dalam hierarki

### 12.11.3. Implementasi Python: Pohon Sistem Berkas

```python
class FileSystemNode:
    """
    Merepresentasikan satu simpul dalam pohon sistem berkas.
    Simpul dapat berupa direktori (memiliki anak) atau berkas (tidak punya anak).
    """

    def __init__(self, name, is_directory=False):
        self.name         = name
        self.is_directory = is_directory
        self.children     = []  # Daftar anak (FileSystemNode)

    def add_child(self, child_node):
        """Menambahkan anak ke direktori ini."""
        if not self.is_directory:
            raise ValueError(f"'{self.name}' adalah berkas, bukan direktori.")
        self.children.append(child_node)
        return child_node

    def __repr__(self):
        tipe = "DIR" if self.is_directory else "FILE"
        return f"[{tipe}] {self.name}"


class FileSystem:
    """
    Pohon sistem berkas sederhana dengan operasi:
      - add_path   : menambahkan direktori atau berkas
      - search     : mencari berkas/direktori berdasarkan nama
      - display    : menampilkan struktur direktori (preorder traversal)
      - list_files : mencantumkan semua berkas (leaves) menggunakan postorder
    """

    def __init__(self, root_name="/"):
        self.root = FileSystemNode(root_name, is_directory=True)

    def display(self, node=None, indent=0, prefix=""):
        """
        Menampilkan struktur direktori menggunakan preorder traversal.
        Root ditampilkan pertama, kemudian isinya secara rekursif.
        """
        if node is None:
            node = self.root

        ikon = "[DIR] " if node.is_directory else "[FILE]"
        print(prefix + ikon + node.name)

        for i, child in enumerate(node.children):
            is_last  = (i == len(node.children) - 1)
            new_pref = prefix + ("    " if (prefix.endswith("    ") or
                                            prefix.endswith("└── ")) else "│   ")
            connector = "└── " if is_last else "├── "
            self._display_child(child, indent + 1,
                                prefix + ("    " if is_last else "│   "),
                                connector)

    def _display_child(self, node, indent, prefix, connector):
        """Helper untuk menampilkan satu anak dengan konektor yang sesuai."""
        ikon = "[DIR] " if node.is_directory else "[FILE]"
        print(prefix.rstrip("│   ") + connector + ikon + node.name)

        for i, child in enumerate(node.children):
            is_last     = (i == len(node.children) - 1)
            child_pref  = prefix + ("    " if is_last else "│   ")
            child_conn  = "└── " if is_last else "├── "
            self._display_child(child, indent + 1, child_pref, child_conn)

    def search(self, node, target_name):
        """
        Mencari berkas/direktori berdasarkan nama menggunakan preorder traversal.

        Returns:
            FileSystemNode jika ditemukan, None jika tidak.
        """
        if node.name == target_name:
            return node
        for child in node.children:
            hasil = self.search(child, target_name)
            if hasil is not None:
                return hasil
        return None

    def list_all_files(self, node=None):
        """
        Mengumpulkan semua berkas (leaf) menggunakan postorder traversal.

        Returns:
            list: nama-nama berkas dalam pohon
        """
        if node is None:
            node = self.root
        files = []
        for child in node.children:
            files.extend(self.list_all_files(child))
        if not node.is_directory:
            files.append(node.name)
        return files

    def count_directories(self, node=None):
        """Menghitung jumlah direktori dalam pohon."""
        if node is None:
            node = self.root
        count = 1 if node.is_directory else 0
        for child in node.children:
            count += self.count_directories(child)
        return count

    def tree_height(self, node=None):
        """Menghitung kedalaman maksimal pohon sistem berkas."""
        if node is None:
            node = self.root
        if not node.children:
            return 0
        return 1 + max(self.tree_height(child) for child in node.children)


# ============================================================
# DEMONSTRASI SISTEM BERKAS
# ============================================================

def demo_filesystem():
    """Membangun dan menelusuri pohon sistem berkas contoh."""
    fs = FileSystem("/")

    # Direktori utama
    home = fs.root.add_child(FileSystemNode("home", is_directory=True))
    etc  = fs.root.add_child(FileSystemNode("etc",  is_directory=True))
    var  = fs.root.add_child(FileSystemNode("var",  is_directory=True))

    # Subdirektori home
    alice = home.add_child(FileSystemNode("alice", is_directory=True))
    bob   = home.add_child(FileSystemNode("bob",   is_directory=True))

    # Isi direktori alice
    docs      = alice.add_child(FileSystemNode("documents", is_directory=True))
    downloads = alice.add_child(FileSystemNode("downloads", is_directory=True))

    docs.add_child(FileSystemNode("thesis.pdf"))
    docs.add_child(FileSystemNode("notes.txt"))
    downloads.add_child(FileSystemNode("data.zip"))

    # Isi direktori bob
    projects = bob.add_child(FileSystemNode("projects", is_directory=True))
    projects.add_child(FileSystemNode("main.py"))

    # Isi /etc dan /var
    etc.add_child(FileSystemNode("config.conf"))
    log = var.add_child(FileSystemNode("log", is_directory=True))
    log.add_child(FileSystemNode("system.log"))

    # Tampilkan struktur
    print("STRUKTUR SISTEM BERKAS:")
    print("=" * 40)
    fs.display()

    print(f"\nSemua berkas: {fs.list_all_files()}")
    print(f"Jumlah direktori: {fs.count_directories()}")
    print(f"Kedalaman maksimal: {fs.tree_height()}")

    # Pencarian
    target = "thesis.pdf"
    hasil  = fs.search(fs.root, target)
    print(f"\nMencari '{target}': {'Ditemukan' if hasil else 'Tidak ditemukan'}")


if __name__ == "__main__":
    demo_filesystem()
```

### 12.11.4. Relevansi dengan Praktik Nyata

Sistem berkas hanya salah satu dari banyak aplikasi tree dalam dunia nyata. Beberapa aplikasi penting lainnya meliputi:

**Tabel 12.5. Aplikasi Tree dalam Sistem Nyata**

| Domain | Struktur Tree | Jenis Traversal Utama | Keterangan |
|---|---|---|---|
| Sistem Berkas (OS) | General tree | Preorder (tampilkan), Postorder (hapus direktori) | Root = direktori /; leaf = berkas |
| Indeks Database | B-Tree / B+ Tree | Inorder | Pencarian range O(log n) |
| Kompiler | Abstract Syntax Tree (AST) | Postorder (evaluasi) | Merepresentasikan ekspresi dan statement |
| XML/HTML Parser | DOM Tree | Preorder (render) | Elemen HTML tersusun hierarkis |
| Kecerdasan Buatan | Decision Tree | Preorder (klasifikasi) | Pohon keputusan untuk machine learning |
| Jaringan Komputer | Spanning Tree | BFS/DFS | Routing protokol dalam jaringan |

---

> **Tahukah Anda? 12.2**
>
> Perintah `find` dan `ls -R` pada Linux/Unix secara internal menggunakan traversal tree pada struktur direktori. Perintah `find /home -name "*.py"` melakukan preorder traversal pada pohon sistem berkas, mencetak path setiap berkas yang cocok dengan pola `*.py`. Perintah `rm -rf direktori` menggunakan postorder traversal untuk memastikan isi direktori (anak) dihapus sebelum direktori itu sendiri (induk) dihapus.

---

## 12.12. Perbandingan BST dengan Struktur Data Lain

Setelah memahami BST secara mendalam, penting untuk menempatkannya dalam konteks perbandingan dengan struktur data yang telah dipelajari sebelumnya.

**Tabel 12.6. Perbandingan Kinerja Struktur Data untuk Operasi Kamus**

| Struktur Data | Search | Insert | Delete | Terurut? | Keterangan |
|---|---|---|---|---|---|
| Array tidak terurut | O(n) | O(1) amortized | O(n) | Tidak | Sederhana, tidak efisien untuk pencarian |
| Array terurut | O(log n) | O(n) | O(n) | Ya | Pencarian efisien, modifikasi lambat |
| Linked List terurut | O(n) | O(n) | O(n) | Ya | Tidak ada binary search |
| Hash Table | O(1) avg | O(1) avg | O(1) avg | Tidak | Sangat cepat, tetapi tidak mendukung range query |
| BST (seimbang) | O(log n) | O(log n) | O(log n) | Ya | Seimbang dalam kecepatan dan dukungan urutan |
| BST (tidak seimbang) | O(n) worst | O(n) worst | O(n) worst | Ya | Bergantung input; dapat didegenerasi |

BST seimbang menawarkan keunggulan unik: kecepatan O(log n) untuk search/insert/delete sekaligus mendukung operasi berurutan (seperti "cari semua nilai antara 30 dan 70") yang tidak didukung oleh hash table.

---

## Rangkuman Bab

1. **Tree adalah struktur data non-linear hierarkis** yang terdiri dari simpul (node) dan tepi (edge). Terminologi fundamental meliputi root (simpul tanpa induk), leaf (simpul tanpa anak), parent, child, sibling, depth (jarak dari root), height (jarak ke leaf terdalam), dan level. Terminologi ini merupakan fondasi untuk semua pembahasan tentang tree dan algoritma yang bekerja padanya.

2. **Binary tree membatasi setiap simpul memiliki maksimal dua anak**, yaitu anak kiri dan anak kanan. Klasifikasinya mencakup full binary tree (0 atau 2 anak), complete binary tree (level terakhir terisi dari kiri), dan perfect binary tree (semua leaf di level yang sama). Klasifikasi ini menentukan sifat matematis dan kinerja operasi yang bekerja pada masing-masing jenis.

3. **BST mendefinisikan invariant yang menjadi jaminan kebenaran seluruh operasinya:** semua nilai di subpohon kiri lebih kecil dari nilai simpul, semua nilai di subpohon kanan lebih besar, dan sifat ini berlaku secara rekursif untuk setiap simpul. Pelanggaran invariant pada simpul mana pun — bahkan yang bukan anak langsung — membatalkan keabsahan BST.

4. **Operasi delete BST menangani tiga kasus yang berbeda secara fundamental:** simpul daun dihapus langsung; simpul dengan satu anak disambungkan ke induknya (bypass); simpul dengan dua anak digantikan nilai inorder successor-nya dan inorder successor asli dihapus. Kasus ketiga selalu dapat direduksi menjadi kasus pertama atau kedua, karena inorder successor tidak memiliki anak kiri.

5. **Ketiga traversal bersifat saling komplementer dan melayani kegunaan yang berbeda:** inorder (L-N-R) menghasilkan data terurut pada BST karena setiap simpul dikunjungi tepat setelah seluruh nilai yang lebih kecil dan sebelum seluruh nilai yang lebih besar — ini adalah akibat langsung dari BST property yang dapat dibuktikan secara formal; preorder (N-L-R) merekonstruksi pohon dan digunakan untuk serialisasi; postorder (L-R-N) memroses anak sebelum induk sehingga ideal untuk penghapusan dan evaluasi ekspresi.

6. **Kompleksitas operasi BST adalah O(h) — bergantung pada tinggi pohon h.** Pada pohon seimbang h = O(log n), memberikan kinerja optimal. Pada pohon miring akibat input terurut, h = O(n) menjadikan BST setara dengan linked list. Kelemahan ini mendorong pengembangan self-balancing BST (AVL Tree, Red-Black Tree) yang menjamin h = O(log n) dalam semua kasus.

7. **BST menjadi fondasi berbagai sistem nyata:** indeks database, tabel simbol kompiler, struktur direktori sistem berkas, dan pohon keputusan dalam kecerdasan buatan semuanya memanfaatkan prinsip-prinsip yang dibangun di atas BST. Pemahaman mendalam tentang BST adalah prasyarat untuk mempelajari struktur data lanjutan dan algoritma tingkat tinggi.

---

## Istilah Kunci

| Istilah | Definisi Singkat |
|---|---|
| **Tree (Pohon)** | Struktur data non-linear hierarkis yang terdiri dari simpul dan tepi, bersifat asiklik dan terhubung |
| **Root (Akar)** | Simpul tunggal dalam tree yang tidak memiliki induk; titik awal penelusuran |
| **Leaf (Daun)** | Simpul yang tidak memiliki anak; simpul terminal pada ujung cabang |
| **Internal Node** | Simpul yang memiliki minimal satu anak; bukan leaf |
| **Parent (Induk)** | Simpul yang langsung berada satu tingkat di atas simpul tertentu |
| **Child (Anak)** | Simpul yang langsung berada satu tingkat di bawah simpul tertentu |
| **Sibling (Saudara)** | Simpul-simpul yang memiliki induk yang sama |
| **Depth (Kedalaman)** | Jumlah tepi dari root ke suatu simpul; root memiliki depth 0 |
| **Height (Tinggi)** | Jumlah tepi pada jalur terpanjang dari suatu simpul ke leaf terdalam di bawahnya |
| **Binary Tree** | Tree yang setiap simpulnya memiliki paling banyak dua anak (kiri dan kanan) |
| **Full Binary Tree** | Binary tree di mana setiap simpul memiliki tepat 0 atau 2 anak |
| **Complete Binary Tree** | Binary tree di mana semua level terisi penuh kecuali level terakhir yang terisi dari kiri |
| **Perfect Binary Tree** | Binary tree di mana semua internal node punya 2 anak dan semua leaf di level yang sama |
| **BST Invariant** | Aturan BST: nilai subpohon kiri < nilai simpul < nilai subpohon kanan, secara rekursif |
| **Inorder Traversal** | Traversal L-N-R; menghasilkan data terurut menaik pada BST |
| **Preorder Traversal** | Traversal N-L-R; root dikunjungi pertama; berguna untuk serialisasi |
| **Postorder Traversal** | Traversal L-R-N; root dikunjungi terakhir; berguna untuk penghapusan |
| **Inorder Successor** | Simpul dengan nilai terkecil yang lebih besar dari suatu simpul; minimum di subpohon kanan |
| **Degenerate Tree** | BST yang menyerupai linked list akibat input terurut; tinggi O(n) |
| **Self-Balancing BST** | Varian BST yang secara otomatis menjaga tinggi O(log n); contoh: AVL Tree, Red-Black Tree |

---

## Soal Latihan

**Soal 1 [C2 — Memahami]**

Perhatikan tree berikut:

```
         [R]
        /   \
      [P]   [Q]
     /   \     \
   [M]   [N]   [O]
         /
       [L]
```

Tentukan: (a) depth dari setiap simpul, (b) height dari setiap simpul, (c) height of the tree, (d) semua simpul yang merupakan ancestor dari L, (e) semua simpul yang merupakan descendant dari P.

---

**Soal 2 [C2 — Memahami]**

Jelaskan perbedaan antara full binary tree, complete binary tree, dan perfect binary tree. Berikan masing-masing satu contoh konkret (diagram) dan sebutkan satu kegunaan atau konteks di mana masing-masing jenis pohon tersebut relevan.

---

**Soal 3 [C3 — Menerapkan]**

Gambarkan BST yang dihasilkan setelah menyisipkan elemen-elemen berikut secara berurutan (sertakan diagram setelah setiap penyisipan):

```
[15, 10, 25, 7, 12, 20, 30, 5, 8]
```

Setelah semua elemen disisipkan, tuliskan hasil inorder, preorder, dan postorder traversal.

---

**Soal 4 [C3 — Menerapkan]**

Diberikan BST berikut:

```
              [45]
             /    \
          [22]    [77]
          /  \    /  \
        [11] [33][55] [90]
                   \
                   [66]
```

Lakukan operasi berikut secara berurutan dan gambarkan BST setelah setiap operasi:
(a) Delete(11) — Kasus 1
(b) Delete(22) — Kasus 2
(c) Delete(45) — Kasus 3

Jelaskan kasus mana yang berlaku dan alasannya untuk setiap penghapusan.

---

**Soal 5 [C3 — Menerapkan]**

Implementasikan dalam Python sebuah fungsi `is_valid_bst(root)` yang mengembalikan `True` jika binary tree dengan root yang diberikan adalah BST yang valid, dan `False` jika tidak. Fungsi ini harus memeriksa BST property secara menyeluruh (bukan hanya antar parent-child langsung).

*Petunjuk:* Gunakan parameter batas bawah dan batas atas yang diwariskan saat rekursi turun ke anak-anak.

---

**Soal 6 [C4 — Menganalisis]**

Dua mahasiswa, Adit dan Budi, sama-sama menyisipkan 8 nilai ke dalam BST. Adit menggunakan urutan [50, 25, 75, 10, 35, 60, 85, 5], sedangkan Budi menggunakan urutan [5, 10, 25, 35, 50, 60, 75, 85].

(a) Gambarkan BST yang dihasilkan Adit dan BST yang dihasilkan Budi.
(b) Hitung height masing-masing BST.
(c) Berapa perbandingan maksimal yang diperlukan untuk operasi search(5) pada masing-masing BST?
(d) Analisis mengapa urutan input sangat memengaruhi kinerja BST dan apa implikasinya dalam aplikasi nyata.

---

**Soal 7 [C4 — Menganalisis]**

Buktikan secara informal (dengan argumen logis yang terstruktur, bukan bukti formal matematis) mengapa inorder traversal pada sembarang BST yang valid selalu menghasilkan elemen-elemennya dalam urutan terurut menaik. Gunakan properti rekursif BST dalam argumen Anda.

---

**Soal 8 [C4 — Menganalisis]**

Diketahui urutan preorder traversal suatu BST adalah: [40, 20, 10, 30, 25, 35, 60, 50, 70].

(a) Rekonstruksi BST dari urutan preorder tersebut dengan cara menyisipkan nilai-nilai tersebut satu per satu ke BST kosong menggunakan algoritma insert normal.
(b) Verifikasi rekonstruksi dengan menjalankan inorder traversal pada BST yang Anda buat dan pastikan hasilnya terurut.
(c) Mengapa urutan preorder (bukan postorder atau inorder) yang dapat digunakan untuk merekonstruksi BST yang identik?

---

**Soal 9 [C4 — Menganalisis]**

Perhatikan situasi berikut: sebuah aplikasi kamus digital menyimpan 100.000 kata dalam sebuah BST. Kata-kata disisipkan dalam urutan alfabetis dari "aardvark" hingga "zymurgy".

(a) Deskripsikan struktur BST yang dihasilkan.
(b) Berapa height pohon tersebut secara teoritis?
(c) Berapa perbandingan yang diperlukan untuk mencari kata "zymurgy" pada BST tersebut?
(d) Bandingkan dengan BST seimbang untuk data yang sama dan hitung selisih perbandingannya.
(e) Sarankan pendekatan yang lebih baik untuk kasus ini.

---

**Soal 10 [C5 — Mengevaluasi]**

Seorang pengembang dihadapkan pada pilihan struktur data untuk menyimpan koleksi ISBN buku (bilangan integer 13 digit) di perpustakaan digital dengan kebutuhan berikut:
- Pencarian berdasarkan ISBN spesifik harus secepat mungkin.
- Sesekali diperlukan daftar semua ISBN dalam urutan terurut.
- Data buku baru sering ditambahkan dan buku lama dihapus.

Evaluasi kelebihan dan kekurangan menggunakan (a) array terurut, (b) hash table, dan (c) BST seimbang untuk memenuhi ketiga kebutuhan tersebut. Rekomendasikan struktur data yang paling sesuai disertai justifikasi.

---

**Soal 11 [C5 — Mengevaluasi]**

Implementasikan dalam Python sebuah fungsi `count_nodes_in_range(root, low, high)` yang menghitung jumlah simpul dalam BST yang nilainya berada dalam rentang [low, high] (inklusif). Bandingkan dua pendekatan: (a) inorder traversal penuh kemudian filter, dan (b) pruning saat traversal dengan memanfaatkan BST property. Analisis kompleksitas keduanya.

---

**Soal 12 [C6 — Mencipta]**

Rancanglah sistem manajemen kontak (address book) menggunakan BST. Setiap kontak memiliki nama (string, digunakan sebagai kunci BST) dan nomor telepon. Implementasikan kelas `ContactBook` dalam Python yang mendukung operasi:
- `add_contact(name, phone)`: menambahkan kontak baru
- `search_contact(name)`: mencari kontak berdasarkan nama
- `delete_contact(name)`: menghapus kontak
- `list_all_contacts()`: menampilkan semua kontak dalam urutan alfabetis
- `contacts_starting_with(prefix)`: menampilkan semua kontak yang namanya diawali dengan prefix tertentu

Sertakan pengujian dengan minimal 10 data kontak dan diskusikan mengapa BST lebih sesuai daripada array sederhana untuk kasus ini.

---

## Bacaan Lanjutan

**1. Cormen, T.H., Leiserson, C.E., Rivest, R.L., dan Stein, C. (2009). *Introduction to Algorithms* (edisi ke-3). MIT Press. Bab 12: Binary Search Trees.**

Referensi standar internasional untuk BST. Bab 12 mencakup definisi formal, analisis kompleksitas rata-rata, dan pembuktian bahwa expected height BST dengan n kunci acak adalah O(log n). Sangat disarankan untuk mahasiswa yang ingin memahami fondasi matematis secara mendalam. Tersedia juga edisi ke-4 (2022) yang memperbarui beberapa notasi.

**2. Goodrich, M.T., Tamassia, R., dan Goldwasser, M.H. (2013). *Data Structures and Algorithms in Python*. Wiley. Bab 8: Trees.**

Satu-satunya buku rujukan utama yang menggunakan Python sebagai bahasa implementasi. Bab 8 membahas general tree, binary tree, dan linked structure untuk tree dengan gaya yang sangat cocok untuk mahasiswa tingkat menengah. Dilengkapi dengan visualisasi dan latihan berbasis Python yang relevan langsung dengan bab ini.

**3. Sedgewick, R. dan Wayne, K. (2011). *Algorithms* (edisi ke-4). Addison-Wesley. Bab 3: Searching.**

Pembahasan komprehensif tentang symbol table dan BST dari perspektif praktis rekayasa perangkat lunak. Bab ini mencakup BST dasar, kemudian berlanjut ke Red-Black Tree yang merupakan implementasi di balik `TreeMap` pada Java. Kode Java yang disajikan mudah dipadankan ke Python.

**4. Knuth, D.E. (1998). *The Art of Computer Programming, Volume 3: Sorting and Searching* (edisi ke-2). Addison-Wesley. Bagian 6.2: Searching by Comparison of Keys.**

Karya klasik oleh tokoh legendaris ilmu komputer. Bagian 6.2.2 membahas binary tree searching dengan analisis matematis yang sangat mendalam, termasuk distribusi tinggi BST untuk permutasi acak. Bacaan yang menantang namun sangat bermanfaat bagi mahasiswa yang berminat pada analisis algoritmik tingkat lanjut.

**5. Skiena, S.S. (2008). *The Algorithm Design Manual* (edisi ke-2). Springer. Bab 3: Data Structures.**

Buku yang menyajikan struktur data dari sudut pandang "bagaimana memilih struktur yang tepat untuk masalah yang tepat". Bab 3 memuat diskusi tentang trade-off antara BST, hash table, dan struktur lain lengkap dengan contoh kasus nyata. Sangat direkomendasikan untuk mahasiswa yang akan memasuki industri dan perlu membuat keputusan desain.

**6. Wirth, N. (1986). *Algorithms and Data Structures*. Prentice-Hall.**

Karya klasik oleh pencipta bahasa Pascal. Pendekatannya yang elegan dan matematis dalam membahas tree memberikan perspektif berbeda dari buku-buku modern. Tersedia bebas dalam format PDF di situs web ETH Zurich. Pembahasan tentang AVL Tree di buku ini adalah salah satu yang paling jelas dan terstruktur.

**7. Bhargava, A.Y. (2016). *Grokking Algorithms: An Illustrated Guide for Programmers and Other Curious People*. Manning Publications.**

Referensi visual dan intuitif yang sangat cocok sebagai bacaan pendamping sebelum atau sesudah bab ini. Buku ini tidak menggantikan referensi akademis di atas, tetapi presentasinya yang bergambar membuat konsep tree dan pencarian menjadi sangat mudah dipahami. Direkomendasikan untuk mahasiswa yang pertama kali berhadapan dengan struktur data non-linear.

---

*Bab 13 akan membahas AVL Tree — self-balancing BST yang menjamin tinggi O(log n) dalam semua kasus dengan menggunakan rotasi otomatis, mengatasi kelemahan utama BST biasa yang telah dibahas dalam bab ini.*

---
