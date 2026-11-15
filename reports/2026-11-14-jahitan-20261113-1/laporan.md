# Laporan QA BlankOn Linux: instalasi ISO jahitan harian 20261113-1

Tanggal tes: 14 November 2026

Status: **PASS di VMware (BIOS dan EFI). Di VirtualBox tidak konsisten: percobaan 1 FAIL, percobaan 2 PASS (BIOS dan EFI).**

- Di VirtualBox percobaan 1, restart setelah Calamares berhenti di splash BlankOn dan VM perlu di-force close (BIOS dan EFI).
- Setelah force close, EFI masuk prompt `grub>`, di BIOS boot normal.
- Percobaan 2 (disk baru, tanpa force close) lancar sampai login di BIOS dan EFI.

## Ringkasan per lingkungan

| Hypervisor | Firmware | Restart via Calamares setelah install | Boot dari disk |
|---|---|---|---|
| VirtualBox 7.2.22 r175245 | EFI (percobaan 1) | **FAIL**: stuck di splash, vm perlu di force close | **FAIL**: stuck di `grub>` |
| VirtualBox 7.2.22 r175245 | EFI (percobaan 2) | **PASS**  | **PASS**  |
| VirtualBox 7.2.22 r175245 | BIOS (percobaan 1) | **FAIL**: stuck di splash, vm perlu di force close | **PASS** (setelah force close) |
| VirtualBox 7.2.22 r175245 | BIOS (percobaan 2) | **PASS** | **PASS** |
| VMware Workstation 26.0.1.25688693 | BIOS | **PASS**| **PASS**  |
| VMware Workstation 26.0.1.25688693 | EFI | **PASS**| **PASS** |

## Lingkungan

| | |
|---|---|
| Produk | BlankOn Linux 26.0 (Sinambung) |
| ISO | `blankon-live-image-amd64.hybrid.iso`, jahitan harian `20261113-1` |
| Sumber ISO | Jahitan harian (`jahitan.blankonlinux.id/harian/`) |
| Host | Asus M1403QA, CachyOS |
| Repo | arsip-dev|

### Spesifikasi VM

| | VirtualBox | VMware Workstation |
|---|---|---|
| Versi | 7.2.22 r175245 | 26.0.1.25688693 |
| RAM | 4096 MB | 4096 MB |
| CPU | 6 vCPU | 4 prosesor x 2 core (total 8) |
| Disk | 20 GB VHD | 20 GB (.vmdk) |
| Firmware | EFI (Secure Boot mati) dan BIOS, dites terpisah | BIOS dan EFI (Secure Boot mati), dites terpisah.   |
| Video | VMSVGA, no 3D acceleration | Autodetect, no 3D acceleration |
| Jaringan | NAT | NAT |

## Hasil Live Boot

| Tahap | VirtualBox EFI | VirtualBox BIOS | VMware BIOS | VMware EFI |
|---|---|---|---|---|
| Boot ISO dan live desktop | **PASS dengan catatan**: pesan `splash.png not found` muncul di awal| **PASS**| **PASS**| **PASS dengan catatan**: pesan `splash.png not found` muncul di awal |
| Restart setelah install | Percobaan 1 **FAIL**, percobaan 2 **PASS** | Percobaan 1 **FAIL**, percobaan 2 **PASS** | **PASS** | **PASS** |
| Boot dari disk | Percobaan 1 **FAIL** (`grub>`), percobaan 2 **PASS** | Percobaan 1 **PASS** (setelah force close), percobaan 2 **PASS** (tanpa force close) | **PASS** | **PASS** |

## Hasil sistem terpasang

| Tes | VirtualBox BIOS | VMware BIOS | VMware EFI | VirtualBox EFI |
|---|---|---|---|---|
| Login | **PASS** | **PASS** | **PASS** | **PASS** (percobaan 2) |
| Kernel | `7.3.3+deb14-amd64` | `7.3.3+deb14-amd64` |`7.3.3+deb14-amd64` | `7.3.3+deb14-amd64` |
| `/etc/os-release` (BlankOn Linux 26.0 Sinambung)| **PASS** | **PASS** | **PASS** | **PASS** |
| Zona waktu (`Asia/Jakarta`, NTP sinkron)| **PASS** | **PASS** | **PASS** | **PASS** |
| `systemctl --failed` | **PASS** (0 unit) | **PASS** (0 unit) | **PASS** 0 unit | **PASS** 0 unit |
| Jaringan (`ping -c 3 blankonlinux.id`) | **PASS** (0% loss) | **PASS** (0% loss) | **PASS** 0 loss | **PASS** 0% loss |
| `journalctl -b -p err` | **PASS dengan catatan**: 1 error `app-gnome-tilingshell-extension-update` gagal start, tidak ada dampak terlihat (bukti 01) | PASS | PASS | - |
| Terminal | **PASS** | **PASS** | **PASS** | **PASS** |
| Firefox | **PASS** | **PASS** | **PASS** | **PASS**|
| File manager | **PASS** | **PASS** | **PASS** | **PASS** |
| Restart dari menu power | **PASS** | **PASS**| - | **PASS** |
| `sudo apt update && sudo apt upgrade`| **PASS**| **PASS**| - | PASS |
| Praya dan keyring | **PASS** | **PASS** | **PASS** | **PASS** |

