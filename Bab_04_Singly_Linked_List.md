# BAB 4
# SINGLY LINKED LIST: STRUKTUR DATA DINAMIS BERBASIS POINTER

---

> *"Seperti mata rantai yang saling menggenggam, kekuatan sebuah linked list bukan terletak pada setiap nodenya secara terpisah, melainkan pada koneksi yang menghubungkan mereka menjadi satu kesatuan yang utuh."*
>
> — Donald E. Knuth, *The Art of Computer Programming*, Vol. 1

---

## Tujuan Pembelajaran

Setelah mempelajari bab ini secara tuntas, mahasiswa diharapkan mampu:

1. **Menjelaskan** (C2 — Memahami) konsep node, pointer, dan mekanisme alokasi memori dinamis sebagai fondasi struktur data singly linked list, termasuk perbedaannya dengan alokasi memori statis pada array.

2. **Mengilustrasikan** (C2 — Memahami) struktur internal singly linked list meliputi komponen head, tail, dan rantai referensi antar node melalui diagram yang akurat dan terperinci.

3. **Mengimplementasikan** (C3 — Menerapkan) kelas `Node` dan kelas `SinglyLinkedList` menggunakan Python secara lengkap, termasuk operasi insert di awal, di akhir, dan di posisi tengah dengan pendekatan berorientasi objek yang disertai docstring.

4. **Mengeksekusi** (C3 — Menerapkan) operasi penghapusan elemen (delete di awal, di akhir, dan berdasarkan nilai) serta operasi pencarian pada singly linked list, disertai dengan trace pointer manual untuk memverifikasi kebenaran algoritma.

5. **Membandingkan** (C4 — Menganalisis) karakteristik dan kompleksitas operasi singly linked list dengan array berdasarkan dimensi akses, penyisipan, penghapusan, penggunaan memori, dan performa cache, untuk menghasilkan rekomendasi pemilihan struktur data yang tepat sasaran.

6. **Merancang** (C5 — Mengevaluasi) solusi perangkat lunak nyata menggunakan singly linked list sebagai struktur penyimpanan utama, didemonstrasikan melalui studi kasus sistem manajemen daftar putar musik (music playlist).

7. **Membangun** (C6 — Mencipta) algoritma baru yang memanfaatkan sifat-sifat singly linked list, seperti pembalikan list dan penggabungan dua list terurut, dengan analisis kompleksitas waktu dan ruang yang formal.

---

## 4.1 Pendahuluan: Motivasi di Balik Linked List

Pada bab-bab sebelumnya, array telah diperkenalkan sebagai struktur data linear yang paling mendasar. Array menawarkan akses acak (random access) dengan kompleksitas waktu O(1) — sebuah keunggulan yang sulit ditandingi. Dengan mengetahui alamat basis (base address) dan ukuran tiap elemen, komputer dapat menghitung alamat elemen mana pun secara langsung. Namun, di balik keunggulan tersebut, array menyimpan kelemahan struktural yang menjadi penghalang dalam berbagai skenario pemrograman modern.

Kelemahan pertama dan paling krusial adalah sifat ukuran statis pada array konvensional. Ketika sebuah array dideklarasikan dengan kapasitas tertentu, blok memori sebesar itu langsung dikunci. Jika data yang masuk ternyata lebih banyak dari kapasitas, program terpaksa mengalokasikan array baru yang lebih besar, menyalin seluruh data lama, kemudian membuang array lama — sebuah operasi yang mahal dengan kompleksitas O(n). Sebaliknya, jika data yang sesungguhnya jauh lebih sedikit dari kapasitas yang disiapkan, terjadi pemborosan memori yang tidak terhindarkan.

Kelemahan kedua muncul pada operasi penyisipan dan penghapusan elemen di posisi selain akhir. Untuk menyisipkan elemen baru di indeks ke-i pada array berisi n elemen, seluruh elemen dari indeks i hingga n-1 harus digeser satu posisi ke kanan terlebih dahulu. Operasi pergeseran massal ini membutuhkan waktu O(n) dalam kasus terburuk. Kondisi serupa terjadi pada penghapusan: elemen-elemen setelah posisi yang dihapus harus digeser ke kiri untuk menutup celah yang ditinggalkan.

Keterbatasan-keterbatasan ini mendorong pengembangan alternatif yang lebih fleksibel: **linked list**. Berbeda dari array yang mengandalkan kontinuitas fisik di memori, linked list menggunakan pendekatan yang sama sekali berbeda — setiap elemen data dikemas bersama sebuah penunjuk (pointer) yang menyimpan alamat elemen berikutnya. Hasilnya adalah sebuah rantai referensi yang secara logis membentuk urutan linear, meskipun secara fisik elemen-elemennya dapat tersebar di lokasi memori yang tidak berdampingan.

Dengan arsitektur ini, penyisipan elemen baru di awal linked list hanya membutuhkan dua langkah sederhana: menghubungkan node baru ke node pertama yang ada, lalu memperbarui penunjuk head. Operasi tersebut selesai dalam waktu konstan O(1), tanpa pergeseran elemen sama sekali. Inilah revolusi efisiensi yang dibawa oleh linked list untuk kasus-kasus operasi insert dan delete yang dominan.

Bab ini membahas secara mendalam varian paling fundamental dari linked list, yakni **singly linked list** — list di mana setiap node hanya memiliki satu penunjuk yang mengarah ke node berikutnya. Pembahasan dimulai dari konsep node dan memori dinamis, diteruskan ke seluruh operasi utama, kemudian diakhiri dengan studi kasus penerapannya dalam sistem manajemen daftar putar musik.

---

## 4.2 Konsep Dasar: Node, Pointer, dan Alokasi Memori Dinamis

### 4.2.1 Anatomi Sebuah Node

Satuan terkecil yang menyusun linked list disebut **node**. Konsep node sangat sederhana namun powerful: ia adalah sebuah objek yang mengandung dua komponen, yaitu data yang ingin disimpan dan sebuah tautan ke node berikutnya.

Komponen pertama disebut **field data** (data field). Field ini menyimpan nilai atau informasi yang hendak direpresentasikan. Tidak ada batasan mengenai tipe data yang dapat disimpan — ia bisa berupa bilangan bulat, bilangan riil, string, objek, atau bahkan linked list lain (nested structure). Dalam konteks Python, field data menyimpan referensi ke objek Python mana pun.

Komponen kedua disebut **field next** (next field) atau sering disebut pointer. Field ini menyimpan alamat memori atau referensi ke node berikutnya dalam urutan logis. Ketika sebuah node merupakan elemen terakhir dalam list, field next-nya diisi dengan nilai `None` (dalam Python) atau `NULL` (dalam C/C++) sebagai penanda bahwa tidak ada node lanjutan.

Representasi visual sebuah node tunggal adalah sebagai berikut:

```
Gambar 4.1 — Struktur Internal Sebuah Node

         +----------+----------+
         |          |          |
         |   data   |   next   |
         |          |          |
         +----------+----------+
              ^            ^
              |            |
         Menyimpan    Menyimpan referensi
         nilai data   ke node berikutnya
                      (atau None)
```

Ketika dua node dihubungkan, tautan antara keduanya terbentuk melalui field next, seperti digambarkan di bawah ini:

```
Gambar 4.2 — Dua Node yang Saling Terhubung

+--------+------+          +--------+------+
|   42   |  *---+--------->|   17   | None |
+--------+------+          +--------+------+
  Node A                      Node B
  (data=42,                   (data=17,
   next=Node_B)                next=None)
```

Pada Gambar 4.2, Node A menyimpan nilai 42 dan field next-nya menunjuk ke Node B. Node B menyimpan nilai 17 dan field next-nya bernilai `None`, menandakan ia adalah elemen terakhir dalam rantai.

> **Catatan Penting 4.1**
>
> Dalam bahasa pemrograman seperti C atau C++, field next secara literal menyimpan **alamat memori** (memory address) dari node berikutnya, itulah mengapa disebut pointer. Dalam Python, konsep pointer tidak terekspos secara langsung kepada programmer; yang ada adalah **referensi objek** (object reference). Namun secara konseptual, mekanismenya identik: field next menyimpan "lokasi" node berikutnya, sehingga program dapat melompat ke sana. Sepanjang bab ini, istilah "pointer" dan "referensi" digunakan secara bergantian untuk merujuk konsep yang sama.

### 4.2.2 Alokasi Memori Dinamis versus Alokasi Statis

Perbedaan paling mendasar antara array dan linked list bukan terletak pada cara data disimpan, melainkan pada cara memori dialokasikan untuk menyimpan data tersebut. Memahami perbedaan ini sangat penting karena ia adalah akar dari semua perbedaan kinerja antara kedua struktur data tersebut.

**Array** menggunakan alokasi memori **statis dan kontigu**. Kata "kontigu" berarti semua elemen menempati blok memori yang berdampingan — tidak ada celah di antara elemen satu dengan elemen berikutnya. Konsekuensinya, ketika sebuah array dengan 5 elemen dideklarasikan, sistem operasi harus menemukan dan mengalokasikan blok memori berukuran tepat 5 kali ukuran satu elemen, semuanya berdampingan. Karena keteraturan fisik ini, alamat elemen ke-i dapat dihitung secara langsung dengan formula `base_address + i * element_size` — inilah yang memungkinkan akses O(1).

**Linked list** menggunakan alokasi memori **dinamis dan tersebar**. Setiap node dibuat secara terpisah pada saat dibutuhkan (runtime), dan sistem operasi bebas menempatkan node tersebut di lokasi memori mana pun yang tersedia. Tidak ada persyaratan bahwa node-node harus berdampingan. Urutan logis di antara node-node ditentukan bukan oleh posisi fisik mereka di memori, melainkan oleh rantai referensi (pointer) yang saling menghubungkan.

Ilustrasi perbedaan fundamental ini ditampilkan pada Gambar 4.3:

