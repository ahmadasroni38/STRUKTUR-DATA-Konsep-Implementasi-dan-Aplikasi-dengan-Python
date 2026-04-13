# BAB 6
# STACK (TUMPUKAN): STRUKTUR DATA LIFO DAN APLIKASINYA

---

> *"Setiap langkah maju dalam komputasi dibangun di atas fondasi yang ditumpuk dengan cermat -- dan fondasi itu harus dilepaskan dalam urutan yang tepat agar sistem dapat kembali ke titik asalnya."*
>
> -- Parafrase dari prinsip kerja call stack dalam ilmu komputer

---

## Tujuan Pembelajaran

Setelah menyelesaikan Bab 6 ini, mahasiswa diharapkan mampu:

1. **Menjelaskan** prinsip Last In First Out (LIFO) sebagai dasar abstraksi stack dan membedakannya dari struktur data linear lainnya (C2 -- Memahami).
2. **Mengidentifikasi** operasi-operasi yang membentuk antarmuka Abstract Data Type (ADT) stack, meliputi push, pop, peek, isEmpty, isFull, dan size, beserta spesifikasi perilaku masing-masing (C2 -- Memahami).
3. **Mengimplementasikan** struktur data stack dalam bahasa Python menggunakan dua pendekatan: berbasis array berkapasitas tetap dan berbasis singly linked list, lengkap dengan penanganan kondisi overflow dan underflow (C3 -- Mengaplikasikan).
4. **Membandingkan** kompleksitas waktu dan ruang kedua pendekatan implementasi stack serta menentukan implementasi yang tepat berdasarkan konteks kebutuhan (C4 -- Menganalisis).
5. **Menerapkan** stack untuk menyelesaikan masalah pengecekan keseimbangan tanda kurung (balanced parentheses) dengan menelusuri langkah eksekusi algoritma secara manual (C3 -- Mengaplikasikan).
6. **Mengimplementasikan** algoritma Shunting-Yard (Dijkstra) untuk mengonversi ekspresi infix ke notasi postfix (Reverse Polish Notation), termasuk penanganan prioritas dan asosiativitas operator (C3 -- Mengaplikasikan).
7. **Merancang** solusi untuk permasalahan komputasi nyata yang memanfaatkan stack, seperti evaluator ekspresi matematika, mekanisme undo/redo, dan navigasi riwayat peramban web (C6 -- Mencipta).
8. **Menganalisis** hubungan antara mekanisme call stack sistem operasi dan konsep rekursi, termasuk implikasi stack overflow pada program rekursif (C4 -- Menganalisis).

---

## 6.1 Pendahuluan: Kesederhanaan yang Bertenaga

Di antara sekian banyak struktur data yang dipelajari dalam ilmu komputer, stack (tumpukan) menempati posisi yang istimewa: ia sederhana dalam konsep namun luar biasa dalam daya jangkau aplikasinya. Tidak ada struktur data lain yang lebih sering digunakan secara implisit oleh sistem komputer setiap kali sebuah baris kode dieksekusi.

Bayangkan situasi yang sangat biasa: seorang mahasiswa sedang menumpuk buku di atas meja. Buku pertama yang diletakkan berada di paling bawah, dan buku terakhir yang diletakkan berada di paling atas. Ketika ingin mengambil buku, buku yang paling atas -- yaitu buku yang paling terakhir diletakkan -- adalah yang pertama dapat diambil. Inilah intisari dari prinsip **Last In First Out (LIFO)**: elemen yang terakhir dimasukkan adalah elemen yang pertama dikeluarkan.

Prinsip LIFO ini, meskipun tampak sepele, menjadi pondasi dari proses-proses komputasi yang sangat fundamental. Ketika sebuah program Python memanggil fungsi, sistem operasi menggunakan stack untuk menyimpan konteks eksekusi -- alamat tempat program harus kembali, variabel lokal, dan parameter -- sehingga setelah fungsi selesai, program dapat melanjutkan dari titik yang tepat. Ketika seorang pengguna menekan Ctrl+Z di editor teks, mekanisme undo yang berbasis stack segera memulihkan keadaan sebelumnya. Ketika sebuah kompiler memproses ekspresi matematika, stack operator memungkinkan evaluasi yang mengikuti aturan prioritas dengan benar.

Bab ini menelusuri stack secara komprehensif: dari definisi formal sebagai Abstract Data Type, dua strategi implementasi yang berbeda (berbasis array dan berbasis linked list), analisis kompleksitas, hingga aplikasi konkret yang mencakup pengecekan keseimbangan tanda kurung dan konversi ekspresi infix ke postfix. Di bagian akhir, studi kasus tentang evaluator ekspresi matematika akan menyatukan semua konsep dalam sebuah implementasi yang terpadu.

---

## 6.2 Konsep Stack sebagai Abstract Data Type

### 6.2.1 Definisi Formal

Dalam ilmu komputer, **Abstract Data Type (ADT)** adalah spesifikasi formal dari sebuah tipe data yang mendefinisikan kumpulan nilai yang mungkin dan operasi yang dapat dilakukan, tanpa menyebutkan bagaimana operasi tersebut diimplementasikan secara konkret. Pendekatan abstraksi ini memisahkan antara "apa yang dapat dilakukan" (antarmuka) dari "bagaimana melakukannya" (implementasi).

**Stack** adalah ADT linear yang mengikuti prinsip LIFO. Secara formal, stack dapat didefinisikan sebagai berikut:

> **Definisi 6.1 (Stack ADT):** Stack adalah struktur data linear yang memungkinkan penambahan dan penghapusan elemen hanya pada satu ujung yang disebut **puncak (top)**. Elemen yang terakhir ditambahkan selalu menjadi elemen pertama yang dihapus.

Antarmuka standar stack terdiri dari operasi-operasi berikut:

| No. | Operasi | Deskripsi | Kondisi Prekondisi |
|-----|---------|-----------|-------------------|
| 1 | `push(e)` | Menambahkan elemen `e` ke puncak stack | Stack tidak penuh |
| 2 | `pop()` | Menghapus dan mengembalikan elemen puncak | Stack tidak kosong |
| 3 | `peek()` | Mengembalikan elemen puncak tanpa menghapusnya | Stack tidak kosong |
| 4 | `is_empty()` | Mengembalikan True jika stack kosong | -- |
| 5 | `is_full()` | Mengembalikan True jika stack penuh | -- |
| 6 | `size()` | Mengembalikan jumlah elemen dalam stack | -- |

**Tabel 6.1** Operasi-operasi pada Stack ADT

Ketika `pop()` dipanggil pada stack kosong, kondisi ini disebut **stack underflow**. Sebaliknya, ketika `push()` dipanggil pada stack yang telah mencapai kapasitas maksimumnya, kondisi ini disebut **stack overflow**. Kedua kondisi ini harus ditangani dengan tepat dalam setiap implementasi.

### 6.2.2 Antarmuka Stack dalam Python

Python mendukung pemrograman berorientasi objek dengan modul `abc` (Abstract Base Classes) yang memungkinkan pendefinisian antarmuka secara eksplisit. Berikut adalah definisi antarmuka stack yang akan menjadi kontrak bagi semua implementasi konkret:

```python
from abc import ABC, abstractmethod

class StackADT(ABC):
    """Abstract Base Class yang mendefinisikan kontrak Stack ADT."""

    @abstractmethod
    def push(self, element):
        """Menambahkan elemen ke bagian atas stack."""
        pass

    @abstractmethod
    def pop(self):
        """Menghapus dan mengembalikan elemen paling atas.
        Melemparkan IndexError jika stack kosong."""
        pass

    @abstractmethod
    def peek(self):
        """Mengembalikan elemen paling atas tanpa menghapusnya.
        Melemparkan IndexError jika stack kosong."""
        pass

    @abstractmethod
    def is_empty(self):
        """Mengembalikan True jika stack kosong, False sebaliknya."""
        pass

    @abstractmethod
    def size(self):
        """Mengembalikan jumlah elemen dalam stack."""
        pass
```

Dengan mendefinisikan `StackADT` sebagai kelas abstrak, Python akan memastikan bahwa setiap kelas turunan wajib mengimplementasikan semua metode yang ditandai `@abstractmethod`. Ini adalah penerapan prinsip **program to an interface, not an implementation** -- salah satu prinsip desain perangkat lunak yang paling fundamental.

---

## 6.3 Visualisasi Operasi Stack

Sebelum membahas implementasi, penting untuk membangun intuisi visual yang kuat tentang bagaimana stack beroperasi. Visualisasi berikut menggambarkan perubahan keadaan stack pada setiap operasi push dan pop.

```
VISUALISASI OPERASI STACK -- PRINSIP LIFO
==========================================

 KONDISI AWAL             Setelah push(10)      Setelah push(20)
 (Stack Kosong)
                           +----------+           +----------+
                           |    10    | <- top    |    20    | <- top
 +---------+               +----------+           +----------+
 | (kosong)| <- top                               |    10    |
 +---------+                                      +----------+

 Setelah push(30)          Setelah pop()          Setelah pop()
                           mengembalikan: 30      mengembalikan: 20
 +----------+
 |    30    | <- top        +----------+           +----------+
 +----------+               |    20    | <- top    |    10    | <- top
 |    20    |               +----------+           +----------+
 +----------+               |    10    |
 |    10    |               +----------+
 +----------+
```

