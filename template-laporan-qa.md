<!--
Template laporan QA BlankOn Linux (draf).
Struktur mengacu ke laporan joyboyid/qa-blankOn dan QualityAssurance/Reports/ di BlankOn/blankon-linux.
Cara pakai: salin isi ini ke GitHub Issue baru di BlankOn/blankon-linux, isi semua <...>, hapus komentar.
Judul issue: QA Report <YYYY-MM-DD> <nama-jahitan>
-->

### BlankOn Linux QA Report: <YYYY-MM-DD>-<nama-jahitan>

Penguji: <nama> (<email atau handle GitHub>)

| Passed | Failed | Tidak dites | On test |
| :----: | :----: | :---------: | :-----: |
|   0    |   0    |      0      |    0    |

## Lingkungan

| | |
|---|---|
| Tanggal tes | <tanggal> |
| Produk | BlankOn Linux <versi> (<nama rilis>) |
| ISO | <nama berkas ISO> |
| Sumber ISO | <URL / zsync, dan tanggal Last-Modified> |
| Checksum | <sha256, jika ada> |
| Mesin | <VM atau hardware; hypervisor + versi> |
| Firmware | <BIOS / EFI / EFI + Secure Boot> |
| Spesifikasi | <RAM, vCPU, disk, jaringan> |
| Kernel | <uname -r> |
| Repo APT | <arsip / arsip-dev> |

Keluaran `cat /etc/os-release`:

```
<tempel di sini>
```

## Ringkasan

<2-4 kalimat: ISO bisa di-boot? Bisa diinstal? Bisa dipakai? Apa yang gagal?>

## Hasil tes

Isi kolom Hasil dengan PASS, FAIL, atau TIDAK DITES (sertakan alasan).

### 1. Boot live

| ID | Kasus | Hasil | Catatan |
|---|---|---|---|
| 1.1 | ISO terbaca, menu boot tampil | | |
| 1.2 | Live sampai desktop | | |
| 1.3 | Tidak ada error sebelum splash | | |
| 1.4 | Resolusi, mouse, keyboard | | |

### 2. Live: desktop dan aplikasi

| ID | Kasus | Hasil | Catatan |
|---|---|---|---|
| 2.1 | Menu, font, bahasa, layout keyboard | | |
| 2.2 | Jam dan zona waktu | | |
| 2.3 | Terminal, file manager, pengaturan | | |
| 2.4 | Jaringan: IP, ping, browser | | |

### 3. Instalasi (Calamares)

| ID | Kasus | Hasil | Catatan |
|---|---|---|---|
| 3.1 | Install online, erase disk | | |
| 3.2 | Install offline | | |
| 3.3 | Mode BIOS dan/atau EFI | | |
| 3.4 | Reboot ke sistem terpasang | | |

### 4. Sistem terpasang

| ID | Kasus | Hasil | Catatan |
|---|---|---|---|
| 4.1 | Login, sudo, hostname | | |
| 4.2 | Desktop Praya dan GNOME | | |
| 4.3 | Aplikasi utama | | |
| 4.4 | Hardware dan driver (wifi, audio, dll.) | | |

### 5. Update paket

Mengacu ke `QualityAssurance/PackageUpdates.md`.

| ID | Kasus | Hasil | Catatan |
|---|---|---|---|
| 5.1 | `sudo apt update` tanpa NO_PUBKEY | | |
| 5.2 | `sudo apt full-upgrade` selesai | | |
| 5.3 | Perintah upgrade dari "Diff against arsip-dev" sukses | | |
| 5.4 | Reboot setelah upgrade | | |

## Daftar FAIL

Satu blok per FAIL. Buat issue terpisah untuk tiap bug dan link di sini.

### FAIL-1: <judul singkat>

- **ID kasus:** <mis. 2.2>
- **Mode:** <live / terpasang>
- **Issue bug:** <link ke issue, atau "belum dibuat">
- **Langkah reproduksi:**
  1. <langkah>
  2. <langkah>
- **Hasil yang diharapkan:** <...>
- **Hasil aktual:** <...>
- **Frekuensi:** <selalu / kadang / sekali>
- **Bukti:** <screenshot / log; tempel atau seret ke issue>

## Tidak dites

| ID | Alasan |
|---|---|
| <ID> | <mis. belum sempat, perlu hardware lain> |

## Bukti

| Berkas | Isi |
|---|---|
| <nama berkas> | <keterangan> |