```
Gambar 4.3 — Perbedaan Alokasi Memori: Array vs. Linked List

ARRAY (alokasi kontigu):
Alamat: 1000  1004  1008  1012  1016
        +-----+-----+-----+-----+-----+
        | 10  | 20  | 30  | 40  | 50  |
        +-----+-----+-----+-----+-----+
        Elemen 0   1   2   3   4
        (Semua berdampingan di memori fisik)

LINKED LIST (alokasi tersebar):
Alamat  : 1000         3400         2200         4100
          +----+----+  +----+----+  +----+----+  +----+------+
          | 10 |3400+->| 20 |2200+->| 30 |4100+->| 40 | None |
          +----+----+  +----+----+  +----+----+  +----+------+
          Node 0       Node 1       Node 2       Node 3
        (Tersebar di lokasi memori yang tidak berurutan)
```

Perhatikan bahwa pada linked list di Gambar 4.3, node yang menyimpan nilai 10 berada di alamat 1000, node berikutnya (nilai 20) berada di alamat 3400, bukan 1004. Urutan logis dipertahankan oleh nilai 3400 yang disimpan dalam field next node pertama.

> **Tahukah Anda? 4.1**
>
> Dalam Python, manajemen memori dinamis ditangani sepenuhnya oleh **garbage collector** (pengumpul sampah). Ketika kita menulis `node = Node(42)`, Python secara otomatis mengalokasikan memori untuk objek node tersebut di heap. Ketika tidak ada lagi variabel atau referensi yang menunjuk ke objek tersebut, garbage collector akan secara otomatis membebaskan memorinya — programmer tidak perlu (dan tidak bisa) melakukannya secara manual seperti di C/C++ dengan `free()` atau `delete`. Inilah mengapa Python dikatakan memiliki automatic memory management, yang sangat memudahkan implementasi linked list.

### 4.2.3 Implementasi Kelas Node dalam Python

Berbekal pemahaman konseptual di atas, implementasi kelas `Node` dalam Python bersifat sangat ringkas. Kelas ini hanya membutuhkan konstruktor (`__init__`) yang menginisialisasi dua atribut, serta metode `__repr__` untuk memudahkan debugging dan pemeriksaan objek.

```python
class Node:
    """
    Representasi satu node dalam singly linked list.

    Setiap node menyimpan sebuah nilai (data) dan referensi ke
    node berikutnya dalam rantai (next). Jika node ini adalah
    elemen terakhir, atribut next bernilai None.

    Atribut:
        data : nilai yang disimpan dalam node ini (tipe bebas)
        next : referensi ke Node berikutnya, atau None
    """

    def __init__(self, data):
        """
        Inisialisasi node baru dengan data yang diberikan.

        Parameter:
            data : nilai yang akan disimpan dalam node ini

        Catatan:
            Field next diinisialisasi ke None karena node baru
            belum terhubung ke node lain mana pun.
        """
        self.data = data   # field data: menyimpan nilai
        self.next = None   # field pointer: belum terhubung ke node lain

    def __repr__(self):
        """Representasi string untuk debugging."""
        return f"Node({self.data})"
```

Untuk memahami cara kerja kelas `Node` dan pembentukan rantai antar node secara manual, perhatikan contoh berikut:

```python
# Membuat tiga node secara independen — masing-masing berdiri sendiri
node_a = Node(10)   # Node(10), next=None
node_b = Node(20)   # Node(20), next=None
node_c = Node(30)   # Node(30), next=None

# Menghubungkan node secara manual untuk membentuk rantai
node_a.next = node_b   # Node(10) -> Node(20)
node_b.next = node_c   # Node(20) -> Node(30)
# node_c.next tetap None — ini adalah node terakhir

# Traversal manual mengikuti rantai referensi
current = node_a
while current is not None:
    print(current.data, end=" -> ")
    current = current.next
print("None")
# Output: 10 -> 20 -> 30 -> None
```

Contoh di atas menunjukkan esensi linked list secara paling telanjang: sebuah rantai objek di mana setiap objek "tahu" alamat objek berikutnya. Traversal dilakukan dengan mengikuti rantai referensi dari awal hingga ditemukan `None`.

---

## 4.3 Struktur Singly Linked List: Head, Tail, dan Traversal

### 4.3.1 Komponen Struktural Singly Linked List

Sebuah **singly linked list** adalah kumpulan node yang terurut secara linear, di mana setiap node hanya memiliki satu arah tautan, yaitu ke node yang tepat mengikutinya. Kata "singly" (tunggal) merujuk pada fakta bahwa setiap node hanya memiliki satu pointer — ke depan (forward pointer) — berbeda dengan doubly linked list yang memiliki pointer ke depan sekaligus ke belakang.

Untuk mengelola singly linked list secara efisien, tiga komponen struktural perlu dipelihara:

**Head** adalah referensi ke node pertama dalam list. Head merupakan satu-satunya "pintu masuk" ke dalam linked list — tanpa head, tidak ada cara untuk mengakses elemen mana pun dalam list. Ketika `head = None`, ini berarti list dalam kondisi kosong.

**Tail** adalah referensi ke node terakhir dalam list. Node terakhir selalu ditandai oleh `next = None`. Menyimpan referensi tail secara eksplisit memungkinkan operasi insert di akhir list dilakukan dalam waktu konstan O(1), tanpa perlu melakukan traversal terlebih dahulu untuk menemukan elemen terakhir.

**Size** adalah penghitung jumlah node yang ada dalam list. Atribut ini dapat diperbarui secara inkremental setiap kali terjadi operasi insert atau delete, sehingga kueri `len()` dapat dijawab dalam O(1) tanpa perlu menghitung ulang dengan traversal.

Gambar 4.4 mengilustrasikan struktur lengkap sebuah singly linked list dengan empat elemen:

```
Gambar 4.4 — Struktur Singly Linked List dengan Empat Node

head                                              tail
 |                                                  |
 v                                                  v
+----+----+    +----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | *--+--> | 40 | None |
+----+----+    +----+----+    +----+----+    +----+------+
  Node 0          Node 1         Node 2         Node 3
  (idx=0)         (idx=1)        (idx=2)        (idx=3)

                    size = 4
```

### 4.3.2 Operasi Traversal

Traversal adalah operasi fundamental yang mengunjungi setiap node dari head hingga tail secara berurutan. Karena tidak ada akses acak dalam linked list, traversal selalu dimulai dari head — tidak ada jalan pintas untuk "melompat" ke node di tengah. Traversal merupakan blok bangunan untuk hampir semua operasi lain yang lebih kompleks: pencarian, penghapusan berdasarkan nilai, dan insert di posisi tengah semuanya bergantung pada traversal sebagai langkah awal.

Implementasi traversal yang paling dasar adalah sebagai berikut:

```python
def traverse(self):
    """
    Cetak seluruh elemen dari head ke tail dalam format
    'a -> b -> c -> None'.

    Kompleksitas Waktu : O(n) — setiap node dikunjungi tepat sekali
    Kompleksitas Ruang : O(1) — hanya satu variabel pointer tambahan
    """
    if self.is_empty():
        print("List kosong")
        return
    elements = []
    current = self.head          # mulai dari pintu masuk: head
    while current is not None:
        elements.append(str(current.data))
        current = current.next   # ikuti tautan ke node berikutnya
    print(" -> ".join(elements) + " -> None")
```

Untuk memperjelas mekanisme traversal, berikut adalah trace manual langkah demi langkah pada list [10, 20, 30, 40]:

```
Trace Traversal pada List [10, 20, 30, 40]:

Langkah 1: current = head = Node(10)
           Catat nilai: "10"
           current = current.next = Node(20)

Langkah 2: current = Node(20)
           Catat nilai: "20"
           current = current.next = Node(30)

Langkah 3: current = Node(30)
           Catat nilai: "30"
           current = current.next = Node(40)

Langkah 4: current = Node(40)
           Catat nilai: "40"
           current = current.next = None

Langkah 5: current = None -> kondisi loop terpenuhi -> BERHENTI

Output akhir: "10 -> 20 -> 30 -> 40 -> None"
```

Traversal adalah operasi dengan kompleksitas O(n) karena setiap node dikunjungi tepat satu kali. Tidak ada cara untuk mempercepatnya pada linked list standar karena tidak ada indeks atau peta memori yang bisa dimanfaatkan.

---

## 4.4 Operasi Insert: Tiga Skenario Fundamental

Operasi penyisipan (insert) adalah salah satu kekuatan terbesar singly linked list dibandingkan array. Terdapat tiga skenario insert yang perlu dikuasai, masing-masing dengan karakteristik algoritmik yang berbeda.

### 4.4.1 Insert di Awal (Prepend)

Insert di awal adalah operasi paling efisien dalam singly linked list. Efisiensinya berasal dari fakta bahwa head selalu dapat diakses secara langsung, sehingga tidak diperlukan traversal sama sekali. Operasi ini bekerja dalam waktu konstan O(1), tidak peduli seberapa panjang list yang ada.

Algoritma insert di awal dapat dirumuskan dalam empat langkah:
1. Buat node baru dengan data yang diberikan.
2. Jadikan `new_node.next` menunjuk ke node yang saat ini menjadi head (atau None jika list kosong).
3. Perbarui `head` agar menunjuk ke `new_node`.
4. Jika list sebelumnya kosong, perbarui `tail` juga ke `new_node`. Tambah counter size.

Gambar 4.5 memvisualisasikan seluruh proses insert nilai 5 di awal list [10, 20, 30]:

```
Gambar 4.5 — Proses Insert di Awal List

KONDISI SEBELUM INSERT:
head
 |
 v
+----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | None |
+----+----+    +----+----+    +----+------+

LANGKAH 1: Buat new_node = Node(5)
new_node
 |
 v
+----+------+
|  5 | None |
+----+------+

LANGKAH 2: new_node.next = head  (arahkan new_node ke head lama)
new_node
 |
 v
+----+----+    +----+----+    +----+----+    +----+------+
|  5 | *--+--> | 10 | *--+--> | 20 | *--+--> | 30 | None |
+----+----+    +----+----+    +----+----+    +----+------+
               ^
               | head lama (masih menunjuk ke Node(10))

LANGKAH 3: head = new_node  (perbarui head ke node baru)
head
 |
 v
+----+----+    +----+----+    +----+----+    +----+------+
|  5 | *--+--> | 10 | *--+--> | 20 | *--+--> | 30 | None |
+----+----+    +----+----+    +----+----+    +----+------+

KONDISI SETELAH INSERT: List = [5, 10, 20, 30], size = 4
```