**Gambar 6.1** Visualisasi operasi push dan pop pada stack

Urutan pengeluaran elemen (30, 20, 10) merupakan kebalikan dari urutan pemasukan (10, 20, 30). Inilah manifestasi konkret dari prinsip LIFO.

Diagram berikut memperlihatkan representasi stack dalam memori menggunakan linked list, yang akan dibahas lebih lanjut pada Subbab 6.5:

```
REPRESENTASI STACK BERBASIS LINKED LIST
=========================================

    top
     |
     v
 +------+------+    +------+------+    +------+------+
 |  30  |  o---+--->|  20  |  o---+--->|  10  | None |
 +------+------+    +------+------+    +------+------+
  node terbaru      node tengah         node terlama
  (push terakhir)                       (push pertama)

 Panah menunjukkan referensi "next" dari setiap node.
 Operasi push menambahkan node baru di kiri (head).
 Operasi pop menghapus node paling kiri (head).
```

**Gambar 6.2** Representasi internal stack berbasis linked list

---

## 6.4 Implementasi Stack Berbasis Array

### 6.4.1 Prinsip dan Strategi Implementasi

Pendekatan pertama dalam mengimplementasikan stack adalah dengan menggunakan array (atau list dalam Python) sebagai wadah penyimpanan internal. Ide dasarnya sangat langsung:

- Array digunakan sebagai kontainer berkapasitas tetap atau dinamis.
- **Indeks terakhir** dari array yang terisi merepresentasikan posisi puncak (top) stack.
- Operasi `push` berarti menyimpan nilai baru pada indeks berikutnya setelah puncak, kemudian menaikkan penanda puncak.
- Operasi `pop` berarti mengambil nilai pada indeks puncak, kemudian menurunkan penanda puncak.

Variabel `_top` menyimpan indeks elemen puncak stack. Nilai `_top = -1` menandakan stack kosong, karena tidak ada indeks valid yang bernilai negatif. Ketika elemen pertama di-push, `_top` menjadi 0. Ketika elemen tersebut di-pop, `_top` kembali menjadi -1.

```
RELASI ANTARA INDEKS ARRAY DAN KEADAAN STACK
=============================================

   _data:  [None][None][None][None][None]    _top = -1  (kosong)
              0     1     2     3     4

   _data:  [ 10 ][None][None][None][None]    _top =  0
              0     1     2     3     4
              ^--- top

   _data:  [ 10 ][ 20 ][ 30 ][None][None]   _top =  2
              0     1     2     3     4
                          ^--- top

   _data:  [ 10 ][ 20 ][ 30 ][ 40 ][ 50 ]  _top =  4  (penuh)
              0     1     2     3     4
                                       ^--- top
```

**Gambar 6.3** Relasi antara nilai `_top` dan isi array pada implementasi stack berbasis array berkapasitas 5

### 6.4.2 Implementasi Stack Array dengan Kapasitas Tetap

```python
class StackArray:
    """
    Implementasi Stack menggunakan array (list Python) dengan kapasitas tetap.
    Prinsip: LIFO (Last In First Out)
    Kompleksitas waktu semua operasi: O(1)
    """

    def __init__(self, kapasitas=10):
        """
        Menginisialisasi stack dengan kapasitas maksimum.

        Parameter:
            kapasitas (int): Jumlah maksimum elemen yang dapat disimpan.
        """
        self._data = [None] * kapasitas  # array internal berukuran tetap
        self._top = -1                   # indeks elemen paling atas; -1 = kosong
        self._kapasitas = kapasitas

    def is_empty(self):
        """Mengembalikan True jika stack kosong."""
        return self._top == -1

    def is_full(self):
        """Mengembalikan True jika stack penuh."""
        return self._top == self._kapasitas - 1

    def size(self):
        """Mengembalikan jumlah elemen dalam stack."""
        return self._top + 1

    def push(self, elemen):
        """
        Menambahkan elemen ke bagian atas stack.

        Parameter:
            elemen: Nilai yang akan ditambahkan ke puncak stack.

        Raises:
            OverflowError: Jika stack telah mencapai kapasitas maksimum.
        """
        if self.is_full():
            raise OverflowError("Stack penuh! Tidak dapat melakukan push.")
        self._top += 1
        self._data[self._top] = elemen

    def pop(self):
        """
        Menghapus dan mengembalikan elemen dari puncak stack.

        Returns:
            Nilai elemen yang dihapus dari puncak.

        Raises:
            IndexError: Jika stack kosong (stack underflow).
        """
        if self.is_empty():
            raise IndexError("Stack kosong! Tidak dapat melakukan pop.")
        elemen = self._data[self._top]
        self._data[self._top] = None  # bersihkan referensi untuk garbage collection
        self._top -= 1
        return elemen

    def peek(self):
        """
        Mengembalikan elemen puncak stack tanpa menghapusnya.

        Returns:
            Nilai elemen puncak.

        Raises:
            IndexError: Jika stack kosong.
        """
        if self.is_empty():
            raise IndexError("Stack kosong! Tidak dapat melakukan peek.")
        return self._data[self._top]

    def __str__(self):
        """Representasi string stack dari elemen bawah ke atas."""
        if self.is_empty():
            return "Stack: [ kosong ]"
        isi = self._data[:self._top + 1]
        return f"Stack (bawah -> atas): {isi} | top = {self.peek()}"
```

Perhatikan bahwa pada operasi `pop()`, referensi di indeks `_top` dibersihkan (`self._data[self._top] = None`) sebelum penanda `_top` diturunkan. Langkah ini penting untuk mencegah **memory leak**: jika stack menyimpan objek besar, membiarkan referensi lama di array akan mencegah garbage collector Python untuk membebaskan memori yang tidak lagi dibutuhkan.

> **Catatan Penting -- Stack Overflow dan Underflow**
>
> Dua kondisi error yang wajib ditangani pada implementasi stack berbasis array berkapasitas tetap adalah:
>
> 1. **Stack Overflow**: Terjadi ketika `push()` dipanggil pada stack yang telah penuh (`_top == kapasitas - 1`). Dalam Python, kondisi ini direpresentasikan dengan melemparkan `OverflowError`.
> 2. **Stack Underflow**: Terjadi ketika `pop()` atau `peek()` dipanggil pada stack kosong (`_top == -1`). Dalam Python, kondisi ini direpresentasikan dengan melemparkan `IndexError`.
>
> Penamaan "overflow" dan "underflow" berasal dari analogi wadah fisik: overflow seperti cairan yang tumpah karena wadah penuh, sementara underflow seperti mencoba mengambil cairan dari wadah yang sudah kosong.

### 6.4.3 Stack Array Dinamis Menggunakan List Python

Python menyediakan tipe data `list` yang bersifat dinamis: ia dapat tumbuh dan menyusut secara otomatis sesuai kebutuhan. Ini memungkinkan implementasi stack yang lebih fleksibel tanpa batasan kapasitas tetap:

```python
class StackDinamis:
    """
    Implementasi Stack menggunakan list Python yang bersifat dinamis.
    Tidak ada batasan kapasitas (selama memori sistem tersedia).
    Ini adalah implementasi yang paling umum digunakan dalam praktik Python.
    """

    def __init__(self):
        self._data = []

    def is_empty(self):
        """Mengembalikan True jika stack kosong."""
        return len(self._data) == 0

    def push(self, elemen):
        """Menambahkan elemen ke puncak stack. Kompleksitas: O(1) amortized."""
        self._data.append(elemen)

    def pop(self):
        """Menghapus dan mengembalikan elemen puncak. Kompleksitas: O(1)."""
        if self.is_empty():
            raise IndexError("Stack underflow: stack kosong.")
        return self._data.pop()

    def peek(self):
        """Mengembalikan elemen puncak tanpa menghapus. Kompleksitas: O(1)."""
        if self.is_empty():
            raise IndexError("Stack kosong.")
        return self._data[-1]

    def size(self):
        """Mengembalikan jumlah elemen. Kompleksitas: O(1)."""
        return len(self._data)

    def __repr__(self):
        return f"Stack{self._data}"
```

Kelas `StackDinamis` memanfaatkan metode `append()` dan `pop()` bawaan list Python. Metode `append()` menyisipkan elemen di akhir list (menjadi puncak stack), dan metode `pop()` tanpa argumen menghapus dan mengembalikan elemen terakhir (puncak stack). Keduanya memiliki kompleksitas O(1) secara amortized.

> **Tahukah Anda? -- Strategi Penggandaan (Doubling Strategy)**
>
> List dinamis Python menggunakan strategi alokasi memori yang disebut **amortized doubling**. Ketika kapasitas internal list habis dan elemen baru perlu ditambahkan, Python tidak hanya mengalokasikan satu slot baru, melainkan menggandakan (atau melipatgandakan dengan faktor tertentu) kapasitas alokasi. Akibatnya, meskipun sesekali operasi `append()` membutuhkan waktu O(n) untuk menyalin seluruh isi array ke lokasi memori baru, secara rata-rata selama n operasi berturut-turut, setiap operasi hanya membutuhkan O(1). Strategi ini dikenal sebagai analisis **amortized complexity** -- biaya mahal yang jarang terjadi "diamortisasi" ke seluruh operasi yang lebih murah.

