# Laporan QA BlankOn Linux: instalasi ISO rilis stable 26.09 "Verbeek"

Tanggal tes: 16 November 2026, 02:40 AM.

Status: **[isi setelah tes]**

## Lingkungan

| | |
|---|---|
| Produk | BlankOn Linux 26.09 (Verbeek)  |
| ISO | `blankon-sinambung-26.09-verbeek-amd64.iso` |
| Sumber ISO | ``https://jahitan.blankonlinux.id/releases/current/blankon-sinambung-26.09-verbeek-amd64.iso`` |
| Nomor jahitan | 20260921-6 |
| Checksum | [isi sha256, jika ada] |
| Host | Asus M1403QA, CachyOS |
| Repo Awal | ``arsip.blankonlinux.id/sinambung`` |

### Spesifikasi VM

| | |
|---|---|
| Hypervisor | VirtualBox 7.2.22 r175245 |
| RAM | 8192MB|
| CPU | 6vCPU |
| Disk | 20GB|
| Firmware | EFI (Secure Boot mati) |
| Video | VMSVGA|
| Jaringan | NAT |

## Alur pengujian

| No | Langkah | Hasil | Catatan |
|---|---|---|---|
| 1 | Fresh install ISO rilis stabil | **PASS** | |
| 2 | `sudo apt update && sudo apt full-upgrade` |**PASS** | |
| 3 | Pindah ke `arsip-dev` |**PASS** | |
| 4 | `sudo apt update && sudo apt install warsi` |**PASS** | |
| 5 | Update sistem lewat Warsi | |  Pemasangan Pemutakhiran dimulai 3:56 AM, proses loncat ke 100% dalam waktu singkat. Namun, beberapa saat kemudian proses berkurang. VM hang pada 4:10 AM (proses 99%). 

Hasil: PASS / PASS dengan catatan / FAIL / TIDAK DITES.

## Pengecekan log error

Dijalankan sekali, setelah update via Warsi (langkah 5) dan reboot.

| `systemctl --failed` | `journalctl -b -p err` | Catatan |
|---|---|---|
| | | |

## Temuan

Belum ada.

## Bukti

| Berkas | Isi |
|---|---|