Urutan langkah 2 dan 3 di atas **tidak boleh ditukar**. Jika head diperbarui dulu sebelum `new_node.next` diatur, referensi ke node head lama akan hilang dan seluruh elemen list yang ada akan terputus dan tidak dapat diakses lagi.

### 4.4.2 Insert di Akhir (Append)

Insert di akhir memanfaatkan referensi tail yang disimpan secara eksplisit. Dengan tail yang selalu menunjuk ke node terakhir, operasi ini juga dapat diselesaikan dalam O(1).

Algoritma insert di akhir:
1. Buat node baru dengan data yang diberikan.
2. Jika list kosong, jadikan node baru sebagai head sekaligus tail.
3. Jika tidak kosong, jadikan `tail.next` menunjuk ke node baru, lalu perbarui `tail` ke node baru.
4. Tambah counter size.

```
Gambar 4.6 — Proses Insert di Akhir List

KONDISI SEBELUM INSERT:
head                        tail
 |                            |
 v                            v
+----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | None |
+----+----+    +----+----+    +----+------+

LANGKAH 1: Buat new_node = Node(50)
+----+------+
| 50 | None |
+----+------+

LANGKAH 2: tail.next = new_node  (sambungkan tail lama ke new_node)
head                        tail
 |                            |
 v                            v
+----+----+    +----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | *--+--> | 50 | None |
+----+----+    +----+----+    +----+----+    +----+------+

LANGKAH 3: tail = new_node  (perbarui tail ke node baru)
head                                         tail
 |                                             |
 v                                             v
+----+----+    +----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | *--+--> | 50 | None |
+----+----+    +----+----+    +----+----+    +----+------+

KONDISI SETELAH INSERT: List = [10, 20, 30, 50], size = 4
```

> **Catatan Penting 4.2**
>
> Kompleksitas O(1) untuk insert di akhir **hanya berlaku** apabila referensi `tail` disimpan secara eksplisit dalam objek linked list. Banyak implementasi sederhana yang tidak menyimpan referensi tail demi kesederhanaan kode. Dalam implementasi tanpa tail, operasi insert di akhir membutuhkan traversal penuh dari head ke node terakhir, sehingga kompleksitasnya menjadi O(n). Dalam bab ini, seluruh implementasi menyertakan referensi tail.

### 4.4.3 Insert di Posisi Tengah (Insert After Index)

Menyisipkan node di posisi tengah adalah operasi yang paling kompleks dari ketiga skenario insert. Operasi ini membutuhkan traversal ke node pendahulu (predecessor) dari posisi target, sehingga kompleksitasnya adalah O(n).

Algoritma insert setelah indeks ke-`pos`:
1. Validasi posisi: pastikan `0 <= pos < size`. Lempar `IndexError` jika tidak valid.
2. Jika `pos == 0` dan posisi awal: gunakan `insert_at_beginning`.
3. Jika `pos == size - 1` (setelah elemen terakhir): gunakan `insert_at_end`.
4. Traversal dari head sebanyak `pos` langkah untuk mencapai node pada indeks `pos`.
5. Simpan `new_node.next = current.next` (sambungkan node baru ke penerus current).
6. Perbarui `current.next = new_node` (sambungkan current ke node baru).
7. Tambah counter size.

Gambar 4.7 memvisualisasikan penyisipan nilai 25 setelah indeks 1 pada list [10, 20, 30, 40]:

```
Gambar 4.7 — Proses Insert di Posisi Tengah (setelah indeks 1)

KONDISI SEBELUM INSERT:
head
 |
 v
+----+----+    +----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | *--+--> | 40 | None |
+----+----+    +----+----+    +----+----+    +----+------+
 idx=0          idx=1          idx=2          idx=3

LANGKAH 1: Buat new_node = Node(25)
+----+------+
| 25 | None |
+----+------+

LANGKAH 2: Traversal ke idx=1
  Iterasi 0: current = Node(10) (idx=0, belum sampai)
  Iterasi 1: current = Node(20) (idx=1, BERHENTI)

Keadaan pointer saat ini:
           current
             |
             v
+----+----+  +----+----+  +----+----+  +----+------+
| 10 |    |  | 20 | *--+->| 30 | *--+->| 40 | None |
+----+----+  +----+----+  +----+----+  +----+------+
                ^
                head.next menunjuk ke sini

LANGKAH 3: new_node.next = current.next
           Node(25).next = Node(30)

           current              current.next
             |                      |
             v                      v
+----+----+  +----+----+  +----+----+  +----+------+
| 20 | *--+->| 30 | *--+->| 40 | None |
+----+----+  +----+----+  +----+----+

           +----+----+
           | 25 | *--+---> Node(30)  (new_node.next sudah diatur)
           +----+----+

LANGKAH 4: current.next = new_node
           Node(20).next = Node(25)

head
 |
 v
+----+----+  +----+----+  +----+----+  +----+----+  +----+------+
| 10 | *--+->| 20 | *--+->| 25 | *--+->| 30 | *--+->| 40 | None |
+----+----+  +----+----+  +----+----+  +----+----+  +----+------+
 idx=0        idx=1        idx=2(baru)  idx=3         idx=4

KONDISI SETELAH INSERT: List = [10, 20, 25, 30, 40], size = 5
```

> **Catatan Penting 4.3**
>
> Urutan langkah 3 dan 4 pada insert di posisi tengah adalah **sangat kritis**. Langkah 3 (`new_node.next = current.next`) harus selalu dilakukan **sebelum** langkah 4 (`current.next = new_node`). Jika urutannya terbalik, ketika `current.next` diubah ke `new_node` terlebih dahulu, referensi ke node yang seharusnya menjadi penerus `new_node` akan hilang secara permanen, menyebabkan bagian ekor list terputus.

---

## 4.5 Operasi Delete: Tiga Skenario Penghapusan

Operasi penghapusan (delete) pada singly linked list memiliki karakteristik yang asimetris: delete di awal sangat efisien (O(1)), sementara delete di akhir tidak dapat menghindari traversal O(n) karena keterbatasan pointer satu arah.

### 4.5.1 Delete di Awal

Menghapus elemen pertama adalah operasi paling sederhana dan paling efisien. Cukup dengan memajukan head ke node berikutnya, node pertama secara otomatis kehilangan semua referensi yang menunjuknya dan akan dibersihkan oleh garbage collector Python.

```
Gambar 4.8 — Proses Delete di Awal List

KONDISI SEBELUM DELETE:
head
 |
 v
+----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | None |
+----+----+    +----+----+    +----+------+

LANGKAH 1: removed_data = head.data  =>  removed_data = 10
LANGKAH 2: head = head.next          =>  head sekarang menunjuk ke Node(20)

KONDISI SETELAH head = head.next:
                   head
                    |
                    v
+----+----+    +----+----+    +----+------+
| 10 | *--+    | 20 | *--+--> | 30 | None |
+----+----+    +----+----+    +----+------+
    ^
    Tidak ada yang menunjuk ke sini lagi
    -> Garbage collector akan membebaskan memori ini

KONDISI AKHIR: List = [20, 30], data yang dihapus = 10
```

Kompleksitas delete di awal adalah O(1) untuk waktu dan O(1) untuk ruang.

### 4.5.2 Delete di Akhir

Meskipun kita menyimpan referensi tail yang langsung menunjuk ke node terakhir, menghapus node tersebut tetap membutuhkan traversal O(n). Mengapa demikian? Karena setelah node terakhir dihapus, `tail` harus diperbarui untuk menunjuk ke node sebelumnya (predecessor). Dalam singly linked list, tidak ada cara untuk mundur dari tail ke predecessor tanpa traversal dari head, karena setiap node hanya memiliki pointer ke depan.

```
Gambar 4.9 — Proses Delete di Akhir List

KONDISI SEBELUM DELETE:
head                                    tail
 |                                        |
 v                                        v
+----+----+    +----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | *--+--> | 40 | None |
+----+----+    +----+----+    +----+----+    +----+------+

TRAVERSAL: Cari node di mana current.next == tail
  Step 1: current = Node(10), current.next = Node(20)  != tail -> lanjut
  Step 2: current = Node(20), current.next = Node(30)  != tail -> lanjut
  Step 3: current = Node(30), current.next = Node(40) == tail -> BERHENTI

LANGKAH: removed_data = tail.data    =>  removed_data = 40
         current.next = None         =>  putus tautan ke Node(40)
         tail = current              =>  Node(30) menjadi tail baru

head                        tail
 |                            |
 v                            v
+----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | None |
+----+----+    +----+----+    +----+------+

Node(40) tidak direferensikan siapa pun -> dibebaskan oleh GC
KONDISI AKHIR: List = [10, 20, 30], data yang dihapus = 40
```

> **Catatan Penting 4.4**
>
> Ini adalah kelemahan inheren singly linked list yang tidak dapat dieliminasi selama struktur hanya memiliki pointer satu arah. **Doubly linked list** (dibahas pada bab berikutnya) mengatasi masalah ini dengan menyimpan pointer ke belakang (prev) di setiap node, sehingga predecessor tail dapat diakses secara langsung dan delete di akhir dapat dilakukan dalam O(1).

### 4.5.3 Delete Berdasarkan Nilai

Penghapusan berdasarkan nilai membutuhkan dua langkah: pertama mencari node yang memiliki data sesuai target, kemudian memutus node tersebut dari rantai. Teknik yang digunakan adalah **two-pointer technique**, yaitu memelihara dua pointer (`prev` dan `current`) yang bergerak bersama selama traversal. Ketika node target ditemukan pada `current`, pointer `prev.next` dapat langsung "melompati" `current` ke penerusnya.

