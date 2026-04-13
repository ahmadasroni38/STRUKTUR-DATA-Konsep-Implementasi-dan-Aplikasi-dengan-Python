# BAB 7
# QUEUE (ANTRIAN): PRINSIP FIFO, IMPLEMENTASI, DAN APLIKASI

---

> *"Kesabaran dalam menunggu giliran adalah cerminan dari tatanan yang beradab. Demikian pula queue dalam ilmu komputer: ia memastikan setiap elemen mendapat giliran yang adil, dalam urutan yang benar."*
>
> — Diadaptasi dari konsep fairness dalam teori antrian (Queueing Theory)

---

## 7.1 Tujuan Pembelajaran

Setelah mempelajari bab ini secara tuntas, mahasiswa diharapkan mampu:

1. **[C2 - Memahami]** Menjelaskan prinsip FIFO (First In First Out) sebagai dasar abstraksi queue dan membedakannya dari prinsip LIFO pada stack.
2. **[C2 - Memahami]** Menguraikan operasi-operasi dasar ADT Queue (enqueue, dequeue, peek, is\_empty, size) beserta kontrak semantiknya masing-masing.
3. **[C3 - Menerapkan]** Mengimplementasikan Linear Queue berbasis array, Circular Queue dengan aritmatika modular, dan Linked List Queue yang bersifat dinamis menggunakan bahasa pemrograman Python.
4. **[C4 - Menganalisis]** Mendiagnosis masalah *false overflow* pada linear queue dan membuktikan bagaimana Circular Queue menyelesaikan masalah tersebut melalui mekanisme aritmatika modular.
5. **[C4 - Menganalisis]** Membandingkan lima varian implementasi queue (LinearQueue, CircularQueue, LinkedListQueue, PriorityQueue, dan Deque) berdasarkan kompleksitas waktu, kompleksitas ruang, kelebihan, dan kekurangan masing-masing.
6. **[C5 - Mengevaluasi]** Menentukan varian queue yang paling sesuai untuk konteks permasalahan tertentu berdasarkan analisis kebutuhan sistem.
7. **[C6 - Mencipta]** Merancang dan mengimplementasikan simulasi sistem antrian layanan (bank atau rumah sakit) yang memanfaatkan queue sebagai komponen utama pengolahan data.

---

## 7.2 Pendahuluan: Kehidupan Nyata sebagai Inspirasi Struktur Data

Bayangkan sebuah pagi di loket pelayanan bank. Nasabah pertama yang tiba tentu adalah nasabah pertama yang dilayani. Nasabah yang datang kemudian harus menunggu di belakang antrian hingga tiba gilirannya. Tidak ada yang boleh menyerobot. Tidak ada yang boleh dilayani dua kali sebelum yang lain. Tatanan inilah yang menjamin keadilan dan ketertiban dalam proses layanan.

Fenomena antrian semacam ini ternyata bukan hanya milik dunia sosial manusia. Di dalam sistem komputer, pola yang sama terjadi di mana-mana: paket data yang menunggu giliran untuk dikirimkan melalui jaringan, proses yang mengantri untuk mendapatkan jatah waktu CPU dari sistem operasi, permintaan cetak yang menunggu printer, hingga pesan yang mengantri dalam sistem komunikasi asinkron antara berbagai komponen perangkat lunak. Semua mengikuti satu prinsip universal yang sama: **siapa yang datang lebih dahulu, dilayani lebih dahulu**.

Prinsip inilah yang dalam ilmu komputer dikenal sebagai **FIFO (First In First Out)**, dan struktur data yang mengabstraksikannya disebut **Queue** (antrian). Queue merupakan salah satu Abstract Data Type (ADT) yang paling fundamental dan paling banyak digunakan dalam rekayasa perangkat lunak. Pemahaman yang mendalam tentang Queue bukan sekadar pengetahuan akademis — ia adalah fondasi untuk memahami bagaimana sistem operasi menjadwalkan proses, bagaimana jaringan mengelola paket data, bagaimana algoritma BFS menjelajahi graf, dan bagaimana arsitektur perangkat lunak modern membangun sistem yang skalabel melalui message queue.

Bab ini membahas Queue secara sistematis dan mendalam. Kita akan memulai dari definisi formal ADT Queue, kemudian bergerak ke implementasi konkret dalam Python: dari Linear Queue yang paling sederhana beserta kelemahannya, Circular Queue sebagai solusi elegan berbasis aritmatika modular, Linked List Queue yang menawarkan kapasitas dinamis, hingga Priority Queue dan Deque sebagai generalisasi yang lebih kuat. Setiap implementasi diikuti oleh analisis kompleksitas dan studi kasus aplikasi nyata.

---

## 7.3 Konsep FIFO dan Abstraksi Queue

### 7.3.1 Definisi Formal

**Queue** adalah struktur data linear yang mengikuti prinsip **FIFO (First In First Out)**: elemen yang pertama kali dimasukkan ke dalam queue adalah elemen yang pertama kali dikeluarkan. Secara formal, queue adalah kumpulan elemen terurut dengan dua titik akses yang berbeda:

- **Front (depan)**: titik di mana elemen diambil atau dihapus dari queue, yaitu titik keluar.
- **Rear** atau **Back (belakang)**: titik di mana elemen baru ditambahkan ke queue, yaitu titik masuk.

Analogi yang paling tepat adalah antrian manusia di kasir supermarket atau loket bank: orang pertama yang masuk barisan adalah orang pertama yang dilayani dan meninggalkan antrian, sementara orang yang baru datang selalu bergabung di ujung belakang barisan.

**Gambar 7.1** Ilustrasi Prinsip FIFO pada Queue

```
  REAR                                        FRONT
   |                                            |
   v                                            v
 [ E ] <-- [ D ] <-- [ C ] <-- [ B ] <-- [ A ]
            arah masuk (enqueue)    arah keluar (dequeue)

  Urutan masuk  : A, B, C, D, E
  Urutan keluar : A, B, C, D, E   (sama dengan urutan masuk)
```

Perhatikan kontras antara Queue dan Stack yang telah dibahas pada bab sebelumnya. Pada Stack (LIFO), elemen yang terakhir masuk justru yang pertama keluar — seperti tumpukan piring. Pada Queue (FIFO), elemen yang pertama masuk adalah yang pertama keluar — seperti barisan antrian.

### 7.3.2 Operasi Dasar ADT Queue

ADT Queue mendefinisikan sekumpulan operasi yang harus didukung oleh setiap implementasi yang sah. Operasi-operasi ini membentuk "kontrak" antara pengguna queue dan implementasinya, sehingga pengguna tidak perlu mengetahui detail internal implementasi.

**Tabel 7.1** Operasi Dasar ADT Queue beserta Kompleksitas Waktu

| Operasi              | Deskripsi                                                           | Kompleksitas |
|----------------------|---------------------------------------------------------------------|:------------:|
| `enqueue(e)`         | Menambahkan elemen `e` ke bagian belakang (rear) queue             | O(1)         |
| `dequeue()`          | Menghapus dan mengembalikan elemen dari bagian depan (front) queue | O(1)         |
| `peek()` / `first()` | Mengembalikan elemen depan tanpa menghapusnya                       | O(1)         |
| `is_empty()`         | Mengembalikan `True` jika queue tidak memiliki elemen              | O(1)         |
| `size()`             | Mengembalikan jumlah elemen yang ada dalam queue                   | O(1)         |

Sebelum mengimplementasikan queue secara konkret, sangat baik praktiknya untuk terlebih dahulu mendefinisikan antarmuka abstrak (abstract interface) dalam Python. Pendekatan ini memastikan bahwa setiap implementasi mengikuti kontrak yang sama dan dapat saling dipertukarkan (interchangeable).

```python
class QueueADT:
    """
    Antarmuka abstrak untuk ADT Queue.
    Semua implementasi queue konkret harus mewarisi kelas ini
    dan mengimplementasikan semua metode di bawah ini.
    """

    def enqueue(self, element):
        """Menambahkan elemen ke belakang queue."""
        raise NotImplementedError("Metode enqueue() harus diimplementasikan.")

    def dequeue(self):
        """Menghapus dan mengembalikan elemen dari depan queue."""
        raise NotImplementedError("Metode dequeue() harus diimplementasikan.")

    def peek(self):
        """Mengembalikan elemen depan tanpa menghapus."""
        raise NotImplementedError("Metode peek() harus diimplementasikan.")

    def is_empty(self):
        """Mengembalikan True jika queue kosong."""
        raise NotImplementedError("Metode is_empty() harus diimplementasikan.")

    def size(self):
        """Mengembalikan jumlah elemen dalam queue."""
        raise NotImplementedError("Metode size() harus diimplementasikan.")
```

> **Catatan Penting 7.1 — Perbedaan Queue dan Stack**
>
> Queue dan Stack sama-sama merupakan struktur data linear dengan akses terbatas, namun berbeda dalam kebijakan akses elemennya. Stack menggunakan kebijakan LIFO (Last In First Out): operasi push dan pop terjadi di satu ujung yang sama (top). Queue menggunakan kebijakan FIFO (First In First Out): operasi enqueue terjadi di rear, sedangkan operasi dequeue terjadi di front — dua ujung yang berbeda. Pilihan antara keduanya bergantung sepenuhnya pada kebutuhan pemrosesan: apakah elemen terbaru yang harus diproses duluan (gunakan Stack), atau elemen terlama yang harus diproses duluan (gunakan Queue).

