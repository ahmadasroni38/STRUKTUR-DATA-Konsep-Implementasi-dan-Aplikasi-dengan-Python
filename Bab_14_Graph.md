# BAB 14
# GRAPH: REPRESENTASI, TRAVERSAL, DAN ALGORITMA JALUR TERPENDEK

---

> *"The utility of a graph is in making clear what is not obvious."*
> — Leonhard Euler (1707–1783), dalam semangat karyanya *Solutio problematis ad geometriam situs pertinentis* (1736), tulisan yang melahirkan teori graph modern.

---

## 14.1 Tujuan Pembelajaran

Setelah mempelajari bab ini, mahasiswa diharapkan mampu:

1. **[C2 - Memahami]** Menjelaskan sejarah lahirnya teori graph dari permasalahan Jembatan Königsberg dan menguraikan terminologi graph meliputi vertex, edge, path, cycle, degree, connected, dan weight.
2. **[C2 - Memahami]** Membedakan jenis-jenis graph (undirected, directed, weighted, DAG) berdasarkan karakteristik edge dan kegunaannya dalam pemodelan masalah nyata.
3. **[C3 - Menerapkan]** Mengimplementasikan representasi graph menggunakan adjacency matrix dan adjacency list dalam bahasa Python, termasuk operasi penambahan vertex, penambahan edge, dan pengecekan ketetanggaan.
4. **[C4 - Menganalisis]** Membandingkan kompleksitas ruang dan waktu antara adjacency matrix dan adjacency list, serta menentukan representasi yang tepat berdasarkan karakteristik graph.
5. **[C3 - Menerapkan]** Menerapkan algoritma traversal Breadth-First Search (BFS) dengan menggunakan queue untuk menelusuri graph dan menemukan jalur dengan jumlah edge minimum.
6. **[C3 - Menerapkan]** Menerapkan algoritma traversal Depth-First Search (DFS) secara rekursif maupun iteratif, serta menggunakannya untuk deteksi siklus dan pengurutan topologis.
7. **[C4 - Menganalisis]** Menganalisis prinsip kerja algoritma Dijkstra melalui trace manual dan mengidentifikasi perbedaan mendasar antara Dijkstra dengan BFS dalam konteks graph berbobot.
8. **[C5 - Mengevaluasi]** Mengevaluasi keterkaitan antara konsep graph dengan topik-topik lanjutan dalam ilmu komputer, termasuk masalah NP-hard, aliran jaringan, dan pembelajaran mesin berbasis graph.

---

## 14.2 Pendahuluan: Ketika Satu Struktur Data Memodelkan Segalanya

Perjalanan panjang studi struktur data yang telah ditempuh dalam buku ini dimulai dari representasi data yang paling mendasar — array dan string — lalu berkembang melewati linked list, stack, queue, tree binary, BST, heap, hash table, hingga trie. Setiap struktur yang dipelajari memberikan cara pandang baru dalam mengorganisasi dan memanipulasi informasi. Namun, pada bab penutup ini, kita berhadapan dengan sebuah struktur data yang secara ekspresif melampaui semua yang telah dipelajari sebelumnya: **graph**.

Apa yang membuat graph begitu istimewa? Jawabannya terletak pada kemampuannya merepresentasikan hubungan yang *sembarang* antar entitas. Pada array dan linked list, hubungan yang direpresentasikan bersifat linear dan sekuensial — setiap elemen hanya "mengenal" elemen sebelum atau sesudahnya. Pada tree, hubungan bersifat hierarkis — setiap simpul memiliki tepat satu parent dan boleh memiliki banyak child, namun aliran informasi selalu satu arah dari akar ke daun. Graph melepaskan diri dari kedua keterbatasan tersebut. Dalam sebuah graph, setiap vertex dapat terhubung ke vertex mana pun, dalam jumlah berapa pun, dan dalam arah apa pun.

Kemampuan representasi yang bebas ini menjadikan graph sebagai model universal untuk hampir semua sistem yang melibatkan relasi antar objek dalam dunia nyata. Jaringan jalan raya yang menghubungkan kota-kota adalah graph. Peta penerbangan internasional adalah graph. Jaringan sosial dengan ratusan juta pengguna adalah graph. Internet dengan miliaran perangkat yang saling terhubung adalah graph. Sirkuit elektronik, struktur molekul kimia, peta ketergantungan paket perangkat lunak, bahkan aliran kendali dalam sebuah program komputer — semuanya dapat direpresentasikan dan dianalisis menggunakan model graph.

Bab ini tidak hanya membahas definisi dan implementasi graph, tetapi juga menelusuri akar historisnya dalam matematika abad ke-18, mengeksplorasi dua algoritma traversal fundamental yang membentuk landasan sebagian besar algoritma graph modern, dan memberikan pengantar algoritma pencarian jalur terpendek yang menjadi tulang punggung sistem navigasi global. Sebagai bab terakhir buku ini, pembahasan akan ditutup dengan melihat ke depan — bagaimana konsep-konsep graph yang dipelajari di sini membuka pintu menuju topik-topik lanjutan yang menjadi area penelitian aktif di era komputasi modern.

---

## 14.3 Sejarah: Dari Jembatan Königsberg ke Era Jaringan Raksasa

### 14.3.1 Permasalahan Tujuh Jembatan Königsberg

Teori graph lahir bukan dari kebutuhan komputasi, melainkan dari sebuah teka-teki geometri yang menghiasi kehidupan sehari-hari penduduk kota Königsberg (kini Kaliningrad, Rusia) pada abad ke-18. Kota tersebut dibangun di atas dua pulau besar di Sungai Pregel, yang dihubungkan ke daratan dan satu sama lain oleh tujuh jembatan. Pertanyaan yang beredar di masyarakat adalah: dapatkah seseorang berjalan melintasi kota tersebut dengan menyeberangi setiap jembatan tepat satu kali, dan kembali ke titik awal?

Pertanyaan ini tampak seperti sebuah permainan, namun mengandung kerumitan yang tidak mudah dipecahkan secara intuitif. Pada tahun 1736, matematikawan Swiss Leonhard Euler mempublikasikan makalah berjudul *Solutio problematis ad geometriam situs pertinentis* (Solusi untuk sebuah masalah yang berkaitan dengan geometri posisi), yang secara resmi dianggap sebagai titik lahirnya teori graph. Euler membuktikan bahwa perjalanan semacam itu — yang kemudian dikenal sebagai *Euler path* atau *Euler circuit* — tidak mungkin dilakukan.

Kebrilianan Euler terletak pada abstraksinya. Ia mengabaikan semua detail fisik kota — posisi bangunan, lebar jalan, panjang jembatan — dan hanya mempertahankan informasi esensial: daratan mana saja yang ada, dan jembatan mana yang menghubungkan daratan-daratan tersebut. Dengan kata lain, Euler secara intuitif menciptakan konsep graph: daratan sebagai *vertex*, jembatan sebagai *edge*.

Euler kemudian membuktikan teorema yang elegan: sebuah graph memiliki *Euler circuit* (jalur yang mengunjungi setiap edge tepat satu kali dan kembali ke titik awal) jika dan hanya jika setiap vertex memiliki *degree* genap. Karena semua daratan di Königsberg memiliki degree ganjil (3 atau 5 — jumlah jembatan yang terhubung ke setiap daratan adalah ganjil), maka Euler circuit tidak mungkin ada, dan pertanyaan warga Königsberg pun terjawab secara matematis.

> **Kotak 14.1 — Tahukah Anda?**
>
> Kata "topologi" dalam judul makalah Euler (*geometria situs* — geometri posisi) merujuk pada fakta bahwa Euler menyadari permasalahan ini tidak bergantung pada bentuk geometri atau jarak, melainkan hanya pada *struktur konektivitas*. Inilah sifat abstrak yang membuat graph begitu kuat sebagai alat pemodelan: yang penting bukan posisi atau ukuran node, melainkan *bagaimana* mereka terhubung satu sama lain.

### 14.3.2 Dari Teori ke Ilmu Komputer

Selama dua abad setelah Euler, teori graph berkembang sebagai cabang matematika diskret yang kaya, menghasilkan teorema-teorema fundamental seperti Four Color Theorem (1976), teorema Menger tentang konektivitas graph, dan teori Ramsey tentang keteraturan dalam graph besar. Namun, revolusi komputer pada pertengahan abad ke-20 mengangkat teori graph dari domain matematika murni ke arena yang jauh lebih praktis.

Ketika para insinyur dan ilmuwan komputer mulai menghadapi masalah-masalah nyata — menemukan rute pengiriman paket data terpendek dalam jaringan komputer, mengoptimalkan aliran komoditas dalam jaringan distribusi, menentukan urutan kompilasi yang benar dalam sistem build yang kompleks — mereka menemukan bahwa graph adalah model yang paling alami untuk semua masalah tersebut. Edsger W. Dijkstra, salah satu bapak ilmu komputer, memperkenalkan algoritma jalur terpendeknya pada tahun 1956 — sebuah kontribusi yang hingga hari ini menjadi inti dari sistem navigasi GPS di seluruh dunia.

Memasuki era internet dan media sosial, graph bertransformasi dari objek matematika yang elegan menjadi infrastruktur komputasi yang menopang kehidupan digital miliaran manusia. Graph Knowledge Google menyimpan miliards fakta tentang entitas dan hubungannya. Algoritma PageRank yang membangun kejayaan Google Search adalah algoritma berbasis random walk pada graph web raksasa. Facebook Social Graph menghubungkan lebih dari tiga miliar pengguna. Dan di garis terdepan penelitian kecerdasan buatan saat ini, *Graph Neural Network* (GNN) sedang mendefinisikan ulang cara mesin memahami hubungan dan struktur.

---

## 14.4 Definisi Formal dan Terminologi Graph

### 14.4.1 Definisi Formal

Graph **G** didefinisikan secara formal sebagai pasangan terurut:

```
G = (V, E)
```

di mana:
- **V** adalah himpunan vertex (simpul atau titik) yang tidak kosong. Jumlah vertex dilambangkan dengan |V| atau n.
- **E** adalah himpunan edge (sisi atau busur), yaitu himpunan pasangan vertex. Untuk undirected graph, E adalah himpunan pasangan tidak terurut {u, v}. Untuk directed graph, E adalah himpunan pasangan terurut (u, v). Jumlah edge dilambangkan dengan |E| atau m.

Sebagai contoh, sebuah graph sederhana dengan lima vertex dan enam edge dapat dituliskan:

```
V = {A, B, C, D, E}
E = {(A,B), (A,C), (B,C), (B,D), (C,D), (C,E)}
```

### 14.4.2 Komponen dan Terminologi Dasar

**Vertex (Simpul/Node)**

Vertex adalah entitas dasar dalam graph. Bergantung pada konteks masalah, vertex dapat merepresentasikan kota, pengguna, halaman web, komputer dalam jaringan, stasiun kereta api, gen dalam jaringan regulasi biologis, atau entitas lainnya. Tidak ada batasan pada jenis informasi yang dapat direpresentasikan oleh vertex.

**Edge (Sisi/Busur)**

Edge adalah hubungan atau koneksi antara dua vertex. Pada *undirected graph*, edge (u, v) identik dengan edge (v, u) — hubungan bersifat simetris. Pada *directed graph*, edge (u, v) berbeda dengan (v, u) — edge memiliki arah dari u ke v. Sebuah edge dikatakan *incident* pada dua endpoint-nya.

**Degree (Derajat)**

Degree suatu vertex adalah jumlah edge yang melekat padanya. Pada directed graph, dibedakan antara:
- **In-degree**: jumlah edge yang masuk ke vertex.
- **Out-degree**: jumlah edge yang keluar dari vertex.

**Teorema Jabat Tangan** (*Handshaking Theorem*) menyatakan bahwa pada undirected graph:

```
Jumlah semua degree = 2 * |E|
```

Ini karena setiap edge menyumbang satu degree pada masing-masing dua endpoint-nya. Implikasinya: jumlah vertex berderajat ganjil dalam sebuah graph selalu genap.

**Adjacency (Ketetanggaan)**