```
Gambar 4.10 — Proses Delete Berdasarkan Nilai (target = 20)

KONDISI SEBELUM DELETE:
head
 |
 v
+----+----+    +----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | *--+--> | 40 | None |
+----+----+    +----+----+    +----+----+    +----+------+

INISIALISASI: prev = None, current = Node(10)

TRAVERSAL:
  Step 1: current.data = 10 != 20
          prev = Node(10), current = Node(20)
  Step 2: current.data = 20 == 20 -> TARGET DITEMUKAN!

Keadaan pointer sebelum manipulasi:
prev          current
  |              |
  v              v
+----+----+    +----+----+    +----+----+    +----+------+
| 10 | *--+--> | 20 | *--+--> | 30 | *--+--> | 40 | None |
+----+----+    +----+----+    +----+----+    +----+------+

LANGKAH: prev.next = current.next
         Node(10).next = Node(30)  (melompati Node(20))

prev                             current (akan di-GC)
  |                                 |
  v                                 v
+----+----+    +----+----+    +----+----+    +----+------+
| 10 | *--+    | 20 | *--+--> | 30 | *--+--> | 40 | None |
+----+----+ \  +----+----+    +----+----+    +----+------+
             \                   ^
              +-------------------+
              prev.next langsung ke Node(30)

KONDISI AKHIR: List = [10, 30, 40], data yang dihapus = 20
```

---

## 4.6 Operasi Pencarian dan Akses Berbasis Indeks

Linked list tidak mendukung akses acak (random access). Tidak seperti array di mana elemen ke-i dapat diakses secara langsung, pada linked list setiap akses mengharuskan traversal dari head. Ini berlaku baik untuk pencarian berdasarkan nilai maupun pengambilan data berdasarkan indeks.

**Pencarian berdasarkan nilai** (search by value) melakukan traversal sambil membandingkan setiap elemen dengan target. Pencarian dimulai dari head dan berhenti ketika target ditemukan atau list habis. Kompleksitas adalah O(n) dalam kasus rata-rata dan terburuk, serta O(1) dalam kasus terbaik (target ada di head).

**Akses berdasarkan indeks** (get by index) melakukan traversal sebanyak `index` langkah dari head. Kompleksitasnya selalu O(n) bahkan dalam kasus terbaik (kecuali untuk indeks 0 yang O(1) karena bisa langsung dari head). Ini adalah perbedaan paling mencolok dibandingkan array yang menjamin O(1) untuk akses indeks mana pun.

```python
def search(self, target):
    """
    Cari nilai target dalam list secara sekuensial.
    Kembalikan indeks pertama yang cocok, atau -1 jika tidak ditemukan.

    Kompleksitas Waktu : O(n) rata-rata dan terburuk; O(1) terbaik
    Kompleksitas Ruang : O(1)
    """
    current = self.head
    index = 0
    while current is not None:
        if current.data == target:
            return index        # ditemukan pada indeks ini
        current = current.next
        index += 1
    return -1                   # tidak ditemukan

def get_at(self, index):
    """
    Akses dan kembalikan data pada posisi indeks tertentu (berbasis-nol).

    Kompleksitas Waktu : O(n) — tidak ada random access seperti array
    Kompleksitas Ruang : O(1)

    Raises:
        IndexError: Jika indeks berada di luar rentang [0, size-1]
    """
    if index < 0 or index >= self.size:
        raise IndexError(
            f"Indeks {index} di luar batas. Ukuran list: {self.size}"
        )
    current = self.head
    for _ in range(index):
        current = current.next
    return current.data
```

---

## 4.7 Implementasi Lengkap Kelas SinglyLinkedList

Berikut adalah implementasi lengkap dan terstruktur dari `SinglyLinkedList` yang mengintegrasikan seluruh operasi yang telah dibahas pada subbab-subbab sebelumnya. Implementasi ini mengikuti prinsip enkapsulasi berorientasi objek (object-oriented encapsulation), di mana semua logika internal terlindungi di dalam kelas dan antarmuka publik yang bersih tersedia untuk pengguna.

```python
class Node:
    """
    Representasi satu node dalam singly linked list.

    Atribut:
        data : nilai yang disimpan dalam node ini
        next : referensi ke Node berikutnya, atau None
    """

    def __init__(self, data):
        self.data = data
        self.next = None

    def __repr__(self):
        return f"Node({self.data})"


class SinglyLinkedList:
    """
    Implementasi Singly Linked List dengan referensi head, tail, dan size.

    Struktur Data:
        head (Node) : referensi ke node pertama; None jika list kosong
        tail (Node) : referensi ke node terakhir; None jika list kosong
        size (int)  : jumlah node dalam list; selalu terjaga konsistensinya

    Ringkasan Kompleksitas Operasi:
        insert_at_beginning(data)     -> O(1) waktu, O(1) ruang
        insert_at_end(data)           -> O(1) waktu, O(1) ruang
        insert_after_index(idx, data) -> O(n) waktu, O(1) ruang
        delete_at_beginning()         -> O(1) waktu, O(1) ruang
        delete_at_end()               -> O(n) waktu, O(1) ruang
        delete_by_value(target)       -> O(n) waktu, O(1) ruang
        search(target)                -> O(n) waktu, O(1) ruang
        get_at(index)                 -> O(n) waktu, O(1) ruang
        traverse()                    -> O(n) waktu, O(1) ruang
        is_empty()                    -> O(1) waktu, O(1) ruang
        __len__()                     -> O(1) waktu, O(1) ruang
    """

    def __init__(self):
        """Inisialisasi linked list kosong."""
        self.head = None    # referensi ke node pertama
        self.tail = None    # referensi ke node terakhir
        self.size = 0       # jumlah node

    # ------------------------------------------------------------------ #
    #  OPERASI INSERT                                                      #
    # ------------------------------------------------------------------ #

    def insert_at_beginning(self, data):
        """
        Sisipkan node baru di awal list (operasi prepend).

        Algoritma:
            1. Buat node baru.
            2. Jika list kosong, node baru menjadi head sekaligus tail.
            3. Jika tidak kosong, arahkan new_node.next ke head lama,
               lalu perbarui head ke new_node.
            4. Tambah size.

        Kompleksitas Waktu : O(1) — tidak ada traversal
        Kompleksitas Ruang : O(1) — satu alokasi node
        """
        new_node = Node(data)
        if self.is_empty():
            self.head = new_node
            self.tail = new_node
        else:
            new_node.next = self.head   # sambungkan ke head lama
            self.head = new_node        # perbarui head
        self.size += 1

    def insert_at_end(self, data):
        """
        Sisipkan node baru di akhir list (operasi append).

        Algoritma:
            1. Buat node baru.
            2. Jika list kosong, node baru menjadi head sekaligus tail.
            3. Jika tidak kosong, arahkan tail.next ke new_node,
               lalu perbarui tail ke new_node.
            4. Tambah size.

        Kompleksitas Waktu : O(1) — referensi tail memungkinkan akses langsung
        Kompleksitas Ruang : O(1)
        """
        new_node = Node(data)
        if self.is_empty():
            self.head = new_node
            self.tail = new_node
        else:
            self.tail.next = new_node   # sambungkan tail lama ke new_node
            self.tail = new_node        # perbarui tail
        self.size += 1

    def insert_after_index(self, index, data):
        """
        Sisipkan node baru SETELAH node pada posisi 'index' (berbasis-nol).

        Algoritma:
            1. Validasi index.
            2. Kasus khusus: index == size-1 berarti insert setelah tail
               (delegasikan ke insert_at_end).
            3. Traversal ke node pada posisi 'index'.
            4. Sambungkan new_node ke penerus current, lalu
               sambungkan current ke new_node.
            5. Tambah size.

        Kompleksitas Waktu : O(n) — traversal ke posisi index
        Kompleksitas Ruang : O(1)

        Raises:
            IndexError: Jika index di luar rentang [0, size-1]
        """
        if index < 0 or index >= self.size:
            raise IndexError(
                f"Indeks {index} di luar batas. Ukuran list: {self.size}"
            )
        if index == self.size - 1:
            self.insert_at_end(data)
            return

        new_node = Node(data)
        current = self.head
        for _ in range(index):            # traversal ke posisi index
            current = current.next

        # URUTAN BERIKUT TIDAK BOLEH DITUKAR:
        new_node.next = current.next      # 1. sambungkan new_node ke penerus
        current.next = new_node           # 2. sambungkan current ke new_node
        self.size += 1

    # ------------------------------------------------------------------ #
    #  OPERASI DELETE                                                      #
    # ------------------------------------------------------------------ #

    def delete_at_beginning(self):
        """
        Hapus node di awal list dan kembalikan nilainya.

        Algoritma:
            1. Cek list tidak kosong.
            2. Simpan data node head.
            3. Jika hanya 1 node, reset head dan tail ke None.
            4. Jika lebih, majukan head ke head.next.
            5. Kurangi size, kembalikan data yang dihapus.

        Kompleksitas Waktu : O(1)
        Kompleksitas Ruang : O(1)

        Raises:
            IndexError: Jika list kosong
        """
        if self.is_empty():
            raise IndexError("Tidak dapat menghapus dari list kosong")

        removed_data = self.head.data
        if self.size == 1:
            self.head = None
            self.tail = None
        else:
            self.head = self.head.next    # maju head ke node berikutnya
        self.size -= 1
        return removed_data

    def delete_at_end(self):
        """
        Hapus node di akhir list dan kembalikan nilainya.

        Algoritma:
            1. Cek list tidak kosong.
            2. Jika hanya 1 node, reset head dan tail ke None.
            3. Jika lebih, traversal untuk menemukan predecessor tail.
            4. Putus tautan, perbarui tail ke predecessor.
            5. Kurangi size, kembalikan data yang dihapus.

        Kompleksitas Waktu : O(n) — traversal untuk menemukan predecessor tail
        Kompleksitas Ruang : O(1)

        Catatan:
            Meskipun tail tersimpan eksplisit, singly linked list tidak dapat
            mengakses predecessor secara langsung. Traversal O(n) tidak
            dapat dihindari.

        Raises:
            IndexError: Jika list kosong
        """
        if self.is_empty():
            raise IndexError("Tidak dapat menghapus dari list kosong")

        removed_data = self.tail.data
        if self.size == 1:
            self.head = None
            self.tail = None
        else:
            # Traversal untuk menemukan node sebelum tail
            current = self.head
            while current.next != self.tail:
                current = current.next
            # current kini adalah predecessor tail
            current.next = None           # putus tautan ke tail lama
            self.tail = current           # perbarui tail ke current
        self.size -= 1
        return removed_data

    def delete_by_value(self, target):
        """
        Hapus kemunculan PERTAMA node yang bernilai 'target'.

        Algoritma:
            1. Cek list tidak kosong.
            2. Kasus khusus: jika target ada di head, delegasi ke
               delete_at_beginning.
            3. Gunakan two-pointer technique (prev dan current).
            4. Saat target ditemukan: prev.next = current.next.
            5. Jika yang dihapus adalah tail, perbarui tail ke prev.
            6. Kurangi size, kembalikan True.
            7. Jika tidak ditemukan, kembalikan False.

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(1)
        """
        if self.is_empty():
            return False

        # Kasus khusus: target ada di head
        if self.head.data == target:
            self.delete_at_beginning()
            return True

        # Two-pointer traversal
        prev = self.head
        current = self.head.next
        while current is not None:
            if current.data == target:
                prev.next = current.next    # lompati node target
                if current == self.tail:
                    self.tail = prev        # perbarui tail jika perlu
                self.size -= 1
                return True
            prev = current
            current = current.next

        return False    # target tidak ditemukan dalam list

    # ------------------------------------------------------------------ #
    #  OPERASI PENCARIAN DAN AKSES                                         #
    # ------------------------------------------------------------------ #

    def search(self, target):
        """
        Cari nilai target secara sekuensial dari head.
        Kembalikan indeks pertama yang cocok, atau -1 jika tidak ada.

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(1)
        """
        current = self.head
        index = 0
        while current is not None:
            if current.data == target:
                return index
            current = current.next
            index += 1
        return -1

    def get_at(self, index):
        """
        Kembalikan data pada posisi 'index' (berbasis-nol).

        Kompleksitas Waktu : O(n) — tidak ada random access
        Kompleksitas Ruang : O(1)

        Raises:
            IndexError: Jika index di luar rentang [0, size-1]
        """
        if index < 0 or index >= self.size:
            raise IndexError(
                f"Indeks {index} di luar batas. Ukuran list: {self.size}"
            )
        current = self.head
        for _ in range(index):
            current = current.next
        return current.data

    # ------------------------------------------------------------------ #
    #  OPERASI TRAVERSAL DAN UTILITAS                                      #
    # ------------------------------------------------------------------ #

    def traverse(self):
        """
        Cetak seluruh elemen dari head ke tail.

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(1) variabel pointer; O(n) untuk string output
        """
        if self.is_empty():
            print("List kosong")
            return
        elements = []
        current = self.head
        while current is not None:
            elements.append(str(current.data))
            current = current.next
        print(" -> ".join(elements) + " -> None")

    def to_list(self):
        """
        Konversi ke Python list standar untuk interoperabilitas.

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(n)
        """
        result = []
        current = self.head
        while current is not None:
            result.append(current.data)
            current = current.next
        return result

    def is_empty(self):
        """Periksa apakah list kosong. Kompleksitas O(1)."""
        return self.head is None

    def __len__(self):
        """Dukung fungsi len() bawaan Python. Kompleksitas O(1)."""
        return self.size

    def __repr__(self):
        """Representasi string untuk debugging."""
        return f"SinglyLinkedList({self.to_list()})"
```