---

## 7.4 Linear Queue Berbasis Array dan Masalah False Overflow

### 7.4.1 Struktur Linear Queue

Implementasi queue yang paling intuitif menggunakan array (list Python) dengan kapasitas tetap. Dua variabel indeks dipertahankan untuk melacak posisi elemen terdepan dan terbelakang:

- `front`: indeks elemen pertama (terdepan) yang akan diambil saat operasi dequeue.
- `rear`: indeks elemen terakhir yang dimasukkan melalui operasi enqueue.

Saat `enqueue` dilakukan, nilai `rear` bertambah satu dan elemen baru ditempatkan di posisi `rear`. Saat `dequeue` dilakukan, elemen di posisi `front` diambil dan nilai `front` bertambah satu. Kapasitas maksimum array ditentukan saat inisialisasi.

**Gambar 7.2** Evolusi State pada Linear Queue Berbasis Array (Kapasitas = 5)

```
Kondisi awal (kosong):
  front = 0, rear = -1, count = 0
  [ _ ][ _ ][ _ ][ _ ][ _ ]
    0    1    2    3    4

Setelah enqueue(A), enqueue(B), enqueue(C):
  front = 0, rear = 2, count = 3
  [ A ][ B ][ C ][ _ ][ _ ]
    ^                           front = 0
    0    1    2    3    4

Setelah dequeue() -> mengambil A:
  front = 1, rear = 2, count = 2
  [ _ ][ B ][ C ][ _ ][ _ ]
    0    ^                       front = 1
         1    2    3    4
         (slot 0 terbuang, tidak dapat dipakai lagi)
```

### 7.4.2 Masalah "False Overflow": Kelemahan Kritis Linear Queue

Masalah paling serius pada linear queue adalah fenomena yang disebut **false overflow** (luapan palsu). Kondisi ini terjadi ketika indeks `rear` telah mencapai posisi terakhir array (`MAX_SIZE - 1`), sehingga operasi `enqueue` ditolak dengan pesan "queue penuh" — padahal kenyataannya jumlah elemen aktual dalam queue jauh lebih sedikit dari kapasitas penuh. Slot-slot di bagian depan array telah kosong akibat operasi dequeue sebelumnya, tetapi tidak dapat digunakan kembali.

**Gambar 7.3** Ilustrasi False Overflow pada Linear Queue

```
Kondisi False Overflow:
  MAX_SIZE = 5, front = 3, rear = 4, count = 2

  [ _ ][ _ ][ _ ][ D ][ E ]
    0    1    2    3    4
                   ^          rear = 4 (sudah di ujung!)
                   front = 3

  Terdapat 3 slot kosong di indeks 0, 1, 2.
  Namun operasi enqueue(F) akan DITOLAK karena:
    rear == MAX_SIZE - 1 (kondisi "penuh" palsu)

  Inilah yang disebut FALSE OVERFLOW:
  queue "terasa" penuh padahal tidak benar-benar penuh.
```

Pemborosan memori ini menjadi masalah yang sangat serius pada sistem dengan kapasitas terbatas. Bayangkan sebuah buffer jaringan dengan kapasitas 10.000 slot: hanya karena front terus bergerak maju akibat banyak dequeue, ribuan slot di awal array menjadi tidak dapat digunakan, meskipun hanya ratusan paket yang sedang dalam antrian.

Berikut adalah implementasi LinearQueue yang lengkap dalam Python, termasuk demonstrasi masalah false overflow:

```python
class LinearQueue:
    """
    Implementasi Queue Linear berbasis array dengan kapasitas tetap.
    Mendemonstrasikan masalah false overflow yang merupakan
    kelemahan utama pendekatan ini.
    """

    def __init__(self, capacity=10):
        """Inisialisasi queue dengan kapasitas tertentu."""
        self._capacity = capacity
        self._data = [None] * capacity
        self._front = 0
        self._rear = -1
        self._count = 0

    def is_empty(self):
        """Mengembalikan True jika queue kosong."""
        return self._count == 0

    def is_full(self):
        """
        Mengembalikan True jika rear sudah di posisi akhir.
        PERHATIAN: ini dapat menghasilkan false overflow!
        """
        return self._rear == self._capacity - 1

    def size(self):
        """Mengembalikan jumlah elemen yang ada dalam queue."""
        return self._count

    def enqueue(self, element):
        """
        Menambahkan elemen ke belakang queue.
        Kompleksitas Waktu: O(1)
        Kompleksitas Ruang: O(1) per operasi
        """
        if self.is_full():
            raise OverflowError(
                f"Queue penuh atau false overflow! "
                f"rear={self._rear}, front={self._front}, "
                f"jumlah elemen aktual={self._count}"
            )
        self._rear += 1
        self._data[self._rear] = element
        self._count += 1

    def dequeue(self):
        """
        Menghapus dan mengembalikan elemen dari depan queue.
        Kompleksitas Waktu: O(1)
        """
        if self.is_empty():
            raise IndexError("Operasi dequeue pada queue kosong.")
        elemen = self._data[self._front]
        self._data[self._front] = None  # Hapus referensi untuk garbage collector
        self._front += 1
        self._count -= 1
        return elemen

    def peek(self):
        """Mengembalikan elemen depan tanpa menghapus."""
        if self.is_empty():
            raise IndexError("Queue kosong, tidak ada elemen untuk dilihat.")
        return self._data[self._front]

    def __str__(self):
        """Representasi string queue dari depan ke belakang."""
        if self.is_empty():
            return "LinearQueue: []"
        elemen = self._data[self._front:self._rear + 1]
        return f"LinearQueue (front->rear): {elemen}"


# --- Demonstrasi False Overflow ---
if __name__ == "__main__":
    print("=== Demonstrasi Linear Queue dan False Overflow ===\n")
    lq = LinearQueue(capacity=5)

    for item in ['A', 'B', 'C', 'D', 'E']:
        lq.enqueue(item)
    print(f"Setelah enqueue A-E  : {lq}")
    print(f"front={lq._front}, rear={lq._rear}, count={lq._count}\n")

    for _ in range(3):
        diambil = lq.dequeue()
        print(f"Dequeue -> {diambil}")

    print(f"\nSetelah 3x dequeue  : {lq}")
    print(f"front={lq._front}, rear={lq._rear}, count={lq._count}\n")

    try:
        lq.enqueue('F')
    except OverflowError as e:
        print(f"GAGAL enqueue 'F': {e}")
        print("=> Ini adalah FALSE OVERFLOW!")
        print(f"   Slot kosong tersedia: {lq._front} buah (indeks 0 s/d {lq._front-1})")
```

**Output demonstrasi:**
```
=== Demonstrasi Linear Queue dan False Overflow ===

Setelah enqueue A-E  : LinearQueue (front->rear): ['A', 'B', 'C', 'D', 'E']
front=0, rear=4, count=5

Dequeue -> A
Dequeue -> B
Dequeue -> C

Setelah 3x dequeue  : LinearQueue (front->rear): ['D', 'E']
front=3, rear=4, count=2

GAGAL enqueue 'F': Queue penuh atau false overflow! rear=4, front=3, jumlah elemen aktual=2
=> Ini adalah FALSE OVERFLOW!
   Slot kosong tersedia: 3 buah (indeks 0 s/d 2)
```

> **Tahukah Anda? 7.1 — Asal Usul Istilah "False Overflow"**
>
> Istilah *false overflow* (atau kadang disebut *phantom overflow* dalam literatur tertentu) pertama kali dibahas secara sistematis dalam konteks implementasi queue berbasis array pada era awal ilmu komputer. Kondisi ini muncul karena desainer awal sistem komputer menggunakan strategi indeks bergerak maju (*advancing pointer*) tanpa strategi pemulihan slot yang telah ditinggalkan. Solusi yang kemudian ditemukan — circular buffer atau ring buffer — menjadi standar de facto untuk implementasi queue berbasis array yang efisien hingga hari ini, terutama dalam sistem *embedded* dan pemrograman tingkat rendah.

---

## 7.5 Circular Queue: Solusi Elegan Berbasis Aritmatika Modular

### 7.5.1 Konsep dan Prinsip Kerja

**Circular Queue** (antrian melingkar), yang juga dikenal sebagai **Ring Buffer**, adalah solusi definitif untuk masalah false overflow. Ide dasarnya sangat elegan: alih-alih membiarkan indeks `rear` terus bergerak maju hingga mencapai ujung array dan berhenti, kita membuat array tersebut berperilaku **seolah-olah melingkar** — ujung terakhir array terhubung kembali ke awal. Ketika `rear` atau `front` mencapai indeks terakhir array dan perlu maju satu langkah lagi, ia tidak berhenti, melainkan "melingkar" kembali ke indeks 0.

Mekanisme ini dicapai dengan sangat sederhana menggunakan **operasi modulo (sisa bagi)**:

```
indeks_berikutnya = (indeks_sekarang + 1) % kapasitas
```

Dengan rumus ini, apabila kapasitas adalah 6 dan indeks sekarang adalah 5 (indeks terakhir), maka indeks berikutnya adalah (5 + 1) % 6 = 0. Array seolah-olah "melingkar" kembali ke awal.

**Gambar 7.4** Representasi Konseptual Circular Queue sebagai Ring Buffer

```
              [indeks 0]
            /             \
    [indeks 5]             [indeks 1]
        |        RING        |
    [indeks 4]             [indeks 2]
            \             /
              [indeks 3]

  Kondisi: front=3, rear=1, count=5, kapasitas=6
  [0]='E'  [1]='F'  [2]=' '  [3]='B'  [4]='C'  [5]='D'
            ^rear                ^front

  Urutan antrian dari depan: B -> C -> D -> E -> F
  Slot kosong hanya [2]. Kapasitas tersisa = 1.
```

### 7.5.2 Visualisasi Tahap demi Tahap

Untuk memahami cara kerja circular queue secara menyeluruh, perhatikan simulasi langkah-demi-langkah berikut dengan kapasitas 6:

**Gambar 7.5** Evolusi State Circular Queue (Kapasitas = 6)

```
TAHAP 1: Kondisi awal (kosong)
  front=0, rear=-1, count=0
  [ _ ][ _ ][ _ ][ _ ][ _ ][ _ ]
    0    1    2    3    4    5

TAHAP 2: enqueue(A), enqueue(B), enqueue(C), enqueue(D)
  front=0, rear=3, count=4
  [ A ][ B ][ C ][ D ][ _ ][ _ ]
    ^                             front=0, rear=3
    0    1    2    3    4    5

TAHAP 3: dequeue() x2 -> mengambil A, lalu B
  front=2, rear=3, count=2
  [ _ ][ _ ][ C ][ D ][ _ ][ _ ]
              ^                   front=2, rear=3
    0    1    2    3    4    5
    (slot 0 dan 1 kosong, siap dipakai ulang)

TAHAP 4: enqueue(E), enqueue(F), enqueue(G)
  front=2, rear=5, count=5
  [ _ ][ _ ][ C ][ D ][ E ][ F ]
              ^              ^    front=2, rear=5
    0    1    2    3    4    5

  Catatan: rear masih bisa maju, tapi sudah di indeks 5 (ujung)

TAHAP 5: enqueue(G) -> rear MELINGKAR ke indeks 0!
  rear_baru = (5 + 1) % 6 = 0
  front=2, rear=0, count=6
  [ G ][ _ ][ C ][ D ][ E ][ F ]
    ^         ^                   rear=0, front=2
    0    1    2    3    4    5

TAHAP 6: Kondisi PENUH (count = kapasitas = 6)
  enqueue(H) -> rear_baru = (0+1)%6 = 1
  front=2, rear=1, count=6... PENUH, enqueue(H) DITOLAK
  (count == kapasitas => overflow sesungguhnya)
```

Perhatikan perbedaan mendasar dari linear queue: slot-slot yang telah dikosongkan oleh operasi dequeue dapat digunakan kembali karena rear "melingkar" kembali ke awal. Tidak ada false overflow.

### 7.5.3 Kondisi Penuh dan Kosong: Tantangan Distingtif

Salah satu tantangan teknis dalam implementasi circular queue adalah membedakan kondisi **penuh** dan **kosong** dengan tepat. Pada implementasi linear queue, perbedaan ini mudah: jika `rear < front`, queue kosong (atau gunakan `count`). Namun pada circular queue, secara visual posisi `front` dan `rear` bisa tampak berdekatan baik saat kosong maupun saat penuh.

Terdapat dua strategi umum untuk membedakan kedua kondisi ini:

**Strategi 1: Menggunakan variabel `count` (direkomendasikan)**
- Queue kosong jika `count == 0`
- Queue penuh jika `count == kapasitas`
- Kelebihan: paling mudah dipahami dan tidak membuang slot

**Strategi 2: Menyisakan satu slot kosong selalu**
- Queue kosong jika `front == rear`
- Queue penuh jika `(rear + 1) % kapasitas == front`
- Kekurangan: satu slot array selalu terbuang (kapasitas efektif berkurang satu)

Implementasi dalam buku ini menggunakan Strategi 1 karena lebih intuitif dan efisien dalam penggunaan memori.

### 7.5.4 Implementasi CircularQueue dalam Python

```python
class CircularQueue:
    """
    Implementasi Circular Queue (Ring Buffer) berbasis array.
    Menggunakan aritmatika modular untuk mengelola indeks front dan rear.
    Menyelesaikan masalah false overflow pada linear queue secara definitif.
    
    Invariant:
      - 0 <= _front < _capacity
      - 0 <= _count <= _capacity
      - _rear = (_front + _count - 1) % _capacity  (jika count > 0)
    """

    def __init__(self, capacity=10):
        """Inisialisasi circular queue dengan kapasitas tetap."""
        if capacity <= 0:
            raise ValueError("Kapasitas harus berupa bilangan bulat positif.")
        self._capacity = capacity
        self._data = [None] * capacity
        self._front = 0       # Indeks elemen terdepan
        self._rear = -1       # Indeks elemen terbelakang
        self._count = 0       # Jumlah elemen aktif

    def is_empty(self):
        """Mengembalikan True jika queue kosong."""
        return self._count == 0

    def is_full(self):
        """Mengembalikan True jika queue benar-benar penuh (bukan false overflow)."""
        return self._count == self._capacity

    def size(self):
        """Mengembalikan jumlah elemen dalam queue."""
        return self._count

    def enqueue(self, element):
        """
        Menambahkan elemen ke belakang queue.
        Menggunakan modular arithmetic: rear = (rear + 1) % capacity
        Kompleksitas Waktu: O(1)
        Kompleksitas Ruang: O(1) per operasi
        """
        if self.is_full():
            raise OverflowError(
                f"Queue benar-benar penuh ({self._count}/{self._capacity} elemen). "
                f"Ini bukan false overflow — queue sudah terisi seluruhnya."
            )
        # Geser rear ke depan secara melingkar menggunakan modulo
        self._rear = (self._rear + 1) % self._capacity
        self._data[self._rear] = element
        self._count += 1

    def dequeue(self):
        """
        Menghapus dan mengembalikan elemen dari depan queue.
        Menggunakan modular arithmetic: front = (front + 1) % capacity
        Kompleksitas Waktu: O(1)
        """
        if self.is_empty():
            raise IndexError("Operasi dequeue pada queue kosong.")
        elemen = self._data[self._front]
        self._data[self._front] = None    # Bersihkan referensi untuk GC
        # Geser front ke depan secara melingkar menggunakan modulo
        self._front = (self._front + 1) % self._capacity
        self._count -= 1
        return elemen

    def peek(self):
        """Mengembalikan elemen depan tanpa menghapus."""
        if self.is_empty():
            raise IndexError("Queue kosong.")
        return self._data[self._front]

    def visualisasi(self):
        """
        Menampilkan visualisasi array internal beserta posisi front dan rear.
        Berguna untuk debugging dan pembelajaran.
        """
        print(f"\n--- Visualisasi Circular Queue ---")
        print(f"Kapasitas: {self._capacity} | Jumlah elemen: {self._count}")
        print(f"front={self._front} | rear={self._rear}")
        slot_tampil = []
        for i, val in enumerate(self._data):
            slot_tampil.append(f"[{val if val is not None else '_':^3}]")
        print("Array : " + " ".join(slot_tampil))
        indeks_label = [f" {i:^3} " for i in range(self._capacity)]
        print("Indeks:" + " ".join(indeks_label))
        penanda = ["     "] * self._capacity
        if not self.is_empty():
            if self._front == self._rear:
                penanda[self._front] = " F=R "
            else:
                penanda[self._front] = "  F  "
                penanda[self._rear]  = "  R  "
        print("      " + "".join(penanda))
        print()

    def __str__(self):
        """Representasi string queue dari depan ke belakang."""
        if self.is_empty():
            return "CircularQueue: []"
        hasil = []
        for i in range(self._count):
            idx = (self._front + i) % self._capacity
            hasil.append(str(self._data[idx]))
        return f"CircularQueue (front->rear): [{', '.join(hasil)}]"
```

> **Catatan Penting 7.2 — Kunci Circular Queue: Aritmatika Modular**
>
> Seluruh keajaiban circular queue bertumpu pada satu baris kode: `indeks_baru = (indeks_lama + 1) % kapasitas`. Operasi modulo (%) memastikan bahwa indeks tidak pernah melebihi batas array, melainkan "melingkar" kembali ke 0 ketika mencapai `kapasitas`. Misalnya, pada array berkapasitas 8: indeks 7 -> (7+1)%8 = 0, indeks 0 -> (0+1)%8 = 1. Konsep ini identik dengan "jam digital" yang berputar dari 23 kembali ke 0: `(23 + 1) % 24 = 0`.

---

## 7.6 Linked List Queue: Kapasitas Dinamis