Dua vertex u dan v disebut *adjacent* (bertetangga) apabila terdapat edge yang menghubungkan keduanya. Kumpulan semua vertex yang bertetangga dengan vertex v disebut *neighborhood* dari v, dilambangkan N(v).

**Path (Lintasan)**

Path adalah urutan vertex v1, v2, ..., vk di mana terdapat edge antara setiap vi dan vi+1 yang berurutan. Panjang path adalah jumlah edge yang dilalui. Path disebut *simple path* apabila tidak ada vertex yang dikunjungi lebih dari satu kali. Panjang path terpendek antara dua vertex disebut *jarak* (*distance*) antar dua vertex tersebut.

**Cycle (Siklus)**

Cycle adalah path tertutup yang diawali dan diakhiri pada vertex yang sama, dengan syarat setiap edge hanya dilalui satu kali. Untuk simple graph, panjang cycle minimal adalah 3. Graph yang tidak mengandung siklus disebut *acyclic*.

**Connected (Terhubung)**

Sebuah undirected graph disebut *connected* apabila terdapat path antara setiap pasang vertex. Apabila tidak connected, graph terdiri atas beberapa *connected components* yang masing-masing merupakan subgraph yang connected. Pada directed graph, dikenal:
- *Strongly connected*: setiap pasang vertex (u, v) memiliki path berarah dari u ke v dan dari v ke u.
- *Weakly connected*: terhubung jika semua arah edge diabaikan.

**Weight (Bobot)**

Pada *weighted graph*, setiap edge memiliki nilai numerik yang disebut bobot (*weight*) atau biaya (*cost*). Bobot dapat merepresentasikan jarak, waktu tempuh, biaya finansial, kapasitas, latensi jaringan, atau nilai lainnya sesuai konteks masalah.

### 14.4.3 Terminologi Tambahan

Beberapa istilah tambahan yang sering dijumpai dalam literatur:

- **Loop**: edge yang menghubungkan sebuah vertex dengan dirinya sendiri, yaitu edge (v, v).
- **Multi-edge (Parallel edge)**: dua atau lebih edge yang menghubungkan pasangan vertex yang sama.
- **Simple graph**: graph tanpa loop dan tanpa multi-edge. Sebagian besar graph dalam aplikasi komputasi adalah simple graph.
- **Complete graph** K_n: undirected graph di mana setiap pasang vertex terhubung oleh tepat satu edge. K_n memiliki n(n-1)/2 edge — ini adalah kasus dense graph yang paling ekstrem.
- **Subgraph**: graph H = (V', E') di mana V' merupakan subset V dan E' merupakan subset E yang relevan terhadap V'.
- **Spanning tree**: subgraph yang mencakup semua vertex (spanning) dan merupakan tree (connected dan tidak mengandung siklus). Setiap connected graph memiliki setidaknya satu spanning tree.
- **Bipartite graph**: graph di mana vertex-nya dapat dibagi menjadi dua kelompok disjoint sedemikian sehingga setiap edge hanya menghubungkan vertex dari kelompok yang berbeda.

---

## 14.5 Klasifikasi Graph

Graph diklasifikasikan berdasarkan sifat edge-nya. Pemahaman atas klasifikasi ini penting karena setiap jenis graph membutuhkan algoritma dan representasi yang berbeda.

### 14.5.1 Undirected Graph (Graph Tidak Berarah)

Pada undirected graph, edge tidak memiliki arah. Edge {u, v} identik dengan {v, u}. Hubungan yang direpresentasikan bersifat simetris. Contoh: jaringan pertemanan Facebook (jika A berteman dengan B, maka B berteman dengan A), jaringan jalan dua arah, dan koneksi fisik antar komputer dalam Local Area Network.

```
Gambar 14.1 — Contoh Undirected Graph (5 vertex, 6 edge)

      A --- B
      |   / |
      |  /  |
      | /   |
      C --- D
       \
        E

Vertex: {A, B, C, D, E}
Edge  : {(A,B), (A,C), (B,C), (B,D), (C,D), (C,E)}
Degree: A=2, B=3, C=4, D=2, E=1
Total degree = 2+3+4+2+1 = 12 = 2 x 6 (Teorema Jabat Tangan terpenuhi)
```

### 14.5.2 Directed Graph / Digraph (Graph Berarah)

Pada directed graph, setiap edge memiliki arah. Edge (u, v) berbeda dengan (v, u). Arah edge merepresentasikan hubungan asimetris. Contoh: Twitter/Instagram (A mengikuti B tidak berarti B mengikuti A), hubungan hyperlink antar halaman web, dan ketergantungan antar tugas dalam manajemen proyek.

```
Gambar 14.2 — Contoh Directed Graph (5 vertex, 6 edge)

      A ---> B
      ^     / |
      |    /  |
      |   v   v
      C <--- D
      |
      v
      E

Vertex: {A, B, C, D, E}
Edge  : {(A,B), (B,C), (B,D), (D,C), (C,A), (C,E)}
In-degree : A=1, B=1, C=2, D=1, E=1
Out-degree: A=1, B=2, C=2, D=1, E=0
```

### 14.5.3 Weighted Graph (Graph Berbobot)

Weighted graph adalah graph (berarah maupun tidak berarah) di mana setiap edge memiliki nilai bobot. Bobot digunakan dalam algoritma pencarian jalur terpendek (*Dijkstra*, *Bellman-Ford*), pohon rentang minimum (*Prim*, *Kruskal*), dan masalah aliran jaringan. Contoh: peta kota dengan jarak antar persimpangan, jaringan komputer dengan bandwidth atau latensi antar router.

```
Gambar 14.3 — Contoh Weighted Undirected Graph

           4
      A -------- B
      |         /|
    6 |      3 / | 2
      |       /  |
      C -------- D
           5
      |
    1 |
      |
      E

Edge dengan bobot:
(A,B)=4, (A,C)=6, (B,C)=3, (B,D)=2, (C,D)=5, (C,E)=1
```

### 14.5.4 Directed Acyclic Graph / DAG

DAG adalah directed graph yang tidak mengandung siklus. DAG memiliki posisi khusus dalam ilmu komputer karena kemampuannya memodelkan ketergantungan (*dependency*) yang bebas dari circular reference. Aplikasinya mencakup: urutan kompilasi file dalam sistem build (Makefile, CMake), jadwal tugas dalam manajemen proyek (Critical Path Method), struktur ekspresi matematika dalam compiler, dan topologi jaringan bayesian dalam kecerdasan buatan.

```
Gambar 14.4 — Contoh DAG

      A -----> B -----> D
      |        |        |
      |        v        v
      +------> C -----> E

Vertex: {A, B, C, D, E}
Edge  : {(A,B), (A,C), (B,C), (B,D), (C,E), (D,E)}
Urutan topologis yang valid: A, B, C, D, E  atau  A, B, D, C, E
```

### 14.5.5 Ringkasan Klasifikasi Graph

**Tabel 14.1 — Klasifikasi Jenis-Jenis Graph**

| Jenis Graph         | Arah Edge | Bobot Edge | Siklus   | Contoh Aplikasi                        |
|---------------------|-----------|------------|----------|----------------------------------------|
| Undirected          | Tidak     | Tidak      | Boleh    | Jaringan pertemanan, jaringan LAN      |
| Directed (Digraph)  | Ya        | Tidak      | Boleh    | Twitter following, web hyperlink       |
| Weighted Undirected | Tidak     | Ya         | Boleh    | Peta jalan, jaringan pipa              |
| Weighted Directed   | Ya        | Ya         | Boleh    | Navigasi GPS, jaringan komputer        |
| DAG                 | Ya        | Opsional   | Tidak    | Dependensi build, bayesian network     |
| Tree                | Tidak     | Opsional   | Tidak    | Hierarki organisasi, file system       |

> **Kotak 14.2 — Catatan Penting**
>
> Perhatikan bahwa **tree adalah kasus khusus dari graph**. Sebuah tree dengan n vertex adalah connected undirected graph yang memiliki tepat n-1 edge dan tidak mengandung siklus. Dengan demikian, semua struktur data tree yang telah dipelajari di bab-bab sebelumnya — binary tree, binary search tree, AVL tree, heap — semuanya adalah graph dengan sifat-sifat tambahan yang lebih ketat. Graph adalah generalisasi dari tree.

---

## 14.6 Representasi Graph dalam Memori Komputer

Sebuah graph secara matematis didefinisikan oleh himpunan vertex dan edge-nya. Namun dalam implementasi perangkat lunak, kita perlu memilih struktur data konkret untuk menyimpannya di memori. Dua representasi yang paling umum digunakan adalah **adjacency matrix** dan **adjacency list**. Pilihan representasi berdampak langsung pada efisiensi penggunaan memori dan kecepatan operasi-operasi kunci pada graph.

### 14.6.1 Adjacency Matrix (Matriks Ketetanggaan)

Adjacency matrix adalah matriks dua dimensi berukuran |V| x |V|. Elemen M[i][j] bernilai 1 (atau nilai bobot w(i,j) untuk weighted graph) apabila terdapat edge dari vertex i ke vertex j, dan bernilai 0 apabila tidak ada edge.

```
Gambar 14.5 — Graph dan Adjacency Matrix-nya

Graph (tidak berarah):         Adjacency Matrix:

    0 --- 1                      0   1   2   3   4
    |   / |                  0 [ 0,  1,  1,  0,  0 ]
    |  /  |                  1 [ 1,  0,  1,  1,  0 ]
    | /   |                  2 [ 1,  1,  0,  1,  0 ]
    2 --- 3 --- 4             3 [ 0,  1,  1,  0,  1 ]
                              4 [ 0,  0,  0,  1,  0 ]
```

Untuk undirected graph, adjacency matrix selalu simetris: M[i][j] = M[j][i]. Sifat ini karena edge (u,v) dan edge (v,u) merepresentasikan hubungan yang sama.

**Implementasi Python: Adjacency Matrix**

```python
class GraphMatrix:
    """Representasi graph menggunakan adjacency matrix."""

    def __init__(self, num_vertices, directed=False):
        """
        Inisialisasi graph dengan adjacency matrix.

        Parameters:
            num_vertices (int): Jumlah vertex dalam graph.
            directed (bool): True jika graph berarah, False jika tidak berarah.
        """
        self.num_vertices = num_vertices
        self.directed = directed
        # Inisialisasi matriks dengan nilai nol
        self.matrix = [[0] * num_vertices for _ in range(num_vertices)]

    def add_edge(self, u, v, weight=1):
        """Menambahkan edge antara vertex u dan v dengan bobot weight."""
        if 0 <= u < self.num_vertices and 0 <= v < self.num_vertices:
            self.matrix[u][v] = weight
            if not self.directed:
                self.matrix[v][u] = weight

    def remove_edge(self, u, v):
        """Menghapus edge antara vertex u dan v."""
        if 0 <= u < self.num_vertices and 0 <= v < self.num_vertices:
            self.matrix[u][v] = 0
            if not self.directed:
                self.matrix[v][u] = 0

    def has_edge(self, u, v):
        """Memeriksa apakah terdapat edge dari u ke v. Kompleksitas: O(1)."""
        return self.matrix[u][v] != 0

    def get_neighbors(self, v):
        """
        Mengembalikan daftar tetangga vertex v.
        Kompleksitas: O(V) — harus memeriksa seluruh baris.
        """
        neighbors = []
        for i in range(self.num_vertices):
            if self.matrix[v][i] != 0:
                neighbors.append(i)
        return neighbors

    def print_matrix(self):
        """Menampilkan adjacency matrix secara terformat."""
        print("Adjacency Matrix:")
        header = "   " + "  ".join(str(i) for i in range(self.num_vertices))
        print(header)
        for i, row in enumerate(self.matrix):
            print(f"{i}  {row}")


# Demonstrasi penggunaan
if __name__ == "__main__":
    g = GraphMatrix(5, directed=False)
    edges = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3), (3, 4)]
    for u, v in edges:
        g.add_edge(u, v)
    g.print_matrix()
    print(f"\nTetangga vertex 1 : {g.get_neighbors(1)}")
    print(f"Ada edge (2, 3)? : {g.has_edge(2, 3)}")
    print(f"Ada edge (0, 4)? : {g.has_edge(0, 4)}")
```

