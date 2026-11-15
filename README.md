# blankon-qa

Catatan dan laporan pengujian QA untuk BlankOn Linux.

## Isi

- [template-laporan-qa.md](template-laporan-qa.md): template laporan QA.
- [test-cases-detail.md](test-cases-detail.md): kasus tes detail dengan langkah dan hasil yang diharapkan.

## Temuan

Ringkasan bug dari semua laporan. Detail, langkah reproduksi, dan bukti ada di laporan masing-masing.

| No | Temuan | Tingkat | Jahitan dan lingkungan | Frekuensi | Laporan | Issue |
|---|---|---|---|---|---|---|
| 1 | Pesan `syntax error`, `incorrect command`, dan `boot/grub/splash.png not found` saat boot ISO | Minor | `20261112-1` dan `20261113-1`, mode EFI (VirtualBox dan VMware). Tidak muncul di BIOS | Setiap boot ISO mode EFI | [20261112-1](reports/2026-11-14-jahitan-20261112-1/laporan.md) (Temuan 3) | Belum dibuat |
| 2 | Aksara Korea tampil sebagai kotak di Calamares (sesi live) | Minor | `20261112-1`, VirtualBox EFI | Setiap kali bahasa Korea dipilih | [20261112-1](reports/2026-11-14-jahitan-20261112-1/laporan.md) (Temuan 4) | Belum dibuat |
| 3 | Aksara Korea tampil sebagai kotak di Firefox dan panel (`fc-list :lang=ko` kosong, tanpa `fonts-noto-cjk`) | Minor | `20261113-1`, VirtualBox (sistem terpasang) | Pada teks yang memakai font sistem. Dites di satu instalasi | [20261113-1](reports/2026-11-14-jahitan-20261113-1/laporan.md) (Temuan 3) | Belum dibuat |