---

## 6.5 Implementasi Stack Berbasis Linked List

### 6.5.1 Prinsip dan Motivasi

Pada implementasi berbasis array, kapasitas stack terikat pada ukuran array yang dialokasikan. Meskipun list dinamis Python mengatasi masalah ini, memahami implementasi berbasis linked list tetap penting karena:

1. Memberikan pemahaman mendalam tentang manajemen memori dinamis pada level yang lebih rendah.
2. Menjadi dasar untuk memahami struktur data yang lebih kompleks seperti pohon (tree) dan graf (graph).
3. Dalam bahasa pemrograman seperti C atau C++, linked list memberikan kontrol penuh atas alokasi memori tanpa overhead realokasi array.

Pada implementasi linked list, setiap elemen stack disimpan dalam sebuah **node** (simpul). Setiap node menyimpan:
- **data**: nilai elemen stack.
- **next**: referensi (pointer) ke node berikutnya (elemen di bawahnya dalam stack).

Puncak stack selalu diwakili oleh **head** (kepala) linked list. Operasi `push` menambahkan node baru di awal linked list (menjadi head baru), dan operasi `pop` menghapus node dari awal linked list (head lama digantikan oleh node berikutnya). Kedua operasi ini hanya memanipulasi pointer dan tidak memerlukan perpindahan data, sehingga selalu berjalan dalam O(1).

### 6.5.2 Kelas Node

```python
class Node:
    """
    Simpul (Node) untuk singly linked list.
    Setiap node menyimpan satu data dan referensi ke node berikutnya.
    """

    def __init__(self, data):
        """
        Menginisialisasi node dengan data yang diberikan.

        Parameter:
            data: Nilai yang akan disimpan dalam node ini.
        """
        self.data = data
        self.next = None  # referensi ke node berikutnya; None jika tidak ada

    def __repr__(self):
        return f"Node({self.data})"
```

### 6.5.3 Implementasi Lengkap Stack Linked List

```python
class StackLinkedList:
    """
    Implementasi Stack menggunakan Singly Linked List.
    Puncak stack (top) = head dari linked list.
    Semua operasi berjalan dalam O(1).
    """

    def __init__(self):
        """Menginisialisasi stack kosong."""
        self._head = None  # pointer ke node puncak; None = stack kosong
        self._size = 0     # pencacah jumlah elemen

    def is_empty(self):
        """Mengembalikan True jika stack kosong."""
        return self._head is None

    def size(self):
        """Mengembalikan jumlah elemen dalam stack."""
        return self._size

    def push(self, elemen):
        """
        Menambahkan elemen baru ke puncak stack.

        Mekanisme:
        1. Buat node baru dengan data = elemen.
        2. Atur node_baru.next = self._head (hubungkan ke head lama).
        3. Perbarui self._head = node_baru (node baru menjadi head baru).

        Kompleksitas Waktu: O(1)
        Kompleksitas Ruang: O(1) per operasi
        """
        node_baru = Node(elemen)
        node_baru.next = self._head  # node baru menunjuk ke head lama
        self._head = node_baru       # head diperbarui ke node baru
        self._size += 1

    def pop(self):
        """
        Menghapus dan mengembalikan elemen dari puncak stack.

        Mekanisme:
        1. Simpan data dari self._head.
        2. Perbarui self._head = self._head.next (geser ke node berikutnya).
        3. Kembalikan data yang disimpan.

        Kompleksitas Waktu: O(1)

        Raises:
            IndexError: Jika stack kosong (stack underflow).
        """
        if self.is_empty():
            raise IndexError("Stack underflow: stack kosong.")
        elemen = self._head.data
        self._head = self._head.next  # geser head ke node berikutnya
        self._size -= 1
        return elemen

    def peek(self):
        """
        Mengembalikan elemen puncak tanpa menghapusnya.

        Kompleksitas Waktu: O(1)

        Raises:
            IndexError: Jika stack kosong.
        """
        if self.is_empty():
            raise IndexError("Stack kosong.")
        return self._head.data

    def __str__(self):
        """Merepresentasikan stack dari puncak ke bawah."""
        bagian = []
        node_saat_ini = self._head
        while node_saat_ini is not None:
            bagian.append(str(node_saat_ini.data))
            node_saat_ini = node_saat_ini.next
        if not bagian:
            return "Stack: [ kosong ]"
        return "Stack (atas -> bawah): [" + " -> ".join(bagian) + "]"
```

### 6.5.4 Trace Operasi pada Stack Linked List

Berikut adalah simulasi manual operasi push dan pop pada `StackLinkedList` untuk memperdalam pemahaman mekanisme pointer:

```
TRACE: StackLinkedList -- Operasi Push Berturut-turut
======================================================

Keadaan Awal:
  _head = None,  _size = 0

Setelah push(10):
  node_baru = Node(10)
  node_baru.next = None  (head lama adalah None)
  _head = node_baru

  _head --> [10 | None]           _size = 1

Setelah push(20):
  node_baru = Node(20)
  node_baru.next = _head  (menunjuk ke node 10)
  _head = node_baru

  _head --> [20 | o] --> [10 | None]    _size = 2

Setelah push(30):
  node_baru = Node(30)
  node_baru.next = _head  (menunjuk ke node 20)
  _head = node_baru

  _head --> [30 | o] --> [20 | o] --> [10 | None]   _size = 3

Setelah pop():  (mengembalikan 30)
  elemen = _head.data = 30
  _head = _head.next  (menunjuk ke node 20)

  _head --> [20 | o] --> [10 | None]    _size = 2
  Dikembalikan: 30
```

**Gambar 6.4** Trace operasi push dan pop pada StackLinkedList

---

## 6.6 Analisis Kompleksitas dan Perbandingan Implementasi

Pemilihan implementasi stack yang tepat sangat bergantung pada konteks penggunaan. Tabel berikut merangkum perbandingan kompleksitas antara ketiga varian implementasi:

| Operasi | Stack Array (Tetap) | Stack Array (Dinamis) | Stack Linked List |
|---------|--------------------|-----------------------|-------------------|
| `push` | O(1) | O(1) amortized | O(1) |
| `pop` | O(1) | O(1) | O(1) |
| `peek` | O(1) | O(1) | O(1) |
| `is_empty` | O(1) | O(1) | O(1) |
| `size` | O(1) | O(1) | O(1) |
| Ruang (Space) | O(n) tetap | O(n) dinamis | O(n) + overhead pointer |
| Risiko Overflow | Ya (kapasitas tetap) | Tidak | Tidak* |
| Overhead per Elemen | Rendah | Rendah | Tinggi (pointer next) |

**Tabel 6.2** Perbandingan kompleksitas operasi pada tiga varian implementasi stack

*) Stack linked list dapat mengalami kehabisan memori sistem, tetapi tidak memiliki batas kapasitas yang ditetapkan secara eksplisit.

Panduan pemilihan implementasi:

1. **Stack Array Berkapasitas Tetap**: Gunakan ketika kapasitas maksimum diketahui sebelumnya dan efisiensi memori menjadi prioritas. Cocok untuk sistem tertanam (embedded systems) atau lingkungan dengan sumber daya terbatas.

2. **Stack Array Dinamis (Python List)**: Gunakan untuk sebagian besar aplikasi Python umum. Kombinasi kesederhanaan kode, performa O(1) amortized, dan fleksibilitas menjadikannya pilihan terbaik dalam praktik.

3. **Stack Linked List**: Gunakan ketika ukuran stack sangat bervariasi dan penghindaran realokasi memori menjadi prioritas. Juga berguna sebagai bahan pembelajaran manajemen memori dinamis.

> **Catatan Penting -- Overhead Memori Linked List**
>
> Setiap node dalam linked list menyimpan dua informasi: data elemen dan referensi (pointer) ke node berikutnya. Di Python, setiap objek memiliki overhead memori tersendiri. Akibatnya, untuk stack dengan n elemen, implementasi linked list menggunakan memori yang secara konstan lebih besar daripada implementasi array -- meskipun keduanya memiliki kompleksitas ruang O(n). Dalam konteks bahasa seperti C, setiap pointer mengkonsumsi 4 atau 8 byte tergantung arsitektur sistem. Untuk stack yang menyimpan jutaan elemen berukuran kecil, selisih overhead ini bisa menjadi signifikan.

---

## 6.7 Aplikasi 1 -- Pengecekan Keseimbangan Tanda Kurung

### 6.7.1 Deskripsi Masalah

Salah satu tugas pertama yang dihadapi oleh kompiler saat memproses kode sumber adalah memverifikasi bahwa semua tanda kurung dalam ekspresi terpasang dengan benar dan seimbang. Masalah ini dikenal sebagai **balanced parentheses problem**.