### 14.6.2 Adjacency List (Daftar Ketetanggaan)

Adjacency list merepresentasikan graph sebagai kumpulan daftar. Untuk setiap vertex v, disimpan daftar semua vertex yang bertetangga dengan v beserta bobot edge-nya (untuk weighted graph). Dalam Python, representasi ini paling alami menggunakan dictionary of lists.

```
Gambar 14.6 — Graph dan Adjacency List-nya

Graph (tidak berarah):

    0 --- 1
    |   / |
    |  /  |
    | /   |
    2 --- 3 --- 4

Adjacency List:
  Vertex 0: [1, 2]
  Vertex 1: [0, 2, 3]
  Vertex 2: [0, 1, 3]
  Vertex 3: [1, 2, 4]
  Vertex 4: [3]
```

**Implementasi Python: Adjacency List (Kelas Graph Lengkap)**

```python
from collections import defaultdict, deque


class Graph:
    """
    Representasi graph menggunakan adjacency list.
    Mendukung graph berarah/tidak berarah dan berbobot/tidak berbobot.
    """

    def __init__(self, directed=False):
        """
        Inisialisasi graph kosong.

        Parameters:
            directed (bool): True jika graph berarah, False jika tidak berarah.
        """
        self.directed = directed
        # adjacency_list[v] = list of (neighbor, weight)
        self.adjacency_list = defaultdict(list)
        self.vertices = set()

    def add_vertex(self, v):
        """Menambahkan vertex baru ke dalam graph. Kompleksitas: O(1)."""
        self.vertices.add(v)
        if v not in self.adjacency_list:
            self.adjacency_list[v] = []

    def add_edge(self, u, v, weight=1):
        """
        Menambahkan edge dari u ke v dengan bobot weight.
        Untuk undirected graph, juga menambahkan edge dari v ke u.
        Kompleksitas: O(1).
        """
        self.vertices.add(u)
        self.vertices.add(v)
        self.adjacency_list[u].append((v, weight))
        if not self.directed:
            self.adjacency_list[v].append((u, weight))

    def get_neighbors(self, v):
        """
        Mengembalikan daftar (neighbor, weight) dari vertex v.
        Kompleksitas: O(degree(v)).
        """
        return self.adjacency_list[v]

    def get_neighbor_vertices(self, v):
        """Mengembalikan daftar vertex tetangga dari v (tanpa bobot)."""
        return [neighbor for neighbor, _ in self.adjacency_list[v]]

    def has_edge(self, u, v):
        """
        Memeriksa apakah terdapat edge dari u ke v.
        Kompleksitas: O(degree(u)).
        """
        return any(neighbor == v for neighbor, _ in self.adjacency_list[u])

    def __str__(self):
        """Representasi string dari graph."""
        result = []
        for vertex in sorted(self.vertices):
            neighbors = self.adjacency_list[vertex]
            neighbor_str = ", ".join(f"{n}(w={w})" for n, w in neighbors)
            result.append(f"  {vertex}: [{neighbor_str}]")
        return "Graph (Adjacency List):\n" + "\n".join(result)


# Demonstrasi penggunaan
if __name__ == "__main__":
    g = Graph(directed=False)
    edges = [
        ('A', 'B'), ('A', 'C'), ('B', 'C'), ('B', 'D'),
        ('C', 'D'), ('C', 'E'), ('D', 'F'), ('E', 'F'), ('F', 'G')
    ]
    for u, v in edges:
        g.add_edge(u, v)
    print(g)
    print(f"\nTetangga A    : {g.get_neighbor_vertices('A')}")
    print(f"Ada edge C-E? : {g.has_edge('C', 'E')}")
```

### 14.6.3 Perbandingan Komprehensif: Adjacency Matrix vs. Adjacency List

Pemilihan representasi yang tepat sangat bergantung pada karakteristik graph dan operasi yang paling sering dilakukan. Berikut perbandingan menyeluruh kedua representasi:

**Tabel 14.2 — Perbandingan Adjacency Matrix dan Adjacency List**

| Aspek                        | Adjacency Matrix          | Adjacency List                       |
|------------------------------|---------------------------|--------------------------------------|
| Kompleksitas Ruang           | O(V^2)                    | O(V + E)                             |
| Pengecekan edge (u, v)       | O(1)                      | O(degree(u))                         |
| Iterasi tetangga vertex v    | O(V)                      | O(degree(v))                         |
| Penambahan edge              | O(1)                      | O(1)                                 |
| Penghapusan edge             | O(1)                      | O(degree(u))                         |
| Penambahan vertex baru       | O(V^2) — harus resize     | O(1)                                 |
| Cocok untuk                  | Dense graph (E mendekati V^2) | Sparse graph (E jauh lebih kecil dari V^2) |
| Kemudahan implementasi       | Lebih sederhana           | Sedikit lebih kompleks               |
| Penggunaan memori aktual     | Selalu V x V              | Proporsional dengan jumlah edge      |

**Dense graph** adalah graph dengan jumlah edge mendekati maksimum, yaitu mendekati O(V^2). **Sparse graph** adalah graph dengan jumlah edge jauh lebih sedikit dari V^2, biasanya O(V) atau O(V log V).

> **Kotak 14.3 — Catatan Penting: Analisis Kebutuhan Memori Konkret**
>
> Pertimbangkan sebuah peta jaringan jalan kota besar dengan V = 10.000 persimpangan. Rata-rata setiap persimpangan terhubung ke 4 jalan, sehingga E = 20.000 edge (untuk undirected graph).
>
> - **Adjacency matrix**: 10.000 x 10.000 = **100 juta sel**. Dengan asumsi 4 byte per integer, ini membutuhkan sekitar **400 MB memori** hanya untuk matriks kosong.
> - **Adjacency list**: 10.000 vertex + 2 x 20.000 entri edge = sekitar **50.000 entri**. Dengan overhead pointer dan data, membutuhkan kurang dari **2 MB memori**.
>
> Penghematan memori mencapai lebih dari **200 kali lipat**. Sebagian besar graph nyata — peta jalan, jaringan sosial, internet — adalah sparse graph, sehingga adjacency list adalah pilihan default yang hampir selalu lebih unggul.

---

## 14.7 Breadth-First Search (BFS): Menjelajah Graph Level demi Level

Setelah memiliki representasi graph yang efisien, pertanyaan berikutnya adalah: bagaimana cara menjelajahi seluruh graph secara sistematis? Dua algoritma traversal yang menjadi fondasi hampir semua algoritma graph lainnya adalah Breadth-First Search (BFS) dan Depth-First Search (DFS).

### 14.7.1 Intuisi dan Algoritma BFS

BFS menjelajahi graph *level demi level*. Dimulai dari vertex sumber s, BFS pertama-tama mengunjungi semua tetangga langsung s (level 1), kemudian semua tetangga dari tetangga-tetangga tersebut yang belum pernah dikunjungi (level 2), dan seterusnya hingga seluruh vertex yang terjangkau dari s telah dikunjungi.

Analogi yang baik untuk BFS adalah gelombang air yang menyebar dari titik jatuhnya batu. Gelombang menyebar ke segala arah secara seragam, membasahi area terdekat lebih dulu sebelum mencapai area yang lebih jauh.

Struktur data kunci yang digunakan BFS adalah **queue (antrian FIFO)**: vertex yang ditemukan paling awal akan diproses paling awal pula. Ini yang memastikan BFS menjelajahi graph secara melebar sebelum menyelam lebih dalam.

```
Pseudocode BFS:

BFS(G, s):
  1. Inisialisasi: tandai semua vertex sebagai belum dikunjungi
  2. Tandai vertex s sebagai dikunjungi, masukkan s ke dalam queue
  3. Selama queue tidak kosong:
     a. u = dequeue vertex dari depan queue
     b. Proses vertex u
     c. Untuk setiap tetangga v dari u:
        - Jika v belum dikunjungi:
          * Tandai v sebagai dikunjungi
          * Enqueue v ke dalam queue
```

**Sifat-sifat penting BFS:**
- Kompleksitas waktu: O(V + E) — setiap vertex dan setiap edge diproses tepat satu kali.
- Kompleksitas ruang: O(V) — untuk queue dan array visited.
- **Menjamin menemukan jalur dengan jumlah edge minimum** (shortest path pada unweighted graph) dari sumber ke semua vertex yang terjangkau.
- Menghasilkan *BFS tree* yang secara implisit merekam jalur terpendek dari sumber ke setiap vertex.

### 14.7.2 Trace BFS yang Sangat Detail

Untuk memahami mekanisme BFS secara mendalam, mari kita lakukan trace pada graph berikut:

```
Gambar 14.7 — Graph Contoh untuk Trace BFS dan DFS

    0 --- 1 --- 3
    |     |     |
    |     |     |
    2 --- 4     5
          |
          6

Adjacency List (urutan vertex tetangga dari kecil ke besar):
  0: [1, 2]
  1: [0, 3, 4]
  2: [0, 4]
  3: [1, 5]
  4: [1, 2, 6]
  5: [3]
  6: [4]
```

**Trace BFS dari vertex 0:**

```
Tabel 14.3 — Trace BFS dari Vertex 0

Langkah | Aksi                         | Queue       | Visited
--------|------------------------------|-------------|-----------------------------
Awal    | Inisialisasi: tandai 0       | [0]         | {0}
        | visited, enqueue 0           |             |
--------|------------------------------|-------------|-----------------------------
1       | Dequeue 0, proses 0          | []          | {0}
        | Tetangga 0: 1, 2             |             |
        | 1 belum visited -> enqueue 1 | [1]         | {0, 1}
        | 2 belum visited -> enqueue 2 | [1, 2]      | {0, 1, 2}
--------|------------------------------|-------------|-----------------------------
2       | Dequeue 1, proses 1          | [2]         | {0, 1, 2}
        | Tetangga 1: 0, 3, 4          |             |
        | 0 sudah visited, lewati      |             |
        | 3 belum visited -> enqueue 3 | [2, 3]      | {0, 1, 2, 3}
        | 4 belum visited -> enqueue 4 | [2, 3, 4]   | {0, 1, 2, 3, 4}
--------|------------------------------|-------------|-----------------------------
3       | Dequeue 2, proses 2          | [3, 4]      | {0, 1, 2, 3, 4}
        | Tetangga 2: 0, 4             |             |
        | 0 sudah visited, lewati      |             |
        | 4 sudah visited, lewati      |             |
--------|------------------------------|-------------|-----------------------------
4       | Dequeue 3, proses 3          | [4]         | {0, 1, 2, 3, 4}
        | Tetangga 3: 1, 5             |             |
        | 1 sudah visited, lewati      |             |
        | 5 belum visited -> enqueue 5 | [4, 5]      | {0, 1, 2, 3, 4, 5}
--------|------------------------------|-------------|-----------------------------
5       | Dequeue 4, proses 4          | [5]         | {0, 1, 2, 3, 4, 5}
        | Tetangga 4: 1, 2, 6          |             |
        | 1 sudah visited, lewati      |             |
        | 2 sudah visited, lewati      |             |
        | 6 belum visited -> enqueue 6 | [5, 6]      | {0, 1, 2, 3, 4, 5, 6}
--------|------------------------------|-------------|-----------------------------
6       | Dequeue 5, proses 5          | [6]         | {0, 1, 2, 3, 4, 5, 6}
        | Tetangga 5: 3                |             |
        | 3 sudah visited, lewati      |             |
--------|------------------------------|-------------|-----------------------------
7       | Dequeue 6, proses 6          | []          | {0, 1, 2, 3, 4, 5, 6}
        | Tetangga 6: 4                |             |
        | 4 sudah visited, lewati      |             |
--------|------------------------------|-------------|-----------------------------
Selesai | Queue kosong, BFS selesai    |             |
```

Hasil traversal BFS: **0, 1, 2, 3, 4, 5, 6**

