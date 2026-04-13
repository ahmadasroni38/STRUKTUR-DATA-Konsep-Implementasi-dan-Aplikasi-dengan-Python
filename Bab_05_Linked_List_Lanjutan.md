# BAB 5
# LINKED LIST LANJUTAN: DOUBLY, CIRCULAR, DAN CIRCULAR DOUBLY LINKED LIST

---

> *"Keanggunan sebuah solusi perangkat lunak tidak diukur dari seberapa rumit kodenya, melainkan dari seberapa tepat struktur data yang dipilih mencerminkan hakikat masalah yang diselesaikan."*
>
> --- Donald E. Knuth, *The Art of Computer Programming*

---

## Tujuan Pembelajaran

Setelah mempelajari bab ini, mahasiswa diharapkan mampu:

1. **[C2 - Memahami]** Menjelaskan perbedaan struktural antara doubly linked list, circular linked list, dan circular doubly linked list, serta mendeskripsikan kondisi pointer pada masing-masing variasi tersebut.

2. **[C3 - Menerapkan]** Mengimplementasikan doubly linked list dalam bahasa Python, mencakup operasi penyisipan (di awal, di akhir, setelah simpul tertentu), penghapusan (di awal, di akhir, simpul tertentu), dan penelusuran dua arah.

3. **[C3 - Menerapkan]** Mengimplementasikan circular linked list dan circular doubly linked list menggunakan pointer `tail` sebagai acuan, serta mengelola kondisi melingkar secara konsisten pada setiap operasi.

4. **[C4 - Menganalisis]** Menganalisis kompleksitas waktu dan ruang dari setiap operasi pada keempat variasi linked list (singly, doubly, circular, circular doubly), serta mengidentifikasi kondisi yang menyebabkan perbedaan efisiensi di antara keempat variasi tersebut.

5. **[C4 - Menganalisis]** Menjelaskan konsep sentinel node, menganalisis keuntungannya dibandingkan implementasi tanpa sentinel, dan mengidentifikasi kasus-kasus di mana teknik ini paling menguntungkan.

6. **[C5 - Mengevaluasi]** Mengevaluasi dan memilih variasi linked list yang paling sesuai untuk skenario permasalahan tertentu berdasarkan pertimbangan efisiensi operasi, penggunaan memori, dan kemudahan implementasi.

7. **[C6 - Mencipta]** Merancang dan mengimplementasikan solusi perangkat lunak berbasis doubly linked list untuk studi kasus nyata, khususnya sistem riwayat navigasi browser dengan fitur undo dan redo.

8. **[C6 - Mencipta]** Mengembangkan variasi implementasi linked list yang menggabungkan fitur circular dan doubly untuk memenuhi kebutuhan aplikasi yang memerlukan navigasi dua arah sekaligus penelusuran melingkar.

---

## 5.1 Pendahuluan: Keterbatasan Singly Linked List dan Kebutuhan Variasi Lanjutan

Pada bab sebelumnya telah dibahas singly linked list sebagai struktur data linier yang setiap simpulnya menyimpan satu pointer menuju simpul berikutnya. Struktur ini menawarkan kesederhanaan implementasi dan efisiensi operasi penyisipan di posisi awal. Namun, singly linked list memiliki keterbatasan yang menjadi kendala nyata dalam banyak skenario aplikasi dunia nyata.

Pertimbangkan dua skenario berikut. Pertama, sebuah peramban web (web browser) perlu mengelola riwayat halaman yang dikunjungi oleh pengguna. Pengguna dapat menekan tombol "Back" untuk kembali ke halaman sebelumnya dan tombol "Forward" untuk maju ke halaman berikutnya. Dengan singly linked list, navigasi mundur menuntut penelusuran ulang dari awal daftar setiap kali tombol "Back" ditekan, menghasilkan kompleksitas O(n) yang tidak dapat diterima untuk aplikasi yang responsif. Doubly linked list, dengan pointer dua arahnya, memberikan solusi elegan: setiap simpul dapat langsung meloncat ke pendahulunya maupun penerusnya dalam O(1).

Kedua, sebuah aplikasi pemutar musik (music player) dengan mode "Putar Berulang" (Repeat All) perlu memastikan bahwa setelah lagu terakhir dalam daftar putar selesai dimainkan, lagu pertama secara otomatis dimulai kembali. Dengan singly linked list biasa, ketika penelusuran mencapai simpul terakhir dan menemukan nilai `None` pada pointer `next`-nya, program harus secara eksplisit kembali ke head. Circular linked list menyelesaikan masalah ini secara struktural: pointer `next` dari simpul terakhir langsung menunjuk kembali ke simpul pertama, sehingga penelusuran yang terus-menerus secara alami bersifat melingkar tanpa memerlukan penanganan kasus khusus.

Bab ini membahas tiga variasi lanjutan dari linked list yang mengatasi keterbatasan singly linked list: doubly linked list, circular linked list, dan circular doubly linked list. Selain ketiga variasi tersebut, diperkenalkan pula teknik sentinel node sebagai pendekatan yang elegan untuk menyederhanakan implementasi. Pemahaman atas topik-topik ini memberikan fondasi yang kokoh bagi mahasiswa dalam memilih dan merancang struktur data yang tepat untuk berbagai permasalahan komputasi.

---

## 5.2 Doubly Linked List

### 5.2.1 Definisi dan Representasi Struktural

Doubly linked list (DLL) adalah variasi dari linked list di mana setiap simpul memiliki tiga komponen: bidang data yang menyimpan nilai, pointer `prev` yang menunjuk ke simpul pendahulunya, dan pointer `next` yang menunjuk ke simpul penerusnya. Simpul pertama dalam daftar memiliki `prev = None`, menandai bahwa tidak ada simpul di sebelah kirinya. Simpul terakhir memiliki `next = None`, menandai ujung kanan daftar.

Perbedaan mendasar dengan singly linked list dapat divisualisasikan melalui perbandingan struktur simpul berikut:

**Gambar 5.1 Perbandingan Struktur Simpul Singly dan Doubly Linked List**

```
Singly Linked List Node:
+------------+----------+
|    data    |   next   |
+------------+----------+
  (2 bidang)

Doubly Linked List Node:
+----------+------------+----------+
|   prev   |    data    |   next   |
+----------+------------+----------+
  (3 bidang)
```

Dengan penambahan pointer `prev`, doubly linked list memungkinkan penelusuran dua arah yang efisien. Dari simpul mana pun, seluruh daftar dapat dilintasi baik ke kanan (maju) maupun ke kiri (mundur) tanpa perlu memulai ulang dari salah satu ujung.

**Gambar 5.2 Representasi ASCII Doubly Linked List dengan Empat Simpul**

```
         +-----------+       +-----------+       +-----------+       +-----------+
None <-- |prev| 5|next| <--> |prev|10|next| <--> |prev|20|next| <--> |prev|30|next| --> None
         +-----------+       +-----------+       +-----------+       +-----------+
              ^                                                            ^
             head                                                        tail
```

Secara formal, struktur doubly linked list dapat didefinisikan sebagai berikut:

- Terdapat simpul `head` yang merupakan simpul pertama (paling kiri), dengan `head.prev = None`.
- Terdapat simpul `tail` yang merupakan simpul terakhir (paling kanan), dengan `tail.next = None`.
- Untuk setiap simpul `v` yang bukan head dan bukan tail, berlaku: `v.prev.next = v` dan `v.next.prev = v` (konsistensi pointer dua arah).
- Daftar kosong direpresentasikan dengan `head = None` dan `tail = None`.

---

> **Catatan Penting 5.1: Konsistensi Pointer pada Doubly Linked List**
>
> Ketika memodifikasi doubly linked list, pemrogram harus selalu memperbarui pointer dari kedua arah secara konsisten. Setiap operasi penyisipan atau penghapusan melibatkan pembaruan hingga empat pointer sekaligus. Kegagalan memperbarui salah satu pointer akan menyebabkan inkonsistensi struktur yang sulit di-debug. Sebagai praktik terbaik, gambarlah diagram perubahan pointer sebelum menulis kode.

---

### 5.2.2 Implementasi Python: Doubly Linked List

Berikut adalah implementasi lengkap doubly linked list dalam Python dengan penjelasan setiap operasi:

```python
class Node:
    """Simpul untuk doubly linked list.

    Attributes:
        data: Nilai yang disimpan dalam simpul.
        prev: Pointer ke simpul pendahulu (atau None jika simpul pertama).
        next: Pointer ke simpul penerus (atau None jika simpul terakhir).
    """

    def __init__(self, data):
        self.data = data
        self.prev = None
        self.next = None

    def __repr__(self):
        return f"Node({self.data})"


class DoublyLinkedList:
    """
    Implementasi Doubly Linked List.

    Mempertahankan pointer head dan tail agar operasi penyisipan
    dan penghapusan di kedua ujung dapat dilakukan dalam O(1).

    Referensi: Goodrich, Tamassia, & Goldwasser (2013), Bab 3, Section 3.3.
    """

    def __init__(self):
        self.head = None
        self.tail = None
        self._size = 0

    def __len__(self):
        return self._size

    def is_empty(self):
        """Memeriksa apakah daftar kosong."""
        return self._size == 0

    # ------------------------------------------------------------------
    # Operasi Penyisipan
    # ------------------------------------------------------------------

    def add_first(self, data):
        """
        Menyisipkan elemen baru di posisi awal daftar. O(1).

        Setelah operasi ini, simpul baru menjadi head baru.
        Pointer prev dari head lama diperbarui untuk menunjuk ke simpul baru.

        Contoh:
            Sebelum: [10] <--> [20] <--> [30]
            add_first(5)
            Sesudah: [5] <--> [10] <--> [20] <--> [30]
        """
        new_node = Node(data)
        if self.is_empty():
            self.head = new_node
            self.tail = new_node
        else:
            new_node.next = self.head
            self.head.prev = new_node
            self.head = new_node
        self._size += 1

    def add_last(self, data):
        """
        Menyisipkan elemen baru di posisi akhir daftar. O(1).

        Menggunakan pointer tail agar operasi ini tidak memerlukan
        penelusuran ke akhir daftar.

        Contoh:
            Sebelum: [5] <--> [10] <--> [20]
            add_last(30)
            Sesudah: [5] <--> [10] <--> [20] <--> [30]
        """
        new_node = Node(data)
        if self.is_empty():
            self.head = new_node
            self.tail = new_node
        else:
            new_node.prev = self.tail
            self.tail.next = new_node
            self.tail = new_node
        self._size += 1

    def add_after(self, target_data, new_data):
        """
        Menyisipkan elemen baru tepat setelah simpul dengan nilai target. O(n).

        Menelusuri daftar untuk menemukan target, kemudian menyisipkan
        simpul baru di antara target dan penerusnya.

        Args:
            target_data: Nilai simpul yang menjadi acuan penyisipan.
            new_data: Nilai simpul baru yang akan disisipkan.

        Returns:
            True jika berhasil, False jika target tidak ditemukan.
        """
        current = self.head
        while current is not None:
            if current.data == target_data:
                new_node = Node(new_data)
                new_node.prev = current
                new_node.next = current.next
                if current.next is not None:
                    current.next.prev = new_node
                else:
                    # current adalah tail, simpul baru menjadi tail baru
                    self.tail = new_node
                current.next = new_node
                self._size += 1
                return True
            current = current.next
        return False

    # ------------------------------------------------------------------
    # Operasi Penghapusan
    # ------------------------------------------------------------------

    def remove_first(self):
        """
        Menghapus dan mengembalikan elemen pertama. O(1).

        Setelah operasi ini, simpul kedua (jika ada) menjadi head baru
        dengan nilai prev diatur ke None.

        Returns:
            Data dari simpul yang dihapus, atau None jika daftar kosong.
        """
        if self.is_empty():
            return None
        data = self.head.data
        if self._size == 1:
            self.head = None
            self.tail = None
        else:
            self.head = self.head.next
            self.head.prev = None
        self._size -= 1
        return data

    def remove_last(self):
        """
        Menghapus dan mengembalikan elemen terakhir. O(1).

        Inilah keunggulan doubly linked list atas singly linked list:
        karena tersedia pointer prev, simpul pendahulu tail dapat
        diakses langsung tanpa penelusuran O(n).

        Returns:
            Data dari simpul yang dihapus, atau None jika daftar kosong.
        """
        if self.is_empty():
            return None
        data = self.tail.data
        if self._size == 1:
            self.head = None
            self.tail = None
        else:
            self.tail = self.tail.prev
            self.tail.next = None
        self._size -= 1
        return data

    def remove(self, target_data):
        """
        Menghapus simpul pertama yang memiliki nilai target. O(n).

        Setelah simpul ditemukan, penghapusannya sendiri adalah O(1)
        karena tersedia pointer prev dan next.

        Args:
            target_data: Nilai simpul yang akan dihapus.

        Returns:
            True jika berhasil, False jika tidak ditemukan.
        """
        current = self.head
        while current is not None:
            if current.data == target_data:
                if current.prev is not None:
                    current.prev.next = current.next
                else:
                    self.head = current.next
                if current.next is not None:
                    current.next.prev = current.prev
                else:
                    self.tail = current.prev
                self._size -= 1
                return True
            current = current.next
        return False

    # ------------------------------------------------------------------
    # Operasi Penelusuran
    # ------------------------------------------------------------------

    def search(self, target_data):
        """
        Mencari dan mengembalikan simpul dengan nilai target. O(n).

        Returns:
            Objek simpul yang ditemukan, atau None.
        """
        current = self.head
        while current is not None:
            if current.data == target_data:
                return current
            current = current.next
        return None

    def traverse_forward(self):
        """Menelusuri dan mengembalikan semua nilai dari head ke tail. O(n)."""
        elements = []
        current = self.head
        while current is not None:
            elements.append(current.data)
            current = current.next
        return elements

    def traverse_backward(self):
        """Menelusuri dan mengembalikan semua nilai dari tail ke head. O(n)."""
        elements = []
        current = self.tail
        while current is not None:
            elements.append(current.data)
            current = current.prev
        return elements

    def __repr__(self):
        elements = self.traverse_forward()
        return "None <-> " + " <-> ".join(str(e) for e in elements) + " <-> None"


# ======================================================================
# Demonstrasi penggunaan DoublyLinkedList
# ======================================================================
if __name__ == "__main__":
    dll = DoublyLinkedList()

    dll.add_last(10)
    dll.add_last(20)
    dll.add_last(30)
    dll.add_first(5)
    print("Setelah penambahan:", dll)
    # Output: None <-> 5 <-> 10 <-> 20 <-> 30 <-> None

    print("Penelusuran mundur:", dll.traverse_backward())
    # Output: [30, 20, 10, 5]

    dll.add_after(20, 25)
    print("Setelah add_after(20, 25):", dll)
    # Output: None <-> 5 <-> 10 <-> 20 <-> 25 <-> 30 <-> None

    dll.remove(10)
    print("Setelah remove(10):", dll)
    # Output: None <-> 5 <-> 20 <-> 25 <-> 30 <-> None

    print("Ukuran daftar:", len(dll))
    # Output: 4
```

### 5.2.3 Analisis Kompleksitas Doubly Linked List

Tabel berikut merangkum kompleksitas waktu untuk setiap operasi pada doubly linked list yang mempertahankan pointer `head` dan `tail`.

**Tabel 5.1 Kompleksitas Waktu Operasi Doubly Linked List**

| Operasi             | Kompleksitas Waktu | Keterangan                                                  |
|---------------------|--------------------|-------------------------------------------------------------|
| `add_first`         | O(1)               | Hanya perlu memperbarui head dan dua pointer tetangga       |
| `add_last`          | O(1)               | Menggunakan pointer tail, tidak perlu penelusuran           |
| `add_after(target)` | O(n)               | Perlu penelusuran linier untuk menemukan target             |
| `remove_first`      | O(1)               | Hanya perlu memperbarui head dan pointer prev head baru     |
| `remove_last`       | O(1)               | Menggunakan pointer tail dan prev-nya, tidak perlu telusuri |
| `remove(target)`    | O(n)               | Perlu penelusuran linier; penghapusan itu sendiri O(1)      |
| `search`            | O(n)               | Penelusuran linier dalam kasus terburuk                     |
| `traverse_forward`  | O(n)               | Mengunjungi semua n simpul                                  |
| `traverse_backward` | O(n)               | Mengunjungi semua n simpul dari arah sebaliknya             |

Kompleksitas ruang doubly linked list adalah O(n), di mana setiap simpul mengonsumsi memori untuk bidang data ditambah dua pointer. Dibandingkan dengan singly linked list, overhead memori per simpul lebih besar sebesar satu pointer, yang dalam implementasi Python berukuran 8 byte pada sistem 64-bit.

---

> **Tahukah Anda? 5.1**
>
> Mengapa `remove_last` pada singly linked list adalah O(n) bahkan ketika pointer `tail` tersedia? Jawabannya terletak pada ketiadaan pointer `prev`. Untuk menghapus tail, kita perlu mengetahui simpul pendahulunya agar pointer `next`-nya dapat diatur ke `None`. Pada singly linked list, satu-satunya cara menemukan pendahulu tail adalah menelusuri seluruh daftar dari head, memakan waktu O(n). Inilah motivasi utama penambahan pointer `prev` pada doubly linked list: `remove_last` menjadi O(1) karena pendahulu tail dapat langsung diakses melalui `tail.prev`.