Diberikan sebuah string yang dapat mengandung berbagai jenis tanda kurung -- `()`, `[]`, dan `{}` -- beserta karakter-karakter lainnya, tentukan apakah semua tanda kurung dalam string tersebut seimbang. Sebuah string dikatakan seimbang jika:
1. Setiap kurung buka memiliki tepat satu kurung tutup yang sesuai.
2. Setiap kurung tutup memiliki tepat satu kurung buka yang sesuai di sebelah kirinya.
3. Pasangan kurung tidak saling bersilangan (misalnya `([)]` adalah tidak valid).

Contoh kasus uji:

| Ekspresi | Status | Alasan |
|----------|--------|--------|
| `(())` | Valid | Semua terpasang dengan benar |
| `([{}])` | Valid | Tiga pasang bersarang dengan benar |
| `([)]` | Tidak Valid | Urutan penutupan salah |
| `(((` | Tidak Valid | Ada kurung buka yang tidak ditutup |
| `}{{` | Tidak Valid | Dimulai dengan kurung tutup tanpa pasangan |
| `a*(b+c)-[d/{e}]` | Valid | Karakter non-kurung diabaikan |

**Tabel 6.3** Contoh kasus uji balanced parentheses

### 6.7.2 Algoritma Berbasis Stack

Stack sangat cocok untuk masalah ini karena sifat alami dari keseimbangan tanda kurung: kurung buka yang paling terakhir dilihat harus ditutup pertama -- persis seperti prinsip LIFO.

```
Algoritma Balanced_Parentheses(ekspresi):
  ==========================================
  Inisialisasi stack kosong
  Definisikan peta pasangan: ')' -> '(', ']' -> '[', '}' -> '{'
  Definisikan himpunan kurung_buka: {'(', '[', '{'}
  Definisikan himpunan kurung_tutup: {')', ']', '}'}

  Untuk setiap karakter c dalam ekspresi:

    JIKA c termasuk kurung_buka:
      push(c) ke stack

    JIKA c termasuk kurung_tutup:
      JIKA stack kosong:
        KEMBALIKAN False  // kurung tutup tanpa pasangan
      top = pop() dari stack
      JIKA top != pasangan[c]:
        KEMBALIKAN False  // jenis kurung tidak cocok

    (karakter lain diabaikan)

  KEMBALIKAN is_empty(stack)
  // True  -> semua kurung buka telah ditutup dengan benar
  // False -> masih ada kurung buka yang belum ditutup
```

### 6.7.3 Implementasi Python

```python
def cek_tanda_kurung_seimbang(ekspresi, verbose=False):
    """
    Memeriksa apakah tanda kurung dalam ekspresi seimbang.
    Mendukung tiga jenis tanda kurung: (), [], {}

    Parameter:
        ekspresi (str): String yang akan diperiksa.
        verbose  (bool): Jika True, tampilkan trace setiap langkah.

    Returns:
        bool: True jika seimbang, False jika tidak.
    """
    stack = StackDinamis()

    # Peta pasangan: kurung tutup -> kurung buka yang diharapkan
    pasangan = {')': '(', ']': '[', '}': '{'}
    kurung_buka  = set('([{')
    kurung_tutup = set(')]}')

    if verbose:
        print(f'\n  Ekspresi: "{ekspresi}"')
        print(f"  {'Token':<8} {'Aksi':<35} {'Stack (bawah -> atas)'}")
        print(f"  {'-'*7} {'-'*35} {'-'*25}")

    for karakter in ekspresi:
        if karakter in kurung_buka:
            stack.push(karakter)
            aksi = f"push('{karakter}')"

        elif karakter in kurung_tutup:
            if stack.is_empty():
                if verbose:
                    print(f"  '{karakter}'      Stack kosong saat tutup -> GAGAL")
                return False
            top = stack.pop()
            if top != pasangan[karakter]:
                if verbose:
                    print(f"  '{karakter}'      pop='{top}', harap '{pasangan[karakter]}' -> GAGAL")
                return False
            aksi = f"pop()='{top}', pasangan '{top}{karakter}' cocok"

        else:
            aksi = "lewati (bukan tanda kurung)"

        if verbose:
            print(f"  '{karakter}'      {aksi:<35} {list(stack._data)}")

    hasil = stack.is_empty()
    if verbose:
        if hasil:
            print(f"\n  Stack KOSONG -> SEIMBANG (True)")
        else:
            print(f"\n  Stack TIDAK KOSONG -> TIDAK SEIMBANG (False)")
    return hasil
```

### 6.7.4 Trace Lengkap: Ekspresi `({[]})`

```
TRACE: cek_tanda_kurung_seimbang("({[]})")
==========================================

  Ekspresi: "({[]})"

  Token    Aksi                                Stack (bawah -> atas)
  -------  -----------------------------------  ---------------------
  '('      push('(')                           ['(']
  '{'      push('{')                           ['(', '{']
  '['      push('[')                           ['(', '{', '[']
  ']'      pop()='[', pasangan '[' ']' cocok   ['(', '{']
  '}'      pop()='{', pasangan '{' '}' cocok   ['(']
  ')'      pop()='(', pasangan '(' ')' cocok   []

  Stack KOSONG -> SEIMBANG (True)
```

**Gambar 6.5** Trace eksekusi balanced parentheses untuk ekspresi `({[]})`

### 6.7.5 Trace Lengkap: Ekspresi `([)]`

```
TRACE: cek_tanda_kurung_seimbang("([)]")
==========================================

  Ekspresi: "([)]"

  Token    Aksi                                Stack (bawah -> atas)
  -------  -----------------------------------  ---------------------
  '('      push('(')                           ['(']
  '['      push('[')                           ['(', '[']
  ')'      pop()='[', harap '(' -> GAGAL!

  Fungsi mengembalikan False seketika.
  Penjelasan: Saat ')' ditemukan, puncak stack adalah '[',
  tetapi pasangan yang diharapkan untuk ')' adalah '('.
  Ini menunjukkan bahwa kurung '[' belum ditutup, tetapi
  program sudah mencoba menutup '(' -- kondisi yang tidak valid.

  TIDAK SEIMBANG (False)
```

**Gambar 6.6** Trace eksekusi balanced parentheses untuk ekspresi tidak valid `([)]`

---

## 6.8 Aplikasi 2 -- Konversi Ekspresi Infix ke Postfix

### 6.8.1 Notasi Ekspresi Matematika

Terdapat tiga cara penulisan ekspresi matematika yang lazim dikenal dalam ilmu komputer, dibedakan berdasarkan posisi operator relatif terhadap operandnya:

**1. Notasi Infix**: Operator ditulis di antara dua operand. Ini adalah notasi yang biasa digunakan manusia dalam penulisan sehari-hari.

Contoh: `A + B`, `(A + B) * C`

Kelemahan infix bagi komputer: memerlukan aturan prioritas operator dan penggunaan tanda kurung untuk menentukan urutan evaluasi yang benar.

**2. Notasi Prefix (Polish Notation)**: Operator ditulis sebelum kedua operandnya. Dikembangkan oleh logikawan Polandia Jan Lukasiewicz, sehingga disebut Polish Notation.

Contoh: `+ A B`, `* + A B C`

**3. Notasi Postfix (Reverse Polish Notation / RPN)**: Operator ditulis setelah kedua operandnya.

Contoh: `A B +`, `A B + C *`

Notasi postfix sangat efisien untuk dievaluasi oleh komputer karena tidak memerlukan tanda kurung maupun aturan prioritas saat evaluasi -- urutan operasi sudah tersimpan secara implisit dalam urutan token.

| Infix | Postfix | Keterangan |
|-------|---------|------------|
| `A + B` | `A B +` | Bentuk paling sederhana |
| `A + B * C` | `A B C * +` | `*` lebih tinggi prioritasnya dari `+` |
| `(A + B) * C` | `A B + C *` | Kurung mengubah urutan evaluasi |
| `A * B + C * D` | `A B * C D * +` | Dua subekspresi dengan prioritas sama |
| `(A + B) * (C - D)` | `A B + C D - *` | Dua pasang kurung |

**Tabel 6.4** Contoh konversi ekspresi infix ke postfix

> **Studi Kasus -- Kalkulator HP-35 dan Notasi Postfix**
>
> Kalkulator ilmiah pertama yang dapat masuk ke saku baju, HP-35, diluncurkan oleh Hewlett-Packard pada tahun 1972 dengan harga 395 dolar Amerika. Salah satu keputusan desain paling mencolok dari kalkulator ini adalah penggunaan notasi Reverse Polish Notation (RPN) untuk memasukkan ekspresi. Pengguna memasukkan operand terlebih dahulu, lalu menekan tombol operator. Misalnya, untuk menghitung `(3 + 4) * 2`, pengguna memasukkan: `3 [Enter] 4 [+] 2 [*]`.
>
> Pilihan RPN bukan sekadar keunikan desain; ini adalah keputusan rekayasa yang cerdas. Kalkulator elektronik awal memiliki kapasitas memori yang sangat terbatas. Evaluasi ekspresi postfix dengan stack hanya membutuhkan satu lintasan (single pass) melalui ekspresi dan tidak memerlukan pengalokasian memori untuk menyimpan hasil antara pada tumpukan yang dalam. Konsep ini tetap relevan hingga kini: kompiler modern mengonversi ekspresi infix ke representasi yang secara konseptual serupa dengan postfix untuk menghasilkan kode mesin yang efisien.