Jarak terpendek (jumlah edge) dari vertex 0 ke setiap vertex:
```
  0 -> 0 : 0 edge
  0 -> 1 : 1 edge  (jalur: 0 -> 1)
  0 -> 2 : 1 edge  (jalur: 0 -> 2)
  0 -> 3 : 2 edge  (jalur: 0 -> 1 -> 3)
  0 -> 4 : 2 edge  (jalur: 0 -> 1 -> 4)
  0 -> 5 : 3 edge  (jalur: 0 -> 1 -> 3 -> 5)
  0 -> 6 : 3 edge  (jalur: 0 -> 1 -> 4 -> 6)
```

BFS secara natural mengungkap level-level graph: vertex 0 di level 0, vertex 1 dan 2 di level 1, vertex 3 dan 4 di level 2, vertex 5 dan 6 di level 3.

### 14.7.3 Implementasi Python BFS

```python
from collections import deque


def bfs(graph, start):
    """
    Breadth-First Search pada graph menggunakan adjacency list.

    Parameters:
        graph (Graph): objek graph yang akan ditelusuri.
        start: vertex awal BFS.

    Returns:
        list : urutan vertex yang dikunjungi.
        dict : jarak terpendek (jumlah edge) dari start ke setiap vertex.
        dict : parent/predecessor setiap vertex dalam BFS tree.
    """
    visited = set()
    queue = deque()
    distance = {}
    parent = {}
    order = []

    # Inisialisasi dengan vertex awal
    visited.add(start)
    queue.append(start)
    distance[start] = 0
    parent[start] = None

    while queue:
        # Dequeue vertex dari depan antrian
        u = queue.popleft()
        order.append(u)

        # Proses setiap tetangga u
        for v in graph.get_neighbor_vertices(u):
            if v not in visited:
                visited.add(v)
                queue.append(v)
                distance[v] = distance[u] + 1
                parent[v] = u

    return order, distance, parent


def reconstruct_path(parent, start, end):
    """
    Merekonstruksi jalur terpendek dari start ke end
    menggunakan informasi parent dari BFS.

    Parameters:
        parent (dict): dictionary parent dari hasil BFS.
        start  : vertex awal.
        end    : vertex tujuan.

    Returns:
        list: jalur terpendek dari start ke end, atau None jika tidak terjangkau.
    """
    if end not in parent:
        return None

    path = []
    current = end
    while current is not None:
        path.append(current)
        current = parent[current]
    path.reverse()

    return path if path[0] == start else None


# Demonstrasi BFS
if __name__ == "__main__":
    g = Graph(directed=False)
    edges = [(0, 1), (0, 2), (1, 3), (1, 4), (2, 4), (3, 5), (4, 6)]
    for u, v in edges:
        g.add_edge(u, v)

    print("=== BFS dari vertex 0 ===")
    order, distance, parent = bfs(g, 0)
    print(f"Urutan kunjungan     : {order}")
    print(f"Jarak dari vertex 0  : {distance}")
    print(f"Jalur terpendek 0->6 : {reconstruct_path(parent, 0, 6)}")
```

---

## 14.8 Depth-First Search (DFS): Menjelajah Graph dengan Menyelam Sedalam Mungkin

### 14.8.1 Intuisi dan Algoritma DFS

DFS menjelajahi graph dengan strategi yang berlawanan dengan BFS: alih-alih melebar terlebih dahulu, DFS *menyelam sedalam mungkin* ke salah satu jalur sebelum kembali (*backtrack*) dan menjelajahi jalur lain. Analogi yang tepat untuk DFS adalah seorang penjelajah labirin yang selalu mengambil belokan pertama yang tersedia dan hanya kembali ke persimpangan sebelumnya ketika menemui jalan buntu.

DFS dapat diimplementasikan dengan dua pendekatan:
1. **Rekursif**: memanfaatkan call stack sistem secara implisit.
2. **Iteratif**: menggunakan stack eksplisit, dengan karakteristik sedikit berbeda dalam urutan kunjungan.

Struktur data kunci yang digunakan DFS (versi iteratif) adalah **stack (tumpukan LIFO)**: vertex yang ditemukan paling terakhir akan diproses paling awal, mendorong eksplorasi yang semakin dalam.

```
Pseudocode DFS Rekursif:

DFS_Rekursif(G, v, visited):
  1. Tandai v sebagai dikunjungi
  2. Proses vertex v
  3. Untuk setiap tetangga u dari v:
     - Jika u belum dikunjungi:
       * Panggil DFS_Rekursif(G, u, visited)

Pseudocode DFS Iteratif:

DFS_Iteratif(G, s):
  1. Inisialisasi: tandai semua vertex sebagai belum dikunjungi
  2. Push s ke dalam stack
  3. Selama stack tidak kosong:
     a. v = pop vertex dari puncak stack
     b. Jika v belum dikunjungi:
        - Tandai v sebagai dikunjungi
        - Proses vertex v
        - Push semua tetangga v yang belum dikunjungi ke stack
```

**Sifat-sifat penting DFS:**
- Kompleksitas waktu: O(V + E).
- Kompleksitas ruang: O(V) untuk stack/rekursi dan array visited.
- **Tidak menjamin jalur terpendek**.
- Secara natural mendukung: deteksi siklus, pengurutan topologis pada DAG, identifikasi komponen terhubung, pencarian bridge dan articulation point.

### 14.8.2 Trace DFS yang Sangat Detail

Menggunakan graph yang sama dengan trace BFS (Gambar 14.7):

**Trace DFS Rekursif dari vertex 0:**

```
Tabel 14.4 — Trace DFS Rekursif dari Vertex 0

Langkah | Aksi                          | Call Stack DFS        | Visited
--------|-------------------------------|------------------------|-----------------------------
Awal    | Panggil DFS(0)                | [DFS(0)]               | {0}
        | Proses 0, cek tetangga: 1, 2  |                        |
--------|-------------------------------|------------------------|-----------------------------
1       | Tetangga 1 belum visited      |                        |
        | Panggil DFS(1)                | [DFS(0), DFS(1)]       | {0, 1}
        | Proses 1, cek tetangga:       |                        |
        | 0 (visited), 3, 4             |                        |
--------|-------------------------------|------------------------|-----------------------------
2       | Tetangga 3 belum visited      |                        |
        | Panggil DFS(3)                | [..., DFS(3)]          | {0, 1, 3}
        | Proses 3, cek tetangga:       |                        |
        | 1 (visited), 5                |                        |
--------|-------------------------------|------------------------|-----------------------------
3       | Tetangga 5 belum visited      |                        |
        | Panggil DFS(5)                | [..., DFS(3), DFS(5)]  | {0, 1, 3, 5}
        | Proses 5, cek tetangga: 3     |                        |
        | 3 sudah visited               |                        |
        | DFS(5) selesai, kembali ke    | [..., DFS(3)]          |
        | DFS(3) selesai (tidak ada     |                        |
        | tetangga lain), kembali ke    | [DFS(0), DFS(1)]       |
--------|-------------------------------|------------------------|-----------------------------
4       | Lanjut cek tetangga DFS(1): 4 |                        |
        | Tetangga 4 belum visited      |                        |
        | Panggil DFS(4)                | [..., DFS(4)]          | {0, 1, 3, 4, 5}
        | Proses 4, cek tetangga:       |                        |
        | 1 (visited), 2, 6             |                        |
--------|-------------------------------|------------------------|-----------------------------
5       | Tetangga 2 belum visited      |                        |
        | Panggil DFS(2)                | [..., DFS(4), DFS(2)]  | {0, 1, 2, 3, 4, 5}
        | Proses 2, cek tetangga:       |                        |
        | 0 (visited), 4 (visited)      |                        |
        | DFS(2) selesai, kembali ke    | [..., DFS(4)]          |
--------|-------------------------------|------------------------|-----------------------------
6       | Lanjut cek tetangga DFS(4): 6 |                        |
        | Tetangga 6 belum visited      |                        |
        | Panggil DFS(6)                | [..., DFS(4), DFS(6)]  | {0,1,2,3,4,5,6}
        | Proses 6, cek tetangga: 4     |                        |
        | 4 sudah visited               |                        |
        | DFS(6) selesai, kembali ke    | [DFS(0), DFS(1)]       |
        | DFS(4) selesai, kembali ke    | [DFS(0)]               |
        | DFS(1) selesai, kembali ke    | [DFS(0)]               |
--------|-------------------------------|------------------------|-----------------------------
7       | Lanjut cek tetangga DFS(0): 2 |                        |
        | 2 sudah visited, lewati       |                        |
        | DFS(0) selesai                | []                     |
--------|-------------------------------|------------------------|-----------------------------
Selesai | Call stack kosong, DFS selesai|                        |
```

Hasil traversal DFS Rekursif: **0, 1, 3, 5, 4, 2, 6**

**Perbandingan urutan kunjungan BFS vs DFS pada graph yang sama:**

```
Tabel 14.5 — Perbandingan Urutan Kunjungan BFS dan DFS

BFS (level-order): 0, 1, 2, 3, 4, 5, 6   (melebar, level demi level)
DFS (depth-first): 0, 1, 3, 5, 4, 2, 6   (menyelam, sedalam mungkin dulu)
```

BFS mengunjungi vertex 1 dan 2 secara berurutan (keduanya berada di level 1), kemudian baru bergerak ke level 2. DFS sebaliknya: setelah mengunjungi vertex 1, langsung menyelam ke vertex 3 (tetangga 1 yang pertama), lalu ke vertex 5 (tetangga 3 yang belum dikunjungi), baru kemudian kembali dan mengeksplorasi cabang lainnya.

### 14.8.3 Implementasi Python DFS dan Aplikasinya

```python
def dfs_recursive(graph, start):
    """
    Depth-First Search rekursif.

    Parameters:
        graph (Graph): objek graph.
        start: vertex awal DFS.

    Returns:
        list: urutan vertex yang dikunjungi.
    """
    visited = set()
    order = []

    def _dfs(v):
        visited.add(v)
        order.append(v)
        for neighbor in graph.get_neighbor_vertices(v):
            if neighbor not in visited:
                _dfs(neighbor)

    _dfs(start)
    return order


def dfs_iterative(graph, start):
    """
    Depth-First Search iteratif menggunakan stack eksplisit.

    Parameters:
        graph (Graph): objek graph.
        start: vertex awal DFS.

    Returns:
        list: urutan vertex yang dikunjungi.
    """
    visited = set()
    stack = [start]
    order = []

    while stack:
        v = stack.pop()
        if v not in visited:
            visited.add(v)
            order.append(v)
            # Push tetangga dalam urutan terbalik agar urutan kunjungan konsisten
            for neighbor in reversed(graph.get_neighbor_vertices(v)):
                if neighbor not in visited:
                    stack.append(neighbor)

    return order


def dfs_detect_cycle(graph):
    """
    Mendeteksi siklus dalam undirected graph menggunakan DFS.

    Returns:
        bool: True jika terdapat siklus, False jika tidak.
    """
    visited = set()

    def has_cycle(v, parent):
        visited.add(v)
        for neighbor in graph.get_neighbor_vertices(v):
            if neighbor not in visited:
                if has_cycle(neighbor, v):
                    return True
            elif neighbor != parent:
                # Menemukan back edge — graph mengandung siklus
                return True
        return False

    for vertex in graph.vertices:
        if vertex not in visited:
            if has_cycle(vertex, None):
                return True
    return False


def topological_sort_dfs(graph):
    """
    Pengurutan topologis menggunakan DFS (hanya valid untuk DAG).
    Urutan topologis: urutan vertex sehingga untuk setiap edge (u, v),
    vertex u selalu muncul sebelum vertex v.

    Returns:
        list: urutan topologis vertex, atau None jika graph mengandung siklus.
    """
    visited = set()
    result_stack = []
    in_recursion = set()  # Untuk deteksi siklus

    def dfs_topo(v):
        visited.add(v)
        in_recursion.add(v)
        for neighbor in graph.get_neighbor_vertices(v):
            if neighbor in in_recursion:
                return False  # Siklus ditemukan
            if neighbor not in visited:
                if not dfs_topo(neighbor):
                    return False
        in_recursion.remove(v)
        result_stack.append(v)  # Tambahkan ke stack setelah semua tetangga diproses
        return True

    for vertex in graph.vertices:
        if vertex not in visited:
            if not dfs_topo(vertex):
                return None  # Graph mengandung siklus

    result_stack.reverse()
    return result_stack


# Demonstrasi DFS
if __name__ == "__main__":
    g = Graph(directed=False)
    edges = [(0, 1), (0, 2), (1, 3), (1, 4), (2, 4), (3, 5), (4, 6)]
    for u, v in edges:
        g.add_edge(u, v)

    print("=== DFS dari vertex 0 ===")
    print(f"DFS Rekursif  : {dfs_recursive(g, 0)}")
    print(f"DFS Iteratif  : {dfs_iterative(g, 0)}")
    print(f"Ada siklus?   : {dfs_detect_cycle(g)}")

    # Topological sort pada DAG
    dag = Graph(directed=True)
    dag_edges = [('A', 'B'), ('A', 'C'), ('B', 'D'), ('C', 'D'), ('D', 'E')]
    for u, v in dag_edges:
        dag.add_edge(u, v)
    topo = topological_sort_dfs(dag)
    print(f"\nUrutan topologis DAG: {topo}")
```