---

### 5.2.4 Perbandingan Singly dan Doubly Linked List

**Tabel 5.2 Perbandingan Singly Linked List dan Doubly Linked List**

| Aspek                        | Singly Linked List         | Doubly Linked List                  |
|------------------------------|----------------------------|-------------------------------------|
| Pointer per simpul           | 1 (next)                   | 2 (prev, next)                      |
| Penggunaan memori per simpul | data + 1 referensi         | data + 2 referensi                  |
| Kompleksitas `add_last`      | O(n) tanpa tail; O(1) dengan tail | O(1) dengan tail               |
| Kompleksitas `remove_last`   | O(n) meskipun ada tail     | O(1) dengan tail                    |
| Penelusuran mundur           | Tidak efisien (O(n) dari head) | Efisien O(n) dari tail, O(1) satu langkah |
| Penghapusan simpul yang diketahui | O(n) (perlu cari prev) | O(1) (prev tersedia)               |
| Kompleksitas implementasi    | Lebih sederhana            | Lebih kompleks                      |
| Kasus penggunaan utama       | Stack, queue sederhana     | Browser history, undo/redo, deque   |

---

## 5.3 Circular Linked List

### 5.3.1 Konsep dan Motivasi

Circular linked list (CLL) adalah variasi singly linked list di mana pointer `next` dari simpul terakhir tidak bernilai `None`, melainkan menunjuk kembali ke simpul pertama, membentuk struktur siklus tertutup. Dengan demikian, tidak ada simpul yang memiliki nilai `None` pada pointer `next`-nya.

Motivasi desain ini berasal dari kebutuhan aplikasi yang bersifat siklik. Pada sistem penjadwalan round-robin dalam sistem operasi, setiap proses mendapat giliran CPU secara bergantian tanpa ada proses yang secara permanen menjadi "terakhir". Pada pemutar musik dengan mode pengulangan, setelah lagu terakhir selesai, lagu pertama harus otomatis dimulai. Kedua skenario ini secara alami dimodelkan oleh struktur melingkar.

**Gambar 5.3 Representasi ASCII Circular Linked List**

```
head
 |
 v
+-------+    +-------+    +-------+    +-------+
|10|next|--->|20|next|--->|30|next|--->|40|next|---+
+-------+    +-------+    +-------+    +-------+   |
  ^                                                 |
  |_________________________________________________|
                  (tail.next = head)
```

Atau dalam representasi yang menekankan sifat melingkar:

```
       +-------------------------------------------+
       |                                           |
       v                                           |
     [10] ------> [20] ------> [30] ------> [40]--+
       ^
      head
     (tail = simpul dengan next menunjuk ke head)
```

**Perbedaan kunci** dalam penelusuran: kondisi berhenti bukan lagi `current is None`, melainkan `current is head` (setelah satu putaran penuh) atau lebih andal menggunakan counter untuk membatasi jumlah iterasi sebanyak `n` kali.

### 5.3.2 Pilihan Desain: Pointer Tail vs. Pointer Head

Meskipun secara konseptual head adalah titik acuan yang intuitif, implementasi yang lebih efisien menggunakan pointer `tail` sebagai satu-satunya referensi yang disimpan. Alasannya: dengan `tail`, kita dapat mengakses `head` melalui `tail.next`, sehingga baik operasi `add_first` maupun `add_last` dapat dilakukan dalam O(1). Jika hanya menyimpan `head`, operasi `add_last` memerlukan penelusuran O(n) untuk menemukan tail.

### 5.3.3 Implementasi Python: Circular Linked List

```python
class CNode:
    """Simpul untuk circular linked list.

    Attributes:
        data: Nilai yang disimpan.
        next: Pointer ke simpul berikutnya (tidak pernah None pada
              list yang tidak kosong).
    """

    def __init__(self, data):
        self.data = data
        self.next = None

    def __repr__(self):
        return f"CNode({self.data})"


class CircularLinkedList:
    """
    Implementasi Circular Linked List dengan referensi tail.

    Dengan menyimpan pointer tail (bukan head), operasi add_first
    dan add_last sama-sama O(1). Head diakses melalui tail.next.

    Referensi: Goodrich, Tamassia, & Goldwasser (2013), Bab 3, Section 3.4.
    """

    def __init__(self):
        self.tail = None    # tail.next = head (saat tidak kosong)
        self._size = 0

    def __len__(self):
        return self._size

    def is_empty(self):
        return self._size == 0

    @property
    def head(self):
        """Properti untuk mengakses head melalui tail."""
        if self.tail is None:
            return None
        return self.tail.next

    # ------------------------------------------------------------------
    # Operasi Penyisipan
    # ------------------------------------------------------------------

    def add_first(self, data):
        """
        Menyisipkan elemen baru di posisi awal (sesudah tail, sebelum head
        lama). Kompleksitas O(1).

        Simpul baru ditempatkan antara tail dan head lama:
            Sebelum: ... --> [tail] --> [head_lama] --> ...
            Sesudah: ... --> [tail] --> [baru] --> [head_lama] --> ...
        """
        new_node = CNode(data)
        if self.is_empty():
            new_node.next = new_node    # menunjuk ke diri sendiri
            self.tail = new_node
        else:
            new_node.next = self.tail.next    # new_node.next = head lama
            self.tail.next = new_node         # tail.next = head baru
        self._size += 1

    def add_last(self, data):
        """
        Menyisipkan elemen baru di posisi akhir. Kompleksitas O(1).

        Simpul baru ditempatkan antara tail lama dan head:
            Sebelum: ... --> [tail_lama] --> [head] --> ...
            Sesudah: ... --> [tail_lama] --> [baru] --> [head] --> ...
                                              ^
                                           tail baru
        """
        new_node = CNode(data)
        if self.is_empty():
            new_node.next = new_node
            self.tail = new_node
        else:
            new_node.next = self.tail.next    # new_node.next = head
            self.tail.next = new_node         # tail lama -> new_node
            self.tail = new_node              # tail baru = new_node
        self._size += 1

    # ------------------------------------------------------------------
    # Operasi Penghapusan
    # ------------------------------------------------------------------

    def remove_first(self):
        """
        Menghapus dan mengembalikan elemen pertama (head). Kompleksitas O(1).

        Setelah penghapusan, tail.next diperbarui ke simpul yang
        sebelumnya adalah head.next.

        Returns:
            Data dari simpul yang dihapus, atau None jika daftar kosong.
        """
        if self.is_empty():
            return None
        old_head = self.tail.next
        data = old_head.data
        if self._size == 1:
            self.tail = None
        else:
            self.tail.next = old_head.next    # tail.next = head baru
        self._size -= 1
        return data

    def remove(self, target_data):
        """
        Menghapus simpul dengan nilai target. Kompleksitas O(n).

        Menggunakan iterator berbasis counter untuk menghindari
        penelusuran tak terbatas pada struktur melingkar.

        Returns:
            True jika berhasil, False jika tidak ditemukan.
        """
        if self.is_empty():
            return False

        prev = self.tail
        current = self.tail.next    # mulai dari head
        for _ in range(self._size):
            if current.data == target_data:
                if self._size == 1:
                    self.tail = None
                else:
                    prev.next = current.next
                    if current is self.tail:
                        self.tail = prev
                self._size -= 1
                return True
            prev = current
            current = current.next
        return False

    # ------------------------------------------------------------------
    # Operasi Penelusuran
    # ------------------------------------------------------------------

    def traverse(self):
        """
        Menelusuri seluruh daftar satu kali putaran. Kompleksitas O(n).

        Menggunakan counter sebagai kondisi berhenti (bukan None check)
        karena struktur melingkar tidak memiliki simpul yang bernilai None.
        """
        if self.is_empty():
            return []
        elements = []
        current = self.tail.next    # mulai dari head
        for _ in range(self._size):
            elements.append(current.data)
            current = current.next
        return elements

    def __repr__(self):
        if self.is_empty():
            return "Circular: (kosong)"
        elements = self.traverse()
        return "Circular: " + " --> ".join(str(e) for e in elements) + " --> (kembali ke awal)"


# ======================================================================
# Demonstrasi penggunaan CircularLinkedList
# ======================================================================
if __name__ == "__main__":
    cll = CircularLinkedList()

    cll.add_last(10)
    cll.add_last(20)
    cll.add_last(30)
    cll.add_first(5)
    print(cll)
    # Output: Circular: 5 --> 10 --> 20 --> 30 --> (kembali ke awal)

    print("Head:", cll.head.data)    # 5
    print("Tail:", cll.tail.data)    # 30
    print("Tail.next adalah Head?", cll.tail.next is cll.head)    # True

    cll.remove_first()
    print("Setelah remove_first:", cll)
    # Output: Circular: 10 --> 20 --> 30 --> (kembali ke awal)

    cll.remove(20)
    print("Setelah remove(20):", cll)
    # Output: Circular: 10 --> 30 --> (kembali ke awal)

    print("Ukuran:", len(cll))    # 2
```