### 6.8.2 Tabel Prioritas Operator

Sebelum membahas algoritma konversi, prioritas dan asosiativitas operator perlu didefinisikan secara eksplisit:

| Operator | Simbol | Prioritas | Asosiativitas |
|----------|--------|-----------|---------------|
| Pangkat | `^` | 3 (tertinggi) | Kanan ke kiri |
| Perkalian | `*` | 2 | Kiri ke kanan |
| Pembagian | `/` | 2 | Kiri ke kanan |
| Modulo | `%` | 2 | Kiri ke kanan |
| Penjumlahan | `+` | 1 | Kiri ke kanan |
| Pengurangan | `-` | 1 | Kiri ke kanan |
| Kurung buka | `(` | 0 (terendah di stack) | -- |

**Tabel 6.5** Prioritas dan asosiativitas operator untuk konversi infix ke postfix

Asosiativitas menentukan urutan evaluasi ketika dua operator memiliki prioritas yang sama. Operator asosiatif kiri dievaluasi dari kiri ke kanan: `A - B - C` diinterpretasikan sebagai `(A - B) - C`. Operator pangkat (`^`) bersifat asosiatif kanan: `A ^ B ^ C` diinterpretasikan sebagai `A ^ (B ^ C)`.

### 6.8.3 Algoritma Shunting-Yard (Dijkstra)

Algoritma **Shunting-Yard** ditemukan oleh Edsger W. Dijkstra -- ilmuwan komputer yang juga dikenal karena algoritma jalur terpendek Dijkstra -- dan dinamai berdasarkan analogi dengan jalur penyortiran kereta api (shunting yard). Algoritma ini menggunakan sebuah stack operator dan sebuah antrian (atau list) output:

```
Algoritma Shunting_Yard(ekspresi_infix):
  =========================================
  Inisialisasi stack_operator kosong
  Inisialisasi list output kosong

  Untuk setiap token dalam ekspresi_infix:

    KASUS 1: token adalah OPERAND (angka atau variabel)
      Tambahkan token langsung ke output

    KASUS 2: token adalah '('
      push token ke stack_operator

    KASUS 3: token adalah ')'
      Sementara stack_operator tidak kosong DAN peek() != '(':
        pop dari stack_operator, tambahkan ke output
      pop '(' dari stack_operator (buang, jangan ke output)

    KASUS 4: token adalah OPERATOR op
      Sementara (stack_operator tidak kosong DAN
                 peek() != '(' DAN
                 peek() adalah operator DAN
                 (prioritas(peek()) > prioritas(op) ATAU
                  (prioritas(peek()) == prioritas(op) DAN
                   op bukan operator asosiatif kanan))):
        pop dari stack_operator, tambahkan ke output
      push op ke stack_operator

  Sementara stack_operator tidak kosong:
    pop dari stack_operator, tambahkan ke output

  KEMBALIKAN output sebagai string
```

### 6.8.4 Implementasi Python dengan Jejak Eksekusi

```python
def infix_ke_postfix(ekspresi, verbose=False):
    """
    Mengonversi ekspresi infix ke notasi postfix menggunakan
    algoritma Shunting-Yard (Dijkstra).

    Mendukung operator: +, -, *, /, ^, dan tanda kurung ().
    Operand berupa karakter alfanumerik tunggal (A-Z, a-z, 0-9).

    Parameter:
        ekspresi (str): Ekspresi infix tanpa spasi.
        verbose  (bool): Jika True, tampilkan trace langkah per langkah.

    Returns:
        str: Ekspresi dalam notasi postfix, token dipisahkan spasi.
    """
    prioritas = {'^': 3, '*': 2, '/': 2, '%': 2, '+': 1, '-': 1, '(': 0}
    asosiatif_kanan = {'^'}  # operator yang bersifat asosiatif kanan

    stack_op = StackDinamis()
    output = []

    if verbose:
        print(f'\n  Ekspresi Infix: "{ekspresi}"')
        print(f"\n  {'Token':<8} {'Aksi':<38} {'Stack Op':<20} Output")
        print(f"  {'-'*7} {'-'*38} {'-'*20} {'-'*25}")

    for token in ekspresi:
        if token == ' ':
            continue

        # Kasus 1: Token adalah operand (huruf atau angka)
        if token.isalnum():
            output.append(token)
            aksi = "operand -> langsung ke output"

        # Kasus 2: Token adalah kurung buka
        elif token == '(':
            stack_op.push(token)
            aksi = "push('(')"

        # Kasus 3: Token adalah kurung tutup
        elif token == ')':
            aksi = "kurung tutup: pop hingga '('"
            while not stack_op.is_empty() and stack_op.peek() != '(':
                output.append(stack_op.pop())
            if not stack_op.is_empty():
                stack_op.pop()  # buang '(' dari stack

        # Kasus 4: Token adalah operator
        elif token in prioritas:
            while (not stack_op.is_empty() and
                   stack_op.peek() != '(' and
                   stack_op.peek() in prioritas and
                   (prioritas[stack_op.peek()] > prioritas[token] or
                    (prioritas[stack_op.peek()] == prioritas[token] and
                     token not in asosiatif_kanan))):
                output.append(stack_op.pop())
            stack_op.push(token)
            aksi = f"operator: atur prioritas, push('{token}')"

        else:
            aksi = "karakter tidak dikenal, lewati"

        if verbose:
            print(f"  '{token}'      {aksi:<38} {str(list(stack_op._data)):<20} {''.join(output)}")

    # Pindahkan semua sisa operator dari stack ke output
    while not stack_op.is_empty():
        op = stack_op.pop()
        output.append(op)
        if verbose:
            print(f"  [flush] pop '{op}' ke output"
                  f"{'':>28} {str(list(stack_op._data)):<20} {''.join(output)}")

    hasil = ' '.join(output)
    if verbose:
        print(f'\n  Hasil Postfix: "{hasil}"')
    return hasil
```

### 6.8.5 Trace Lengkap: Ekspresi `(A+B)*C`

```
TRACE: infix_ke_postfix("(A+B)*C")
=====================================

  Ekspresi Infix: "(A+B)*C"

  Token    Aksi                                   Stack Op      Output
  -------  -------------------------------------  ----------    ------
  '('      push('(')                             ['(']
  'A'      operand -> langsung ke output         ['(']          A
  '+'      operator: push('+')                   ['(', '+']     A
           (peek='(', tidak perlu pop)
  'B'      operand -> langsung ke output         ['(', '+']     AB
  ')'      kurung tutup: pop '+' ke output,      []             AB+
           buang '('
  '*'      operator: push('*')                   ['*']          AB+
           (stack kosong setelah buang kurung)
  'C'      operand -> langsung ke output         ['*']          AB+C
  [flush]  pop '*' ke output                     []             AB+C*

  Hasil Postfix: "A B + C *"
```

**Gambar 6.7** Trace konversi ekspresi `(A+B)*C` menggunakan algoritma Shunting-Yard

Verifikasi kebenaran dengan nilai A=2, B=3, C=4:
- Infix: `(2+3)*4 = 5*4 = 20`
- Postfix `A B + C *`: push 2, push 3, pop keduanya kemudian push (2+3)=5, push 4, pop keduanya kemudian push 5*4=20. Hasil: **20**. Benar.

### 6.8.6 Trace Tambahan: Ekspresi `A+B*C`

```
TRACE: infix_ke_postfix("A+B*C")
===================================
(Menunjukkan penanganan prioritas tanpa tanda kurung)

  Token    Aksi                                   Stack Op      Output
  -------  -------------------------------------  ----------    ------
  'A'      operand -> output                      []            A
  '+'      push('+')                              ['+']         A
  'B'      operand -> output                      ['+']         AB
  '*'      prioritas '*'(2) > prioritas '+'(1),  ['+', '*']    AB
           push('*') tanpa pop '+'
  'C'      operand -> output                      ['+', '*']    ABC
  [flush]  pop '*' ke output                      ['+']         ABC*
  [flush]  pop '+' ke output                      []            ABC*+

  Hasil Postfix: "A B C * +"
```

**Gambar 6.8** Trace konversi `A+B*C` -- demonstrasi penanganan prioritas operator

---

## 6.9 Aplikasi 3 -- Evaluasi Ekspresi Postfix

### 6.9.1 Algoritma Evaluasi

Setelah ekspresi infix dikonversi ke bentuk postfix, evaluasinya sangat sederhana dan elegan menggunakan stack. Algoritma bekerja dengan satu lintasan dari kiri ke kanan:

```
Algoritma Evaluasi_Postfix(ekspresi_postfix):
  ============================================
  Inisialisasi stack operand kosong
  Pisahkan ekspresi menjadi token-token

  Untuk setiap token:
    JIKA token adalah BILANGAN:
      push(float(token)) ke stack

    JIKA token adalah OPERATOR op:
      operand2 = pop() dari stack  // operand kanan
      operand1 = pop() dari stack  // operand kiri
      hasil = operand1 [op] operand2
      push(hasil) ke stack

  KEMBALIKAN pop() dari stack (satu-satunya nilai tersisa)
```