### 7.6.1 Motivasi dan Perbandingan dengan Pendekatan Array

Baik linear queue maupun circular queue berbasis array memiliki satu keterbatasan yang sama: **kapasitas harus ditentukan sejak awal** dan tidak dapat berubah selama masa pakai queue. Jika antrian ternyata membutuhkan lebih banyak slot dari yang diperkirakan, tidak ada cara untuk menambah kapasitas tanpa membuat ulang seluruh struktur data.

Queue berbasis **Linked List** hadir sebagai solusi untuk keterbatasan ini. Pada implementasi ini, tidak ada array tetap — setiap elemen disimpan dalam sebuah **Node** yang dialokasikan secara dinamis dari heap memori saat operasi enqueue, dan dikembalikan ke sistem saat operasi dequeue. Kapasitas queue hanya dibatasi oleh total memori yang tersedia pada sistem, bukan oleh konstanta yang ditetapkan saat kompilasi atau inisialisasi.

Struktur yang digunakan adalah **singly linked list** (daftar berantai tunggal) dengan dua pointer strategis:
- **`_front`** (head): pointer ke node paling depan — titik keluar saat dequeue.
- **`_rear`** (tail): pointer ke node paling belakang — titik masuk saat enqueue.

Dengan dua pointer ini, baik operasi enqueue (tambah di tail) maupun dequeue (hapus dari head) dapat dilakukan dalam waktu O(1) tanpa perlu menelusuri seluruh linked list.

**Gambar 7.6** Representasi Linked List Queue

```
front (_front/head)                        rear (_rear/tail)
       |                                          |
       v                                          v
   [A | *] --> [B | *] --> [C | *] --> [D | None]

   Operasi enqueue(E):
   Buat node baru [E|None], hubungkan _rear.next ke node baru,
   lalu geser _rear ke node baru.

   [A | *] --> [B | *] --> [C | *] --> [D | *] --> [E | None]
                                                         ^
                                                       _rear (baru)

   Operasi dequeue() -> mengembalikan A:
   Simpan A, geser _front ke _front.next.

   [B | *] --> [C | *] --> [D | *] --> [E | None]
    ^
  _front (baru)
```

### 7.6.2 Implementasi LinkedListQueue dalam Python

```python
class Node:
    """
    Node tunggal untuk linked list queue.
    Menyimpan data dan referensi ke node berikutnya dalam antrian.
    """

    def __init__(self, data):
        self.data = data
        self.next = None    # Referensi ke node berikutnya (None jika terakhir)

    def __repr__(self):
        return f"Node({self.data!r})"


class LinkedListQueue:
    """
    Implementasi Queue berbasis Singly Linked List.
    
    Karakteristik utama:
      - Enqueue: O(1) — menambah node baru di _rear (tail)
      - Dequeue: O(1) — menghapus node dari _front (head)
      - Kapasitas sepenuhnya dinamis, tidak ada false overflow
      - Overhead memori: satu pointer (next) per elemen
    """

    def __init__(self):
        """Inisialisasi queue kosong tanpa node."""
        self._front = None    # Pointer ke node depan (head linked list)
        self._rear = None     # Pointer ke node belakang (tail linked list)
        self._count = 0       # Penghitung jumlah elemen

    def is_empty(self):
        """Mengembalikan True jika queue tidak memiliki elemen."""
        return self._count == 0

    def size(self):
        """Mengembalikan jumlah elemen dalam queue."""
        return self._count

    def enqueue(self, element):
        """
        Menambahkan elemen baru ke belakang queue (tail linked list).
        Alokasi node baru dilakukan secara dinamis.
        Kompleksitas Waktu: O(1)
        Kompleksitas Ruang: O(1) per operasi (O(n) total)
        """
        node_baru = Node(element)
        if self.is_empty():
            # Queue kosong: front dan rear sama-sama menunjuk ke satu-satunya node
            self._front = node_baru
            self._rear = node_baru
        else:
            # Sambungkan node terakhir ke node baru, lalu geser rear
            self._rear.next = node_baru
            self._rear = node_baru
        self._count += 1

    def dequeue(self):
        """
        Menghapus dan mengembalikan elemen dari depan queue (head linked list).
        Node yang dihapus akan dibebaskan oleh garbage collector Python.
        Kompleksitas Waktu: O(1)
        """
        if self.is_empty():
            raise IndexError("Operasi dequeue pada queue kosong.")
        data = self._front.data
        self._front = self._front.next    # Geser front ke node berikutnya
        if self._front is None:
            # Queue menjadi kosong setelah dequeue ini: rear juga harus None
            self._rear = None
        self._count -= 1
        return data

    def peek(self):
        """Mengembalikan elemen depan tanpa menghapus node."""
        if self.is_empty():
            raise IndexError("Operasi peek pada queue kosong.")
        return self._front.data

    def __str__(self):
        """Representasi string queue dari depan ke belakang."""
        if self.is_empty():
            return "LinkedListQueue: []"
        elemen = []
        current = self._front
        while current:
            elemen.append(repr(current.data))
            current = current.next
        return f"LinkedListQueue (front->rear): [{' -> '.join(elemen)}]"
```

> **Catatan Penting 7.3 — Trade-off: Array vs. Linked List untuk Queue**
>
> Pilihan antara implementasi berbasis array (circular queue) dan berbasis linked list bukan soal mana yang "lebih baik" secara absolut, melainkan soal konteks penggunaan. Circular queue berbasis array lebih *cache-friendly* karena elemen-elemennya tersimpan secara berurutan dalam memori, sehingga akses lebih cepat pada perangkat keras modern. Namun, kapasitasnya tetap. Linked list queue sebaliknya: kapasitas dinamis, tetapi setiap node membutuhkan memori tambahan untuk menyimpan pointer `next`, dan akses memorinya tidak berurutan (berpotensi memperlambat cache). Untuk sistem *embedded* atau *real-time* dengan kapasitas yang telah diketahui, circular queue lebih disukai. Untuk aplikasi umum dengan beban yang tidak dapat diprediksi, linked list queue lebih tepat.

---

## 7.7 Priority Queue: Ketika Urutan Prioritas Mengalahkan Urutan Kedatangan

### 7.7.1 Konsep dan Motivasi

Selama ini kita mengasumsikan bahwa semua elemen dalam queue diperlakukan setara — yang datang lebih dahulu dilayani lebih dahulu tanpa memandang "kepentingan" elemen tersebut. Namun, dunia nyata tidak selalu seadil itu. Di unit gawat darurat rumah sakit, pasien yang mengalami serangan jantung harus ditangani lebih dahulu daripada pasien dengan luka kecil, meskipun pasien dengan luka kecil datang lebih awal. Di sistem operasi, proses sistem yang kritis harus mendapat prioritas lebih tinggi daripada proses latar belakang.

**Priority Queue** adalah ADT yang memperluas konsep queue dengan menambahkan atribut **prioritas** pada setiap elemen. Elemen dengan nilai prioritas tertinggi (atau terendah, tergantung konvensi) selalu berada di depan antrian dan diproses lebih dahulu, terlepas dari urutan kedatangan. Di antara elemen-elemen dengan prioritas yang sama, prinsip FIFO tetap berlaku.

**Gambar 7.7** Ilustrasi Priority Queue dengan Min-Heap (Nilai Prioritas Lebih Kecil = Lebih Diprioritaskan)

```
Urutan kedatangan: Task-D(4), Task-A(1), Task-C(3), Task-B(2)

Setelah semua elemen masuk, antrian tersusun berdasarkan prioritas:

  front                                     rear
    |                                         |
    v                                         v
  [Task-A, p=1] -> [Task-B, p=2] -> [Task-C, p=3] -> [Task-D, p=4]

  Urutan keluar (dequeue): Task-A, Task-B, Task-C, Task-D
  (bukan urutan kedatangan D, A, C, B)
```

### 7.7.2 Implementasi dengan Min-Heap

Implementasi priority queue yang paling efisien menggunakan struktur data **heap** (tumpukan biner). Python menyediakan modul `heapq` yang mengimplementasikan min-heap: elemen dengan nilai terkecil selalu berada di "puncak" heap dan dapat diakses dalam O(1), sementara operasi penambahan dan penghapusan berjalan dalam O(log n).