### 5.3.4 Kasus Penggunaan Circular Linked List

Circular linked list sangat tepat untuk skenario-skenario berikut:

1. **Penjadwalan Round-Robin**: Sistem operasi mengalokasikan slice waktu CPU kepada setiap proses secara bergantian. Setelah proses terakhir mendapat gilirannya, sistem secara otomatis kembali ke proses pertama. Circular linked list memodelkan antrian proses ini secara natural.

2. **Pemutar Musik dengan Mode Ulangi Semua**: Navigasi antar-lagu secara berulang tanpa perlu pengecekan batas eksplisit.

3. **Permainan Berbasis Giliran**: Dalam permainan multipemain, giliran setiap pemain berputar secara siklik. Pointer hanya perlu bergerak ke simpul berikutnya, dan setelah pemain terakhir, secara otomatis kembali ke pemain pertama.

4. **Buffer Melingkar (Ring Buffer)**: Digunakan pada aliran data (data streaming) audio dan video, di mana data yang masuk dituliskan ke lokasi berikutnya dalam buffer melingkar, menimpa data lama yang sudah tidak diperlukan.

---

> **Tahukah Anda? 5.2**
>
> Sistem operasi Unix/Linux menggunakan varian dari struktur circular linked list dalam penjadwal proses (process scheduler). Daftar proses yang siap dieksekusi (ready queue) dikelola sebagai antrian melingkar sehingga CPU time sharing dapat berjalan secara terus-menerus dan adil di antara semua proses yang aktif.

---

## 5.4 Circular Doubly Linked List

### 5.4.1 Konsep dan Motivasi

Circular doubly linked list (CDLL) merupakan gabungan dari dua variasi sebelumnya: setiap simpul memiliki dua pointer (`prev` dan `next`) layaknya doubly linked list, dan struktur keseluruhannya melingkar seperti circular linked list. Dengan kata lain, pointer `next` dari simpul terakhir menunjuk ke head, dan pointer `prev` dari head menunjuk ke tail.

CDLL adalah struktur yang paling lengkap di antara keempat variasi linked list. Ia mendukung navigasi dua arah sekaligus pengulangan alami, membuatnya ideal untuk aplikasi yang memerlukan kedua sifat tersebut, seperti daftar putar musik dengan navigasi lagu sebelumnya dan berikutnya yang bersifat melingkar.

**Gambar 5.4 Representasi ASCII Circular Doubly Linked List**

```
+-----------------------------------------------------------+
|                                                           |
|   +-----------+       +-----------+       +-----------+  |
+-->|prev|10|next| <--> |prev|20|next| <--> |prev|30|next|--+
    +-----------+       +-----------+       +-----------+
         ^                                       ^
        head                                   tail
```

Kondisi pointer pada CDLL:

```
head.prev = tail          (pointer mundur dari head kembali ke tail)
tail.next = head          (pointer maju dari tail kembali ke head)

Untuk setiap simpul v selain head dan tail:
    v.prev.next = v  dan  v.next.prev = v
```

### 5.4.2 Teknik Sentinel Node

Sebelum menyajikan implementasi CDLL, penting untuk memperkenalkan teknik sentinel node (juga dikenal sebagai dummy node atau header node), yang akan digunakan dalam implementasi ini.

Sentinel node adalah simpul tambahan yang tidak menyimpan data bermakna, tetapi berfungsi sebagai penanda batas struktur. Dalam konteks CDLL, sentinel ditempatkan secara permanen dalam daftar dan tidak pernah dihapus. Semua simpul data nyata berada di antara sentinel dan dirinya sendiri (karena melingkar).

**Gambar 5.5 Ilustrasi Sentinel pada Daftar Kosong**

```
          +---------------------------+
          |                           |
          v                           |
    +------------------+              |
    | prev|SENTINEL|next |-----------+
    +------------------+
```

Ketika daftar kosong, sentinel menunjuk ke dirinya sendiri dari kedua arah: `sentinel.next = sentinel` dan `sentinel.prev = sentinel`.

**Gambar 5.6 Ilustrasi Sentinel pada Daftar dengan Tiga Elemen**

```
    +-----------------------------------------------------------------+
    |                                                                 |
    |  +----------+     +----------+     +----------+     +-------+  |
    +->|prev|S|next| <-> |prev|10|next| <-> |prev|20|next| <-> |prev|30|next| --+
       +----------+     +----------+     +----------+     +----------+
       (sentinel)            head                              tail
```

Atau lebih ringkas:

```
[sentinel] <--> [10] <--> [20] <--> [30] <--> [sentinel]
    ^                                               |
    |_______________________________________________|
                     (melingkar)
```

Keunggulan sentinel dibandingkan implementasi tanpa sentinel:

1. **Eliminasi kasus tepi**: Tanpa sentinel, metode `add_first` harus memeriksa apakah daftar kosong sebelum memodifikasi pointer. Dengan sentinel, `sentinel.next` selalu valid (menunjuk ke head nyata atau ke sentinel sendiri saat kosong), sehingga pemeriksaan tersebut tidak diperlukan.

2. **Metode internal yang universal**: Operasi `_insert_between(predecessor, successor)` dan `_delete_node(node)` bekerja secara identik untuk semua posisi tanpa kondisi khusus.

3. **Kode yang lebih bersih dan mudah dipelihara**: Pengurangan pengecekan kondisi mengurangi jumlah cabang logika (branches) dan menurunkan kemungkinan bug.

---

> **Catatan Penting 5.2: Sentinel Bukan Kepala yang Sebenarnya**
>
> Penting untuk dipahami bahwa sentinel node tidak mengandung data yang bermakna dan tidak dihitung sebagai anggota daftar. Ketika menampilkan atau memproses isi daftar, iterasi harus dimulai dari `sentinel.next` dan berhenti ketika kembali ke sentinel (bukan ketika menemukan None, karena pada CDLL tidak ada None). Atribut `_size` juga tidak mencakup sentinel dalam hitungannya.

---

### 5.4.3 Implementasi Python: Circular Doubly Linked List dengan Sentinel