Perhatikan urutan pengambilan operand: `operand2` diambil lebih dulu dari stack (karena ia dimasukkan lebih terakhir), kemudian `operand1`. Ini penting untuk operator yang tidak komutatif seperti pengurangan dan pembagian.

### 6.9.2 Implementasi Evaluator Postfix

```python
def evaluasi_postfix(ekspresi_postfix, verbose=False):
    """
    Mengevaluasi ekspresi postfix dan mengembalikan hasilnya sebagai float.
    Token harus dipisahkan oleh spasi tunggal.

    Parameter:
        ekspresi_postfix (str): Ekspresi dalam notasi postfix.
        verbose (bool): Jika True, tampilkan trace evaluasi.

    Returns:
        float: Hasil evaluasi ekspresi.

    Raises:
        ZeroDivisionError: Jika terjadi pembagian dengan nol.
        ValueError: Jika ekspresi tidak valid.
    """
    stack = StackDinamis()
    token_list = ekspresi_postfix.split()

    if verbose:
        print(f'\n  Mengevaluasi: "{ekspresi_postfix}"')
        print(f"  {'Token':<10} {'Aksi':<38} Stack")
        print(f"  {'-'*9} {'-'*38} {'-'*25}")

    for token in token_list:
        # Cek apakah token adalah bilangan (termasuk negatif)
        if token.lstrip('-').replace('.', '', 1).isdigit():
            stack.push(float(token))
            aksi = f"push({token})"
        else:
            # Token adalah operator: ambil dua operand dari stack
            if stack.size() < 2:
                raise ValueError(f"Ekspresi postfix tidak valid: kurang operand untuk '{token}'")
            operand2 = stack.pop()  # operand kanan (diambil lebih dulu)
            operand1 = stack.pop()  # operand kiri

            if token == '+':
                hasil = operand1 + operand2
            elif token == '-':
                hasil = operand1 - operand2
            elif token == '*':
                hasil = operand1 * operand2
            elif token == '/':
                if operand2 == 0:
                    raise ZeroDivisionError("Pembagian dengan nol tidak diizinkan.")
                hasil = operand1 / operand2
            elif token == '^':
                hasil = operand1 ** operand2
            else:
                raise ValueError(f"Operator tidak dikenal: '{token}'")

            stack.push(hasil)
            aksi = f"{operand1} {token} {operand2} = {hasil}"

        if verbose:
            print(f"  '{token}'      {aksi:<38} {list(stack._data)}")

    if stack.size() != 1:
        raise ValueError("Ekspresi postfix tidak valid: sisa operand di stack.")
    return stack.pop()
```

### 6.9.3 Studi Kasus -- Kalkulator Ilmiah Berbasis Stack

Menyatukan tiga komponen yang telah dibahas -- `cek_tanda_kurung_seimbang`, `infix_ke_postfix`, dan `evaluasi_postfix` -- kita dapat membangun sebuah kalkulator ilmiah sederhana yang mampu mengevaluasi ekspresi infix dengan memperhatikan prioritas operator dan tanda kurung.

```python
def kalkulator_ilmiah(ekspresi_infix, verbose=False):
    """
    Kalkulator ilmiah yang mengevaluasi ekspresi infix melalui dua tahap:
      1. Konversi infix -> postfix (Shunting-Yard)
      2. Evaluasi postfix (stack operand)

    Mendukung operator: +, -, *, /, ^ dan tanda kurung ().
    Operand harus berupa bilangan bulat atau desimal.

    Parameter:
        ekspresi_infix (str): Ekspresi infix dengan token dipisahkan spasi.
        verbose (bool): Jika True, tampilkan proses lengkap.

    Returns:
        float: Hasil evaluasi ekspresi.
    """
    # Tahap 0: Validasi keseimbangan tanda kurung
    ekspresi_tanpa_spasi = ekspresi_infix.replace(' ', '')
    if not cek_tanda_kurung_seimbang(ekspresi_tanpa_spasi):
        raise ValueError(f"Ekspresi tidak valid: tanda kurung tidak seimbang.")

    if verbose:
        print(f"\n{'='*55}")
        print(f"  INPUT: {ekspresi_infix}")
        print(f"{'='*55}")

    # Tahap 1: Konversi token numerik - tangani angka multi-digit
    # (implementasi sederhana dengan asumsi token dipisahkan spasi)
    token_list = ekspresi_infix.split()
    infix_singkat = ''.join(
        t if len(t) == 1 else t for t in token_list
    )

    # Konversi infix ke postfix
    postfix = infix_ke_postfix(ekspresi_infix.replace(' ', ''), verbose=verbose)

    if verbose:
        print(f"\n  Postfix: {postfix}")

    # Tahap 2: Evaluasi postfix
    hasil = evaluasi_postfix(postfix, verbose=verbose)

    if verbose:
        print(f"\n  HASIL AKHIR: {ekspresi_infix} = {hasil}")

    return hasil


# ============================================================
# DEMONSTRASI KALKULATOR ILMIAH
# ============================================================

def demo_kalkulator():
    """Demonstrasi kalkulator ilmiah berbasis stack."""
    print("\n" + "=" * 60)
    print("  STUDI KASUS: KALKULATOR ILMIAH BERBASIS STACK")
    print("=" * 60)

    kasus_uji = [
        ("3+4*2",        "3 + 4*2 = 11"),
        ("(3+4)*2",      "(3+4)*2 = 14"),
        ("2^3^2",        "2^3^2 = 512  (asosiatif kanan: 2^(3^2)=2^9)"),
        ("(5+3)*(2-8)/4", "kompleks dengan kurung berganda"),
    ]

    for ekspresi, keterangan in kasus_uji:
        try:
            hasil = kalkulator_ilmiah(ekspresi, verbose=False)
            print(f"  {ekspresi:<25} = {hasil}   ({keterangan})")
        except Exception as e:
            print(f"  ERROR pada '{ekspresi}': {e}")

demo_kalkulator()
```

Output yang diharapkan:

```
  3+4*2                     = 11.0   (3 + 4*2 = 11)
  (3+4)*2                   = 14.0   ((3+4)*2 = 14)
  2^3^2                     = 512.0  (asosiatif kanan: 2^(3^2)=2^9)
  (5+3)*(2-8)/4             = -12.0  (kompleks dengan kurung berganda)
```

---

## 6.10 Aplikasi Stack dalam Sistem Nyata

### 6.10.1 Call Stack: Mesin di Balik Pemanggilan Fungsi

Setiap kali sebuah program mengeksekusi pemanggilan fungsi, sistem operasi secara otomatis mengelola sebuah struktur data yang disebut **call stack** (tumpukan pemanggilan). Call stack menyimpan **stack frame** (bingkai tumpukan) untuk setiap fungsi yang sedang aktif. Setiap stack frame berisi:

- Alamat pengembalian (return address): instruksi mana yang harus dieksekusi setelah fungsi selesai.
- Parameter yang diteruskan ke fungsi.
- Variabel lokal yang dideklarasikan di dalam fungsi.
- Penanda posisi dalam frame sebelumnya.

```
SIMULASI CALL STACK: Pemanggilan Fungsi Bersarang
==================================================

Ketika program berikut dieksekusi:
  def main():
      hasil = fungsi_a()

  def fungsi_a():
      return fungsi_b() + 1

  def fungsi_b():
      return 42

Urutan call stack (bawah = pertama masuk, atas = aktif):

  Saat main() dimulai:
  +-------------+
  | frame: main |  <- top (aktif)
  +-------------+

  Saat fungsi_a() dipanggil dari main():
  +--------------+
  | frame: a()   |  <- top (aktif)
  +--------------+
  | frame: main  |
  +--------------+

  Saat fungsi_b() dipanggil dari fungsi_a():
  +--------------+
  | frame: b()   |  <- top (aktif), mengembalikan 42
  +--------------+
  | frame: a()   |
  +--------------+
  | frame: main  |
  +--------------+

  Setelah fungsi_b() selesai (pop frame b):
  +--------------+
  | frame: a()   |  <- top (aktif), mengembalikan 43
  +--------------+
  | frame: main  |
  +--------------+

  Setelah fungsi_a() selesai (pop frame a):
  +-------------+
  | frame: main |  <- top (aktif), mendapat hasil = 43
  +-------------+
```

**Gambar 6.9** Ilustrasi perubahan call stack selama eksekusi program bersarang

Dalam Python, rekursi yang terlalu dalam menyebabkan `RecursionError: maximum recursion depth exceeded`. Ini adalah manifestasi nyata dari stack overflow pada call stack. Secara default, Python membatasi kedalaman rekursi pada 1000 level, meskipun batas ini dapat diubah dengan `sys.setrecursionlimit()`.

### 6.10.2 Mekanisme Undo/Redo pada Editor Teks

Fitur undo dan redo yang ada di hampir semua aplikasi modern diimplementasikan menggunakan sepasang stack. Setiap aksi pengguna disimpan ke `undo_stack`. Ketika Ctrl+Z ditekan, aksi terakhir di-pop dari `undo_stack` dan di-push ke `redo_stack`. Ketika Ctrl+Y ditekan, aksi di-pop dari `redo_stack` dan diterapkan kembali.