### 14.8.4 Perbandingan Menyeluruh BFS dan DFS

**Tabel 14.6 — Perbandingan BFS dan DFS**

| Aspek                     | BFS                                | DFS                                  |
|---------------------------|------------------------------------|--------------------------------------|
| Struktur data bantu       | Queue (FIFO)                       | Stack (LIFO) atau rekursi            |
| Strategi penelusuran      | Level demi level (melebar)         | Sedalam mungkin (menyelam)           |
| Jalur terpendek           | Ya (unweighted graph)              | Tidak dijamin                        |
| Penggunaan memori         | O(V) — bisa besar untuk graph lebar| O(V) — bisa besar untuk graph dalam  |
| Deteksi siklus            | Dapat dilakukan                    | Lebih natural dan efisien            |
| Topological sort          | Tidak langsung (Kahn's algorithm)  | Ya, secara natural                   |
| Komponen terhubung        | Ya                                 | Ya                                   |
| Cocok untuk               | Jalur terpendek, level-order       | Eksplorasi mendalam, backtracking    |
| Kompleksitas waktu        | O(V + E)                           | O(V + E)                             |
| Kompleksitas ruang        | O(V)                               | O(V)                                 |

---

## 14.9 Pengantar Algoritma Dijkstra: Jalur Terpendek pada Graph Berbobot

### 14.9.1 Motivasi: Keterbatasan BFS pada Graph Berbobot

BFS berhasil menemukan jalur dengan **jumlah edge minimum** dari vertex sumber ke semua vertex lainnya. Namun, dalam banyak aplikasi nyata, tidak semua edge memiliki "biaya" yang sama. Jarak antar kota berbeda-beda. Latensi antar router tidak seragam. Biaya penerbangan antara dua bandara bergantung pada rute yang dipilih.

Perhatikan contoh berikut: misalkan terdapat dua jalur dari A ke C. Jalur pertama A -> C langsung dengan bobot 10. Jalur kedua A -> B -> C dengan bobot 2 + 3 = 5. BFS akan memilih jalur pertama karena hanya memiliki 1 edge, padahal jalur kedua jauh lebih "murah" dengan total bobot 5 versus 10. BFS tidak dapat membedakan ini karena ia menganggap semua edge berbobot sama.

Di sinilah **algoritma Dijkstra** berperan. Dijkstra dirancang khusus untuk menemukan jalur dengan **total bobot minimum** pada weighted graph dengan bobot non-negatif.

> **Kotak 14.4 — Tahukah Anda?**
>
> Edsger W. Dijkstra merancang algoritma ini pada tahun 1956 dalam waktu kurang dari 20 menit, saat sedang beristirahat di sebuah kafe bersama tunangannya di Amsterdam. Ia tidak menggunakan kertas dan pensa karena tertinggal. Dikatakannya kemudian: "One of the reasons that it is so nice was that I designed it without pencil and paper. I learned later that one of the advantages of designing without pencil and paper is that you are almost forced to avoid all avoidable complexities." Makalahnya baru dipublikasikan tiga tahun kemudian, pada 1959.

### 14.9.2 Prinsip Kerja: Greedy dengan Relaksasi Edge

Dijkstra bekerja berdasarkan prinsip *greedy*: pada setiap langkah, algoritma memilih vertex yang belum diproses dengan estimasi jarak terpendek terkecil, kemudian "merelaksasi" semua edge yang berasal dari vertex tersebut.

**Relaksasi edge** adalah operasi kunci Dijkstra. Merelaksasi edge (u, v) dengan bobot w berarti: jika jalur dari sumber ke u ditambah edge (u, v) memberikan jarak yang lebih kecil dari estimasi jarak sumber ke v yang ada saat ini, maka perbarui estimasi jarak v tersebut.

```
Pseudocode Dijkstra:

Dijkstra(G, s):
  1. Inisialisasi:
     - dist[s] = 0  (jarak dari sumber ke dirinya sendiri)
     - dist[v] = TAK_TERHINGGA  untuk semua v != s
     - parent[v] = None  untuk semua v
     - Q = priority queue berisi semua vertex, diprioritaskan oleh dist
  2. Selama Q tidak kosong:
     a. u = extract vertex dari Q dengan dist[u] terkecil (extract-min)
     b. Untuk setiap tetangga v dari u (di mana v masih dalam Q):
        - alt = dist[u] + weight(u, v)
        - Jika alt < dist[v]:
          * dist[v] = alt          (relaksasi: temukan jalur lebih pendek)
          * parent[v] = u
          * Perbarui posisi v dalam priority queue
  3. Kembalikan dist dan parent
```

**Kompleksitas:**
- Implementasi naive dengan array biasa: O(V^2)
- Implementasi dengan min-heap (priority queue): O((V + E) log V)

### 14.9.3 Trace Manual Dijkstra Step by Step

**Graph berbobot berarah untuk trace:**

```
Gambar 14.8 — Graph Berbobot untuk Trace Dijkstra

          2
     A -------> B
     |          |\ 
   6 |        1 | \ 3
     |          |  \
     v          v   v
     C <------- D -------> E
           4           1

Edge (berarah) dengan bobot:
  (A, B) = 2
  (A, C) = 6
  (B, C) = 1
  (B, D) = 3
  (D, C) = 4
  (D, E) = 1

Vertex sumber: A
```

```
Tabel 14.7 — Trace Dijkstra dari Vertex A

Inisialisasi:
  dist   = {A:0,  B:inf, C:inf, D:inf, E:inf}
  parent = {A:None, B:None, C:None, D:None, E:None}
  Q      = {A, B, C, D, E}

------------------------------------------------------------------
Iterasi 1: Extract-min dari Q -> u = A  (dist[A] = 0)
  Tetangga A: B (bobot=2), C (bobot=6)

  Relaksasi edge (A, B):
    alt = dist[A] + 2 = 0 + 2 = 2
    2 < inf (dist[B]) -> PERBARUI: dist[B] = 2, parent[B] = A

  Relaksasi edge (A, C):
    alt = dist[A] + 6 = 0 + 6 = 6
    6 < inf (dist[C]) -> PERBARUI: dist[C] = 6, parent[C] = A

  Q = {B, C, D, E}
  dist = {A:0, B:2, C:6, D:inf, E:inf}

------------------------------------------------------------------
Iterasi 2: Extract-min dari Q -> u = B  (dist[B] = 2)
  Tetangga B: C (bobot=1), D (bobot=3)

  Relaksasi edge (B, C):
    alt = dist[B] + 1 = 2 + 1 = 3
    3 < 6 (dist[C]) -> PERBARUI: dist[C] = 3, parent[C] = B  *** UPDATE ***

  Relaksasi edge (B, D):
    alt = dist[B] + 3 = 2 + 3 = 5
    5 < inf (dist[D]) -> PERBARUI: dist[D] = 5, parent[D] = B

  Q = {C, D, E}
  dist = {A:0, B:2, C:3, D:5, E:inf}

------------------------------------------------------------------
Iterasi 3: Extract-min dari Q -> u = C  (dist[C] = 3)
  Tetangga C: (tidak ada edge keluar dari C)
  Tidak ada relaksasi.

  Q = {D, E}
  dist = {A:0, B:2, C:3, D:5, E:inf}

------------------------------------------------------------------
Iterasi 4: Extract-min dari Q -> u = D  (dist[D] = 5)
  Tetangga D: C (bobot=4), E (bobot=1)

  Relaksasi edge (D, C):
    alt = dist[D] + 4 = 5 + 4 = 9
    9 > 3 (dist[C]) -> TIDAK diperbarui (C sudah punya jalur yang lebih pendek)

  Relaksasi edge (D, E):
    alt = dist[D] + 1 = 5 + 1 = 6
    6 < inf (dist[E]) -> PERBARUI: dist[E] = 6, parent[E] = D

  Q = {E}
  dist = {A:0, B:2, C:3, D:5, E:6}

------------------------------------------------------------------
Iterasi 5: Extract-min dari Q -> u = E  (dist[E] = 6)
  Tetangga E: (tidak ada edge keluar dari E)
  Tidak ada relaksasi.

  Q = {}
  Algoritma selesai.

------------------------------------------------------------------
HASIL AKHIR:
  Jarak terpendek dari A ke setiap vertex:
    A -> A : 0         (tidak perlu bergerak)
    A -> B : 2         (jalur: A -> B)
    A -> C : 3         (jalur: A -> B -> C)
    A -> D : 5         (jalur: A -> B -> D)
    A -> E : 6         (jalur: A -> B -> D -> E)
```

Perhatikan keindahan iterasi 2: awalnya Dijkstra menemukan jalur A -> C dengan bobot 6. Namun pada iterasi 2, ditemukan jalur yang lebih pendek: A -> B -> C dengan total bobot 3. Inilah mekanisme relaksasi edge — Dijkstra secara progresif memperbarui estimasi jarak ketika menemukan jalur yang lebih optimal.

### 14.9.4 Implementasi Python Dijkstra

```python
import heapq


def dijkstra(graph, start):
    """
    Algoritma Dijkstra untuk shortest path pada weighted graph.
    Bobot edge harus non-negatif.

    Parameters:
        graph (Graph): objek graph dengan bobot pada setiap edge.
        start: vertex sumber.

    Returns:
        dict: jarak terpendek dari start ke semua vertex.
        dict: parent/predecessor setiap vertex pada jalur terpendek.
    """
    # Inisialisasi jarak semua vertex ke tak terhingga
    dist = {v: float('inf') for v in graph.vertices}
    dist[start] = 0
    parent = {v: None for v in graph.vertices}

    # Priority queue berisi (jarak, vertex)
    # heapq di Python adalah min-heap
    priority_queue = [(0, start)]
    visited = set()

    while priority_queue:
        # Extract vertex dengan jarak terkecil
        current_dist, u = heapq.heappop(priority_queue)

        # Lewati jika sudah diproses (dapat ada duplikat dalam heap)
        if u in visited:
            continue
        visited.add(u)

        # Relaksasi semua edge dari vertex u
        for v, weight in graph.get_neighbors(u):
            if v not in visited:
                alt = dist[u] + weight
                if alt < dist[v]:
                    dist[v] = alt
                    parent[v] = u
                    heapq.heappush(priority_queue, (alt, v))

    return dist, parent


# Demonstrasi Dijkstra
if __name__ == "__main__":
    g = Graph(directed=True)
    weighted_edges = [
        ('A', 'B', 2), ('A', 'C', 6),
        ('B', 'C', 1), ('B', 'D', 3),
        ('D', 'C', 4), ('D', 'E', 1)
    ]
    for u, v, w in weighted_edges:
        g.add_edge(u, v, w)

    dist, parent = dijkstra(g, 'A')
    print("=== Dijkstra dari vertex A ===")
    for vertex in sorted(dist.keys()):
        path = reconstruct_path(parent, 'A', vertex)
        print(f"  A -> {vertex}: jarak = {dist[vertex]}, jalur = {path}")
```

> **Kotak 14.5 — Catatan Penting: Keterbatasan Dijkstra**
>
> Dijkstra hanya bekerja dengan benar pada graph dengan **bobot non-negatif**. Jika terdapat edge berbobot negatif, Dijkstra dapat menghasilkan jawaban yang salah. Untuk graph dengan bobot negatif, digunakan algoritma **Bellman-Ford** yang memiliki kompleksitas O(V*E) — lebih lambat dari Dijkstra tetapi mampu menangani bobot negatif dan mendeteksi negative cycle. Untuk semua pasang titik sumber-tujuan sekaligus, digunakan algoritma **Floyd-Warshall** dengan kompleksitas O(V^3).

---

## 14.10 Studi Kasus: Sistem Navigasi GPS Berbasis Graph

### 14.10.1 Pemodelan Peta Kota sebagai Graph

Sistem navigasi GPS pada intinya adalah sebuah mesin yang beroperasi pada graph berskala sangat besar. Setiap persimpangan jalan — baik itu perempatan, tikungan, atau mulut jalan — direpresentasikan sebagai vertex. Setiap ruas jalan yang menghubungkan dua persimpangan direpresentasikan sebagai edge dengan bobot yang dapat merepresentasikan jarak dalam kilometer, estimasi waktu tempuh, atau biaya tol.

```
Gambar 14.9 — Peta Kota Sederhana sebagai Graph Berbobot

   Pasar ---5km--- Stasiun ---3km--- Mall
     |                |                |
    2km              4km              6km
     |                |                |
  Sekolah ---7km--- Hotel ---2km--- Bandara

Pertanyaan-pertanyaan yang dapat dijawab:
  1. BFS   : Berapa persimpangan minimum dari Pasar ke Bandara?
  2. Dijkstra: Rute terpendek (total km) dari Pasar ke Bandara?
  3. DFS   : Apakah ada jalan melingkar di kota ini?
```

### 14.10.2 Implementasi Lengkap: Studi Kasus Peta Kota

```python
from collections import defaultdict, deque
import heapq


class Graph:
    """Graph lengkap dengan adjacency list, mendukung BFS, DFS, dan Dijkstra."""

    def __init__(self, directed=False):
        self.directed = directed
        self.adjacency_list = defaultdict(list)
        self.vertices = set()

    def add_vertex(self, v):
        self.vertices.add(v)
        if v not in self.adjacency_list:
            self.adjacency_list[v] = []

    def add_edge(self, u, v, weight=1):
        self.vertices.add(u)
        self.vertices.add(v)
        self.adjacency_list[u].append((v, weight))
        if not self.directed:
            self.adjacency_list[v].append((u, weight))

    def get_neighbors(self, v):
        return self.adjacency_list[v]

    def get_neighbor_vertices(self, v):
        return [n for n, _ in self.adjacency_list[v]]

    def has_edge(self, u, v):
        return any(n == v for n, _ in self.adjacency_list[u])

    def bfs(self, start):
        visited, queue = set(), deque()
        order, dist, parent = [], {start: 0}, {start: None}
        visited.add(start)
        queue.append(start)
        while queue:
            u = queue.popleft()
            order.append(u)
            for v in self.get_neighbor_vertices(u):
                if v not in visited:
                    visited.add(v)
                    queue.append(v)
                    dist[v] = dist[u] + 1
                    parent[v] = u
        return order, dist, parent

    def dfs_recursive(self, start):
        visited, order = set(), []

        def _dfs(v):
            visited.add(v)
            order.append(v)
            for n in self.get_neighbor_vertices(v):
                if n not in visited:
                    _dfs(n)

        _dfs(start)
        return order

    def dfs_iterative(self, start):
        visited, stack, order = set(), [start], []
        while stack:
            v = stack.pop()
            if v not in visited:
                visited.add(v)
                order.append(v)
                for n in reversed(self.get_neighbor_vertices(v)):
                    if n not in visited:
                        stack.append(n)
        return order

    def dijkstra(self, start):
        dist = {v: float('inf') for v in self.vertices}
        dist[start] = 0
        parent = {v: None for v in self.vertices}
        pq = [(0, start)]
        visited = set()
        while pq:
            d, u = heapq.heappop(pq)
            if u in visited:
                continue
            visited.add(u)
            for v, w in self.get_neighbors(u):
                if v not in visited and dist[u] + w < dist[v]:
                    dist[v] = dist[u] + w
                    parent[v] = u
                    heapq.heappush(pq, (dist[v], v))
        return dist, parent

    def reconstruct_path(self, parent, start, end):
        if end not in parent:
            return None
        path, current = [], end
        while current is not None:
            path.append(current)
            current = parent.get(current)
        path.reverse()
        return path if path and path[0] == start else None


# ============================================================
# STUDI KASUS: PETA KOTA
# ============================================================
if __name__ == "__main__":
    # Membangun peta kota sebagai weighted undirected graph
    kota = Graph(directed=False)
    jalan = [
        ("Pasar",   "Stasiun", 5),
        ("Pasar",   "Sekolah", 2),
        ("Stasiun", "Mall",    3),
        ("Stasiun", "Hotel",   4),
        ("Mall",    "Bandara", 6),
        ("Sekolah", "Hotel",   7),
        ("Hotel",   "Bandara", 2),
    ]
    for u, v, w in jalan:
        kota.add_edge(u, v, w)

    print("=" * 60)
    print("        STUDI KASUS: NAVIGASI PETA KOTA")
    print("=" * 60)

    # BFS: Jumlah persimpangan minimum (jalur dengan edge terkecil)
    print("\n--- BFS dari Pasar: Jalur dengan Persimpangan Minimum ---")
    order_bfs, dist_bfs, parent_bfs = kota.bfs("Pasar")
    print(f"Urutan kunjungan BFS : {order_bfs}")
    for tujuan in ["Stasiun", "Mall", "Bandara"]:
        jalur = kota.reconstruct_path(parent_bfs, "Pasar", tujuan)
        print(f"  Pasar -> {tujuan}: "
              f"{dist_bfs.get(tujuan, 'N/A')} persimpangan, "
              f"jalur = {jalur}")

    # DFS: Eksplorasi penuh
    print("\n--- DFS dari Pasar: Eksplorasi Penuh ---")
    order_dfs_r = kota.dfs_recursive("Pasar")
    order_dfs_i = kota.dfs_iterative("Pasar")
    print(f"DFS Rekursif : {order_dfs_r}")
    print(f"DFS Iteratif : {order_dfs_i}")

    # Dijkstra: Jarak terpendek dalam km
    print("\n--- Dijkstra dari Pasar: Rute Terpendek (km) ---")
    dist_dijk, parent_dijk = kota.dijkstra("Pasar")
    for tujuan in sorted(dist_dijk.keys()):
        jalur = kota.reconstruct_path(parent_dijk, "Pasar", tujuan)
        print(f"  Pasar -> {tujuan}: {dist_dijk[tujuan]} km, "
              f"jalur = {jalur}")
```

### 14.10.3 Analisis Hasil Studi Kasus

Hasil yang diharapkan dari eksekusi kode di atas menggambarkan perbedaan mendasar antara ketiga algoritma:

- **BFS** menemukan bahwa Pasar ke Bandara dapat dicapai dengan melewati 2 persimpangan: Pasar -> Stasiun -> Hotel -> Bandara (3 edge) atau Pasar -> Sekolah -> Hotel -> Bandara (3 edge). BFS tidak peduli dengan jarak dalam kilometer.

- **Dijkstra** menemukan rute terpendek dalam kilometer: Pasar -> Sekolah (2km) -> Hotel (7km, total 9km) -> Bandara (2km, total 11km) atau Pasar -> Stasiun (5km) -> Hotel (4km, total 9km) -> Bandara (2km, total 11km). Keduanya menghasilkan total 11 km. Rute via Pasar -> Stasiun -> Mall -> Bandara menghasilkan 5+3+6 = 14 km, lebih jauh.

- **DFS** mengeksplorasi seluruh kota tetapi tidak memberikan jaminan jalur terpendek maupun jalur dengan persimpangan minimum.

> **Kotak 14.6 — Studi Kasus: Google Maps dan Jaringan Jalan Dunia**
>
> Google Maps beroperasi pada graph yang mengandung lebih dari **1 miliar vertex** (persimpangan dan titik-titik jalan) dan miliards edge (segmen jalan). Algoritma yang digunakan bukan Dijkstra murni, melainkan varian-varian yang lebih efisien untuk skala besar:
>
> - **A* (A-Star)**: varian Dijkstra yang menggunakan *heuristic function* (estimasi jarak lurus ke tujuan) untuk memandu pencarian ke arah yang lebih menjanjikan, sehingga jauh lebih cepat dalam praktik meskipun kompleksitas kasus terburuk sama.
> - **Contraction Hierarchies**: teknik preprocessing yang "memendekkan" graph dengan menambahkan shortcut, sehingga query waktu-nyata menjadi sangat cepat.
> - **Bidirectional Dijkstra**: menjalankan Dijkstra dari sumber dan tujuan secara bersamaan dan bertemu di tengah, mengurangi area pencarian secara dramatis.
>
> Data real-time (kemacetan, kecelakaan, kondisi jalan) diintegrasikan sebagai pembaruan bobot edge secara dinamis, mengharuskan graph diperbarui dan rute dihitung ulang dalam hitungan detik.

---

## 14.11 Koneksi ke Topik Lanjutan: Horizon di Balik Graph Dasar

Bab ini telah memperkenalkan fondasi graph: definisi, representasi, BFS, DFS, dan Dijkstra. Namun, dunia graph dalam ilmu komputer jauh lebih luas dan dalam. Sebagai penutup buku ini, bagian berikut membuka cakrawala topik-topik lanjutan yang menanti untuk dijelajahi lebih jauh.

### 14.11.1 Algoritma Graph Klasik Lanjutan

Setelah memahami Dijkstra, langkah alami berikutnya adalah mempelajari keluarga algoritma shortest path yang lebih lengkap:

- **Bellman-Ford**: menangani bobot negatif dan mendeteksi *negative cycle*. Digunakan dalam protokol routing BGP di internet.
- **Floyd-Warshall**: menemukan jarak terpendek untuk semua pasang vertex sekaligus dengan kompleksitas O(V^3). Berguna untuk graph kecil-menengah.
- **Johnson's Algorithm**: kombinasi Bellman-Ford dan Dijkstra yang efisien untuk all-pairs shortest path pada sparse graph.

Untuk pohon rentang minimum (*Minimum Spanning Tree*):
- **Kruskal's Algorithm**: membangun MST dengan secara greedy menambahkan edge berbobot terkecil yang tidak membentuk siklus.
- **Prim's Algorithm**: membangun MST dari satu vertex dengan secara greedy memperluas pohon satu vertex pada satu waktu.

### 14.11.2 Masalah NP-Hard Berbasis Graph

Beberapa masalah graph yang tampak sederhana secara deskripsi ternyata termasuk dalam kelas masalah *NP-hard* — tidak diketahui algoritma polynomial yang dapat menyelesaikannya secara optimal untuk semua kasus. Masalah-masalah ini memiliki implikasi praktis yang luar biasa besar:

- **Travelling Salesman Problem (TSP)**: menemukan jalur terpendek yang mengunjungi setiap vertex tepat satu kali. Relevan dalam optimasi rute pengiriman dan logistik.
- **Graph Coloring Problem**: mewarnai vertex graph sehingga tidak ada dua vertex bertetangga yang memiliki warna sama, menggunakan jumlah warna minimum. Digunakan dalam penjadwalan dan alokasi register compiler.
- **Maximum Clique**: menemukan subgraph complete terbesar. Relevan dalam deteksi komunitas jaringan sosial.
- **Hamiltonian Cycle**: menentukan apakah terdapat siklus yang mengunjungi setiap vertex tepat satu kali.

Untuk masalah-masalah NP-hard ini, praktisi menggunakan pendekatan aproksimasi, heuristik, atau algoritma exact untuk input kecil.

### 14.11.3 Network Flow

Teori aliran jaringan (*network flow*) memodelkan permasalahan di mana sesuatu — air, listrik, data, barang — mengalir melalui jaringan dari sumber ke tujuan dengan batasan kapasitas pada setiap saluran. Teorema *Max-Flow Min-Cut* menyatakan bahwa aliran maksimum dari sumber ke tujuan sama dengan kapasitas minimum dari cut yang memisahkan keduanya — sebuah hasil yang elegan dengan implikasi praktis sangat luas.

Algoritma aliran jaringan kunci meliputi:
- **Ford-Fulkerson**: algoritma dasar max-flow menggunakan augmenting path.
- **Edmonds-Karp**: varian Ford-Fulkerson dengan BFS yang menjamin kompleksitas O(VE^2).
- **Dinic's Algorithm**: O(V^2 * E), lebih efisien untuk banyak kasus praktis.

Aplikasinya mencakup: alokasi bandwidth jaringan komputer, penjadwalan produksi pabrik, analisis sirkulasi lalu lintas, dan bahkan masalah pencocokan bipartit (matching) yang digunakan dalam sistem rekomendasi dan alokasi sumber daya.

### 14.11.4 Graph Neural Network: Graph Bertemu Kecerdasan Buatan

Salah satu perkembangan paling revolusioner dalam dekade terakhir adalah perkawinan antara teori graph dan pembelajaran mesin (*machine learning*). **Graph Neural Network (GNN)** adalah kelas arsitektur deep learning yang secara langsung beroperasi pada data berbentuk graph, mempelajari representasi vertex dan edge secara bersamaan dengan mempertimbangkan struktur konektivitasnya.

Mengapa GNN penting? Karena banyak data dunia nyata yang secara fundamental berbentuk graph, bukan vektor datar:
- **Jaringan molekul** dalam drug discovery: atom sebagai vertex, ikatan kimia sebagai edge. GNN memprediksi sifat-sifat molekul baru untuk pengembangan obat.
- **Jaringan sosial** dalam deteksi penipuan: GNN mendeteksi pola transaksi mencurigakan dengan memodelkan relasi antara akun, transaksi, dan perangkat.
- **Sistem rekomendasi** berbasis graph: platform seperti Pinterest menggunakan GNN untuk merekomendasikan konten berdasarkan graph interaksi pengguna-item.
- **Knowledge Graph** untuk penalaran mesin: sistem seperti Google Knowledge Graph menggunakan GNN untuk menjawab pertanyaan kompleks dengan bernalar di atas jaringan pengetahuan.

Arsitektur GNN yang populer meliputi Graph Convolutional Network (GCN), Graph Attention Network (GAT), dan GraphSAGE. Pemahaman atas konsep adjacency list, traversal BFS/DFS, dan struktur graph yang telah dipelajari di bab ini merupakan prasyarat konseptual yang tidak terhindarkan untuk memahami cara kerja GNN.

> **Kotak 14.7 — Catatan Penting: Graph sebagai Bahasa Universal**
>
> Ketika buku ini dimulai dari array — struktur data paling sederhana yang hanya mengorganisasi data secara linear — mungkin tidak terpikirkan bahwa perjalanan akan berakhir di graph. Namun inilah gambaran yang utuh: dari linear ke hierarkis ke bebas-sembarang. Dari array ke tree ke graph.
>
> Graph adalah bahasa universal untuk relasi. Apa pun yang dapat dinyatakan sebagai entitas dengan hubungan antar-entitas, dapat dimodelkan, dianalisis, dan diselesaikan menggunakan alat-alat yang telah dipelajari di bab ini. Kemampuan berpikir dalam kerangka graph — melihat masalah sebagai kumpulan simpul dan sisi — adalah salah satu keterampilan paling berharga yang dapat dimiliki seorang ilmuwan komputer.

---

## 14.12 Rangkuman Bab

Bab ini menutup perjalanan studi struktur data dengan topik yang paling ekspresif dan universal: graph. Berikut poin-poin inti yang perlu diingat:

1. **Graph adalah generalisasi dari semua struktur data yang telah dipelajari.** Secara formal, graph G = (V, E) terdiri atas himpunan vertex dan himpunan edge. Graph mampu merepresentasikan hubungan sembarang antar entitas, melampaui keterbatasan struktural linked list (linear), tree (hierarkis), dan array (sekuensial). Tree adalah kasus khusus dari graph, dan semua masalah yang dapat dimodelkan dengan tree dapat juga dimodelkan dengan graph.

2. **Teori graph lahir dari masalah konkret.** Euler membuktikan ketidakmungkinan perjalanan melintasi tujuh jembatan Königsberg pada 1736, dan dalam prosesnya menciptakan abstraksi yang kini menjadi fondasi ilmu komputer modern. Kemampuan mengabstraksikan masalah nyata ke dalam model matematika yang tepat — seperti yang dilakukan Euler — adalah inti dari pemikiran komputasional.

3. **Pilihan representasi graph menentukan efisiensi program.** Adjacency matrix menawarkan pengecekan edge O(1) tetapi membutuhkan memori O(V^2). Adjacency list hanya membutuhkan memori O(V+E) dan lebih efisien untuk iterasi tetangga, namun pengecekan edge membutuhkan O(degree). Karena hampir semua graph nyata bersifat sparse, adjacency list adalah representasi default yang lebih unggul dalam penggunaan memori.

4. **BFS dan DFS adalah dua paradigma traversal yang saling melengkapi.** BFS menggunakan queue dan menjelajahi graph level demi level, menjamin ditemukannya jalur dengan jumlah edge minimum pada unweighted graph — fondasi dari sistem rekomendasi teman di media sosial dan banyak algoritma graph lainnya. DFS menggunakan stack (atau rekursi) dan menyelam sedalam mungkin, secara natural mendukung deteksi siklus, pengurutan topologis DAG, dan eksplorasi komponen terhubung. Keduanya memiliki kompleksitas O(V+E).

5. **Algoritma Dijkstra menjembatani BFS dengan dunia graph berbobot.** Dengan memanfaatkan priority queue (min-heap) dan prinsip greedy relaksasi edge, Dijkstra menemukan jalur dengan total bobot minimum dari satu sumber ke semua vertex dalam O((V+E) log V). Ia adalah inti dari sistem navigasi GPS global dan mengilhami keluarga besar algoritma shortest path lanjutan. Dijkstra hanya bekerja untuk bobot non-negatif.

6. **Graph dasar yang dipelajari adalah pintu masuk ke topik-topik paling penting dalam ilmu komputer modern.** Algoritma lanjutan seperti Bellman-Ford, Floyd-Warshall, Prim, Kruskal, Ford-Fulkerson semuanya bertumpu pada konsep-konsep yang dibangun di bab ini. Masalah-masalah NP-hard seperti TSP dan Graph Coloring yang menjadi inti teori kompleksitas komputasi, teori aliran jaringan yang memodelkan sistem distribusi, dan Graph Neural Network yang berada di garis terdepan penelitian kecerdasan buatan — semuanya berakar pada pemahaman tentang graph yang telah dibangun sepanjang bab ini.

7. **Kemampuan memodelkan masalah sebagai graph adalah keterampilan inti seorang insinyur perangkat lunak.** Ketika menghadapi masalah baru, pertanyaan pertama yang perlu diajukan adalah: apakah masalah ini melibatkan entitas dengan hubungan di antaranya? Jika ya, kemungkinan besar masalah tersebut dapat dimodelkan sebagai graph, dan salah satu algoritma graph yang kaya akan memberikan solusinya. Peta jalan, jaringan komputer, media sosial, sistem rekomendasi, analisis kode sumber, sirkuit elektronik — semua adalah graph yang menunggu untuk dianalisis.

---

## 14.13 Istilah Kunci

| No. | Istilah               | Definisi Singkat                                                                          |
|-----|-----------------------|-------------------------------------------------------------------------------------------|
| 1   | Graph                 | Struktur data G = (V, E) yang terdiri atas himpunan vertex dan himpunan edge.            |
| 2   | Vertex (Simpul)       | Entitas dasar dalam graph; direpresentasikan sebagai titik.                               |
| 3   | Edge (Sisi)           | Hubungan atau koneksi antara dua vertex.                                                  |
| 4   | Degree                | Jumlah edge yang melekat pada sebuah vertex.                                              |
| 5   | In-degree             | Jumlah edge yang masuk ke vertex dalam directed graph.                                    |
| 6   | Out-degree            | Jumlah edge yang keluar dari vertex dalam directed graph.                                 |
| 7   | Path (Lintasan)       | Urutan vertex di mana setiap pasang berurutan dihubungkan oleh sebuah edge.               |
| 8   | Cycle (Siklus)        | Path tertutup yang diawali dan diakhiri pada vertex yang sama.                            |
| 9   | Connected             | Sifat graph di mana terdapat path antara setiap pasang vertex.                            |
| 10  | Undirected Graph      | Graph di mana edge tidak memiliki arah; hubungan bersifat simetris.                       |
| 11  | Directed Graph (DAG)  | Graph di mana edge memiliki arah; DAG adalah directed graph tanpa siklus.                 |
| 12  | Weighted Graph        | Graph di mana setiap edge memiliki nilai numerik (bobot atau cost).                       |
| 13  | Adjacency Matrix      | Representasi graph berupa matriks V x V; M[i][j] = bobot edge dari i ke j.              |
| 14  | Adjacency List        | Representasi graph berupa daftar tetangga per vertex; efisien untuk sparse graph.         |
| 15  | Sparse Graph          | Graph dengan jumlah edge jauh lebih kecil dari V^2.                                       |
| 16  | Dense Graph           | Graph dengan jumlah edge mendekati V^2.                                                   |
| 17  | BFS                   | Traversal graph level demi level menggunakan queue; menjamin shortest path (unweighted). |
| 18  | DFS                   | Traversal graph sedalam mungkin menggunakan stack/rekursi; mendukung topological sort.    |
| 19  | Dijkstra              | Algoritma greedy untuk shortest path pada weighted graph dengan bobot non-negatif.        |
| 20  | Relaksasi Edge        | Operasi dalam Dijkstra: memperbarui estimasi jarak vertex jika ditemukan jalur lebih pendek. |

---

## 14.14 Soal Latihan

**Soal 1 [C2 - Memahami]**

Pada sebuah undirected graph dengan 7 vertex dan 10 edge, berapakah total degree dari semua vertex? Jelaskan teorema yang digunakan untuk menjawab pertanyaan ini dan tuliskan rumusan formalnya.

---

**Soal 2 [C2 - Memahami]**

Berikan sebuah contoh graph berarah dengan 5 vertex di mana graph tersebut merupakan *strongly connected* tetapi bukan DAG. Kemudian ubah graph tersebut sehingga menjadi DAG dengan menghapus edge sesedikit mungkin. Jelaskan perubahan yang dilakukan dan mengapa graph hasil modifikasi tersebut dapat disebut DAG.

---

**Soal 3 [C3 - Menerapkan]**

Diberikan adjacency matrix berikut untuk sebuah directed graph:

```
     0   1   2   3   4
0  [ 0,  1,  0,  1,  0 ]
1  [ 0,  0,  1,  0,  0 ]
2  [ 0,  0,  0,  0,  1 ]
3  [ 0,  1,  0,  0,  1 ]
4  [ 0,  0,  0,  0,  0 ]
```

a) Gambarkan graph tersebut dalam bentuk diagram.
b) Tentukan in-degree dan out-degree setiap vertex.
c) Apakah graph ini merupakan DAG? Berikan alasan dan, jika ya, tuliskan satu urutan topologis yang valid.