### 4.7.1 Demonstrasi Penggunaan Lengkap

Program berikut mendemonstrasikan seluruh operasi yang tersedia pada implementasi di atas secara berurutan dan terverifikasi:

```python
if __name__ == "__main__":
    ll = SinglyLinkedList()

    # --- INSERT ---
    print("=== INSERT DI AKHIR ===")
    for nilai in [10, 20, 30, 40]:
        ll.insert_at_end(nilai)
    ll.traverse()
    # Output: 10 -> 20 -> 30 -> 40 -> None
    print(f"Ukuran: {len(ll)}\n")    # Ukuran: 4

    print("=== INSERT DI AWAL ===")
    ll.insert_at_beginning(5)
    ll.traverse()
    # Output: 5 -> 10 -> 20 -> 30 -> 40 -> None
    print(f"Ukuran: {len(ll)}\n")    # Ukuran: 5

    print("=== INSERT SETELAH INDEKS 2 ===")
    ll.insert_after_index(2, 25)
    ll.traverse()
    # Output: 5 -> 10 -> 20 -> 25 -> 30 -> 40 -> None
    print(f"Ukuran: {len(ll)}\n")    # Ukuran: 6

    # --- SEARCH ---
    print("=== PENCARIAN ===")
    print(f"search(25) = indeks {ll.search(25)}")   # 3
    print(f"search(99) = indeks {ll.search(99)}\n") # -1

    # --- DELETE ---
    print("=== DELETE DI AWAL ===")
    dihapus = ll.delete_at_beginning()
    print(f"Dihapus: {dihapus}")
    ll.traverse()
    # Output: 10 -> 20 -> 25 -> 30 -> 40 -> None

    print("\n=== DELETE DI AKHIR ===")
    dihapus = ll.delete_at_end()
    print(f"Dihapus: {dihapus}")
    ll.traverse()
    # Output: 10 -> 20 -> 25 -> 30 -> None

    print("\n=== DELETE BERDASARKAN NILAI (hapus 25) ===")
    hasil = ll.delete_by_value(25)
    print(f"Berhasil: {hasil}")
    ll.traverse()
    # Output: 10 -> 20 -> 30 -> None

    print("\n=== AKSES BERDASARKAN INDEKS ===")
    print(f"Elemen di indeks 1: {ll.get_at(1)}")    # 20
```

---

## 4.8 Perbandingan Komprehensif: Array vs. Singly Linked List

Salah satu keputusan desain terpenting dalam pemrograman adalah memilih struktur data yang tepat untuk permasalahan yang dihadapi. Perbandingan antara array dan singly linked list tidak bersifat "mana yang lebih baik secara mutlak", melainkan bergantung pada pola operasi dominan dalam aplikasi yang sedang dibangun.

### Tabel 4.1 — Perbandingan Kompleksitas Operasi

| Operasi | Array (Python list) | Singly Linked List | Penjelasan Perbedaan |
|---|---|---|---|
| Akses berdasarkan indeks | **O(1)** | O(n) | Array: formula langsung. SLL: traversal dari head. |
| Insert di awal | O(n) | **O(1)** | Array: geser semua elemen. SLL: perbarui pointer head. |
| Insert di akhir | O(1) amortized | **O(1)*** | Array: append. SLL: O(1) dengan referensi tail eksplisit. |
| Insert di tengah (indeks i) | O(n) | O(n) | Sama-sama O(n), tetapi alasan berbeda: array karena pergeseran, SLL karena traversal. |
| Delete di awal | O(n) | **O(1)** | Array: geser seluruh elemen ke kiri. SLL: majukan head. |
| Delete di akhir | **O(1)** | O(n) | Array: hapus langsung. SLL: traversal untuk menemukan predecessor tail. |
| Delete di tengah | O(n) | O(n) | Sama-sama O(n). |
| Pencarian linear | O(n) | O(n) | Sama-sama O(n), tetapi array lebih cepat dalam praktik karena cache locality. |
| Pencarian biner | O(log n) | Tidak berlaku | SLL tidak mendukung akses acak yang dibutuhkan binary search. |
| Mengetahui ukuran | **O(1)** | **O(1)** | Python list menyimpan len; SLL menyimpan counter size. |

*) O(1) hanya jika referensi tail disimpan secara eksplisit.

### Tabel 4.2 — Perbandingan Karakteristik Struktural

| Karakteristik | Array (Python list) | Singly Linked List |
|---|---|---|
| Alokasi memori | Kontigu (berdampingan di memori fisik) | Tersebar (dinamis, di lokasi acak) |
| Overhead memori per elemen | Minimal (hanya data) | Lebih tinggi (data + referensi next) |
| Performa cache | Sangat baik (spatial locality tinggi) | Buruk (pointer chasing, cache miss sering) |
| Random access | Didukung, O(1) | Tidak didukung, O(n) |
| Ukuran koleksi | Dinamis dengan amortized resize | Selalu dinamis, tanpa pre-alokasi |
| Traversal dua arah | Didukung (indeks maju dan mundur) | Tidak langsung (hanya maju) |
| Implementasi stack | Baik dengan `append`/`pop` | Natural: insert/delete di head O(1) |
| Implementasi queue | Kurang efisien (insert di depan O(n)) | Ideal: insert tail O(1), delete head O(1) |

> **Catatan Penting 4.5 — Cache Locality dan Performa Nyata**
>
> Dalam analisis kompleksitas asimptotik, beberapa operasi antara array dan linked list menunjukkan kompleksitas O(n) yang sama (misalnya, insert di tengah). Namun dalam praktik, array sering kali jauh lebih cepat secara konkret karena fenomena yang disebut **cache locality** (lokalitas cache). Karena elemen array tersimpan secara berdampingan, ketika prosesor mengakses satu elemen, blok memori di sekitarnya (termasuk elemen-elemen berikutnya) secara otomatis dimuat ke cache. Untuk linked list, setiap akses ke node berikutnya berpotensi menyebabkan **cache miss** — prosesor harus mengambil data dari RAM karena node tersebut mungkin berada jauh di memori. Dampak ini sangat terasa pada data berskala besar.

**Panduan Pemilihan Struktur Data:**

Gunakan **Array** apabila:
- Operasi dominan adalah akses berdasarkan indeks (random access) yang sering.
- Ukuran data relatif stabil dan dapat diestimasi di awal.
- Perlu menerapkan algoritma pencarian biner (binary search) pada data terurut.
- Performa cache merupakan prioritas (pemrosesan data numerik intensif).

Gunakan **Singly Linked List** apabila:
- Operasi dominan adalah penyisipan dan penghapusan di awal atau di posisi tengah yang sering.
- Ukuran data sangat dinamis, fluktuatif, dan tidak dapat diprediksi.
- Membangun struktur data abstrak yang lain: stack, queue, atau deque.
- Fragmentasi memori menjadi kendala (sulit mengalokasikan blok besar yang kontigu).

---