```python
class CDNode:
    """Simpul untuk circular doubly linked list.

    Attributes:
        data: Nilai yang disimpan (None untuk sentinel).
        prev: Pointer ke simpul pendahulu.
        next: Pointer ke simpul penerus.
    """

    def __init__(self, data):
        self.data = data
        self.prev = None
        self.next = None

    def __repr__(self):
        return f"CDNode({self.data})"


class CircularDoublyLinkedList:
    """
    Implementasi Circular Doubly Linked List dengan sentinel node.

    Sentinel node memungkinkan semua operasi penyisipan dan penghapusan
    dilakukan melalui dua metode internal universal:
    - _insert_between: untuk semua penyisipan
    - _delete_node: untuk semua penghapusan

    Tanpa pengecekan kondisi khusus (empty list, boundary cases).

    Referensi: Goodrich, Tamassia, & Goldwasser (2013), Bab 3, Section 3.3.3.
    """

    def __init__(self):
        # Sentinel node: tidak menyimpan data nyata
        self._sentinel = CDNode(None)
        self._sentinel.next = self._sentinel
        self._sentinel.prev = self._sentinel
        self._size = 0

    def __len__(self):
        return self._size

    def is_empty(self):
        return self._size == 0

    @property
    def head(self):
        """Simpul pertama yang berisi data nyata (setelah sentinel)."""
        if self.is_empty():
            return None
        return self._sentinel.next

    @property
    def tail(self):
        """Simpul terakhir yang berisi data nyata (sebelum sentinel)."""
        if self.is_empty():
            return None
        return self._sentinel.prev

    def _insert_between(self, data, predecessor, successor):
        """
        Menyisipkan simpul baru di antara predecessor dan successor. O(1).

        Metode internal universal yang digunakan oleh semua operasi
        penyisipan. Karena sentinel selalu valid, tidak diperlukan
        pengecekan kondisi tepi.

        Diagram perubahan pointer:
            Sebelum: predecessor <--> successor
            Sesudah: predecessor <--> new_node <--> successor
        """
        new_node = CDNode(data)
        new_node.prev = predecessor
        new_node.next = successor
        predecessor.next = new_node
        successor.prev = new_node
        self._size += 1
        return new_node

    def _delete_node(self, node):
        """
        Menghapus simpul yang sudah diketahui referensinya. O(1).

        Metode internal universal yang digunakan oleh semua operasi
        penghapusan.

        Diagram perubahan pointer:
            Sebelum: predecessor <--> node <--> successor
            Sesudah: predecessor <--> successor
        """
        predecessor = node.prev
        successor = node.next
        predecessor.next = successor
        successor.prev = predecessor
        self._size -= 1
        return node.data

    # ------------------------------------------------------------------
    # Operasi Penyisipan
    # ------------------------------------------------------------------

    def add_first(self, data):
        """
        Menyisipkan di posisi pertama (antara sentinel dan head lama). O(1).
        """
        return self._insert_between(data, self._sentinel, self._sentinel.next)

    def add_last(self, data):
        """
        Menyisipkan di posisi terakhir (antara tail lama dan sentinel). O(1).
        """
        return self._insert_between(data, self._sentinel.prev, self._sentinel)

    def add_after(self, target_data, new_data):
        """
        Menyisipkan setelah simpul dengan nilai target. O(n).
        """
        current = self._sentinel.next
        while current is not self._sentinel:
            if current.data == target_data:
                self._insert_between(new_data, current, current.next)
                return True
            current = current.next
        return False

    # ------------------------------------------------------------------
    # Operasi Penghapusan
    # ------------------------------------------------------------------

    def remove_first(self):
        """Menghapus dan mengembalikan elemen pertama. O(1)."""
        if self.is_empty():
            return None
        return self._delete_node(self._sentinel.next)

    def remove_last(self):
        """Menghapus dan mengembalikan elemen terakhir. O(1)."""
        if self.is_empty():
            return None
        return self._delete_node(self._sentinel.prev)

    def remove(self, target_data):
        """Menghapus simpul dengan nilai target. O(n)."""
        current = self._sentinel.next
        while current is not self._sentinel:
            if current.data == target_data:
                self._delete_node(current)
                return True
            current = current.next
        return False

    # ------------------------------------------------------------------
    # Operasi Penelusuran
    # ------------------------------------------------------------------

    def traverse_forward(self):
        """Penelusuran maju dari head ke tail, berhenti di sentinel. O(n)."""
        elements = []
        current = self._sentinel.next
        while current is not self._sentinel:
            elements.append(current.data)
            current = current.next
        return elements

    def traverse_backward(self):
        """Penelusuran mundur dari tail ke head, berhenti di sentinel. O(n)."""
        elements = []
        current = self._sentinel.prev
        while current is not self._sentinel:
            elements.append(current.data)
            current = current.prev
        return elements

    def __repr__(self):
        elements = self.traverse_forward()
        if not elements:
            return "CDLL: (kosong)"
        return "CDLL: [sentinel] <--> " + " <--> ".join(str(e) for e in elements) + " <--> [sentinel]"


# ======================================================================
# Demonstrasi penggunaan CircularDoublyLinkedList
# ======================================================================
if __name__ == "__main__":
    cdll = CircularDoublyLinkedList()

    cdll.add_last(10)
    cdll.add_last(20)
    cdll.add_last(30)
    cdll.add_first(5)
    print(cdll)
    # Output: CDLL: [sentinel] <--> 5 <--> 10 <--> 20 <--> 30 <--> [sentinel]

    print("Head:", cdll.head.data)    # 5
    print("Tail:", cdll.tail.data)    # 30

    # Verifikasi sifat melingkar melalui sentinel
    print("sentinel.next.data:", cdll._sentinel.next.data)    # 5 (head)
    print("sentinel.prev.data:", cdll._sentinel.prev.data)    # 30 (tail)

    cdll.add_after(20, 25)
    print("Setelah add_after(20, 25):", cdll)
    # Output: CDLL: [sentinel] <--> 5 <--> 10 <--> 20 <--> 25 <--> 30 <--> [sentinel]

    cdll.remove_last()
    print("Setelah remove_last:", cdll)
    # Output: CDLL: [sentinel] <--> 5 <--> 10 <--> 20 <--> 25 <--> [sentinel]

    print("Penelusuran mundur:", cdll.traverse_backward())
    # Output: [25, 20, 10, 5]
```

---

## 5.5 Perbandingan Menyeluruh Keempat Variasi Linked List

Pemilihan variasi linked list yang tepat merupakan keputusan desain yang kritis. Tabel berikut menyajikan perbandingan komprehensif yang dapat digunakan sebagai panduan.

**Tabel 5.3 Perbandingan Menyeluruh Keempat Variasi Linked List**

| Aspek                        | Singly LL        | Doubly LL          | Circular LL    | Circular Doubly LL     |
|------------------------------|------------------|--------------------|----------------|------------------------|
| Pointer per simpul           | 1 (next)         | 2 (prev, next)     | 1 (next)       | 2 (prev, next)         |
| Memori per simpul            | data + 1 ref     | data + 2 ref       | data + 1 ref   | data + 2 ref           |
| Nilai akhir pointer          | None             | None (head & tail) | Menunjuk head  | Menunjuk sentinel      |
| Add First                    | O(1)             | O(1)               | O(1)           | O(1)                   |
| Add Last                     | O(n) / O(1)*     | O(1)               | O(1)           | O(1)                   |
| Remove First                 | O(1)             | O(1)               | O(1)           | O(1)                   |
| Remove Last                  | O(n)             | O(1)               | O(n)           | O(1)                   |
| Cari Elemen                  | O(n)             | O(n)               | O(n)           | O(n)                   |
| Telusuri Maju                | O(n)             | O(n)               | O(n)           | O(n)                   |
| Telusuri Mundur              | O(n) tidak efisien | O(n) efisien     | Tidak ada      | O(n) efisien           |
| Kondisi berhenti iterasi     | current == None  | current.next == None | counter = n  | current == sentinel    |
| Kompleksitas implementasi    | Rendah           | Sedang             | Sedang         | Tinggi                 |
| Kasus penggunaan utama       | Stack, queue     | Browser, undo/redo | Round-robin, repeat | Editor, playlist  |

*O(1) jika menyimpan pointer tail; O(n) jika hanya menyimpan head.

**Gambar 5.7 Perbandingan Visual Keempat Struktur**

```
Singly Linked List:
  [10] ------> [20] ------> [30] ------> None

Doubly Linked List:
  None <-- [10] <------> [20] <------> [30] --> None

Circular Linked List:
  +--------------------------------------------+
  |                                            |
  +--> [10] ------> [20] ------> [30] ---------+

Circular Doubly Linked List (dengan sentinel):
  +----------------------------------------------------------+
  |                                                          |
  +--> [S] <------> [10] <------> [20] <------> [30] -------+
        ^
     (sentinel)
```

---

## 5.6 Studi Kasus: Implementasi Riwayat Navigasi Browser

### 5.6.1 Analisis Permasalahan

Fitur navigasi browser, yakni tombol Back dan Forward, merupakan salah satu aplikasi doubly linked list yang paling terkenal dan banyak dikutip dalam literatur struktur data. Setiap halaman yang dikunjungi pengguna direpresentasikan sebagai simpul dalam doubly linked list, dan posisi "halaman saat ini" dilacak melalui satu pointer khusus, `current`.

---

> **Studi Kasus 5.1: Sistem Riwayat Browser**
>
> Bayangkan seorang mahasiswa yang menggunakan browser untuk mencari referensi tugas akhir. Ia mengunjungi berturut-turut: Google, Wikipedia, IEEE Xplore, dan ACM Digital Library. Tiba-tiba ia ingin kembali ke Wikipedia untuk mengecek definisi istilah tertentu, lalu ingin maju kembali ke ACM Digital Library. Kemudian, dari Wikipedia, ia membuka halaman baru tentang topik yang relevan, yang seharusnya menghapus riwayat maju ke IEEE dan ACM.
>
> Skenario ini menuntut tiga operasi: navigasi mundur (Back), navigasi maju (Forward), dan penghapusan riwayat maju saat halaman baru dikunjungi. Doubly linked list dengan pointer `current` memenuhi semua kebutuhan ini secara elegan.

---

Spesifikasi sistem Browser History yang akan diimplementasikan:

1. **`visit(url, title)`**: Membuat simpul baru untuk halaman yang dikunjungi dan menjadikannya `current`. Semua simpul di depan posisi `current` (riwayat Forward) dihapus untuk mencegah kebocoran memori.
2. **`go_back(steps)`**: Menggeser pointer `current` ke `current.prev` sebanyak `steps` langkah.
3. **`go_forward(steps)`**: Menggeser pointer `current` ke `current.next` sebanyak `steps` langkah.
4. **`show_history()`**: Menampilkan seluruh daftar halaman dengan penanda visual pada posisi `current`.
5. **`can_go_back()` dan `can_go_forward()`**: Memeriksa ketersediaan navigasi mundur dan maju.

**Gambar 5.8 Diagram Alur Operasi Browser History**