```python
class EditorTeks:
    """Simulasi editor teks dengan fitur undo/redo menggunakan stack."""

    def __init__(self):
        self._konten = ""
        self._undo_stack = StackDinamis()
        self._redo_stack = StackDinamis()

    def ketik(self, teks):
        """Menambahkan teks; menyimpan state lama ke undo_stack."""
        self._undo_stack.push(self._konten)
        self._redo_stack = StackDinamis()  # aksi baru menghapus redo history
        self._konten += teks

    def undo(self):
        """Membatalkan aksi terakhir."""
        if self._undo_stack.is_empty():
            print("  Tidak ada aksi untuk di-undo.")
            return
        self._redo_stack.push(self._konten)
        self._konten = self._undo_stack.pop()

    def redo(self):
        """Mengulangi aksi yang telah di-undo."""
        if self._redo_stack.is_empty():
            print("  Tidak ada aksi untuk di-redo.")
            return
        self._undo_stack.push(self._konten)
        self._konten = self._redo_stack.pop()

    @property
    def konten(self):
        return self._konten
```

### 6.10.3 Navigasi Riwayat Peramban Web

Tombol "Back" dan "Forward" pada peramban web merupakan contoh aplikasi stack yang sangat intuitif. Dua stack digunakan: satu untuk riwayat halaman yang telah dikunjungi (back_stack) dan satu untuk halaman yang telah di-navigate-back (forward_stack). Setiap kunjungan baru menghapus forward_stack karena pengguna telah menyimpang dari jalur yang ada.

> **Tahukah Anda? -- Stack dalam Kompiler**
>
> Kompiler modern menggunakan stack tidak hanya untuk mengevaluasi ekspresi, tetapi juga untuk analisis sintaksis (parsing) keseluruhan program. Teknik yang disebut **LL parsing** dan **LR parsing** -- yang digunakan untuk menganalisis tata bahasa pemrograman -- keduanya mengandalkan stack untuk melacak status parser. Bahkan, definisi formal dari bahasa pemrograman yang dapat di-compile (bahasa bebas konteks / context-free language) berkaitan erat dengan mesin otomata berbasis stack yang disebut **pushdown automaton**. Dengan kata lain, setiap program yang ditulis dalam bahasa pemrograman modern akan melewati proses yang secara fundamental bergantung pada stack untuk dapat dipahami oleh kompiler.

---

## 6.11 Rangkuman Bab

Bab ini telah membahas stack (tumpukan) secara komprehensif, mulai dari konsep abstrak hingga aplikasi konkret. Berikut adalah poin-poin utama yang perlu diingat:

1. **Stack adalah ADT berbasis prinsip LIFO (Last In First Out)**: elemen yang terakhir dimasukkan selalu menjadi elemen pertama yang dikeluarkan. Akses dibatasi hanya pada satu ujung yang disebut puncak (top). Operasi utamanya adalah `push` (masukkan), `pop` (keluarkan), dan `peek` (intip puncak tanpa menghapus).

2. **Dua strategi implementasi utama tersedia**: berbasis array (memanfaatkan indeks untuk melacak puncak, mudah diimplementasikan) dan berbasis linked list (menggunakan node yang dihubungkan oleh pointer, benar-benar dinamis tanpa batasan kapasitas tetap). Semua operasi utama stack berjalan dalam O(1) pada kedua implementasi. Untuk Python, `StackDinamis` berbasis list bawaan adalah pilihan praktis terbaik karena kesederhanaan dan performa O(1) amortized.

3. **Overflow dan underflow adalah dua kondisi error yang wajib ditangani**: overflow terjadi ketika push dilakukan pada stack penuh (relevan untuk array berkapasitas tetap), sedangkan underflow terjadi ketika pop atau peek dilakukan pada stack kosong. Penanganan yang tepat mencegah crash program dan memudahkan debugging.

4. **Balanced parentheses adalah aplikasi stack klasik**: setiap kurung buka di-push ke stack, dan setiap kurung tutup memicu pop beserta pencocokan jenis. Ekspresi valid jika dan hanya jika stack kosong setelah seluruh ekspresi diproses.

5. **Algoritma Shunting-Yard (Dijkstra) mengonversi ekspresi infix ke postfix** menggunakan stack operator. Operand langsung ke output; operator dimasukkan ke stack dengan mempertimbangkan prioritas dan asosiativitas; kurung buka dipush dan kurung tutup memicu pengosongan stack hingga kurung buka ditemukan. Ekspresi postfix yang dihasilkan dapat dievaluasi secara efisien dengan stack operand melalui satu lintasan linear.

6. **Evaluasi ekspresi postfix menggunakan stack operand**: setiap bilangan di-push; setiap operator memicu pengambilan dua operand (operand kanan pertama, operand kiri kedua), penghitungan hasil, dan push kembali ke stack. Nilai tunggal yang tersisa di stack setelah seluruh token diproses adalah hasil akhir ekspresi.

7. **Stack hadir di mana-mana dalam sistem komputasi nyata**: call stack sistem operasi untuk mengelola pemanggilan fungsi dan rekursi; mekanisme undo/redo pada editor; navigasi back/forward pada peramban web; analisis sintaksis oleh kompiler; dan evaluasi ekspresi oleh interpreter. Memahami stack berarti memahami mekanisme fundamental yang menopang sebagian besar komputasi modern.

---

## Istilah Kunci

| Istilah | Definisi |
|---------|----------|
| **Stack (Tumpukan)** | ADT linear berbasis prinsip LIFO yang hanya mengizinkan akses pada satu ujung (puncak) |
| **LIFO (Last In First Out)** | Prinsip pengelolaan elemen di mana elemen terakhir masuk adalah yang pertama keluar |
| **Push** | Operasi menambahkan elemen ke puncak stack |
| **Pop** | Operasi menghapus dan mengembalikan elemen dari puncak stack |
| **Peek / Top** | Operasi melihat elemen puncak stack tanpa menghapusnya |
| **Stack Overflow** | Kondisi error ketika push dilakukan pada stack yang telah penuh |
| **Stack Underflow** | Kondisi error ketika pop atau peek dilakukan pada stack kosong |
| **Abstract Data Type (ADT)** | Spesifikasi tipe data yang mendefinisikan operasi tanpa detail implementasi |
| **Node** | Satuan penyimpanan dalam linked list yang berisi data dan referensi ke node berikutnya |
| **Call Stack** | Stack yang dikelola sistem operasi untuk menyimpan frame setiap fungsi yang sedang aktif |
| **Stack Frame** | Bagian call stack yang menyimpan konteks eksekusi sebuah fungsi (return address, parameter, variabel lokal) |
| **Balanced Parentheses** | Masalah klasik untuk memverifikasi keseimbangan tanda kurung dalam ekspresi |
| **Notasi Infix** | Penulisan ekspresi dengan operator di antara operand (A + B) |
| **Notasi Postfix (RPN)** | Penulisan ekspresi dengan operator setelah operand (A B +); tidak memerlukan tanda kurung |
| **Notasi Prefix** | Penulisan ekspresi dengan operator sebelum operand (+ A B) |
| **Algoritma Shunting-Yard** | Algoritma Dijkstra untuk mengonversi ekspresi infix ke postfix menggunakan stack |
| **Prioritas Operator** | Tingkatan yang menentukan operator mana yang dievaluasi lebih dahulu dalam ekspresi |
| **Asosiativitas** | Aturan yang menentukan urutan evaluasi untuk operator dengan prioritas sama (kiri atau kanan) |
| **Amortized Complexity** | Analisis kompleksitas yang merata-ratakan biaya operasi mahal yang jarang terjadi ke seluruh rangkaian operasi |
| **Rekursi** | Teknik pemrograman di mana fungsi memanggil dirinya sendiri; secara implisit menggunakan call stack |

---

## Soal Latihan

### Bagian A: Pilihan Ganda

**Soal 1 (C2 -- Memahami)**

Diberikan urutan operasi berikut pada stack yang awalnya kosong:
```
push(5), push(3), push(7), pop(), push(2), pop(), pop()
```
Apa nilai yang dikembalikan oleh tiga operasi `pop()` secara berurutan?

A. 7, 3, 5
B. 7, 2, 3
C. 5, 3, 7
D. 2, 7, 3

*(Jawaban: B. Setelah push 5, 3, 7: stack=[5,3,7]. pop()=7. push(2): stack=[5,3,2]. pop()=2. pop()=3. Urutan: 7, 2, 3.)*

---

**Soal 2 (C2 -- Memahami)**

Manakah pernyataan yang BENAR mengenai stack berbasis linked list dibandingkan berbasis array berkapasitas tetap?

A. Stack linked list lebih hemat memori karena tidak perlu menyimpan pointer.
B. Stack linked list memiliki batas kapasitas yang ditetapkan saat inisialisasi.
C. Stack linked list tidak pernah mengalami overflow selama memori sistem tersedia.
D. Operasi `pop` pada stack linked list memiliki kompleksitas O(n).

*(Jawaban: C. Linked list bersifat dinamis; overflow hanya terjadi jika seluruh memori sistem habis.)*