---

**Soal 4 [C3 - Menerapkan]**

Diberikan graph tidak berarah dengan vertex {P, Q, R, S, T, U} dan edge {(P,Q), (P,R), (Q,S), (R,S), (R,T), (S,U), (T,U)}.

a) Representasikan graph tersebut sebagai adjacency list dalam Python (gunakan dictionary).
b) Lakukan trace BFS lengkap dari vertex P, tampilkan state queue dan set visited pada setiap langkah.
c) Tentukan jarak terpendek (jumlah edge) dari P ke semua vertex lainnya.
d) Rekonstruksi jalur terpendek dari P ke U.

---

**Soal 5 [C3 - Menerapkan]**

Menggunakan graph yang sama dengan Soal 4:

a) Lakukan trace DFS rekursif dari vertex P, tampilkan urutan pemanggilan fungsi rekursif dan status visited pada setiap langkah.
b) Bandingkan urutan kunjungan DFS dengan urutan kunjungan BFS. Apa perbedaan fundamentalnya?
c) Apakah graph ini mengandung siklus? Gunakan logika pendeteksian siklus berbasis DFS untuk membuktikan jawaban Anda.

---

**Soal 6 [C4 - Menganalisis]**

Sebuah aplikasi sosial memiliki 500.000 pengguna aktif. Riset menunjukkan bahwa rata-rata setiap pengguna memiliki 150 koneksi pertemanan.