```
Kunjungi A, B, C, D secara berurutan:

  None <-- [A] <--> [B] <--> [C] <--> [D] --> None
                                        ^
                                      current

Tekan Back dua kali (current bergerak ke B):

  None <-- [A] <--> [B] <--> [C] <--> [D] --> None
                     ^
                   current

Kunjungi halaman baru E (C dan D dihapus, E menjadi current):

  None <-- [A] <--> [B] <--> [E] --> None
                               ^
                             current
```

### 5.6.2 Implementasi Python: BrowserHistory

```python
class PageNode:
    """Simpul yang merepresentasikan satu halaman web dalam riwayat browser.

    Attributes:
        url (str): URL lengkap halaman.
        title (str): Judul halaman untuk ditampilkan.
        prev: Pointer ke halaman sebelumnya dalam riwayat.
        next: Pointer ke halaman berikutnya dalam riwayat.
    """

    def __init__(self, url, title=""):
        self.url = url
        self.title = title if title else url
        self.prev = None
        self.next = None

    def __repr__(self):
        return f"[{self.title}]"


class BrowserHistory:
    """
    Implementasi riwayat browser menggunakan Doubly Linked List.

    Memodelkan perilaku nyata browser modern: navigasi Back/Forward
    menggeser pointer current; kunjungan halaman baru memutus dan
    menghapus semua simpul di depan current.

    Referensi: Goodrich, Tamassia, & Goldwasser (2013), Bab 3;
               Drozdek (2012), Bab 3.
    """

    def __init__(self, homepage_url):
        """
        Inisialisasi browser dengan halaman beranda.

        Args:
            homepage_url (str): URL halaman beranda pertama.
        """
        self.current = PageNode(homepage_url, "Beranda")
        self._history_head = self.current    # simpul paling awal dalam riwayat

    def visit(self, url, title=""):
        """
        Mengunjungi halaman baru.

        Semua simpul forward (jika ada) dihapus secara eksplisit
        untuk mencegah kebocoran memori, kemudian simpul baru
        disisipkan setelah current.

        Args:
            url (str): URL halaman baru.
            title (str): Judul halaman (opsional).

        Kompleksitas: O(k) di mana k adalah jumlah simpul forward
                      yang dihapus; O(1) untuk penyisipan simpul baru.
        """
        # Hapus semua simpul forward secara eksplisit
        forward_node = self.current.next
        deleted_count = 0
        while forward_node is not None:
            next_node = forward_node.next
            forward_node.prev = None    # bantu garbage collector
            forward_node.next = None
            forward_node = next_node
            deleted_count += 1

        if deleted_count > 0:
            print(f"  ({deleted_count} halaman dari riwayat forward dihapus)")

        # Sisipkan halaman baru setelah current
        new_page = PageNode(url, title if title else url)
        self.current.next = new_page
        new_page.prev = self.current
        self.current = new_page
        print(f"Mengunjungi: {self.current.title} ({self.current.url})")

    def go_back(self, steps=1):
        """
        Navigasi mundur sebanyak steps halaman.

        Args:
            steps (int): Jumlah langkah mundur (default: 1).

        Returns:
            str: URL halaman saat ini setelah navigasi.

        Kompleksitas: O(steps), biasanya O(1) untuk satu langkah.
        """
        for i in range(steps):
            if self.current.prev is not None:
                self.current = self.current.prev
            else:
                print(f"  Sudah di halaman pertama setelah {i} langkah mundur.")
                break
        print(f"Back -> {self.current.title} ({self.current.url})")
        return self.current.url

    def go_forward(self, steps=1):
        """
        Navigasi maju sebanyak steps halaman.

        Args:
            steps (int): Jumlah langkah maju (default: 1).

        Returns:
            str: URL halaman saat ini setelah navigasi.

        Kompleksitas: O(steps), biasanya O(1) untuk satu langkah.
        """
        for i in range(steps):
            if self.current.next is not None:
                self.current = self.current.next
            else:
                print(f"  Sudah di halaman terakhir setelah {i} langkah maju.")
                break
        print(f"Forward -> {self.current.title} ({self.current.url})")
        return self.current.url

    def show_history(self):
        """
        Menampilkan seluruh riwayat dengan penanda posisi current.

        Penelusuran dimulai dari _history_head untuk menampilkan
        semua simpul, dengan tanda [*] pada posisi current.
        """
        print("\n--- Riwayat Browser ---")
        node = self._history_head
        index = 1
        while node is not None:
            if node is self.current:
                print(f"  {index}. [*] {node.title} ({node.url})  <-- posisi saat ini")
            else:
                print(f"  {index}.     {node.title} ({node.url})")
            node = node.next
            index += 1
        print("-----------------------\n")

    def can_go_back(self):
        """Mengembalikan True jika terdapat halaman sebelumnya."""
        return self.current.prev is not None

    def can_go_forward(self):
        """Mengembalikan True jika terdapat halaman berikutnya."""
        return self.current.next is not None


# ======================================================================
# Skenario simulasi lengkap
# ======================================================================
if __name__ == "__main__":
    print("=" * 55)
    print("SIMULASI RIWAYAT BROWSER")
    print("=" * 55)

    browser = BrowserHistory("https://www.google.com")

    browser.visit("https://www.github.com", "GitHub")
    browser.visit("https://www.stackoverflow.com", "Stack Overflow")
    browser.visit("https://docs.python.org", "Python Docs")
    browser.show_history()

    print("--- Menekan tombol Back ---")
    browser.go_back()
    browser.show_history()

    browser.go_back(2)
    browser.show_history()

    print("--- Menekan tombol Forward ---")
    browser.go_forward()
    browser.show_history()

    print("--- Kunjungi halaman baru dari posisi tengah ---")
    browser.visit("https://www.wikipedia.org", "Wikipedia")
    browser.show_history()

    print("Bisa maju?", browser.can_go_forward())    # False
    print("Bisa mundur?", browser.can_go_back())     # True
```

### 5.6.3 Analisis Solusi

Solusi di atas mendemonstrasikan beberapa prinsip desain yang penting. Pointer `current` menggunakan paradigma "posisi dalam struktur", di mana navigasi hanyalah perpindahan referensi, bukan penyalinan data. Penghapusan eksplisit simpul forward pada operasi `visit` bukan sekadar "memutus koneksi", melainkan juga membatalkan referensi silang (`forward_node.prev = None` dan `forward_node.next = None`) agar garbage collector Python dapat segera membebaskan memori yang tidak lagi digunakan.

Pola desain ini, yang menggunakan doubly linked list sebagai rantai riwayat dengan pointer posisi, juga diterapkan dalam fitur undo/redo pada editor teks seperti Microsoft Word, GNU Emacs, dan Vim.

---

## 5.7 Aplikasi Tambahan: Antrian Musik dengan Circular Linked List

Sebagai pelengkap pemahaman aplikasi practical circular linked list, berikut adalah implementasi antrian musik dengan mode "Putar Berulang".

```python
class MusicQueue:
    """
    Antrian musik dengan mode Putar Berulang menggunakan Circular Linked List.

    Setelah lagu terakhir selesai, lagu pertama otomatis dimainkan
    kembali tanpa pengecekan kondisi batas.
    """

    def __init__(self):
        self._queue = CircularLinkedList()
        self._current = None

    def add_song(self, title):
        """Menambahkan lagu ke akhir antrian."""
        self._queue.add_last(title)
        if self._current is None:
            self._current = self._queue.head

    def next_song(self):
        """Berpindah ke lagu berikutnya (melingkar secara otomatis)."""
        if self._current is None:
            return None
        self._current = self._current.next
        return self._current.data

    def current_song(self):
        """Mengembalikan judul lagu yang sedang diputar."""
        if self._current is None:
            return None
        return self._current.data

    def show_queue(self):
        """Menampilkan seluruh antrian lagu."""
        songs = self._queue.traverse()
        print("Antrian musik:", " --> ".join(songs) + " --> (ulangi)")
        print("Lagu saat ini:", self.current_song())


if __name__ == "__main__":
    player = MusicQueue()
    player.add_song("Bohemian Rhapsody")
    player.add_song("Hotel California")
    player.add_song("Stairway to Heaven")
    player.show_queue()

    print("\nMemutar 5 lagu berikutnya (melewati batas akhir-awal):")
    for i in range(5):
        lagu = player.next_song()
        print(f"  Lagu ke-{i + 1}: {lagu}")
```

Output yang dihasilkan akan membuktikan sifat melingkar: setelah "Stairway to Heaven", lagu berikutnya adalah "Bohemian Rhapsody" lagi tanpa perlu logika khusus.

---