---

**Soal 3 (C3 -- Mengaplikasikan)**

Ekspresi infix `A * (B + C) - D / E` jika dikonversi ke notasi postfix menghasilkan:

A. `A B C + * D E / -`
B. `A B * C + D E / -`
C. `* A + B C - / D E`
D. `A B C * + D E - /`

*(Jawaban: A. Trace: A -> output; * -> push; ( -> push; B -> output; + -> push (di atas '('); C -> output; ) -> pop '+' ke output, buang '(', output: ABC+; - -> pop '*' ke output (prioritas lebih tinggi), push '-', output: ABC+*; D -> output; / -> push (prioritas lebih tinggi dari '-'); E -> output; flush: pop '/' lalu '-'. Hasil: ABC+*DE/-.)*

---

**Soal 4 (C4 -- Menganalisis)**

Perhatikan fungsi rekursif berikut:
```python
def faktorial(n):
    if n == 0:
        return 1
    return n * faktorial(n - 1)
```
Jika `faktorial(4)` dipanggil, berapa kedalaman maksimum call stack yang digunakan (termasuk frame `faktorial(4)` sendiri)?

A. 3
B. 4
C. 5
D. 6

*(Jawaban: C. Rantai pemanggilan: faktorial(4) -> faktorial(3) -> faktorial(2) -> faktorial(1) -> faktorial(0). Lima frame aktif secara bersamaan.)*

---

**Soal 5 (C4 -- Menganalisis)**

Perhatikan algoritma evaluasi postfix untuk ekspresi `5 3 2 * + 1 -`. Nilai akhir yang dihasilkan adalah:

A. 8
B. 10
C. 7
D. 14

*(Jawaban: B. Trace: push 5; push 3; push 2; pop 2 dan 3, push 3*2=6; pop 6 dan 5, push 5+6=11; push 1; pop 1 dan 11, push 11-1=10. Hasil: 10.)*

---

### Bagian B: Soal Uraian dan Implementasi

**Soal 6 (C3 -- Mengaplikasikan)**

Implementasikan fungsi Python `balik_string(s)` yang membalik sebuah string menggunakan stack, tanpa menggunakan slicing `[::-1]` atau fungsi `reversed()`. Tunjukkan trace eksekusi langkah per langkah untuk input `"STRUKTUR"`.

---

**Soal 7 (C4 -- Menganalisis)**

Tunjukkan trace eksekusi algoritma balanced parentheses secara manual (tampilkan isi stack di setiap langkah) untuk kedua ekspresi berikut, dan tentukan apakah masing-masing seimbang atau tidak:

a. `{[A*(B+C)]-D}`
b. `((A+B)*[C-D)`

---

**Soal 8 (C4 -- Menganalisis)**

Lakukan konversi manual dari ekspresi infix berikut ke notasi postfix menggunakan algoritma Shunting-Yard. Tampilkan isi stack operator dan output di setiap langkah:

a. `A*(B+C)-D/E`
b. `A^B^C+D*E`

---

**Soal 9 (C3 -- Mengaplikasikan)**

Sebuah algoritma menggunakan stack untuk memeriksa apakah sebuah string adalah palindrom (dibaca sama dari depan maupun belakang). Jelaskan algoritma tersebut dan implementasikan dalam Python. Uji dengan string `"KATAK"` dan `"MOBIL"`.

---

**Soal 10 (C5 -- Mengevaluasi)**

Bandingkan implementasi `StackArray` (kapasitas tetap), `StackDinamis` (list Python), dan `StackLinkedList` dari segi:
a. Kompleksitas waktu setiap operasi.
b. Penggunaan memori.
c. Situasi praktis yang paling cocok untuk masing-masing.
d. Kelebihan dan kekurangan masing-masing.

Berikan argumen yang didukung oleh analisis kompleksitas.

---

**Soal 11 (C5 -- Mengevaluasi)**

Sebuah tim pengembang sedang membangun sistem evaluasi ekspresi untuk aplikasi spreadsheet. Mereka mempertimbangkan dua pendekatan:

- **Pendekatan A**: Mengonversi infix ke postfix terlebih dahulu, kemudian mengevaluasi postfix.
- **Pendekatan B**: Mengevaluasi ekspresi infix secara langsung dengan menggunakan dua stack (satu untuk operand, satu untuk operator).

Evaluasi kedua pendekatan tersebut dari segi kompleksitas waktu, kemudahan implementasi, dan fleksibilitas untuk mendukung fungsi dengan banyak argumen (seperti `MAX(A, B, C)`). Pendekatan mana yang Anda rekomendasikan dan mengapa?

---

**Soal 12 (C6 -- Mencipta)**

Rancang dan implementasikan dalam Python sebuah kelas `BrowserHistory` yang mensimulasikan navigasi peramban web. Kelas tersebut harus mendukung operasi berikut:

- `visit(url)`: Mengunjungi URL baru (menghapus forward history).
- `back(k)`: Kembali `k` halaman ke belakang (jika `k` melebihi jumlah halaman, kembali ke halaman pertama).
- `forward(k)`: Maju `k` halaman ke depan (jika `k` melebihi jumlah halaman, maju ke halaman terakhir).
- `current()`: Mengembalikan URL halaman yang sedang dibuka.

Demonstrasikan penggunaan kelas tersebut dengan skenario navigasi yang mencakup minimal 5 kunjungan, 2 operasi back, 1 operasi forward, dan 1 kunjungan baru setelah back.

---

## Bacaan Lanjutan

1. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009).** *Introduction to Algorithms* (3rd ed.). MIT Press. -- Bab 10 mengenai Elementary Data Structures memberikan pembahasan stack yang ketat secara matematis, termasuk analisis kompleksitas formal dan bukti kebenaran algoritma. Rujukan standar untuk studi struktur data di tingkat lanjut.

2. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013).** *Data Structures and Algorithms in Python*. John Wiley & Sons. -- Bab 6 membahas stack dalam konteks Python secara lengkap, termasuk implementasi berorientasi objek yang mengikuti prinsip desain perangkat lunak yang baik. Sangat direkomendasikan bagi pembaca yang ingin memahami integrasi antara struktur data dan praktik pemrograman Python modern.

3. **Sedgewick, R., & Wayne, K. (2011).** *Algorithms* (4th ed.). Addison-Wesley Professional. -- Bab 1 menguraikan stack sebagai komponen fundamental dalam pemrograman. Buku ini menggunakan pendekatan yang sangat visual dan dilengkapi dengan contoh nyata dari berbagai domain aplikasi, mulai dari pemrosesan aritmetika hingga kompilasi program.

4. **Knuth, D. E. (1997).** *The Art of Computer Programming, Volume 1: Fundamental Algorithms* (3rd ed.). Addison-Wesley. -- Karya monumental yang membahas stack pada level yang sangat mendalam, termasuk analisis matematika yang ketat. Subbab 2.2.1 dan 2.3 membahas penerapan stack dalam berbagai algoritma klasik. Cocok untuk pembaca yang ingin memahami dasar teori komputasi dari perspektif historis.

5. **Miller, B. N., & Ranum, D. L. (2013).** *Problem Solving with Algorithms and Data Structures Using Python* (2nd ed.). Franklin, Beedle & Associates. -- Buku ajar yang ramah bagi pemula ini memiliki bab khusus tentang stack dengan pembahasan mendalam tentang balanced parentheses dan konversi infix-postfix menggunakan Python. Tersedia secara gratis secara daring di runestone.academy.

6. **Dijkstra, E. W. (1961).** *Mathematisch Centrum Report MR 35/61: An ALGOL 60 translator for the X1.* -- Dokumen historis asli di mana algoritma Shunting-Yard pertama kali dipublikasikan oleh Dijkstra sebagai bagian dari desain kompilator ALGOL 60. Tersedia secara daring melalui arsip EWD di Universitas Texas. Membacanya memberikan wawasan tentang cara berpikir insinyur perangkat lunak pada era perintis komputasi.

7. **Heineman, G. T., Pollice, G., & Selkow, S. (2016).** *Algorithms in a Nutshell: A Practical Guide* (2nd ed.). O'Reilly Media. -- Panduan praktis yang membahas stack dalam konteks implementasi nyata di berbagai bahasa pemrograman. Cocok sebagai referensi cepat ketika menghadapi masalah yang membutuhkan solusi berbasis stack dalam lingkungan produksi.

8. **Wengrow, J. (2020).** *A Common-Sense Guide to Data Structures and Algorithms* (2nd ed.). Pragmatic Bookshelf. -- Pendekatan intuitif dan tidak terlalu formal yang menjadikan buku ini sangat mudah dipahami. Bab mengenai stack memberikan analogi kehidupan nyata yang kaya dan penjelasan tentang mengapa stack menjadi komponen yang tak tergantikan dalam desain sistem perangkat lunak.

---

*Bab 7 akan membahas Queue (Antrian) -- struktur data linear berbasis prinsip FIFO (First In First Out) yang melengkapi pemahaman tentang stack dan memiliki berbagai aplikasi dalam sistem operasi, jaringan komputer, dan pemrosesan data berurutan.*