a) Hitunglah penggunaan memori (dalam megabyte) jika graph jaringan sosial ini direpresentasikan dengan adjacency matrix, dengan asumsi setiap sel membutuhkan 1 byte.
b) Estimasikan penggunaan memori dengan adjacency list, dengan asumsi setiap entri tetangga membutuhkan 8 byte.
c) Berapa kali lipatnya perbedaan memori antara kedua representasi?
d) Algoritma apa yang lebih tepat digunakan untuk fitur "Orang yang Mungkin Anda Kenal" (menemukan teman dari teman dalam jangkauan 2 hop): BFS atau DFS? Jelaskan alasannya secara komprehensif.

---

**Soal 7 [C4 - Menganalisis]**

Perhatikan weighted graph berikut:

```
      A ---2--- B ---5--- E
      |         |
      3         1
      |         |
      C ---4--- D
```

Edge: (A,B)=2, (A,C)=3, (B,D)=1, (B,E)=5, (C,D)=4

a) Lakukan trace manual algoritma Dijkstra dari vertex A. Tampilkan nilai dist dan parent setelah setiap iterasi.
b) Tentukan jalur terpendek dari A ke E beserta total bobotnya.
c) Mengapa BFS tidak dapat digunakan untuk kasus ini? Berikan contoh konkret di mana BFS akan memberikan jawaban yang salah pada graph di atas.
d) Jelaskan mengapa sifat "bobot non-negatif" merupakan syarat wajib untuk kebenaran algoritma Dijkstra.