```python
import heapq

class PriorityQueue:
    """
    Implementasi Priority Queue menggunakan modul heapq Python (min-heap).
    Elemen dengan nilai prioritas TERKECIL diambil terlebih dahulu.
    
    Format internal elemen: (prioritas, urutan_masuk, data)
    Elemen urutan_masuk berfungsi sebagai tie-breaker untuk menjamin
    perilaku FIFO di antara elemen dengan prioritas yang sama.
    """

    def __init__(self):
        """Inisialisasi priority queue kosong."""
        self._heap = []        # Struktur heap internal (min-heap)
        self._counter = 0      # Penghitung urutan masuk sebagai tie-breaker

    def is_empty(self):
        """Mengembalikan True jika priority queue kosong."""
        return len(self._heap) == 0

    def size(self):
        """Mengembalikan jumlah elemen dalam priority queue."""
        return len(self._heap)

    def enqueue(self, element, priority):
        """
        Menambahkan elemen dengan nilai prioritas tertentu.
        Kompleksitas Waktu: O(log n) — akibat operasi heapify-up
        """
        # Tuple tiga elemen: (prioritas, urutan_masuk, data)
        # urutan_masuk sebagai tie-breaker menjamin FIFO untuk prioritas sama
        heapq.heappush(self._heap, (priority, self._counter, element))
        self._counter += 1

    def dequeue(self):
        """
        Menghapus dan mengembalikan elemen dengan prioritas tertinggi
        (nilai prioritas terkecil dalam min-heap).
        Kompleksitas Waktu: O(log n) — akibat operasi heapify-down
        """
        if self.is_empty():
            raise IndexError("Priority queue kosong.")
        prioritas, _, elemen = heapq.heappop(self._heap)
        return elemen, prioritas

    def peek(self):
        """
        Melihat elemen prioritas tertinggi tanpa menghapusnya.
        Kompleksitas Waktu: O(1)
        """
        if self.is_empty():
            raise IndexError("Priority queue kosong.")
        return self._heap[0][2], self._heap[0][0]    # (elemen, prioritas)

    def __str__(self):
        """Representasi string queue dalam urutan prioritas."""
        terurut = [(p, e) for p, _, e in sorted(self._heap)]
        return f"PriorityQueue (prioritas, data): {terurut}"
```

> **Tahukah Anda? 7.2 — Mengapa Perlu Tie-Breaker?**
>
> Tanpa elemen `_counter` sebagai tie-breaker, ketika dua elemen memiliki nilai prioritas yang sama, Python akan mencoba membandingkan elemen ketiga dari tuple — yaitu `element` itu sendiri. Jika `element` adalah objek kustom yang tidak mendukung operator perbandingan `<`, program akan melempar `TypeError`. Dengan menambahkan `_counter` sebagai elemen tengah tuple, perbandingan selalu dapat diselesaikan pada level `_counter` tanpa perlu menyentuh `element`. Selain itu, `_counter` yang terus bertambah menjamin bahwa elemen yang masuk lebih awal akan selalu memiliki nilai `_counter` yang lebih kecil, sehingga FIFO terpelihara di antara elemen-elemen dengan prioritas yang sama.

---

## 7.8 Deque: Generalisasi Queue dengan Dua Ujung

### 7.8.1 Konsep dan Operasi

**Deque** (Double-Ended Queue, dilafalkan "deck") adalah generalisasi dari queue yang memungkinkan penambahan dan penghapusan elemen dari **kedua ujung** — baik dari front maupun dari rear. Deque lebih fleksibel dari queue biasa: bergantung pada cara penggunaannya, ia dapat berperilaku sebagai queue FIFO (enqueue dari rear, dequeue dari front), sebagai stack LIFO (enqueue dan dequeue keduanya dari rear), atau sebagai struktur hibrida.

**Gambar 7.8** Operasi-Operasi pada Deque

```
  add_front(e)                           add_rear(e)
       |                                     |
       v                                     v
  [FRONT] <--> [e1] <--> [e2] <--> [e3] <--> [REAR]
       ^                                     ^
       |                                     |
  remove_front()                        remove_rear()
```

**Tabel 7.2** Operasi ADT Deque

| Operasi          | Deskripsi                                         | Kompleksitas |
|------------------|---------------------------------------------------|:------------:|
| `add_front(e)`   | Tambahkan elemen di bagian depan                  | O(1)         |
| `add_rear(e)`    | Tambahkan elemen di bagian belakang               | O(1)         |
| `remove_front()` | Hapus dan kembalikan elemen dari bagian depan     | O(1)         |
| `remove_rear()`  | Hapus dan kembalikan elemen dari bagian belakang  | O(1)         |
| `peek_front()`   | Lihat elemen depan tanpa menghapus                | O(1)         |
| `peek_rear()`    | Lihat elemen belakang tanpa menghapus             | O(1)         |

### 7.8.2 Implementasi Deque dalam Python

Python menyediakan implementasi deque yang sangat efisien dalam modul standar `collections`. Implementasi berikut membungkus `collections.deque` dengan antarmuka yang lebih eksplisit:

```python
from collections import deque as PythonDeque

class Deque:
    """
    Implementasi Double-Ended Queue (Deque).
    Menggunakan collections.deque Python sebagai struktur dasar
    (diimplementasikan dalam C, sangat efisien).
    Semua operasi front dan rear berjalan dalam O(1) waktu.
    """

    def __init__(self):
        """Inisialisasi deque kosong."""
        self._data = PythonDeque()

    def is_empty(self):
        """Mengembalikan True jika deque kosong."""
        return len(self._data) == 0

    def size(self):
        """Mengembalikan jumlah elemen dalam deque."""
        return len(self._data)

    def add_front(self, element):
        """Menambahkan elemen di bagian depan deque. O(1)"""
        self._data.appendleft(element)

    def add_rear(self, element):
        """Menambahkan elemen di bagian belakang deque. O(1)"""
        self._data.append(element)

    def remove_front(self):
        """Menghapus dan mengembalikan elemen dari depan deque. O(1)"""
        if self.is_empty():
            raise IndexError("Operasi remove_front pada deque kosong.")
        return self._data.popleft()

    def remove_rear(self):
        """Menghapus dan mengembalikan elemen dari belakang deque. O(1)"""
        if self.is_empty():
            raise IndexError("Operasi remove_rear pada deque kosong.")
        return self._data.pop()

    def peek_front(self):
        """Mengembalikan elemen depan tanpa menghapus. O(1)"""
        if self.is_empty():
            raise IndexError("Deque kosong.")
        return self._data[0]

    def peek_rear(self):
        """Mengembalikan elemen belakang tanpa menghapus. O(1)"""
        if self.is_empty():
            raise IndexError("Deque kosong.")
        return self._data[-1]

    def __str__(self):
        return f"Deque (front <-> rear): {list(self._data)}"


# --- Aplikasi: Pemeriksa Palindrom Menggunakan Deque ---
def cek_palindrome(teks: str) -> bool:
    """
    Menggunakan Deque untuk memeriksa apakah teks merupakan palindrom.
    Algoritma: masukkan semua karakter alfabet ke deque, lalu
    bandingkan karakter dari depan dan belakang secara bergantian.
    Kompleksitas: O(n) waktu, O(n) ruang.
    """
    dq = Deque()
    for karakter in teks.lower():
        if karakter.isalpha():    # Abaikan spasi dan tanda baca
            dq.add_rear(karakter)

    while dq.size() > 1:
        if dq.remove_front() != dq.remove_rear():
            return False
    return True


if __name__ == "__main__":
    kata_uji = [
        "radar",
        "level",
        "python",
        "civic",
        "A man a plan a canal Panama",
        "Never odd or even",
        "race a car",
    ]
    print("=== Pemeriksa Palindrom dengan Deque ===")
    for kata in kata_uji:
        hasil = "PALINDROM" if cek_palindrome(kata) else "Bukan palindrom"
        print(f"  '{kata}' -> {hasil}")
```

---

## 7.9 Perbandingan Komprehensif Seluruh Implementasi Queue

Setelah mempelajari kelima varian implementasi queue, penting untuk memiliki gambaran komprehensif tentang perbedaan karakteristik masing-masing. Pemilihan implementasi yang tepat sangat bergantung pada konteks penggunaan, terutama dari sisi kapasitas, kompleksitas operasi, dan karakteristik beban kerja sistem.

**Tabel 7.3** Perbandingan Komprehensif Implementasi Queue

| Implementasi       | Enqueue   | Dequeue   | Peek | Ruang | Kapasitas | Kelebihan Utama                           | Kekurangan Utama                          |
|--------------------|:---------:|:---------:|:----:|:-----:|:---------:|-------------------------------------------|-------------------------------------------|
| Linear Queue       | O(1)      | O(1)      | O(1) | O(n)  | Tetap     | Paling sederhana, mudah dipahami          | False overflow, pemborosan memori         |
| Circular Queue     | O(1)      | O(1)      | O(1) | O(n)  | Tetap     | Efisien, tidak ada false overflow, cache-friendly | Kapasitas tetap, harus ditentukan di awal |
| Linked List Queue  | O(1)      | O(1)      | O(1) | O(n)  | Dinamis   | Kapasitas tak terbatas, tidak ada overflow | Overhead pointer per node, tidak cache-friendly |
| Priority Queue     | O(log n)  | O(log n)  | O(1) | O(n)  | Dinamis   | Mendukung pemrosesan berdasarkan prioritas | Lebih lambat, kompleksitas lebih tinggi   |
| Deque              | O(1)      | O(1)      | O(1) | O(n)  | Dinamis   | Fleksibel (dua arah), bisa jadi queue atau stack | Sedikit lebih kompleks dari queue biasa  |

---

## 7.10 Studi Kasus: Simulasi Sistem Antrian Layanan Bank

### 7.10.1 Latar Belakang dan Relevansi

