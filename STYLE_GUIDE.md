# PANDUAN GAYA (STYLE GUIDE)
## Buku Ajar: Struktur Data — Konsep, Implementasi, dan Aplikasi dengan Python
### Institut Bisnis dan Teknologi Indonesia (INSTIKI)

---

## DAFTAR ISI

1. [Spesifikasi Kertas & Ukuran Halaman](#1-spesifikasi-kertas--ukuran-halaman)
2. [Margin & Layout Halaman](#2-margin--layout-halaman)
3. [Tipografi — Font](#3-tipografi--font)
4. [Hierarki Judul (Heading)](#4-hierarki-judul-heading)
5. [Teks Utama (Body Text)](#5-teks-utama-body-text)
6. [Kode Program](#6-kode-program)
7. [Elemen Khusus (Kotak, Callout, Catatan)](#7-elemen-khusus-kotak-callout-catatan)
8. [Tabel](#8-tabel)
9. [Gambar & Ilustrasi](#9-gambar--ilustrasi)
10. [Persamaan & Formula](#10-persamaan--formula)
11. [Daftar (List)](#11-daftar-list)
12. [Header & Footer](#12-header--footer)
13. [Penomoran Halaman](#13-penomoran-halaman)
14. [Warna](#14-warna)
15. [Front Matter & Back Matter](#15-front-matter--back-matter)
16. [Spesifikasi Cetak](#16-spesifikasi-cetak)
17. [Spesifikasi Versi Digital (PDF/eBook)](#17-spesifikasi-versi-digital-pdfe-book)

---

## 1. Spesifikasi Kertas & Ukuran Halaman

| Atribut              | Nilai                         |
|----------------------|-------------------------------|
| **Ukuran halaman**   | B5 — **17 × 24 cm** (176 × 250 mm) |
| **Orientasi**        | Portrait                      |
| **Standar kertas**   | ISO B5                        |
| **Gramatur (isi)**   | 70 gsm — HVS / Bookpaper offset putih |
| **Gramatur (cover)** | 260 gsm — Art Carton          |
| **Finishing cover**  | Laminasi doff (matte) + UV spot pada judul |
| **Jilid**            | Perfect binding (lem panas / soft cover) |

---

## 2. Margin & Layout Halaman

### Margin Isi (Mirror Margin — untuk cetak buku)

| Posisi          | Ukuran   |
|-----------------|----------|
| **Margin atas** | 2,5 cm   |
| **Margin bawah**| 2,5 cm   |
| **Margin dalam** (gutter / binding side) | 2,8 cm |
| **Margin luar** | 2,2 cm   |
| **Gutter tambahan** | 0,3 cm (masuk ke margin dalam) |

### Kolom

- **Jumlah kolom**: 1 kolom (single column) — untuk isi utama
- **Kolom ganda**: Hanya untuk indeks di Back Matter
- **Lebar teks aktif**: ± 12,5 cm

### Spasi

| Elemen               | Nilai                  |
|----------------------|------------------------|
| **Line spacing (isi)** | 1,3 × ukuran font (approx. 15,6 pt untuk body 12 pt) |
| **Paragraph spacing before** | 0 pt |
| **Paragraph spacing after** | 6 pt |
| **Indentasi paragraf pertama** | 0 cm (no indent, gunakan spasi antar paragraf) |

---

## 3. Tipografi — Font

### Font Utama

| Fungsi               | Font                  | Keterangan                               |
|----------------------|-----------------------|------------------------------------------|
| **Judul Buku**       | **Merriweather Bold** | Serif — otoritatif, akademis             |
| **Judul Bab (H1)**   | **Merriweather Bold** | Konsisten dengan judul buku              |
| **Sub-judul (H2–H4)**| **Merriweather SemiBold / Bold** | Tetap dalam keluarga serif      |
| **Teks isi (body)**  | **Georgia** atau **Source Serif 4** | Serif — optimal untuk bacaan panjang |
| **Kode program**     | **JetBrains Mono** atau **Fira Code** | Monospace — jelas, ligature mendukung Python |
| **Catatan / callout**| **Source Sans 3** atau **Inter** | Sans-serif — kontras visual dengan body |
| **Caption** (gambar/tabel) | **Source Sans 3 Italic** | Sans-serif miring                  |
| **Header/Footer**    | **Source Sans 3**     | Sans-serif ringan                        |

> **Alternatif gratis (Google Fonts / LaTeX):**
> Body: `EB Garamond` atau `Linux Libertine` — Kode: `Inconsolata` atau `Courier Prime`

### Ukuran Font

| Elemen                     | Ukuran    | Style         |
|----------------------------|-----------|---------------|
| Judul buku (cover)         | 32–36 pt  | Bold          |
| Sub-judul buku (cover)     | 18–20 pt  | Regular/Italic|
| H1 — Judul Bab             | 22–24 pt  | Bold          |
| H2 — Sub-bab               | 16–18 pt  | Bold          |
| H3 — Sub-sub-bab           | 13–14 pt  | SemiBold      |
| H4 — Paragraf bernomor     | 12 pt     | Bold          |
| Body text (isi utama)      | 11–12 pt  | Regular       |
| Kode program               | 10–10,5 pt| Regular Mono  |
| Caption gambar/tabel       | 10 pt     | Italic        |
| Catatan kaki (footnote)    | 9 pt      | Regular       |
| Header/footer              | 9–10 pt   | Regular       |
| Nomor halaman              | 10 pt     | Regular/Bold  |

---

## 4. Hierarki Judul (Heading)

### H1 — Judul Bab

```
Nomor Bab : "BAB 01" — font: Merriweather Bold, 14 pt, ALL CAPS, warna aksen
Judul Bab : "Pengantar Struktur Data" — font: Merriweather Bold, 24 pt
Garis dekoratif di bawah judul: 3 pt tebal, warna primer
Spacing setelah H1: 24 pt
Halaman bab dimulai di halaman baru (right/odd page)
```

### H2 — Sub-bab

```
Format: "1.1 Definisi dan Ruang Lingkup"
Font: Merriweather Bold, 16 pt
Spacing before: 18 pt | Spacing after: 8 pt
Garis kiri (left border): 4 pt, warna primer (opsional)
```

### H3 — Sub-sub-bab

```
Format: "1.1.1 Pentingnya Struktur Data"
Font: Merriweather SemiBold, 13 pt
Spacing before: 12 pt | Spacing after: 6 pt
Tanpa garis dekoratif
```

### H4 — Level terakhir

```
Format: "a. Kompleksitas Waktu"
Font: Body font Bold, 12 pt, inline dengan paragraf
Spacing before: 8 pt | Spacing after: 4 pt
```

---

## 5. Teks Utama (Body Text)

| Atribut              | Nilai                         |
|----------------------|-------------------------------|
| **Font**             | Georgia / Source Serif 4      |
| **Ukuran**           | 12 pt                         |
| **Line spacing**     | 1,3 (15,6 pt)                 |
| **Alignment**        | **Justify** (rata kiri-kanan) |
| **Indentasi**        | Tanpa indentasi baris pertama; gunakan spasi antar paragraf |
| **Spacing after**    | 8 pt                          |
| **Warna**            | #1A1A1A (hitam lunak, bukan pure black) |
| **Hyphenation**      | Aktif — untuk mengurangi rivers pada justify |

### Penekanan dalam teks

| Tipe            | Format                    |
|-----------------|---------------------------|
| **Istilah baru** | *Italic* saat pertama kali muncul |
| **Penekanan kuat** | **Bold**                |
| **Kode inline** | `monospace` dengan background abu-abu muda |
| **Kutipan panjang** | Indentasi 1 cm kiri-kanan, font 11 pt italic |

---

## 6. Kode Program

### Blok Kode (Code Block)

```
Font          : JetBrains Mono / Fira Code, 10 pt
Background    : #F5F5F5 (abu-abu sangat muda)
Border kiri   : 4 pt solid, warna primer (#2563EB)
Padding       : 10 pt atas-bawah, 12 pt kiri-kanan
Border radius : 4 pt (untuk PDF digital)
Line spacing  : 1,4 (agar baris kode mudah dibaca)
Margin before : 12 pt
Margin after  : 12 pt
Numbering baris : Direkomendasikan untuk kode > 10 baris
```

### Syntax Highlighting (PDF berwarna / Digital)

| Token               | Warna         | Hex       |
|---------------------|---------------|-----------|
| Keyword (`def`, `for`, `if`) | Biru tua   | `#1D4ED8` |
| String (`"..."`, `'...'`) | Hijau tua  | `#15803D` |
| Komentar (`# ...`)  | Abu-abu       | `#6B7280` |
| Angka / literal     | Oranye        | `#EA580C` |
| Nama fungsi/class   | Ungu          | `#7C3AED` |
| Built-in            | Biru sedang   | `#2563EB` |
| Output / result     | Hijau gelap   | `#166534` |

### Kode Inline

```
Font          : JetBrains Mono, 10,5 pt
Background    : #EFEFEF
Padding       : 1–2 pt horizontal
Border radius : 2 pt
Warna teks    : #C0392B (merah gelap) untuk menonjol di tengah paragraf
```

### Label Kode

```
Format   : "Kode 3.1: Implementasi Pencarian Linear dalam Python"
Posisi   : Di atas blok kode
Font     : Source Sans 3 Bold, 10 pt
Warna    : Primer
```

---

## 7. Elemen Khusus (Kotak, Callout, Catatan)

### Tipe Kotak & Warnanya

| Tipe                  | Label          | Warna border | Warna bg    | Ikon   |
|-----------------------|----------------|--------------|-------------|--------|
| **Definisi**          | DEFINISI       | `#2563EB`    | `#EFF6FF`   | 📖     |
| **Teorema / Klaim**   | TEOREMA        | `#7C3AED`    | `#F5F3FF`   | ∑      |
| **Contoh**            | CONTOH         | `#16A34A`    | `#F0FDF4`   | ✎      |
| **Catatan Penting**   | CATATAN        | `#D97706`    | `#FFFBEB`   | ⚠      |
| **Peringatan**        | PERHATIAN      | `#DC2626`    | `#FEF2F2`   | ⛔     |
| **Tips & Trik**       | TIPS           | `#0891B2`    | `#ECFEFF`   | 💡     |
| **Analogi**           | ANALOGI        | `#65A30D`    | `#F7FEE7`   | 🔍     |
| **Ringkasan Bab**     | RINGKASAN      | `#374151`    | `#F9FAFB`   | ✔      |

### Format Kotak

```
Border        : 1 pt pada semua sisi + 4 pt border kiri (warna utama kotak)
Padding       : 12 pt
Border radius : 4 pt
Header kotak  : Font sans-serif Bold 10 pt ALL CAPS, warna teks sama dengan border
Margin        : 12 pt sebelum dan sesudah kotak
```

---

## 8. Tabel

### Format Umum

| Atribut               | Nilai                                    |
|-----------------------|------------------------------------------|
| **Font header**       | Source Sans 3 Bold, 10 pt, warna putih   |
| **Background header** | Warna primer `#2563EB`                   |
| **Font isi**          | Source Sans 3 / Body font, 10–11 pt      |
| **Baris genap (stripe)** | Background `#F0F4FF` (biru sangat muda)|
| **Border**            | 0,5 pt, warna `#D1D5DB`                  |
| **Padding sel**       | 6 pt vertikal, 8 pt horizontal           |
| **Alignment angka**   | Rata kanan                               |
| **Alignment teks**    | Rata kiri                                |

### Label Tabel

```
Format   : "Tabel 2.1: Perbandingan Kompleksitas Operasi"
Posisi   : Di atas tabel
Font     : Source Sans 3 Bold, 10 pt
Spacing after label : 4 pt
```

---

## 9. Gambar & Ilustrasi

### Spesifikasi Teknis

| Atribut               | Nilai                           |
|-----------------------|---------------------------------|
| **Resolusi cetak**    | Minimum **300 DPI** pada ukuran cetak |
| **Resolusi digital**  | 144 DPI (retina) cukup          |
| **Format file**       | SVG (vektor, diutamakan) / PNG  |
| **Gambar hitam-putih** | Untuk versi cetak B/W — pastikan kontras cukup |
| **Lebar maksimal**    | Sama dengan lebar teks (± 12,5 cm) |
| **Lebar kecil**       | 6–8 cm, center-aligned          |

### Caption Gambar

```
Format   : "Gambar 4.1: Representasi Singly Linked List dengan 4 node"
Posisi   : Di bawah gambar
Font     : Source Sans 3 Italic, 10 pt
Alignment: Center
Warna    : #4B5563 (abu-abu gelap)
Spacing before caption : 4 pt
Spacing after caption  : 12 pt
```

### Diagram & Ilustrasi Struktur Data

- Gunakan **warna primer** (`#2563EB`) untuk node/elemen utama
- Gunakan **warna aksen** (`#F59E0B`) untuk pointer/panah
- Gunakan **abu-abu** (`#9CA3AF`) untuk elemen NULL / kosong
- Tebal garis: 1,5–2 pt
- Font label dalam diagram: JetBrains Mono, 9–10 pt

---

## 10. Persamaan & Formula

| Atribut               | Nilai                                          |
|-----------------------|------------------------------------------------|
| **Renderer**          | LaTeX / MathJax / Word Equation Editor         |
| **Font matematis**    | Computer Modern (LaTeX default) atau STIX Two  |
| **Ukuran inline**     | Sama dengan body (12 pt)                       |
| **Ukuran display**    | 13–14 pt, center-aligned, indentasi 1,5 cm    |
| **Penomoran**         | `(2.1)` rata kanan — hanya untuk persamaan yang dirujuk |
| **Spacing**           | 10 pt sebelum dan sesudah persamaan display    |

### Contoh Penulisan Kompleksitas

```
Inline   : O(n²), O(log n), O(n log n)
Display  : T(n) = 2T(n/2) + O(n)     ...(8.1)
```

---

## 11. Daftar (List)

### Unordered List (Bullet)

```
Level 1  : Bullet •  (solid circle) — indentasi 0,5 cm
Level 2  : Bullet ○  (open circle) — indentasi 1,0 cm
Level 3  : Bullet ▪  (solid square) — indentasi 1,5 cm
Font     : Sama dengan body text
Spacing  : 3 pt antar item; 8 pt sebelum dan sesudah list
```

### Ordered List (Nomor)

```
Level 1  : 1. 2. 3. — indentasi 0,5 cm
Level 2  : a. b. c. — indentasi 1,0 cm
Level 3  : i. ii. iii. — indentasi 1,5 cm
```

### Daftar Langkah (Algoritma Verbal)

```
Gunakan ordered list dengan kotak langkah bergaya prosedur:
Font     : Body text
Label    : "Langkah 1:", "Langkah 2:" — Bold
Background: #F9FAFB, border kiri tipis
```

---

## 12. Header & Footer

### Header

| Halaman        | Isi Header (kiri/kanan sesuai even/odd) |
|----------------|-----------------------------------------|
| Halaman ganjil (odd) | Judul Sub-bab aktif — rata kanan       |
| Halaman genap (even) | Nama Bab aktif — rata kiri             |
| Halaman bab baru     | Tanpa header                           |

```
Font      : Source Sans 3, 9 pt, Regular
Warna     : #6B7280 (abu-abu sedang)
Separator : Garis 0,5 pt di bawah header, warna #D1D5DB
Margin bawah garis ke teks: 6 pt
```

### Footer

```
Isi       : Nomor halaman saja (atau + nama buku singkat pada salah satu sisi)
Font      : Source Sans 3, 9–10 pt
Posisi    : Tengah atau sisi luar (outer margin)
Separator : Garis 0,5 pt di atas footer
```

---

## 13. Penomoran Halaman

| Bagian                | Format    | Penempatan  |
|-----------------------|-----------|-------------|
| **Front Matter**      | i, ii, iii, iv… (romawi kecil) | Tengah / luar |
| **Isi Bab (main)**    | 1, 2, 3… (arab) | Luar (outer) |
| **Back Matter**       | Lanjutan dari isi, atau A-1, A-2… untuk lampiran | |
| **Halaman pertama bab** | Nomor tampil di tengah bawah atau tanpa header |  |
| **Halaman kosong**    | Tidak bernomor, tidak ada header/footer |  |

---

## 14. Warna

### Palet Utama

| Nama             | Hex       | Penggunaan                              |
|------------------|-----------|-----------------------------------------|
| **Primer**       | `#2563EB` | Judul bab, border kode, header tabel, aksen utama |
| **Primer gelap** | `#1E3A8A` | Teks judul cover, elemen yang sangat menonjol |
| **Aksen / Emas** | `#F59E0B` | Panah diagram, highlight khusus, nomor bab dekoratif |
| **Sukses / Hijau** | `#16A34A` | Kotak contoh, output kode |
| **Peringatan**   | `#D97706` | Kotak catatan, warning |
| **Bahaya**       | `#DC2626` | Kotak perhatian, error output |
| **Info**         | `#0891B2` | Tips, info tambahan |
| **Netral gelap** | `#1A1A1A` | Body text |
| **Netral sedang**| `#6B7280` | Header/footer, caption |
| **Netral muda**  | `#D1D5DB` | Border tabel, garis pemisah |
| **Background**   | `#FFFFFF` | Halaman isi |
| **Background kode** | `#F5F5F5` | Blok kode |

### Versi Cetak Hitam-Putih

Untuk cetak B/W, warna primer digantikan dengan:
- Primer → Black `#000000`
- Background kotak → Shading 10–15%
- Border → 1 pt solid

---

## 15. Front Matter & Back Matter

### Urutan Front Matter

| No | Halaman                  | Keterangan                         |
|----|--------------------------|------------------------------------|
| i  | Halaman judul (title page) | Kanan/ganjil                     |
| ii | Halaman hak cipta        | Balik halaman judul (genap)        |
| iii| Kata Pengantar           | Mulai halaman ganjil               |
| —  | Daftar Isi               | Lanjutan                           |
| —  | Daftar Gambar            | Jika > 10 gambar                   |
| —  | Daftar Tabel             | Jika > 10 tabel                    |
| —  | Daftar Kode              | Jika ada banyak listing kode       |
| —  | Daftar Singkatan/Notasi  | Opsional                           |

### Urutan Back Matter

| Bagian           | Keterangan                              |
|------------------|-----------------------------------------|
| Daftar Pustaka   | Format APA 7th edition                  |
| Lampiran         | Penomoran A, B, C…                     |
| Glosarium        | Istilah teknis, alfabetis               |
| Indeks           | 2 kolom, font 10 pt                     |
| Tentang Penulis  | Halaman terakhir                        |

---

## 16. Spesifikasi Cetak

| Atribut                  | Nilai                                     |
|--------------------------|-------------------------------------------|
| **Mode warna**           | CMYK (untuk file ke percetakan)           |
| **Color profile**        | ISO Coated v2 / FOGRA39                   |
| **Bleed**                | 3 mm pada semua sisi (untuk cover)        |
| **Safe zone**            | 5 mm dari tepi (untuk elemen penting)     |
| **Format file akhir**    | PDF/X-1a atau PDF/X-4 (untuk cetak)       |
| **Resolusi gambar**      | Minimum 300 DPI                           |
| **Font embedding**       | Semua font harus di-embed (subset/full)   |
| **Overprint**            | Black text: overprint ON                  |

### Spesifikasi Cover

| Atribut         | Nilai                                          |
|-----------------|------------------------------------------------|
| Layout cover    | Full bleed, dengan spine (punggung buku)       |
| Tebal spine     | Dihitung: (jumlah halaman × gramatur) / 1000   |
| Perkiraan spine | ±18–22 mm untuk ~520 halaman, 70 gsm           |
| Elemen cover depan | Judul, sub-judul, nama penulis, logo INSTIKI |
| Elemen cover belakang | Sinopsis, ISBN barcode, logo penerbit  |
| Elemen spine    | Judul singkat + nama penulis + logo            |

---

## 17. Spesifikasi Versi Digital (PDF/eBook)

| Atribut               | Nilai                                      |
|-----------------------|--------------------------------------------|
| **Format**            | PDF/UA (accessible) + EPUB 3               |
| **Ukuran halaman PDF**| Sama dengan cetak: 17 × 24 cm             |
| **Hyperlink**         | Aktif — TOC, referensi silang, URL         |
| **Bookmark**          | Otomatis dari H1–H3                        |
| **Metadata PDF**      | Title, Author, Subject, Keywords, Language |
| **Warna layar**       | RGB (tidak perlu konversi CMYK)            |
| **Aksesibilitas**     | Alt-text untuk setiap gambar               |
| **Font rendering**    | Semua font di-embed                        |
| **Resolusi gambar**   | 144–200 DPI (retina-friendly)              |

---

## RINGKASAN CEPAT (QUICK REFERENCE)

```
KERTAS    : B5 (17 × 24 cm) | 70 gsm bookpaper | cover 260 gsm art carton doff
MARGIN    : Atas 2,5 | Bawah 2,5 | Dalam 2,8 | Luar 2,2 (cm)
BODY FONT : Georgia / Source Serif 4 — 12 pt — Justify — 1,3 line spacing
HEADING   : Merriweather Bold — H1:24pt | H2:17pt | H3:13pt
CODE FONT : JetBrains Mono — 10 pt — background #F5F5F5
WARNA     : Primer #2563EB | Aksen #F59E0B | Teks #1A1A1A
CAPTION   : Source Sans 3 Italic — 10 pt — di bawah gambar/di atas tabel
HALAMAN   : Front matter = romawi | Isi = arab, sisi luar
CETAK     : CMYK, PDF/X-4, 300 DPI, font embedded
```

---

*Dokumen ini merupakan panduan gaya resmi untuk Buku Ajar Struktur Data, INSTIKI 2025.*
*Versi: 1.0 | Dibuat: April 2026 | Berlaku sejak: Edisi Pertama*