---

**Soal 8 [C4 - Menganalisis]**

Pertimbangkan dua graph berikut:
- Graph A: 100 vertex, 4900 edge (mendekati complete graph K_100)
- Graph B: 100 vertex, 200 edge (rata-rata 2 tetangga per vertex)

a) Klasifikasikan masing-masing sebagai dense graph atau sparse graph.
b) Untuk setiap graph, tentukan representasi yang lebih efisien dalam hal memori (adjacency matrix atau adjacency list) dan hitung selisih penggunaan memorinya dalam satuan elemen penyimpanan.
c) Untuk operasi "cek apakah ada edge antara vertex ke-50 dan vertex ke-75", representasi mana yang lebih cepat? Jelaskan dengan analisis kompleksitas O.
d) Untuk operasi "iterasi semua tetangga vertex ke-50", representasi mana yang lebih cepat untuk Graph A dan untuk Graph B? Jelaskan.

---

**Soal 9 [C5 - Mengevaluasi]**

Sebuah sistem manajemen proyek perlu menentukan urutan pengerjaan tugas-tugas berikut beserta ketergantungannya:
- Tugas A: tidak ada prasyarat
- Tugas B: tidak ada prasyarat
- Tugas C: membutuhkan A selesai terlebih dahulu
- Tugas D: membutuhkan A dan B selesai
- Tugas E: membutuhkan C selesai
- Tugas F: membutuhkan D dan E selesai

a) Modelkan ketergantungan ini sebagai DAG. Gambarkan diagram dan tuliskan adjacency list-nya.
b) Implementasikan fungsi `topological_sort(graph)` dalam Python menggunakan DFS.
c) Temukan semua urutan topologis yang valid menggunakan program Anda.
d) Evaluasi: apakah mungkin terjadi deadlock (circular dependency) dalam sistem manajemen proyek nyata, dan bagaimana deteksi siklus berbasis DFS dapat mencegahnya? Berikan skenario konkret.

---

**Soal 10 [C5 - Mengevaluasi]**

Perbandingan komprehensif BFS dan DFS:

a) Buktikan secara formal (dengan argumen induktif atau contoh counter-example) bahwa BFS menjamin ditemukannya jalur dengan jumlah edge minimum, sedangkan DFS tidak.
b) Tunjukkan bahwa DFS memiliki keunggulan dalam mendeteksi siklus dibandingkan BFS. Apa yang membedakan cara deteksi siklus pada undirected graph versus directed graph menggunakan DFS?
c) Dalam konteks mesin pencari web (*web crawler*) yang perlu menjelajahi halaman-halaman web yang saling terhubung melalui hyperlink, evaluasi mana yang lebih cocok antara BFS dan DFS. Pertimbangkan ukuran graph (miliards halaman), sifat konektivitas (*scale-free network*), dan tujuan eksplorasi.

---

**Soal 11 [C6 - Mencipta]**

Rancang dan implementasikan sebuah kelas `WeightedGraph` dalam Python yang mendukung:
1. Penambahan vertex dan edge berbobot
2. BFS untuk jalur dengan edge minimum
3. Dijkstra untuk jalur dengan bobot minimum
4. Fungsi `compare_paths(source, target)` yang membandingkan jalur yang ditemukan oleh BFS dan Dijkstra, menampilkan perbedaan jumlah edge dan total bobot

Uji implementasi Anda pada graph peta kota dengan minimal 8 vertex. Identifikasi setidaknya satu pasang vertex di mana jalur BFS dan Dijkstra berbeda, dan jelaskan mengapa perbedaan tersebut terjadi.

---

**Soal 12 [C6 - Mencipta]**

Algoritma Dijkstra standar menemukan jalur terpendek dari *satu sumber* ke semua vertex. Tantangan: rancang sebuah algoritma `multi_source_bfs(graph, sources)` yang menemukan, untuk setiap vertex v dalam graph, vertex dalam himpunan `sources` yang paling dekat (dalam jumlah edge) dengan v.

a) Rancang algoritma tersebut. Petunjuk: pertimbangkan BFS dengan multiple starting points secara simultan.
b) Analisis kompleksitas waktu dan ruang algoritma Anda.
c) Implementasikan dalam Python dan uji pada sebuah graph dengan 8 vertex dan 3 sumber.
d) Sebutkan satu aplikasi nyata dari Multi-Source BFS ini dalam sistem komputer yang nyata.

---

## 14.15 Bacaan Lanjutan

**[1] Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022). *Introduction to Algorithms* (4th ed.). MIT Press.**

Referensi algoritmik paling komprehensif dan otoritatif yang tersedia. Bab 20-22 membahas representasi graph, BFS, DFS, topological sort, dan strongly connected components dengan analisis matematis yang ketat. Bab 22 mencakup Dijkstra, Bellman-Ford, dan DAG shortest path. Bab 23-24 membahas Minimum Spanning Tree (Kruskal dan Prim). Bab 26 membahas Maximum Flow. Cocok sebagai rujukan mendalam setelah menguasai konsep-konsep dasar di buku ini.

**[2] Goodrich, M. T., Tamassia, R., & Goldwasser, M. H. (2014). *Data Structures and Algorithms in Python*. John Wiley & Sons.**

Bab 14 buku ini membahas algoritma graph khusus dengan implementasi Python, mencakup DFS, BFS, *transitive closure*, topological sort, dan shortest paths. Pendekatan berorientasi objek dengan Python menjadikannya jembatan yang sempurna dari buku yang sedang Anda baca menuju analisis lebih mendalam. Sangat direkomendasikan sebagai referensi lanjutan berbasis Python.

**[3] Sedgewick, R., & Wayne, K. (2011). *Algorithms* (4th ed.). Addison-Wesley.**

Bab 4 buku ini adalah salah satu pemaparan algoritma graph paling komprehensif yang tersedia, dibagi menjadi empat sub-bab: undirected graphs, directed graphs, minimum spanning trees, dan shortest paths. Meskipun contoh implementasi menggunakan Java, konsep dan visualisasinya sangat kaya dan mudah diadaptasi ke Python. Situs web companion (algs4.cs.princeton.edu) menyediakan visualisasi interaktif yang sangat membantu.

**[4] Kleinberg, J., & Tardos, E. (2006). *Algorithm Design*. Addison-Wesley.**

Bab 3 membahas graph dan BFS/DFS dalam konteks *connected components*, *bipartiteness*, dan *strong connectivity*. Bab 4 membahas Dijkstra dalam konteks paradigma *greedy algorithms* yang lebih luas, memberikan pemahaman mengapa Dijkstra benar dan kapan pendekatan greedy tidak cukup. Bab 7 membahas Network Flow secara mendalam. Buku ini unggul dalam menyajikan motivasi dan intuisi di balik setiap algoritma.

**[5] Skiena, S. S. (2020). *The Algorithm Design Manual* (3rd ed.). Springer.**

Bab 7 (*Graph Traversal*) dan Bab 8 (*Weighted Graph Algorithms*) dilengkapi dengan diskusi aplikasi nyata yang ekstensif dan "war stories" — kisah-kisah nyata bagaimana algoritma graph digunakan untuk memecahkan masalah praktis. Pendekatan pragmatis Skiena sangat berguna untuk memahami kapan dan mengapa memilih algoritma tertentu. Edisi ketiga juga memperbarui pembahasan untuk era modern termasuk aplikasi machine learning.

**[6] Barabasi, A.-L. (2016). *Network Science*. Cambridge University Press. (Tersedia gratis di networksciencebook.com)**

Untuk memahami graph dalam konteks jaringan skala besar (internet, jaringan sosial, jaringan biologis), buku ini adalah rujukan terbaik. Membahas sifat-sifat statistik jaringan nyata seperti *power-law degree distribution*, *small-world phenomenon*, dan *community structure*. Memberikan perspektif sains jaringan (*network science*) yang melengkapi perspektif algoritma dari referensi-referensi sebelumnya. Sangat relevan untuk memahami konteks aplikasi nyata algoritma graph.

**[7] Hamilton, W. L. (2020). *Graph Representation Learning*. Morgan & Claypool Publishers. (Tersedia gratis di cs.mcgill.ca/~wlh/grl_book)**

Buku pengantar terbaik untuk Graph Neural Network (GNN) dan Graph Representation Learning. Bab 1-2 membahas representasi graph dan metode berbasis random walk (DeepWalk, Node2Vec), yang merupakan jembatan antara algoritma graph klasik dan machine learning modern. Bab 5-7 membahas GCN, GraphSAGE, dan Graph Attention Network. Prasyarat: pemahaman graph dasar (bab ini), linear algebra, dan konsep dasar machine learning.

**[8] Euler, L. (1741). "Solutio problematis ad geometriam situs pertinentis." *Commentarii Academiae Scientiarum Imperialis Petropolitanae*, 8, 128–140.**

Makalah orisinal Euler yang melahirkan teori graph — sebuah bacaan bersejarah yang dapat diakses secara online. Meskipun ditulis dalam bahasa Latin, terjemahan Inggrisnya tersedia dan memberikan gambaran yang luar biasa tentang bagaimana seorang jenius matematika mengabstraksikan masalah nyata menjadi model matematika yang elegan. Membaca makalah ini akan memperdalam apresiasi atas dasar-dasar yang telah dibangun selama berabad-abad sebelum ilmu komputer lahir.

---

*Bab ini merupakan bab penutup dari buku "Struktur Data: Konsep, Implementasi, dan Aplikasi dengan Python". Perjalanan dari array di Bab 1 hingga graph di Bab 14 mencerminkan kemajuan bertahap dalam kemampuan merepresentasikan dan memanipulasi data: dari linear, ke hierarkis, ke bebas-sembarang. Pemahaman atas semua struktur data ini — dan hubungan di antaranya — membentuk fondasi yang kuat untuk studi ilmu komputer yang lebih lanjut: algoritma lanjutan, kecerdasan buatan, rekayasa perangkat lunak skala besar, dan teori komputasi.*

*Selamat telah menyelesaikan buku ini. Perjalanan sesungguhnya baru saja dimulai.*

---

*Program Studi Informatika — Institut Bisnis dan Teknologi Indonesia (INSTIKI)*
*Tahun Akademik 2025/2026*