Salah satu aplikasi queue yang paling representatif dalam dunia nyata adalah **simulasi sistem antrian layanan**. Model simulasi semacam ini merupakan alat analisis yang sangat penting dalam **teori antrian** (Queueing Theory) — bidang matematika terapan yang mempelajari perilaku sistem layanan. Hasil simulasi digunakan oleh perencana untuk menentukan jumlah loket yang optimal, memprediksi waktu tunggu nasabah, dan merancang strategi layanan yang efisien.

Parameter kinerja sistem antrian yang umum dianalisis meliputi:
- **Waktu tunggu rata-rata** (average waiting time) per pelanggan.
- **Panjang antrian rata-rata** (average queue length).
- **Utilisasi server** (server utilization) — persentase waktu loket aktif melayani.
- **Tingkat penolakan** — persentase pelanggan yang tidak dapat masuk karena antrian penuh.

---

> **Studi Kasus 7.1 — Simulasi Antrian Loket Tunggal Bank**
>
> Sebuah cabang bank kecil memiliki satu loket layanan. Manajemen bank ingin mengetahui apakah satu loket sudah memadai untuk melayani nasabah selama jam operasi, atau apakah perlu menambah loket. Parameter yang diketahui: jam operasi 60 menit, rata-rata kedatangan 3 nasabah per 10 menit, durasi layanan per nasabah antara 2 hingga 8 menit (bervariasi acak), dan kapasitas ruang tunggu 20 kursi.

```python
import random
import statistics


class Pelanggan:
    """Merepresentasikan seorang pelanggan dalam simulasi antrian."""

    def __init__(self, id_pelanggan: int, waktu_tiba: int):
        self.id = id_pelanggan
        self.waktu_tiba = waktu_tiba
        self.waktu_mulai_layanan = None
        self.waktu_selesai = None
        self.durasi_layanan = random.randint(2, 8)    # Menit

    @property
    def waktu_tunggu(self) -> int:
        """Menghitung lama pelanggan menunggu sebelum dilayani."""
        if self.waktu_mulai_layanan is None:
            return None
        return self.waktu_mulai_layanan - self.waktu_tiba

    def __repr__(self):
        return f"Pelanggan-{self.id:03d}(tiba={self.waktu_tiba})"


class SimulasiAntrian:
    """
    Simulasi sistem antrian satu loket (M/D/1 model sederhana).
    Menggunakan CircularQueue sebagai antrian pelanggan.
    """

    def __init__(self, durasi_simulasi=60, rata_kedatangan=3, kapasitas_antrian=20):
        self.durasi = durasi_simulasi
        self.rata_kedatangan = rata_kedatangan
        self.antrian = CircularQueue(capacity=kapasitas_antrian)
        self.total_pelanggan = 0
        self.pelanggan_selesai = []
        self.pelanggan_ditolak = 0

    def jalankan(self):
        """Menjalankan simulasi menit per menit selama durasi yang ditentukan."""
        print(f"{'='*58}")
        print(f"  SIMULASI ANTRIAN LOKET BANK")
        print(f"  Durasi: {self.durasi} menit | Kapasitas tunggu: "
              f"{self.antrian._capacity} orang")
        print(f"{'='*58}\n")

        waktu_selesai_layanan = 0    # Kapan loket bebas kembali

        for menit in range(1, self.durasi + 1):
            # Fase kedatangan: sejumlah pelanggan tiba secara acak
            jumlah_tiba = random.randint(0, self.rata_kedatangan)
            for _ in range(jumlah_tiba):
                self.total_pelanggan += 1
                pelanggan_baru = Pelanggan(self.total_pelanggan, menit)
                try:
                    self.antrian.enqueue(pelanggan_baru)
                except OverflowError:
                    self.pelanggan_ditolak += 1    # Antrian penuh, pelanggan pergi

            # Fase layanan: layani pelanggan berikutnya jika loket bebas
            if menit >= waktu_selesai_layanan and not self.antrian.is_empty():
                pelanggan = self.antrian.dequeue()
                pelanggan.waktu_mulai_layanan = menit
                pelanggan.waktu_selesai = menit + pelanggan.durasi_layanan
                waktu_selesai_layanan = pelanggan.waktu_selesai
                self.pelanggan_selesai.append(pelanggan)

            # Log setiap 10 menit
            if menit % 10 == 0:
                print(f"  Menit {menit:3d} | "
                      f"Antrian: {self.antrian.size():2d} orang | "
                      f"Terlayani: {len(self.pelanggan_selesai):3d} orang")

        self._cetak_statistik()

    def _cetak_statistik(self):
        """Mencetak ringkasan statistik kinerja sistem."""
        print(f"\n{'='*58}")
        print(f"  RINGKASAN STATISTIK SIMULASI")
        print(f"{'='*58}")
        print(f"  Total pelanggan datang      : {self.total_pelanggan}")
        print(f"  Berhasil dilayani           : {len(self.pelanggan_selesai)}")
        print(f"  Ditolak (antrian penuh)     : {self.pelanggan_ditolak}")
        print(f"  Masih dalam antrian (akhir) : {self.antrian.size()}")

        if self.pelanggan_selesai:
            w_list = [p.waktu_tunggu for p in self.pelanggan_selesai
                      if p.waktu_tunggu is not None]
            if w_list:
                print(f"\n  Waktu tunggu rata-rata      : "
                      f"{statistics.mean(w_list):.2f} menit")
                print(f"  Waktu tunggu maksimum       : {max(w_list)} menit")
                print(f"  Waktu tunggu minimum        : {min(w_list)} menit")
        print(f"{'='*58}\n")


# --- Jalankan Simulasi ---
if __name__ == "__main__":
    random.seed(42)    # Seed tetap untuk hasil yang dapat direproduksi
    sim = SimulasiAntrian(
        durasi_simulasi=60,
        rata_kedatangan=3,
        kapasitas_antrian=20
    )
    sim.jalankan()
```

Simulasi ini merupakan model antrian M/D/1 yang disederhanakan: kedatangan bersifat acak (Markovian), durasi layanan bervariasi dalam rentang tertentu (Deterministic range), dan terdapat satu server (loket). Dalam praktik nyata, insinyur sistem menggunakan model yang lebih kompleks seperti M/M/1, M/M/c, atau G/G/1, namun prinsip penggunaan queue sebagai struktur data inti tetap sama.

---

## 7.11 Aplikasi Queue dalam Penjadwalan Proses: Round Robin Scheduling

Selain simulasi layanan, queue memiliki peran krusial dalam sistem operasi. **Round Robin Scheduling** adalah algoritma penjadwalan CPU yang menggunakan circular queue untuk memastikan setiap proses mendapat jatah waktu CPU yang adil dan merata. Setiap proses mendapat jatah waktu (time quantum) yang sama secara bergiliran. Jika proses belum selesai ketika jatahnya habis, proses tersebut dimasukkan kembali ke belakang antrian untuk menunggu giliran berikutnya.

```python
def round_robin_scheduling(daftar_proses: list, time_quantum: int):
    """
    Simulasi Round Robin CPU Scheduling menggunakan LinkedListQueue.
    
    Parameter:
      daftar_proses : list of tuple (nama_proses, burst_time_ms)
      time_quantum  : jatah waktu CPU per giliran (milidetik)
    """
    antrian = LinkedListQueue()
    burst_tersisa = {nama: bt for nama, bt in daftar_proses}

    for nama, _ in daftar_proses:
        antrian.enqueue(nama)

    waktu = 0
    print(f"\n{'='*52}")
    print(f"  ROUND ROBIN SCHEDULING (Quantum = {time_quantum} ms)")
    print(f"{'='*52}")
    print(f"  {'Waktu':>6} | {'Proses':<14} | {'Sisa Burst':>10}")
    print(f"  {'-'*42}")

    while not antrian.is_empty():
        proses = antrian.dequeue()
        sisa = burst_tersisa[proses]

        if sisa <= time_quantum:
            waktu += sisa
            burst_tersisa[proses] = 0
            print(f"  {waktu:6} | {proses:<14} | {'SELESAI':>10}")
        else:
            waktu += time_quantum
            burst_tersisa[proses] -= time_quantum
            print(f"  {waktu:6} | {proses:<14} | {burst_tersisa[proses]:>8} ms")
            antrian.enqueue(proses)    # Kembali ke belakang antrian

    print(f"\n  Total waktu eksekusi: {waktu} ms\n")


if __name__ == "__main__":
    proses = [("P1", 24), ("P2", 3), ("P3", 3), ("P4", 12)]
    round_robin_scheduling(proses, time_quantum=4)
```

> **Catatan Penting 7.4 — Queue dalam Arsitektur Perangkat Lunak Modern**
>
> Konsep queue melampaui batas implementasi dalam satu program. Dalam arsitektur perangkat lunak modern, **Message Queue** adalah komponen infrastruktur yang memungkinkan komunikasi asinkron antara berbagai layanan (*microservices*). Sistem seperti RabbitMQ, Apache Kafka, dan Amazon SQS pada dasarnya adalah implementasi queue berskala besar yang terdistribusi. Producer mengirim pesan ke queue; consumer mengambil dan memprosesnya secara independen. Prinsip yang mendasarinya tetap sama: FIFO, enqueue, dequeue — hanya skalanya yang berbeda, dari ribuan hingga jutaan pesan per detik.