## 4.9 Studi Kasus: Sistem Manajemen Daftar Putar Musik

> **Studi Kasus 4.1 — Music Playlist Manager**
>
> Bayangkan Anda ditugaskan merancang modul manajemen daftar putar (playlist) untuk sebuah aplikasi pemutar musik. Pengguna aplikasi sering melakukan operasi berikut: menambahkan lagu baru di awal playlist (play next), menambahkan lagu di akhir antrian, menyisipkan lagu di posisi tertentu, menghapus lagu yang tidak diinginkan, mencari lagu berdasarkan judul, dan menelusuri seluruh playlist.
>
> Setelah menganalisis pola operasi tersebut, tim pengembang memutuskan bahwa singly linked list adalah struktur data yang paling tepat untuk inti playlist, karena operasi insert dan delete (terutama di awal dan akhir) jauh lebih sering terjadi daripada akses berdasarkan indeks.

Implementasi berikut membangun sebuah `PlaylistManager` yang lengkap berbasis singly linked list:

```python
class Song:
    """
    Merepresentasikan satu lagu dalam daftar putar.

    Atribut:
        title  (str)   : judul lagu
        artist (str)   : nama artis/penyanyi
        duration (int) : durasi lagu dalam detik
        next   (Song)  : referensi ke lagu berikutnya dalam playlist
    """

    def __init__(self, title: str, artist: str, duration: int):
        """
        Inisialisasi objek lagu.

        Parameter:
            title    : judul lagu
            artist   : nama artis
            duration : durasi dalam detik (misalnya 210 untuk 3 menit 30 detik)
        """
        self.title = title
        self.artist = artist
        self.duration = duration
        self.next = None   # pointer ke lagu berikutnya dalam playlist

    def __repr__(self):
        menit, detik = divmod(self.duration, 60)
        return f'"{self.title}" - {self.artist} ({menit}:{detik:02d})'


class PlaylistManager:
    """
    Manajer daftar putar musik berbasis singly linked list.

    Mendukung semua operasi pengelolaan playlist yang umum dibutuhkan
    oleh aplikasi pemutar musik modern.

    Atribut:
        name  (str)  : nama playlist
        head  (Song) : referensi ke lagu pertama (sedang diputar)
        tail  (Song) : referensi ke lagu terakhir dalam antrian
        size  (int)  : jumlah lagu dalam playlist
    """

    def __init__(self, name: str):
        """
        Inisialisasi playlist baru yang kosong.

        Parameter:
            name : nama/judul playlist
        """
        self.name = name
        self.head = None
        self.tail = None
        self.size = 0

    def add_to_queue(self, title: str, artist: str, duration: int):
        """
        Tambahkan lagu ke AKHIR antrian putar (append).
        Digunakan ketika pengguna menambahkan lagu ke antrian biasa.

        Kompleksitas Waktu : O(1)
        Kompleksitas Ruang : O(1)
        """
        lagu_baru = Song(title, artist, duration)
        if self.head is None:
            self.head = lagu_baru
            self.tail = lagu_baru
        else:
            self.tail.next = lagu_baru
            self.tail = lagu_baru
        self.size += 1
        print(f"Ditambahkan ke antrian: {lagu_baru}")

    def play_next(self, title: str, artist: str, duration: int):
        """
        Sisipkan lagu ke AWAL antrian (prepend).
        Digunakan ketika pengguna memilih "Putar Berikutnya" (Play Next).

        Kompleksitas Waktu : O(1)
        Kompleksitas Ruang : O(1)
        """
        lagu_baru = Song(title, artist, duration)
        if self.head is None:
            self.head = lagu_baru
            self.tail = lagu_baru
        else:
            lagu_baru.next = self.head
            self.head = lagu_baru
        self.size += 1
        print(f"Dijadwalkan berikutnya: {lagu_baru}")

    def insert_at_position(self, pos: int,
                           title: str, artist: str, duration: int):
        """
        Sisipkan lagu pada posisi tertentu dalam playlist.

        Parameter:
            pos      : posisi penyisipan (0 = sebelum lagu pertama,
                       size = setelah lagu terakhir)
            title    : judul lagu
            artist   : nama artis
            duration : durasi dalam detik

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(1)
        """
        if pos < 0 or pos > self.size:
            raise IndexError(
                f"Posisi {pos} tidak valid. Playlist memiliki {self.size} lagu."
            )
        lagu_baru = Song(title, artist, duration)

        if pos == 0:
            self.play_next(title, artist, duration)
            return
        if pos == self.size:
            self.add_to_queue(title, artist, duration)
            return

        current = self.head
        for _ in range(pos - 1):
            current = current.next
        lagu_baru.next = current.next
        current.next = lagu_baru
        self.size += 1
        print(f"Disisipkan di posisi {pos}: {lagu_baru}")

    def skip_current(self):
        """
        Lewati (skip) lagu yang sedang diputar (hapus dari awal).

        Kompleksitas Waktu : O(1)
        Kompleksitas Ruang : O(1)

        Raises:
            IndexError: Jika playlist kosong
        """
        if self.head is None:
            raise IndexError("Playlist kosong, tidak ada lagu untuk dilewati.")

        lagu_dilewati = self.head
        if self.size == 1:
            self.head = None
            self.tail = None
        else:
            self.head = self.head.next
        self.size -= 1
        print(f"Dilewati: {lagu_dilewati}")
        if self.head:
            print(f"Sekarang memutar: {self.head}")

    def remove_song(self, title: str) -> bool:
        """
        Hapus lagu pertama dengan judul yang cocok dari playlist.

        Parameter:
            title : judul lagu yang akan dihapus

        Kembalikan True jika berhasil dihapus, False jika tidak ditemukan.

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(1)
        """
        if self.head is None:
            return False

        # Kasus: lagu ada di head
        if self.head.title.lower() == title.lower():
            print(f"Dihapus dari playlist: {self.head}")
            if self.size == 1:
                self.head = None
                self.tail = None
            else:
                self.head = self.head.next
            self.size -= 1
            return True

        # Traversal dengan two-pointer
        prev = self.head
        current = self.head.next
        while current is not None:
            if current.title.lower() == title.lower():
                prev.next = current.next
                if current == self.tail:
                    self.tail = prev
                self.size -= 1
                print(f"Dihapus dari playlist: {current}")
                return True
            prev = current
            current = current.next

        print(f"Lagu '{title}' tidak ditemukan dalam playlist.")
        return False

    def find_song(self, title: str):
        """
        Cari lagu berdasarkan judul (pencarian tidak peka huruf besar/kecil).

        Parameter:
            title : judul lagu yang dicari

        Kembalikan tuple (posisi, objek Song) jika ditemukan, atau None.

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(1)
        """
        current = self.head
        posisi = 0
        while current is not None:
            if current.title.lower() == title.lower():
                return (posisi, current)
            current = current.next
            posisi += 1
        return None

    def total_duration(self) -> int:
        """
        Hitung total durasi seluruh lagu dalam playlist (dalam detik).

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(1)
        """
        total = 0
        current = self.head
        while current is not None:
            total += current.duration
            current = current.next
        return total

    def display_playlist(self):
        """
        Tampilkan seluruh playlist dalam format yang mudah dibaca.

        Kompleksitas Waktu : O(n)
        Kompleksitas Ruang : O(1)
        """
        print(f"\n{'='*55}")
        print(f"  PLAYLIST: {self.name}")
        print(f"  Jumlah lagu: {self.size}")
        total = self.total_duration()
        jam, sisa = divmod(total, 3600)
        menit, detik = divmod(sisa, 60)
        print(f"  Total durasi: {jam}j {menit}m {detik}d")
        print(f"{'='*55}")
        if self.head is None:
            print("  (Playlist kosong)")
        else:
            current = self.head
            nomor = 1
            while current is not None:
                indikator = " [SEDANG DIPUTAR]" if nomor == 1 else ""
                print(f"  {nomor:2d}. {current}{indikator}")
                current = current.next
                nomor += 1
        print(f"{'='*55}\n")


# -----------------------------------------------------------------------
# DEMONSTRASI PENGGUNAAN PlaylistManager
# -----------------------------------------------------------------------

if __name__ == "__main__":
    # Buat playlist baru
    playlist = PlaylistManager("Belajar Sambil Ngoding")

    # Tambahkan lagu ke antrian
    playlist.add_to_queue("Bohemian Rhapsody", "Queen", 354)
    playlist.add_to_queue("Hotel California", "Eagles", 391)
    playlist.add_to_queue("Stairway to Heaven", "Led Zeppelin", 482)
    playlist.add_to_queue("Yesterday", "The Beatles", 125)

    playlist.display_playlist()

    # Sisipkan lagu untuk diputar berikutnya
    playlist.play_next("Imagine", "John Lennon", 187)

    # Sisipkan lagu di posisi tertentu
    playlist.insert_at_position(2, "Let It Be", "The Beatles", 243)

    playlist.display_playlist()

    # Cari lagu
    hasil = playlist.find_song("Hotel California")
    if hasil:
        posisi, lagu = hasil
        print(f"Ditemukan di posisi {posisi}: {lagu}\n")

    # Lewati lagu yang sedang diputar
    playlist.skip_current()

    # Hapus lagu tertentu
    playlist.remove_song("Yesterday")

    playlist.display_playlist()
```

Output yang diharapkan dari program di atas (sebagian):

```
=======================================================
  PLAYLIST: Belajar Sambil Ngoding
  Jumlah lagu: 4
  Total durasi: 0j 22m 12d
=======================================================
   1. "Bohemian Rhapsody" - Queen (5:54) [SEDANG DIPUTAR]
   2. "Hotel California" - Eagles (6:31)
   3. "Stairway to Heaven" - Led Zeppelin (8:02)
   4. "Yesterday" - The Beatles (2:05)
=======================================================
```

> **Tahukah Anda? 4.2**
>
> Konsep linked list dalam aplikasi nyata jauh lebih luas dari sekadar playlist musik. Sistem operasi menggunakan linked list untuk mengelola daftar proses yang sedang berjalan (process queue), antrian memori yang bebas (free memory list), dan daftar interupsi perangkat keras. Browser web menggunakan variasi doubly linked list untuk mengimplementasikan fungsi tombol Back dan Forward. Bahkan di tingkat hardware, memori virtual (virtual memory) modern memanfaatkan konsep rantai halaman (page chain) yang secara konseptual mirip dengan linked list.

