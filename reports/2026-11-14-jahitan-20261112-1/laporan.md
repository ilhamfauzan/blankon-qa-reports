# Laporan QA BlankOn Linux: instalasi ISO jahitan harian 20261112-1

Tanggal pengujian: 14 November 2026, 10:00 am.

Penguji: Ilham Fauzan


## Lingkungan

| | |
|---|---|
| Produk | BlankOn Linux 26.0 (Sinambung) |
| ISO | `blankon-live-image-amd64.hybrid.iso`, jahitan harian `20261112-1` |
| Sumber ISO | `http://jahitan.blankonlinux.id/harian/current/` |
| Hypervisor | VirtualBox 7.2.22 r175245 |
| Host | Asus M1403QA, CachyOS |
| Firmware VM | EFI, Secure Boot mati |
| Video | VMSVGA, tanpa akselerasi 3D |
| Jaringan | NAT |


## Ringkasan Percobaan

| Percobaan | RAM | vCPU | Disk | Instalasi | Boot dari disk |
|---|---|---|---|---|---|
| Run 1 | 8192 MB | 6 | 20 GB VDI | DONE| **FAIL**: masuk `grub>` |
| Run 2 | 4096 MB | 6 | 20 GB VHD | DONE | **FAIL**: masuk `grub>` |


## Hasil

| Tahap | Hasil | Catatan |
|---|---|---|
| Boot ISO (EFI) | PASS dengan catatan | Menu berhasil tampil. Di awal ada pesan `boot/grub/splash.png not found`.  |
| Live desktop | PASS |  |  
| Jam| PASS | |
| Calamares: bahasa Indonesia | PASS|  |
| Calamares: daftar bahasa | FAIL (minor) | Bahasa Korea tampil sebagai kotak-kotak (tofu), (bukti 01) |
| Calamares: bahasa Korea dipilih | FAIL (minor) | Seluruh teks Bahasa Korea di installer jadi kotak (bukti 02) |
| Calamares: lokasi dan keyboard | PASS |  |
| Calamares: partisi | PASS |  |
| Calamares: user | PASS |  |
| Calamares: instalasi | PASS |  |
| Restart setelah install| FAIL | Opsi restart dicentang, klik lanjut, lalu layar berhenti di splash logo BlankOn (belum reboot).  |
| Boot dari disk| **FAIL** | Masuk ke `grub>`, tanpa menu dan tanpa pesan error (bukti 03) |

## Temuan

### Temuan 1: Sistem terpasang tidak bisa boot, masuk `grub>`

- **Langkah reproduksi:**
  1. Di VirtualBox buat VM EFI (tanpa Secure Boot), disk baru 20 GB.
  2. Boot dari ISO jahitan `20261112-1`, jalankan Calamares: Indonesia, Jakarta, keyboard Indonesian, partisi erase disk, buat user.
  3. Tunggu instalasi selesai (tanpa error), ceklis opsi mulai ulang, lalu restart.
- **Hasil yang diharapkan:** masuk ke boot manager.
- **Hasil aktual:** masuk ke menu GNU GRUB version 2.14-5, tidak bisa masuk ke sistem.
- **Bukti:** [Gambar 03](bukti/03-grub-prompt-setelah-install.png).

### Temuan 2: Layar restart berhenti di splash BlankOn

- **Gejala:** setelah instalasi selesai dan opsi restart dicentang, layar berhenti di splash logo BlankOn dan tidak ter-restart.

### Temuan 3: Pesan error `syntax error`, `incorrect command`, dan `boot/grub/splash.png not found` saat boot ISO

- Muncul di awal boot live ISO. 
- Bukti: [Gambar 04](bukti/04-splash-not-found.png)

### Temuan 4: Karakter Korea tampil sebagai kotak di Calamares

- **Gejala:** di daftar bahasa, entri "Korean" tampil sebagai kotak. Setelah dipilih, sebagian besar teks installer jadi kotak.
- **Bukti:** [Gambar 01](bukti/01-calamares-daftar-bahasa-korea-tofu.png), [Gambar 02](bukti/02-calamares-bahasa-korea-tofu.png).

## Bukti

| Berkas | Isi |
|---|---|
| [01-calamares-daftar-bahasa-korea-tofu.png](bukti/01-calamares-daftar-bahasa-korea-tofu.png) | Calamares berbahasa Indonesia, entri Korean di daftar bahasa tampil sebagai kotak |
| [02-calamares-bahasa-korea-tofu.png](bukti/02-calamares-bahasa-korea-tofu.png) | Calamares setelah memilih Korea, sebagian besar teks menjadi kotak |
| [03-grub-prompt-setelah-install.png](bukti/03-grub-prompt-setelah-install.png) | Prompt `grub>` (GNU GRUB 2.14-5) setelah instalasi, tidak bisa boot |
[04-splash-not-found.png](bukti/04-splash-not-found.png) | Pesan error sebelum masuk boot option. (Hanya di Live ISO)