---

## 7.12 Rangkuman Bab

Bab ini telah membahas Queue sebagai salah satu Abstract Data Type yang paling fundamental dalam ilmu komputer. Berikut adalah poin-poin utama yang telah dipelajari:

1. **Queue** adalah struktur data linear dengan prinsip **FIFO (First In First Out)**: elemen yang pertama masuk adalah yang pertama keluar. Queue memiliki dua titik akses: *front* (titik keluar/dequeue) dan *rear* (titik masuk/enqueue). Semua operasi dasar — enqueue, dequeue, dan peek — dirancang untuk berjalan dalam O(1).

2. **Linear Queue berbasis array** adalah implementasi paling sederhana namun memiliki kelemahan kritis berupa **false overflow**: kondisi di mana operasi enqueue ditolak seolah queue penuh, padahal masih ada slot kosong di bagian depan array yang telah ditinggalkan oleh operasi dequeue. Kelemahan ini disebabkan oleh strategi indeks bergerak maju tanpa pemulihan slot.

3. **Circular Queue** menyelesaikan masalah false overflow secara elegan melalui **aritmatika modular**: `indeks_baru = (indeks_lama + 1) % kapasitas`. Array berperilaku seolah melingkar, dan slot yang telah dikosongkan dapat digunakan kembali. Circular Queue direkomendasikan untuk sistem dengan kapasitas yang telah diketahui, khususnya sistem *embedded* dan *real-time*.

4. **Linked List Queue** menawarkan kapasitas yang sepenuhnya **dinamis** tanpa batas tetap. Setiap elemen disimpan dalam node yang dialokasikan secara dinamis. Dengan dua pointer *front* (head) dan *rear* (tail), operasi enqueue (tambah di tail) dan dequeue (hapus dari head) tetap berjalan dalam O(1). Kekurangannya adalah overhead memori untuk pointer pada setiap node dan akses yang tidak *cache-friendly*.

5. **Priority Queue** memperluas konsep queue dengan menambahkan atribut **prioritas** pada setiap elemen. Elemen dengan prioritas tertinggi selalu diproses lebih dahulu terlepas dari urutan kedatangan. Implementasi menggunakan min-heap memberikan kompleksitas O(log n) untuk operasi enqueue dan dequeue. Aplikasinya mencakup triase medis, penjadwalan proses sistem operasi, dan algoritma Dijkstra.

6. **Deque (Double-Ended Queue)** adalah generalisasi queue yang memungkinkan penambahan dan penghapusan elemen dari kedua ujung dalam O(1). Deque bersifat lebih fleksibel: dapat berperilaku sebagai queue FIFO, stack LIFO, atau keduanya sekaligus. Aplikasinya antara lain pengecekan palindrom, sliding window algorithm, dan undo-redo pada aplikasi.

7. Queue memiliki **aplikasi yang sangat luas** dalam sistem nyata: Round Robin CPU scheduling pada sistem operasi, manajemen buffer pada jaringan komputer, simulasi sistem antrian layanan dalam teori antrian, algoritma BFS (Breadth-First Search) pada penelusuran graf, serta Message Queue dalam arsitektur *microservices* modern.

---

## 7.13 Istilah Kunci

| Istilah | Definisi |
|---------|----------|
| **Queue** | Abstract Data Type linear yang mengikuti prinsip FIFO, dengan dua titik akses: front (keluar) dan rear (masuk). |
| **FIFO** | First In First Out — kebijakan antrian di mana elemen yang pertama masuk adalah yang pertama diproses. |
| **Front** | Ujung depan queue; titik di mana operasi dequeue (penghapusan elemen) dilakukan. |
| **Rear / Back** | Ujung belakang queue; titik di mana operasi enqueue (penambahan elemen) dilakukan. |
| **Enqueue** | Operasi menambahkan elemen baru ke bagian belakang (rear) queue. |
| **Dequeue** | Operasi menghapus dan mengembalikan elemen dari bagian depan (front) queue. |
| **False Overflow** | Kondisi pada linear queue di mana operasi enqueue ditolak meskipun masih ada slot kosong di bagian depan array. |
| **Circular Queue** | Implementasi queue berbasis array yang menggunakan aritmatika modular agar array berperilaku melingkar, menghilangkan false overflow. |
| **Ring Buffer** | Nama lain untuk circular queue; sering digunakan dalam konteks pemrograman sistem dan *embedded*. |
| **Aritmatika Modular** | Teknik perhitungan indeks menggunakan operator modulo (%) untuk membuat indeks array "melingkar". |
| **Linked List Queue** | Implementasi queue menggunakan singly linked list dengan pointer front (head) dan rear (tail). |
| **Priority Queue** | Varian queue di mana setiap elemen memiliki prioritas; elemen berprioritas tertinggi selalu diproses duluan. |
| **Min-Heap** | Struktur data pohon biner lengkap di mana nilai simpul induk selalu lebih kecil atau sama dengan nilai simpul anaknya; digunakan sebagai dasar implementasi priority queue. |
| **Deque** | Double-Ended Queue; generalisasi queue yang memungkinkan penambahan dan penghapusan dari kedua ujung dalam O(1). |
| **Time Quantum** | Jatah waktu CPU yang diberikan kepada setiap proses dalam algoritma Round Robin Scheduling. |
| **Round Robin Scheduling** | Algoritma penjadwalan CPU yang menggunakan circular queue untuk mendistribusikan waktu CPU secara adil kepada semua proses. |
| **Message Queue** | Komponen infrastruktur dalam arsitektur *microservices* yang memungkinkan komunikasi asinkron antar layanan berdasarkan prinsip queue. |
| **Overflow** | Kondisi kesalahan (error) ketika operasi enqueue dilakukan pada queue yang benar-benar sudah penuh. |
| **Underflow** | Kondisi kesalahan (error) ketika operasi dequeue atau peek dilakukan pada queue yang kosong. |
| **Tie-Breaker** | Mekanisme tambahan (biasanya counter urutan masuk) dalam priority queue untuk menjamin perilaku FIFO di antara elemen-elemen dengan nilai prioritas yang sama. |

---

## 7.14 Soal Latihan

**Soal 1 [C2 - Memahami]**
Sebuah linear queue berkapasitas 6 memiliki kondisi: `front = 4`, `rear = 5`, `count = 2`. Elemen yang tersimpan adalah `['X', 'Y']` di posisi indeks 4 dan 5. Jelaskan mengapa operasi `enqueue('Z')` pada queue ini akan gagal meskipun kapasitas array masih memungkinkan secara logis. Apa istilah untuk kondisi ini dan apa akar penyebabnya?

---

**Soal 2 [C2 - Memahami]**
Perhatikan lima pernyataan berikut. Tentukan mana yang benar (B) dan mana yang salah (S), beserta alasannya:

a) Pada queue yang menggunakan prinsip FIFO, elemen yang terakhir masuk adalah yang pertama keluar.
b) Circular queue dengan kapasitas 8 selalu dapat menyimpan tepat 8 elemen secara bersamaan (menggunakan strategi variabel `count`).
c) Operasi `peek()` pada queue kosong seharusnya mengembalikan `None`, bukan melempar exception.
d) Priority queue yang diimplementasikan dengan min-heap menjamin O(1) untuk operasi enqueue.
e) Deque dapat digunakan sebagai pengganti stack karena dapat melakukan operasi tambah dan hapus dari ujung yang sama.

---

**Soal 3 [C3 - Menerapkan]**
Sebuah circular queue berkapasitas 7 sedang dalam kondisi: `front = 5`, `rear = 2`, `count = 5`. Elemen-elemennya (dari front ke rear secara melingkar) adalah: `P, Q, R, S, T`. Gambarkan kondisi array internal setelah rangkaian operasi berikut dilakukan secara berurutan:
1. `dequeue()` — catat nilai yang dikembalikan
2. `dequeue()` — catat nilai yang dikembalikan
3. `enqueue('U')`
4. `enqueue('V')`

Tunjukkan nilai `front`, `rear`, dan `count` setelah setiap langkah.

---

**Soal 4 [C3 - Menerapkan]**
Implementasikan fungsi Python `balik_queue(q)` yang menerima sebuah `LinkedListQueue` berisi n elemen dan mengembalikan queue baru berisi elemen-elemen yang sama dalam urutan terbalik (elemen terakhir menjadi terdepan dan sebaliknya). Fungsi ini boleh menggunakan struktur data pembantu (stack, list Python, dll.). Analisis kompleksitas waktu dan ruang solusi Anda.

---

**Soal 5 [C3 - Menerapkan]**
Implementasikan kelas `HotPotatoGame` yang mensimulasikan permainan *hot potato* menggunakan Queue. Dalam permainan ini, sejumlah peserta duduk melingkar dan saling mengoper objek. Setiap kali hitungan mencapai angka tertentu (N), peserta yang memegang objek dikeluarkan dari permainan. Permainan berlanjut hingga hanya tersisa satu peserta. Uji implementasi Anda dengan: peserta `['Ali', 'Budi', 'Citra', 'Dewi', 'Eko']` dan nilai `N = 3`.