---

## 4.10 Algoritma Lanjutan: Pembalikan Singly Linked List

Salah satu algoritma klasik pada singly linked list yang sering muncul dalam wawancara teknis dan sebagai soal latihan pemrograman kompetitif adalah **pembalikan linked list** (list reversal). Algoritma ini membalik urutan seluruh elemen secara in-place (tanpa membuat node baru) dengan teknik tiga-pointer.

Ide intinya: untuk membalik arah setiap tautan, kita perlu memelihara tiga pointer secara bersamaan — `prev` (node sebelumnya), `current` (node yang sedang diproses), dan `next_node` (node berikutnya yang akan diproses setelah kita memutus tautan `current.next`).

```python
def reverse_linked_list(ll):
    """
    Balik urutan elemen dalam singly linked list secara in-place.
    Tidak membuat node baru; hanya memanipulasi pointer yang sudah ada.

    Parameter:
        ll (SinglyLinkedList) : linked list yang akan dibalik

    Kompleksitas Waktu : O(n) — satu kali traversal penuh
    Kompleksitas Ruang : O(1) — hanya tiga variabel pointer tambahan
    """
    prev = None
    current = ll.head
    ll.tail = ll.head    # head lama akan menjadi tail baru setelah dibalik

    while current is not None:
        next_node = current.next    # simpan node berikutnya sebelum diputus
        current.next = prev         # balik arah tautan (menunjuk ke belakang)
        prev = current              # majukan prev
        current = next_node         # majukan current ke node berikutnya

    ll.head = prev    # prev kini menunjuk ke node yang dulunya terakhir
```

Trace manual algoritma pembalikan untuk list [1, 2, 3] diilustrasikan berikut:

```
Gambar 4.11 — Trace Algoritma Pembalikan Linked List [1, 2, 3]

INISIALISASI:
prev = None, current = Node(1), ll.tail = Node(1) (head lama)

List saat ini:  1 -> 2 -> 3 -> None

---ITERASI 1---
next_node = Node(2)          (simpan penerus)
current.next = prev = None   (balik: Node(1) -> None)
prev = Node(1)               (majukan prev)
current = Node(2)            (majukan current)

Kondisi rantai: None <- 1    2 -> 3 -> None
                prev          current

---ITERASI 2---
next_node = Node(3)          (simpan penerus)
current.next = prev = Node(1)(balik: Node(2) -> Node(1))
prev = Node(2)               (majukan prev)
current = Node(3)            (majukan current)

Kondisi rantai: None <- 1 <- 2    3 -> None
                              prev  current

---ITERASI 3---
next_node = None             (simpan penerus, sudah None)
current.next = prev = Node(2)(balik: Node(3) -> Node(2))
prev = Node(3)               (majukan prev)
current = None               (majukan current)

Kondisi rantai: None <- 1 <- 2 <- 3
                                   prev    current=None

---LOOP BERHENTI (current = None)---
ll.head = prev = Node(3)

HASIL: 3 -> 2 -> 1 -> None
```

---

## Rangkuman Bab

1. **Node** adalah unit penyusun terkecil singly linked list, terdiri dari dua komponen: field data yang menyimpan nilai dan field next yang menyimpan referensi ke node berikutnya. Node terakhir selalu memiliki `next = None` sebagai penanda akhir rantai. Dalam Python, node diimplementasikan sebagai objek kelas dengan dua atribut tersebut.

2. **Singly linked list** adalah koleksi node yang terhubung secara linear dan satu arah melalui rantai referensi. Tiga komponen struktural yang wajib dipelihara adalah `head` (pintu masuk ke list), `tail` (referensi ke node terakhir untuk efisiensi append), dan `size` (counter jumlah elemen untuk kueri O(1)). Alokasi memorinya bersifat dinamis dan tersebar, berbeda dengan array yang kontigu.

3. **Operasi insert di awal dan di akhir** sama-sama dapat diselesaikan dalam O(1): insert di awal hanya membutuhkan pembaruan pointer head, sementara insert di akhir memanfaatkan referensi tail eksplisit. Insert di posisi tengah membutuhkan traversal O(n) untuk menemukan node pendahulu posisi target, diikuti manipulasi dua pointer yang O(1).

4. **Operasi delete menunjukkan asimetri karakteristik** singly linked list: delete di awal adalah O(1) karena head dapat diakses langsung, tetapi delete di akhir adalah O(n) karena membutuhkan traversal untuk menemukan predecessor tail — keterbatasan yang tidak dapat dieliminasi selama pointer hanya satu arah. Delete berdasarkan nilai menggunakan teknik two-pointer (prev dan current) dengan kompleksitas O(n).

5. **Tidak ada random access** dalam singly linked list. Pencarian berdasarkan nilai maupun akses berdasarkan indeks selalu membutuhkan traversal dari head, dengan kompleksitas O(n). Ini berbanding terbalik dengan array yang menjamin O(1) untuk akses indeks mana pun, dan menjadi penyebab utama mengapa pencarian biner tidak berlaku untuk linked list.

6. **Perbandingan dengan array** menghasilkan gambaran bahwa tidak ada satu pun struktur data yang unggul di semua dimensi. Array unggul dalam akses acak, pencarian biner, dan performa cache karena lokalitas memori. Singly linked list unggul dalam insert/delete di awal (O(1) vs. O(n) array), ukuran yang benar-benar dinamis tanpa biaya resize, dan sebagai fondasi alami untuk stack, queue, dan deque.

7. **Singly linked list merupakan fondasi** untuk berbagai struktur data yang lebih kompleks: doubly linked list, circular linked list, stack berbasis linked list, queue FIFO, serta digunakan secara internal dalam implementasi pohon (tree) dan graf (graph) berbasis adjacency list.

---

## Istilah Kunci

| Istilah | Definisi |
|---|---|
| **Node** | Unit terkecil linked list; objek yang mengandung field data dan field next (pointer). |
| **Pointer / Referensi** | Nilai yang menyimpan alamat memori atau referensi ke objek lain. Field next pada node adalah pointer ke node berikutnya. |
| **Singly Linked List** | Struktur data linear di mana setiap node memiliki tepat satu pointer, yang menunjuk ke node berikutnya. |
| **Head** | Referensi ke node pertama dalam linked list; satu-satunya pintu masuk ke dalam list. |
| **Tail** | Referensi ke node terakhir dalam linked list; ditandai oleh `next = None`. |
| **Alokasi Memori Dinamis** | Strategi alokasi memori di mana memori untuk setiap elemen diminta secara terpisah pada saat runtime, bukan semua sekaligus di awal. |
| **Alokasi Memori Statis/Kontigu** | Strategi alokasi memori di mana seluruh blok memori untuk semua elemen diminta sekaligus dan harus berdampingan (seperti pada array). |
| **Traversal** | Operasi mengunjungi setiap node dalam linked list secara berurutan dari head hingga tail. |
| **Prepend** | Operasi menyisipkan elemen baru di awal linked list; kompleksitas O(1). |
| **Append** | Operasi menyisipkan elemen baru di akhir linked list; kompleksitas O(1) dengan referensi tail. |
| **Two-Pointer Technique** | Teknik menggunakan dua variabel pointer (misalnya `prev` dan `current`) yang bergerak bersamaan selama traversal, digunakan pada delete berdasarkan nilai. |
| **Predecessor (Node Pendahulu)** | Node yang field next-nya menunjuk ke node target; diperlukan untuk operasi delete dan insert di posisi tertentu. |
| **Garbage Collector** | Komponen runtime Python yang secara otomatis membebaskan memori dari objek yang tidak lagi memiliki referensi. |
| **Cache Locality / Spatial Locality** | Properti array di mana elemen-elemen yang berdampingan di memori cenderung dimuat bersama ke cache prosesor, meningkatkan performa akses sekuensial. |
| **Cache Miss** | Kondisi di mana data yang dibutuhkan prosesor tidak ditemukan di cache dan harus diambil dari RAM yang lebih lambat; lebih sering terjadi pada linked list karena node tersebar di memori. |
| **Random Access** | Kemampuan mengakses elemen mana pun secara langsung berdasarkan indeks dalam O(1), tanpa harus melalui elemen lain. Array mendukung ini, linked list tidak. |
| **Sentinel Node / Dummy Node** | Node "palsu" yang diletakkan sebelum head atau sesudah tail untuk menyederhanakan logika kondisi tepi (edge case) pada beberapa algoritma. |
| **In-Place Algorithm** | Algoritma yang bekerja langsung pada struktur data yang diberikan tanpa mengalokasikan memori tambahan yang proporsional dengan ukuran input. |
| **Kompleksitas Amortized** | Kompleksitas rata-rata per operasi dalam serangkaian operasi, digunakan untuk mendeskripsikan performa array yang kadang membutuhkan resize mahal namun jarang. |
| **Enkapsulasi** | Prinsip pemrograman berorientasi objek di mana data (atribut) dan perilaku (metode) dibungkus dalam satu unit (kelas), dengan akses yang dikontrol melalui antarmuka publik. |

---

## Soal Latihan

### Bagian A: Pemahaman Konsep (C2 — C3)

**Soal 1** (C2 — Memahami)

Perhatikan serangkaian operasi berikut pada linked list yang awalnya kosong:
```
insert_at_end(15)
insert_at_end(25)
insert_at_beginning(5)
insert_at_end(35)
insert_after_index(1, 10)
```
Gambarkan dengan diagram ASCII kondisi linked list setelah setiap operasi, termasuk posisi pointer head dan tail. Kemudian tuliskan representasi akhir list.

---

**Soal 2** (C2 — Memahami)

Jelaskan mengapa nilai `None` pada field next node terakhir sangat krusial bagi algoritma traversal. Apa yang akan terjadi (secara logis dan programatik) jika node terakhir tidak memiliki nilai `None` tetapi malah menunjuk kembali ke head? Struktur data apakah yang terbentuk dalam kondisi tersebut?

