# Panduan Setup `my-reference.docx` — Sesuai STYLE_GUIDE.md

Pandoc menggunakan file **reference document** (`my-reference.docx`) untuk menentukan semua aspek visual output DOCX: font, ukuran, warna, margin, spacing, header/footer, dll. File ini adalah **kunci utama** agar output sesuai Style Guide.

---

## Langkah 1: Generate Template Awal

Jika belum ada `my-reference.docx`, generate dari terminal:

```powershell
pandoc -o my-reference.docx --print-default-data-file reference.docx
```

Atau jika sudah pernah menjalankan `build-docx.ps1`, file sudah ada di folder proyek.

---

## Langkah 2: Buka di Microsoft Word & Edit Styles

Buka `my-reference.docx` di **Microsoft Word**, lalu ubah style berikut melalui **Home → Styles → Modify Style**:

### A. Page Layout (Layout → Page Setup)

| Setting              | Nilai                          |
|----------------------|--------------------------------|
| Paper Size           | **Custom: 17 × 24 cm** (B5)   |
| Orientation          | Portrait                       |
| Top Margin           | 2,5 cm                        |
| Bottom Margin        | 2,5 cm                        |
| Inside Margin        | 2,8 cm                        |
| Outside Margin       | 2,2 cm                        |
| Gutter               | 0,3 cm                        |
| Multiple pages       | **Mirror margins**             |

### B. Heading Styles

Klik kanan style → **Modify** → ubah sesuai tabel:

| Style Name       | Font                        | Size  | Color     | Extra                        |
|------------------|-----------------------------|-------|-----------|------------------------------|
| **Heading 1**    | Merriweather Bold           | 24 pt | `#1E3A8A` | Page break before, Space after 24pt |
| **Heading 2**    | Merriweather Bold           | 17 pt | `#2563EB` | Space before 18pt, after 8pt |
| **Heading 3**    | Merriweather SemiBold       | 13 pt | `#1A1A1A` | Space before 12pt, after 6pt |
| **Heading 4**    | Georgia Bold                | 12 pt | `#1A1A1A` | Space before 8pt, after 4pt  |

> **Heading 1 Page Break**: Modify Heading 1 → Format → Paragraph → Line and Page Breaks → ☑ Page break before

### C. Body Text (Normal / First Paragraph / Body Text)

| Style Name       | Font               | Size  | Color     | Extra                              |
|------------------|---------------------|-------|-----------|-----------------------------------|
| **Normal**       | Georgia             | 12 pt | `#1A1A1A` | Justify, Line spacing 1.3, Space after 8pt |
| **First Paragraph** | Georgia          | 12 pt | `#1A1A1A` | Same as Normal, no first-line indent |
| **Body Text**    | Georgia             | 12 pt | `#1A1A1A` | Same as Normal                    |

### D. Code Styles

| Style Name               | Font            | Size    | Color     | Extra                          |
|--------------------------|-----------------|---------|-----------|--------------------------------|
| **Source Code**          | JetBrains Mono  | 10 pt   | `#1A1A1A` | Background `#F5F5F5`, Line spacing 1.4 |
| **Verbatim Char**        | JetBrains Mono  | 10.5 pt | `#C0392B` | Background `#EFEFEF`           |

> Jika JetBrains Mono tidak terinstall, gunakan **Fira Code** atau **Consolas**.

### E. Table Styles

| Style Name              | Font             | Size  | Extra                             |
|-------------------------|------------------|-------|-----------------------------------|
| **Table** (buat custom) | Source Sans 3    | 10 pt | Header bg `#2563EB`, font putih   |

### F. Caption & Footnote

| Style Name       | Font                  | Size | Color     | Extra          |
|------------------|-----------------------|------|-----------|----------------|
| **Caption**      | Source Sans 3 Italic  | 10 pt| `#4B5563` | Center         |
| **Table Caption**| Source Sans 3 Bold    | 10 pt| `#2563EB` | Left, above table |
| **Footnote Text**| Georgia               | 9 pt | `#1A1A1A` |                |

### G. Header & Footer

| Style Name  | Font          | Size | Color     | Extra                   |
|-------------|---------------|------|-----------|-------------------------|
| **Header**  | Source Sans 3 | 9 pt | `#6B7280` | Bottom border 0.5pt `#D1D5DB` |
| **Footer**  | Source Sans 3 | 9 pt | `#6B7280` | Top border 0.5pt `#D1D5DB`    |

### H. Block Quote

| Style Name       | Font            | Size  | Extra                                |
|------------------|-----------------|-------|--------------------------------------|
| **Block Text**   | Georgia Italic  | 11 pt | Indent left & right 1cm             |

### I. TOC Styles

| Style Name | Font               | Size  | Extra         |
|------------|--------------------|-------|---------------|
| **TOC 1**  | Merriweather Bold  | 12 pt | Space before 12pt |
| **TOC 2**  | Georgia            | 11 pt | Indent 0.5cm  |
| **TOC 3**  | Georgia            | 10 pt | Indent 1.0cm  |

---

## Langkah 3: Simpan & Jangan Edit Isinya

Setelah semua style diatur:

1. **Hapus semua teks contoh** dalam dokumen (teks "Heading 1", "Body text", dll.) — atau biarkan saja, Pandoc mengabaikan isi dan hanya membaca style definitions.
2. **Save** file sebagai `my-reference.docx` di folder proyek.
3. **JANGAN** menjalankan bagian script yang auto-copy default (sudah dihapus dari `build-docx.ps1`).

---

## Langkah 4: Install Font yang Diperlukan

Download & install font berikut (gratis dari Google Fonts):

| Font              | URL                                             |
|-------------------|-------------------------------------------------|
| Merriweather      | https://fonts.google.com/specimen/Merriweather  |
| Source Serif 4    | https://fonts.google.com/specimen/Source+Serif+4|
| Source Sans 3     | https://fonts.google.com/specimen/Source+Sans+3 |
| JetBrains Mono    | https://fonts.google.com/specimen/JetBrains+Mono|

Georgia sudah terinstall di Windows secara default.

---

## Langkah 5: Jalankan Build

```powershell
.\build-docx.ps1
```

Output akan ada di folder `.\output\`.

---

## Apa yang Dikontrol Reference Doc vs Pandoc Options

| Aspek                        | Dikontrol Oleh              |
|------------------------------|-----------------------------|
| Font, size, color            | `my-reference.docx` styles  |
| Margin, page size            | `my-reference.docx` layout  |
| Line spacing, paragraph spacing | `my-reference.docx` styles |
| Header & footer              | `my-reference.docx`         |
| Syntax highlighting colors   | `style/syntax.theme`        |
| Table of Contents generation | `build-docx.ps1` (`--toc`)  |
| Callout/admonition boxes     | `filters/callout.lua`       |
| Image/resource paths         | `build-docx.ps1` (`--resource-path`) |

---

## Tips

- Setiap kali ingin mengubah tampilan, edit `my-reference.docx` di Word, lalu re-run script.
- Untuk preview cepat satu bab saja: `pandoc Bab_01_Pengantar_Struktur_Data.md --reference-doc=my-reference.docx --highlight-style=style/syntax.theme -o test.docx`
- Git-track `my-reference.docx` supaya tim bisa pakai style yang sama.