`-` berarti belum dites.

## Temuan

### Temuan 1: Di VirtualBox, restart berhenti di splash BlankOn dan VM tidak merespons (mayor)

- **Frekuensi:** intermiten. Terjadi di percobaan 1 (BIOS dan EFI), tidak terjadi di percobaan 2 dan di VMware.
- **Gejala:** setelah instalasi selesai, centang opsi mulai ulang, klik selesai. layar berhenti di splash logo BlankOn.
- **Hasil yang diharapkan:** sistem restart, booting via disk.
- **Bukti:** [02-virtualbox-stuck-splash-blankon.png](bukti/02-virtualbox-stuck-splash-blankon.png).

### Temuan 2: Di VirtualBox mode EFI, boot dari disk masuk `grub>`

- **Frekuensi:** percobaan 1 jahitan ini, dan 2 dari 2 pada jahitan `20261112-1`. Tidak terjadi di percobaan 2, VirtualBox BIOS, maupun VMware EFI.
- **Hasil yang diharapkan:** menu GRUB, lalu login.
- **Hasil aktual:** prompt `grub>` tanpa menu.
- **Bukti:** [03-virtualbox-efi-grub-prompt.png](bukti/03-virtualbox-efi-grub-prompt.png) (GNU GRUB 2.14-5).

### Temuan 3: Aksara Korea tampil sebagai kotak di Firefox dan panel (minor)

- **Frekuensi:** terjadi pada teks yang memakai font sistem. Tidak terjadi di semua situs, kasus di www.korean.go.kr tampil normal.
- **Langkah reproduksi:**
  1. Buka Firefox, lalu buka youtube.com dan cari kata berbahasa Korea (misalnya "트와이스"), atau buka www.korean.go.kr.
  2. Lihat konten website, aksara korea tampil kotak-kotak.
- **Hasil yang diharapkan:** aksara Korea tampil sebagai huruf Hangul.
- **Hasil aktual:** tampil sebagai kotak (tofu) di judul tab, judul jendela di panel, dan konten website. Isi halaman korean.go.kr tampil normal.
- **Cek:** `fc-list :lang=ko` kosong, jadi tidak ada font yang mendukung Korea. Paket `fonts-noto-*` terpasang (`core`, `extra`, `mono`, `ui-core`, `color-emoji`), tapi tidak ada `fonts-noto-cjk`, `fonts-nanum`, maupun `fonts-unfonts`.
- **Bukti:** [04](bukti/04-firefox-youtube-korea-tofu.png), [05](bukti/05-firefox-korean-go-kr-judul-tofu.png), [06](bukti/06-fc-list-lang-ko-kosong.png). Gejala terjadi pada jahitan harian 20261112-1.

## Bukti

| Berkas | Isi |
|---|---|
| [01-virtualbox-bios-terminal-sistem-terpasang.webp](bukti/01-virtualbox-bios-terminal-sistem-terpasang.webp) | VirtualBox BIOS: `uname`, `os-release`, `timedatectl`, `systemctl --failed`, ping, `journalctl -p err` |
| [02-virtualbox-stuck-splash-blankon.png](bukti/02-virtualbox-stuck-splash-blankon.png) | VirtualBox: layar berhenti di splash BlankOn setelah restart dari Calamares |
| [03-virtualbox-efi-grub-prompt.png](bukti/03-virtualbox-efi-grub-prompt.png) | VirtualBox EFI: prompt `grub>` setelah boot dari disk |
| [04-firefox-youtube-korea-tofu.png](bukti/04-firefox-youtube-korea-tofu.png) | Firefox di YouTube: aksara Korea jadi kotak di pencarian, tab, dan panel |
| [05-firefox-korean-go-kr-judul-tofu.png](bukti/05-firefox-korean-go-kr-judul-tofu.png) | Firefox di korean.go.kr: isi halaman normal, judul tab dan panel kotak |
| [06-fc-list-lang-ko-kosong.png](bukti/06-fc-list-lang-ko-kosong.png) | `fc-list :lang=ko` kosong, paket `fonts-noto-*` terpasang tanpa CJK |