> **Catatan Penting 5.3: Trade-off Pemilihan Variasi Linked List**
>
> Tidak ada variasi linked list yang secara universal terbaik. Pemilihan harus didasarkan pada kebutuhan spesifik aplikasi. Doubly linked list mengonsumsi memori lebih banyak dibandingkan singly linked list sebesar satu pointer per simpul. Dalam aplikasi dengan jutaan simpul, perbedaan ini signifikan. Circular linked list memerlukan penanganan kondisi berhenti iterasi yang berbeda (counter atau sentinel alih-alih pengecekan `None`), yang harus diimplementasikan dengan cermat untuk menghindari infinite loop. Circular doubly linked list menawarkan fleksibilitas paling tinggi tetapi dengan kompleksitas implementasi tertinggi pula.

---

## 5.8 Rangkuman Bab

1. **Doubly linked list** memperluas singly linked list dengan menambahkan pointer `prev` pada setiap simpul, memungkinkan penelusuran dua arah yang efisien. Keunggulan utamanya dibandingkan singly linked list adalah kompleksitas O(1) untuk operasi `remove_last` (berkat `tail.prev`) dan kemampuan navigasi mundur langsung dari posisi mana pun tanpa perlu memulai ulang dari head.

2. **Circular linked list** menghubungkan pointer `next` dari simpul terakhir (tail) kembali ke simpul pertama (head), membentuk siklus tertutup tanpa simpul bernilai `None`. Implementasi yang efisien menggunakan pointer `tail` (bukan head) sebagai referensi tunggal agar operasi penyisipan di kedua ujung dapat dilakukan dalam O(1). Struktur ini ideal untuk skenario siklik seperti round-robin scheduling dan pemutar musik dengan mode pengulangan.

3. **Circular doubly linked list** menggabungkan kemampuan doubly linked list (navigasi dua arah) dengan sifat melingkar dari circular linked list, menjadikannya variasi yang paling fleksibel. Implementasi dengan teknik sentinel node menghasilkan dua metode internal universal (`_insert_between` dan `_delete_node`) yang menangani semua kasus penyisipan dan penghapusan tanpa kondisi tepi khusus.

4. **Sentinel node** adalah simpul dummy yang tidak menyimpan data bermakna, ditempatkan secara permanen dalam struktur untuk menghilangkan kebutuhan pengecekan kondisi tepi (`if is_empty()`) pada operasi penyisipan dan penghapusan. Teknik ini menghasilkan kode yang lebih bersih, konsisten, dan lebih mudah dipelihara dengan mengurangi jumlah cabang logika.

5. **Perbandingan kompleksitas** antara keempat variasi: Doubly LL unggul dalam `remove_last` (O(1) vs. O(n) pada Singly LL); Circular LL dan Circular Doubly LL tidak memiliki kondisi berhenti `None` dalam iterasi, sehingga penelusuran harus dibatasi oleh counter atau referensi sentinel. Semua variasi memiliki kompleksitas O(n) untuk pencarian elemen.

6. **Studi kasus Browser History** mendemonstrasikan penerapan doubly linked list dalam skenario nyata: pointer `current` melacak posisi aktif; navigasi Back dan Forward adalah perpindahan pointer O(1); kunjungan halaman baru memerlukan penghapusan eksplisit simpul forward untuk mencegah kebocoran memori. Pola desain yang sama digunakan pada fitur undo/redo di berbagai aplikasi perangkat lunak.

7. **Pemilihan variasi linked list** harus mempertimbangkan tiga dimensi utama: kebutuhan navigasi (satu arah vs. dua arah), kebutuhan siklus (linear vs. melingkar), dan constraint memori serta kompleksitas implementasi yang dapat diterima oleh sistem yang sedang dikembangkan.

---

## Istilah Kunci

1. **Doubly Linked List**: Variasi linked list di mana setiap simpul memiliki dua pointer: `prev` ke simpul pendahulu dan `next` ke simpul penerus.

2. **Circular Linked List**: Variasi linked list di mana pointer `next` dari simpul terakhir menunjuk kembali ke simpul pertama, membentuk siklus tertutup.

3. **Circular Doubly Linked List**: Variasi linked list yang menggabungkan dua pointer per simpul (prev, next) dengan sifat melingkar (tail.next = head, head.prev = tail).

4. **Sentinel Node**: Simpul dummy tanpa data bermakna yang ditempatkan permanen dalam struktur untuk menyederhanakan penanganan kondisi batas (boundary conditions).

5. **Pointer prev**: Bidang dalam simpul doubly linked list yang menyimpan referensi ke simpul pendahulunya.

6. **Pointer tail**: Referensi yang disimpan oleh objek linked list untuk menunjuk ke simpul terakhir dalam daftar, memungkinkan operasi O(1) di ujung akhir.

7. **Penelusuran dua arah (Bidirectional Traversal)**: Kemampuan untuk menelusuri linked list dari head ke tail (maju) maupun dari tail ke head (mundur) secara efisien.

8. **Kondisi batas (Boundary Condition)**: Kasus tepi dalam operasi linked list, seperti daftar kosong atau penyisipan/penghapusan di posisi pertama atau terakhir, yang memerlukan penanganan khusus dalam implementasi tanpa sentinel.

9. **_insert_between**: Metode internal pada circular doubly linked list dengan sentinel yang menyisipkan simpul baru di antara dua simpul yang sudah ada; digunakan oleh semua operasi penyisipan publik.

10. **_delete_node**: Metode internal pada circular doubly linked list dengan sentinel yang menghapus simpul yang sudah diketahui referensinya; digunakan oleh semua operasi penghapusan publik.

11. **Browser History**: Pola desain berbasis doubly linked list yang melacak riwayat navigasi dengan pointer posisi (`current`) untuk mendukung operasi Back dan Forward.

12. **Round-Robin Scheduling**: Algoritma penjadwalan proses dalam sistem operasi di mana setiap proses mendapat giliran CPU secara bergantian; dimodelkan dengan circular linked list.

13. **Ring Buffer (Buffer Melingkar)**: Struktur buffer tetap berukuran n yang bersifat melingkar, di mana lokasi penulisan berikutnya menimpa data terlama; merupakan aplikasi nyata circular linked list.

14. **Kebocoran Memori (Memory Leak)**: Kondisi di mana memori yang dialokasikan tidak dibebaskan kembali karena referensi yang tidak sepenuhnya dihapus; relevan dalam operasi penghapusan riwayat forward pada implementasi browser history.

15. **Garbage Collector**: Mekanisme otomatis Python yang membebaskan memori dari objek yang tidak lagi dapat dijangkau oleh referensi aktif; dimaksimalkan efektivitasnya dengan menghapus referensi silang secara eksplisit.

16. **Kompleksitas Ruang O(n)**: Semua variasi linked list memerlukan memori proporsional dengan jumlah simpul n, ditambah overhead pointer per simpul (satu pointer untuk singly/circular, dua pointer untuk doubly/circular doubly).

17. **Dummy Node**: Istilah lain untuk sentinel node; simpul yang tidak menyimpan data pengguna melainkan berfungsi sebagai titik acuan struktural.

18. **Deque (Double-Ended Queue)**: Antrian dua ujung yang dapat diimplementasikan secara efisien menggunakan doubly linked list, mendukung penyisipan dan penghapusan O(1) di kedua ujung.

---

## Soal Latihan

### Tingkat Pemahaman (C2)

**Soal 1.**
Perhatikan struktur doubly linked list berikut:

```
None <-- [A] <--> [B] <--> [C] <--> [D] --> None
```

Tuliskan nilai dari: (a) `B.prev.data`, (b) `C.next.data`, (c) `A.prev`, (d) `D.next`. Jelaskan mengapa simpul pertama dan terakhir memiliki nilai `None` pada salah satu pointernya.

**Soal 2.**
Jelaskan perbedaan mendasar antara cara mendeteksi "akhir daftar" saat melakukan penelusuran pada singly linked list biasa versus pada circular linked list. Mengapa kondisi `current is None` tidak dapat digunakan pada circular linked list?

**Soal 3.**
Gambarkan representasi visual (diagram ASCII) dari sebuah circular doubly linked list berisi tiga elemen [X, Y, Z] dengan sentinel node. Tunjukkan semua pointer: `sentinel.next`, `sentinel.prev`, serta pointer `prev` dan `next` dari setiap simpul data.

### Tingkat Penerapan (C3)

**Soal 4.**
Implementasikan metode `insert_before(target_data, new_data)` pada kelas `DoublyLinkedList` yang menyisipkan simpul baru tepat sebelum simpul dengan nilai `target_data`. Metode harus mengembalikan `True` jika berhasil dan `False` jika target tidak ditemukan. Sertakan penanganan kasus ketika target adalah head.

**Soal 5.**
Implementasikan metode `rotate(k)` pada kelas `CircularLinkedList` yang memutar daftar sebanyak `k` posisi ke kanan. Contoh: daftar [1, 2, 3, 4, 5] setelah `rotate(2)` menjadi [4, 5, 1, 2, 3]. Metode harus bekerja dalam O(n) waktu.