---

**Soal 6 [C4 - Menganalisis]**
Bandingkan implementasi Circular Queue dan Linked List Queue dari empat aspek berikut: (a) penggunaan memori, (b) penanganan kondisi penuh/overflow, (c) fleksibilitas kapasitas, dan (d) performa cache pada perangkat keras modern. Berdasarkan analisis Anda, implementasi mana yang lebih tepat untuk: (i) buffer audio real-time pada perangkat keras *embedded*, dan (ii) antrian tugas pada server web yang menerima permintaan dengan volume yang sangat bervariasi?

---

**Soal 7 [C4 - Menganalisis]**
Perhatikan kode Python berikut:

```python
q = CircularQueue(capacity=4)
q.enqueue(10)
q.enqueue(20)
q.enqueue(30)
q.dequeue()
q.dequeue()
q.enqueue(40)
q.enqueue(50)
q.enqueue(60)
print(q.peek())
print(q.size())
```

Tanpa menjalankan kode, tentukan: (a) nilai `front` dan `rear` setelah semua operasi selesai, (b) nilai yang dicetak oleh `print(q.peek())`, dan (c) nilai yang dicetak oleh `print(q.size())`. Tunjukkan langkah demi langkah perhitungan Anda menggunakan aritmatika modular.

---

**Soal 8 [C4 - Menganalisis]**
Pada implementasi `PriorityQueue` yang menggunakan heap, mengapa diperlukan `_counter` sebagai elemen ketiga dalam tuple `(prioritas, _counter, elemen)`? Apa yang akan terjadi jika `_counter` dihilangkan dan tuple hanya berisi `(prioritas, elemen)` ketika ada dua elemen dengan prioritas yang sama dan tipe data elemen adalah objek kustom yang tidak mengimplementasikan operator `<`? Jelaskan dengan detail teknis.

---

**Soal 9 [C5 - Mengevaluasi]**
Sebuah sistem antrian rumah sakit memiliki empat kategori pasien: **Merah/Kritis (prioritas 1)**, **Oranye/Serius (prioritas 2)**, **Kuning/Moderat (prioritas 3)**, dan **Hijau/Ringan (prioritas 4)**. Dalam kategori yang sama, pasien yang lebih tua (usia lebih tinggi) diberi prioritas lebih tinggi (karena kondisi fisik lebih rentan). Evaluasi apakah implementasi `PriorityQueue` yang telah dipelajari sudah cukup untuk menangani sistem ini, atau perlu modifikasi. Jika perlu modifikasi, jelaskan perubahan apa yang diperlukan pada metode `enqueue` dan berikan potongan kode yang dimodifikasi.

---

**Soal 10 [C5 - Mengevaluasi]**
Seorang mahasiswa mengusulkan bahwa masalah false overflow pada linear queue dapat diselesaikan dengan cara berikut: "Setiap kali operasi dequeue dilakukan, geser semua elemen yang tersisa satu posisi ke depan sehingga front selalu berada di indeks 0." Evaluasi solusi ini dari aspek (a) apakah berhasil menghilangkan false overflow, (b) kompleksitas waktu operasi dequeue setelah modifikasi, dan (c) apakah ini lebih baik atau lebih buruk dari Circular Queue. Berikan justifikasi kuantitatif.

---

**Soal 11 [C6 - Mencipta]**
Rancang dan implementasikan kelas `MultiServerQueue` yang mensimulasikan sistem antrian dengan **lebih dari satu loket** (multi-server queue). Kelas ini harus:
- Menerima parameter jumlah server (`num_servers`) dan kapasitas antrian.
- Menyimpan status setiap server (sibuk atau bebas, waktu selesai layanan).
- Menggunakan `CircularQueue` sebagai antrian utama pelanggan.
- Mengimplementasikan metode `proses(menit)` yang memperbarui status semua server pada setiap satuan waktu.
- Menyimpan statistik waktu tunggu setiap pelanggan yang berhasil dilayani.

---

**Soal 12 [C6 - Mencipta]**
Rancang dan implementasikan struktur data `HistoryManager` yang mensimulasikan fitur *undo* dan *redo* pada sebuah editor teks sederhana menggunakan **dua deque**. Setiap aksi pengguna (tambah teks, hapus teks, dll.) direpresentasikan sebagai string. Kelas ini harus mendukung:
- `lakukan(aksi)`: merekam aksi baru, menghapus semua history redo yang ada.
- `undo()`: membatalkan aksi terakhir dan memindahkannya ke history redo.
- `redo()`: mengulangi aksi yang terakhir di-undo.
- `tampilkan_history()`: menampilkan riwayat aksi yang telah dilakukan (dari terlama ke terbaru).
- `tampilkan_redo()`: menampilkan daftar aksi yang dapat di-redo.

Uji implementasi Anda dengan minimal 5 skenario berbeda yang melibatkan kombinasi undo dan redo.

---

## 7.15 Bacaan Lanjutan

1. **Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2013). *Data Structures and Algorithms in Python*. John Wiley & Sons.**
   Bab 6 buku ini membahas stack, queue, dan deque secara menyeluruh dengan pendekatan berorientasi objek yang sangat sesuai untuk pemrogram Python. Penjelasan tentang implementasi circular queue berbasis array dan analisis kompleksitasnya sangat mendalam. Buku ini merupakan referensi utama untuk topik queue di tingkat perguruan tinggi dan sangat direkomendasikan sebagai teks pendamping bab ini.

2. **Weiss, M. A. (2013). *Data Structures and Algorithm Analysis in Java* (3rd ed.). Pearson.**
   Meskipun menggunakan Java, Bab 3 buku ini menyajikan analisis komprehensif tentang linked list dan queue yang sangat relevan. Konsep-konsepnya mudah diadaptasi ke Python. Penjelasan tentang amortized analysis pada struktur data dinamis sangat bermanfaat untuk memahami trade-off antara berbagai implementasi queue.

3. **Kleinrock, L. (1975). *Queueing Systems, Volume 1: Theory*. Wiley-Interscience.**
   Karya klasik yang menjadi landasan teori antrian modern. Bagi mahasiswa yang tertarik pada aspek matematis di balik simulasi antrian (distribusi kedatangan, utilisasi server, waktu tunggu rata-rata), buku ini adalah referensi yang tak tertandingi. Model M/M/1, M/M/c, dan variasinya dijelaskan dengan sangat mendalam beserta pembuktian matematisnya.

4. **Python Software Foundation. (2024). *collections — Container datatypes*. Dokumentasi Resmi Python 3.x. https://docs.python.org/3/library/collections.html**
   Dokumentasi resmi untuk modul `collections` Python, mencakup `deque` dan implementasi detailnya. Bagian yang membahas `collections.deque` sangat penting untuk memahami jaminan performa O(1) pada operasi di kedua ujung. Dokumentasi ini juga membahas thread-safety pada operasi `append` dan `popleft` yang relevan untuk aplikasi multi-thread.

5. **Python Software Foundation. (2024). *heapq — Heap queue algorithm*. Dokumentasi Resmi Python 3.x. https://docs.python.org/3/library/heapq.html**
   Dokumentasi resmi untuk modul `heapq` Python yang menjadi dasar implementasi Priority Queue. Memuat penjelasan algoritma heap, contoh penggunaan, dan pola umum seperti *merge sorted iterables* dan *n largest/smallest elements*. Sangat penting untuk memahami cara kerja min-heap yang menjadi dasar Priority Queue efisien.

6. **Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022). *Introduction to Algorithms* (4th ed.). MIT Press.**
   Bab 6 (*Heapsort*) dan Appendix B (*Sets, Relations, Functions, Graphs, and Trees*) dalam buku teks algoritma paling komprehensif ini memberikan analisis matematis yang ketat tentang heap dan priority queue. Untuk mahasiswa yang ingin memahami bukti formal tentang kompleksitas heap operations, buku ini adalah referensi yang tidak dapat dilewatkan.

7. **Tanenbaum, A. S., & Bos, H. (2014). *Modern Operating Systems* (4th ed.). Pearson.**
   Bab 2 (*Processes and Threads*) dan Bab 6 (*Deadlocks*) membahas penggunaan queue dalam konteks sistem operasi: penjadwalan proses Round Robin, antrian ready, antrian wait, dan pengelolaan I/O. Membaca buku ini setelah memahami queue secara implementasi akan memberikan perspektif yang sangat berharga tentang aplikasi nyata queue dalam sistem tingkat rendah.

8. **Newman, S. (2021). *Building Microservices: Designing Fine-Grained Systems* (2nd ed.). O'Reilly Media.**
   Bab yang membahas komunikasi asinkron antar layanan dalam arsitektur microservices menggambarkan bagaimana prinsip queue diterapkan pada skala besar melalui Message Queue seperti RabbitMQ dan Apache Kafka. Buku ini memberikan perspektif engineering tentang bagaimana konsep queue yang sederhana menjadi tulang punggung sistem terdistribusi berskala jutaan pengguna.

---

*Bab 7 dari: Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python*
*Institut Bisnis dan Teknologi Indonesia (INSTIKI)*