---

**Soal 3** (C2 — Memahami)

Identifikasi dan jelaskan dua kondisi tepi (edge case) yang harus ditangani dengan hati-hati pada operasi `delete_at_end`. Mengapa kondisi-kondisi tersebut memerlukan penanganan khusus yang berbeda dari kasus umum?

---

**Soal 4** (C3 — Menerapkan)

Diberikan sebuah singly linked list dengan isi [3, 1, 4, 1, 5, 9, 2, 6]. Tanpa menggunakan fungsi bawaan Python seperti `sorted()` atau `list.sort()`, tuliskan langkah-langkah operasi delete dan insert yang diperlukan untuk mengubah list menjadi [1, 1, 2, 3, 4, 5, 6, 9]. Berapa total operasi yang dibutuhkan?

---

**Soal 5** (C3 — Menerapkan)

Implementasikan metode `count_occurrences(self, target)` untuk kelas `SinglyLinkedList` yang menghitung berapa kali nilai `target` muncul dalam list. Sertakan analisis kompleksitas waktu dan ruang, serta setidaknya dua contoh penggunaan beserta output yang diharapkan.

---

### Bagian B: Analisis dan Evaluasi (C4 — C5)

**Soal 6** (C4 — Menganalisis)

Analisis perbedaan konkret antara kompleksitas O(n) pada "insert di tengah array" dan O(n) pada "insert di tengah singly linked list". Meskipun notasi asimptotiknya sama, apakah operasi yang dilakukan secara fisik berbeda? Jelaskan implikasinya terhadap performa aktual pada hardware modern yang memiliki mekanisme caching.

---

**Soal 7** (C4 — Menganalisis)

Telusuri (trace) secara manual eksekusi kode berikut langkah demi langkah, tunjukkan kondisi setiap pointer (head, tail, current, prev) setelah setiap baris dieksekusi:

```python
ll = SinglyLinkedList()
ll.insert_at_end(100)
ll.insert_at_end(200)
ll.insert_at_end(300)
ll.delete_at_beginning()
ll.insert_at_beginning(50)
ll.delete_by_value(200)
```

Apa isi akhir dari linked list? Apa nilai `head.data` dan `tail.data`?

---

**Soal 8** (C4 — Menganalisis)

Implementasikan sebuah fungsi `find_middle(ll)` yang menemukan node di tengah sebuah singly linked list dalam satu kali traversal (single pass, O(n) waktu, O(1) ruang tambahan). Petunjuk: gunakan teknik "slow and fast pointer" di mana satu pointer bergerak satu langkah per iterasi dan pointer lain bergerak dua langkah per iterasi. Jelaskan mengapa teknik ini bekerja secara matematis.

---

**Soal 9** (C5 — Mengevaluasi)

Evaluasi tiga skenario implementasi berikut untuk sebuah sistem antrian tiket bioskop (FIFO — First In First Out):

- **Skenario A**: Menggunakan Python list (array) dengan `append()` untuk enqueue dan `pop(0)` untuk dequeue.
- **Skenario B**: Menggunakan SinglyLinkedList dengan `insert_at_end()` untuk enqueue dan `delete_at_beginning()` untuk dequeue.
- **Skenario C**: Menggunakan Python `collections.deque`.

Bandingkan ketiga skenario dari sudut pandang kompleksitas waktu tiap operasi, penggunaan memori, dan kemudahan implementasi. Skenario mana yang Anda rekomendasikan dan mengapa?

---

**Soal 10** (C5 — Mengevaluasi)

Perhatikan pernyataan berikut: "Menyimpan referensi tail dalam singly linked list selalu merupakan keputusan desain yang baik karena hanya menambahkan satu variabel referensi namun meningkatkan kinerja operasi append dari O(n) menjadi O(1)."

Evaluasi pernyataan ini. Apakah Anda setuju sepenuhnya? Adakah situasi atau trade-off di mana menyimpan referensi tail justru menambah kompleksitas yang tidak perlu? Berikan argumen yang berimbang.

---

### Bagian C: Sintesis dan Kreasi (C6)

**Soal 11** (C6 — Mencipta)

Rancang dan implementasikan kelas `SortedLinkedList` — sebuah varian singly linked list yang selalu mempertahankan elemen-elemennya dalam urutan menaik (ascending order). Kelas ini hanya memiliki satu metode insert, yaitu `insert(data)`, yang secara otomatis menempatkan elemen baru pada posisi yang benar. Sertakan:
1. Implementasi lengkap dengan docstring.
2. Analisis kompleksitas waktu untuk operasi insert dalam kasus terbaik, rata-rata, dan terburuk.
3. Contoh penggunaan dengan setidaknya 5 operasi insert.
4. Diskusi: apakah struktur ini cocok untuk digunakan sebagai priority queue?

---

**Soal 12** (C6 — Mencipta)

Rancanglah sebuah sistem "Undo-Redo" sederhana untuk aplikasi text editor menggunakan singly linked list. Sistem harus mendukung operasi:
- `do(action)`: lakukan sebuah aksi dan simpan ke riwayat.
- `undo()`: batalkan aksi terakhir (kembali ke kondisi sebelumnya).
- `redo()`: lakukan ulang aksi yang baru saja dibatalkan.
- `show_history()`: tampilkan riwayat aksi.

Implementasikan sistem ini menggunakan satu atau dua singly linked list sebagai struktur penyimpanan utama. Sertakan penjelasan desain dan analisis kompleksitas setiap operasi.

---

## Bacaan Lanjutan dan Referensi

1. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013).** *Data Structures and Algorithms in Python*. John Wiley & Sons.

   Bab 3 "Linked Lists" (hal. 122–175) merupakan referensi utama yang sangat dianjurkan. Buku ini menyajikan implementasi singly linked list, doubly linked list, dan circular list dalam Python dengan pendekatan yang ketat secara akademis. Analisis kompleksitas disajikan secara formal dan lengkap dengan bukti. Bab 6 juga relevan karena menunjukkan bagaimana linked list digunakan untuk mengimplementasikan stack dan queue.

2. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022).** *Introduction to Algorithms* (4th ed.). MIT Press.

   Bab 10.2 "Linked Lists" (hal. 258–265) memberikan analisis formal pseudocode operasi dasar linked list menggunakan notasi algoritmik standar. Bab ini juga memperkenalkan konsep **sentinel node** — teknik untuk menyederhanakan penanganan kondisi tepi yang sangat berguna dalam implementasi praktis. Cocok sebagai referensi ketika mahasiswa ingin memahami linked list dari perspektif teori algoritma formal.

3. **Sedgewick, R., & Wayne, K. (2011).** *Algorithms* (4th ed.). Addison-Wesley Professional.

   Bab 1.3 "Bags, Queues, and Stacks" (hal. 120–162) mendemonstrasikan bagaimana linked list digunakan sebagai fondasi implementasi struktur data bag, stack, dan queue dengan analisis amortized complexity yang mendalam. Pendekatan Sedgewick sangat pragmatis dan berorientasi pada penerapan nyata, dengan visualisasi yang excellent.

4. **Skiena, S. S. (2020).** *The Algorithm Design Manual* (3rd ed.). Springer.

   Bab 3.1 "Contiguous vs. Linked Data Structures" (hal. 69–80) memberikan perspektif yang berbeda dan sangat berharga: analisis trade-off antara struktur kontigu (array) dan linked (linked list) dari sudut pandang desain algoritma, performa cache memori modern, dan pengalaman praktis. Skiena sering memilih array atas linked list dalam implementasi nyata karena alasan cache locality — sebuah perspektif kontra-intuitif yang penting untuk diketahui.

5. **Miller, B. N., & Ranum, D. L. (2013).** *Problem Solving with Algorithms and Data Structures Using Python* (2nd ed.). Franklin, Beedle & Associates.

   Bab 3 "Basic Data Structures" (hal. 89–142) adalah buku teks Python-sentris dengan visualisasi interaktif yang tersedia secara daring. Cocok sebagai bahan belajar mandiri karena penjelasannya sangat accessible dan dilengkapi dengan latihan soal yang bertahap. Tersedia versi daring gratis di runestone.academy.

6. **Weiss, M. A. (2013).** *Data Structures and Algorithm Analysis in Java* (3rd ed.). Pearson Education.

   Meskipun menggunakan Java, Bab 3 "Lists, Stacks, and Queues" (hal. 63–110) memberikan perspektif yang sangat berguna tentang linked list sebagai Abstract Data Type (ADT). Diskusi tentang perbedaan antara antarmuka (interface) dan implementasi sangat relevan untuk memahami prinsip enkapsulasi dalam desain struktur data.

7. **Knuth, D. E. (1997).** *The Art of Computer Programming, Volume 1: Fundamental Algorithms* (3rd ed.). Addison-Wesley Professional.

   Bagian 2.2 "Linear Lists" adalah karya seminal yang memperkenalkan linked list secara formal kepada dunia ilmu komputer. Meski notasinya menggunakan bahasa assembly MIX yang sudah sangat tua, bab ini merupakan bacaan historis yang penting untuk memahami asal-usul dan motivasi awal dari struktur data linked list. Cocok untuk mahasiswa yang ingin mendalami fondasi teoritis ilmu komputer.

8. **Heineman, G. T., Pollice, G., & Selkow, S. (2016).** *Algorithms in a Nutshell* (2nd ed.). O'Reilly Media.

   Bab 2 "The Mathematics of Algorithms" dan Bab 3 "Sorting Algorithms" memberikan konteks tentang bagaimana kompleksitas operasi linked list berinteraksi dengan algoritma pengurutan. Buku ini sangat berguna sebagai referensi cepat dengan perbandingan implementasi dalam berbagai bahasa pemrograman.

---

*Bab ini merupakan bagian dari buku "Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python", yang disusun sebagai buku teks resmi Mata Kuliah Struktur Data, Program Studi Teknik Informatika, Institut Teknologi dan Bisnis STIKOM Bali (INSTIKI). Materi bab ini terintegrasi dengan Capaian Pembelajaran Mata Kuliah (CPMK-3) sesuai Rencana Pembelajaran Semester yang berlaku.*

*Penyusunan: April 2026*