**Soal 6.**
Implementasikan fungsi `merge_sorted(dll1, dll2)` yang menerima dua `DoublyLinkedList` yang sudah terurut dan mengembalikan `DoublyLinkedList` baru yang merupakan gabungan terurut dari keduanya, tanpa membuat simpul baru (menggunakan kembali simpul yang ada). Analisis kompleksitasnya.

### Tingkat Analisis (C4)

**Soal 7.**
Analisis mengapa implementasi sentinel pada `CircularDoublyLinkedList` memungkinkan metode `_insert_between` dan `_delete_node` beroperasi tanpa kondisi tepi (boundary condition). Bandingkan potongan kode `add_first` dengan dan tanpa sentinel untuk mendukung argumen Anda. Berapa banyak pengecekan kondisi yang berhasil dieliminasi?

**Soal 8.**
Sebuah tim pengembang sedang mendebat pilihan struktur data untuk antrian tugas (task queue) pada aplikasi web server. Tugas-tugas dapat ditambahkan di akhir dan dihapus dari awal secara berkelanjutan. Sesekali, tugas berprioritas tinggi harus disisipkan di awal. Evaluasi apakah `DoublyLinkedList`, `CircularLinkedList`, atau `CircularDoublyLinkedList` yang paling sesuai. Justifikasi berdasarkan kompleksitas operasi dan pertimbangan memori.

### Tingkat Evaluasi (C5)

**Soal 9.**
Perbandingan implementasi browser history dengan dua pendekatan: (a) menggunakan doubly linked list sebagaimana dibahas dalam bab ini, dan (b) menggunakan dua stack (satu untuk riwayat back, satu untuk riwayat forward). Evaluasi kedua pendekatan berdasarkan: kompleksitas waktu untuk setiap operasi (visit, go_back, go_forward), penggunaan memori, dan kemudahan implementasi. Kapan pendekatan stack lebih unggul dan kapan doubly linked list lebih unggul?

**Soal 10.**
Evaluasi keputusan desain penggunaan pointer `tail` (bukan `head`) sebagai referensi tunggal pada implementasi `CircularLinkedList`. Apakah ada skenario di mana menyimpan hanya pointer `head` justru lebih efisien? Berikan contoh konkret dan analisis kompleksitas untuk mendukung argumen Anda.

### Tingkat Kreasi (C6)

**Soal 11.**
Rancang dan implementasikan kelas `TextEditor` yang mensimulasikan fitur undo/redo pada editor teks sederhana menggunakan doubly linked list. Setiap "state" teks disimpan sebagai simpul. Kelas harus mendukung: `type_text(text)` untuk menambah teks, `delete_last(n)` untuk menghapus n karakter terakhir, `undo()` untuk membatalkan operasi terakhir, `redo()` untuk mengulang operasi yang dibatalkan, dan `current_state()` untuk menampilkan teks saat ini. Uji dengan minimal tujuh operasi yang mencakup kombinasi undo, redo, dan pengetikan setelah undo.

**Soal 12.**
Rancang dan implementasikan kelas `PlaylistManager` menggunakan circular doubly linked list yang mendukung: `add_song(title)` menambah lagu di akhir, `remove_song(title)` menghapus lagu tertentu, `next_song()` berpindah ke lagu berikutnya (melingkar), `prev_song()` berpindah ke lagu sebelumnya (melingkar), `shuffle_once()` yang menukar posisi setiap pasang simpul (posisi ganjil-genap). Analisis kompleksitas setiap operasi dan jelaskan mengapa circular doubly linked list lebih tepat daripada doubly linked list biasa untuk kasus ini.

---

## Bacaan Lanjutan

1. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013). *Data Structures and Algorithms in Python*. John Wiley & Sons. Bab 3: Linked Lists (Section 3.1--3.4, hal. 115--172).**
   Buku acuan utama untuk bab ini. Membahas singly linked list, doubly linked list dengan sentinel node, dan circular linked list secara komprehensif dengan analisis kompleksitas yang ketat. Notasi dan terminologi yang digunakan dalam bab ini mengikuti buku ini. Sangat direkomendasikan untuk dibaca seluruhnya karena contoh-contohnya menggunakan Python.

2. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009). *Introduction to Algorithms* (3rd ed.). MIT Press. Bab 10: Elementary Data Structures (Section 10.2: Linked Lists, hal. 236--243).**
   Referensi klasik yang membahas doubly linked list dengan sentinel dari perspektif teori algoritma dan pembuktian formal. Menyajikan pseudocode yang agnostik bahasa pemrograman sehingga mahasiswa dapat membandingkan dengan implementasi Python. Cocok untuk memperkuat pemahaman teoretis kompleksitas.

3. **Drozdek, A. (2012). *Data Structures and Algorithms in C++* (4th ed.). Cengage Learning. Bab 3: Linked Lists (Section 3.1--3.5, hal. 91--163).**
   Meskipun menggunakan C++, buku ini sangat berharga karena membahas berbagai variasi linked list beserta studi kasus aplikasinya, termasuk manajemen memori dan implementasi pada sistem nyata. Membaca bab ini membantu mahasiswa memahami pertimbangan level rendah yang relevan dalam perancangan sistem.

4. **Sedgewick, R., & Wayne, K. (2011). *Algorithms* (4th ed.). Addison-Wesley Professional. Bab 1: Fundamentals (Section 1.3: Bags, Queues, and Stacks, hal. 120--163).**
   Membahas linked list dalam konteks implementasi struktur data abstrak tingkat tinggi. Buku ini menekankan perspektif "menggunakan linked list untuk membangun abstraksi yang lebih besar", yang relevan dengan pembelajaran tentang penggunaan linked list sebagai fondasi implementasi stack dan queue pada bab-bab berikutnya.

5. **Miller, B. N., & Ranum, D. L. (2011). *Problem Solving with Algorithms and Data Structures Using Python* (2nd ed.). Franklin, Beedle & Associates. Bab 3: Basic Data Structures (hal. 81--155).**
   Buku yang secara khusus menggunakan Python sebagai bahasa implementasi dengan pendekatan berorientasi pemecahan masalah. Tersedia versi online gratis di [runestone.academy](https://runestone.academy). Cocok sebagai bacaan pendamping yang lebih ringan dan interaktif sebelum membaca Goodrich et al.

6. **Lutz, M. (2013). *Learning Python* (5th ed.). O'Reilly Media. Bab 27: Class Coding Details dan Bab 31: Designing with Classes (hal. 795--900).**
   Referensi untuk memahami teknik pemrograman berorientasi objek Python yang digunakan dalam implementasi linked list, termasuk penggunaan magic methods (`__len__`, `__repr__`, `__iter__`), properti (`@property`), dan konvensi penamaan atribut privat. Dibaca untuk memperkuat kemampuan implementasi Python.

7. **Knuth, D. E. (1997). *The Art of Computer Programming, Volume 1: Fundamental Algorithms* (3rd ed.). Addison-Wesley Professional. Section 2.2: Linear Lists (hal. 238--305).**
   Referensi paling komprehensif dan historis tentang linked list. Knuth memperkenalkan konsep linked list dalam konteks yang sangat mendalam, mencakup variasi-variasi eksotis dan analisis matematika yang ketat. Bacaan ini bersifat opsional dan ditujukan bagi mahasiswa yang ingin menggali pemahaman teoritis pada tingkat yang lebih dalam.

8. **Python Software Foundation. (2024). *Python 3 Documentation: Data Model*. [https://docs.python.org/3/reference/datamodel.html](https://docs.python.org/3/reference/datamodel.html).**
   Dokumentasi resmi Python tentang model data dan magic methods yang digunakan dalam implementasi linked list berbasis kelas. Khususnya relevan untuk memahami cara mengimplementasikan `__len__`, `__repr__`, `__iter__`, dan `__contains__` agar kelas linked list berperilaku sesuai konvensi Python. Selalu tersedia online dan selalu mutakhir.

---

*Bab ini merupakan bagian dari buku teks "Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python" yang disusun untuk kebutuhan perkuliahan Struktur Data di Program Studi Informatika, Institut Bisnis dan Teknologi Indonesia (INSTIKI). Mahasiswa dianjurkan untuk mengeksekusi setiap potongan kode secara mandiri, bereksperimen dengan variasi masukan, dan mencoba mengimplementasikan operasi-operasi tambahan sebagai latihan penguatan.*

*Bab berikutnya membahas Stack dan Queue, dua struktur data abstrak yang implementasinya dapat dibangun di atas linked list yang telah dipelajari dalam bab ini.*

---

**Penulis:** Program Studi Informatika, INSTIKI
**Edisi:** 2026
**Versi:** 1.0
