<!--
Kasus tes detail BlankOn Linux (draf), pelengkap template-laporan-qa.md.
Setiap kasus: Langkah + Hasil diharapkan. Hasil dicatat di tabel laporan: PASS / FAIL / TIDAK DITES.
Sumber ide: blueprint joyboyid/qa-blankOn, QualityAssurance/*.md di BlankOn/blankon-linux,
dan bug nyata di issue blankon-linux #145-#150 (jadi tes regresi).
Prioritas: P1 wajib, P2 penting, P3 tambahan jika sempat.
Aturan umum: kalau FAIL, simpan screenshot dan keluaran perintah, lalu buat satu issue per masalah.
-->

# Kasus tes detail

## A. Persiapan (sekali per jahitan)

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| A.1 P1 | Verifikasi ISO | Unduh via zsync atau langsung, lalu `sha256sum <iso>` dan catat Last-Modified | Berkas utuh, ukuran wajar, tanggal sesuai jahitan yang dites |
| A.2 P1 | Tulis ke media nyata (jika bukan VM) | Tulis ISO ke USB dengan `dd` atau balenaEtcher, boot dari USB | USB bisa boot, tidak ada error baca media |
| A.3 P2 | Snapshot VM | Ambil snapshot sebelum install | Bisa kembali ke kondisi bersih untuk tes ulang |

## B. Boot dan firmware

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| B.1 P1 | Boot BIOS (legacy) | VM dengan EFI mati, boot dari ISO | Menu boot tampil, live sampai desktop |
| B.2 P1 | Boot UEFI | VM dengan EFI hidup, boot dari ISO | Sama seperti B.1, tanpa error GRUB |
| B.3 P1 | Boot UEFI + Secure Boot | EFI + Secure Boot hidup. Di live: `mokutil --sb-state`, `cat /sys/kernel/security/lockdown`, `sudo dmesg \| grep -i secure` | Boot lewat GRUB, "SecureBoot enabled", lockdown menunjukkan mode aktif, kernel melaporkan lockdown |
| B.4 P2 | Menu boot | Pilih tiap entri di menu boot (live, mode aman, dll. jika ada) | Tiap entri bisa dimuat, tidak ada entri rusak |
| B.5 P2 | Waktu boot | Catat waktu dari menu boot sampai desktop siap | Wajar (catat angkanya, bandingkan antar jahitan) |
| B.6 P3 | Boot di hardware nyata | Boot USB di laptop/PC sungguhan | Sama seperti B.2, plus hardware terdeteksi |

## C. Live session

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| C.1 P1 | Desktop muncul | Tunggu sampai desktop | Praya/GNOME tampil, tidak layar hitam atau loop login |
| C.2 P1 | Zona dan jam | Lihat jam panel, jalankan `timedatectl` | Jam sesuai zona; jika UTC, catat sebagai temuan (diketahui sebelumnya di live) |
| C.3 P1 | Bahasa dan keyboard | Ketik huruf, angka, `- / ' "` di terminal | Teks terbaca, layout Indonesia bukan Arabic/Jawi |
| C.4 P2 | Branding | Buka Pengaturan > Tentang, lihat splash dan login | Logo dan nama BlankOn, bukan logo Debian |
| C.5 P2 | Jaringan | `ip -br a`, `ping -c 3 blankonlinux.id`, buka situs di browser | Dapat IP, ping sukses, situs terbuka |
| C.6 P2 | Jaringan terputus | Matikan jaringan lalu nyalakan lagi dari menu desktop | Status berubah benar, tersambung kembali tanpa restart |
| C.7 P2 | Browse jaringan (regresi #145) | Buka Nautilus > Jaringan, lalu `journalctl -b --no-pager \| grep -i wsdd` | Tidak ada banjir error wsdd, daftar jaringan tidak mati |

## D. Instalasi (Calamares)

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| D.1 P1 | Erase disk, online | Install normal dengan internet, Bahasa Indonesia, zona Asia/Jakarta | Selesai tanpa error, bisa reboot |
| D.2 P1 | Erase disk, offline | Cabut jaringan sebelum install | Selesai tanpa error, tidak macet menunggu jaringan |
| D.3 P1 | Install di BIOS | Ulangi D.1 dengan EFI mati | Sistem boot dari disk di mode BIOS |
| D.4 P1 | Install di UEFI | Ulangi D.1 dengan EFI hidup | Entri boot `BlankOn` terbentuk, boot sukses |
| D.5 P1 | Install di UEFI + Secure Boot | Ulangi D.1 dengan Secure Boot hidup, lalu `mokutil --sb-state` | Install selesai, boot pertama sukses, "SecureBoot enabled" |
| D.6 P2 | Installer Bahasa Inggris | Pilih English di installer | Teks terbaca, hasil install berbahasa Inggris |
| D.7 P2 | Pilihan bahasa | Buka daftar bahasa di installer | Tidak ada karakter kotak/simbol tak terbaca |
| D.8 P2 | Partisi manual | Buat `/` dan swap secara manual | Install sukses, `lsblk` sesuai rancangan |
| D.9 P2 | Swap | Setelah install: `swapon --show`, `free -h` | Swap aktif sesuai pilihan (partisi atau file) |
| D.10 P2 | Disk kecil | Install di disk 20 GB | Berhasil, atau pesan galat jelas jika tidak muat |
| D.11 P2 | RAM minimum | Install dengan RAM 2 GB | Berhasil, tidak OOM |
| D.12 P2 | Validasi isian | Kosongkan nama/password, pakai password lemah, hostname tidak valid | Installer menolak dengan pesan jelas |
| D.13 P3 | Enkripsi disk (jika tersedia) | Aktifkan opsi enkripsi, install, boot | Diminta passphrase saat boot, sistem jalan |
| D.14 P3 | Dual boot | Install berdampingan dengan OS lain (VM berisi Windows/Linux) | Kedua OS muncul di menu boot, keduanya bisa boot |
| D.15 P1 | Log jika gagal | Jalankan `sudo calamares -D8 \| sudo tee ~/calamares.log` | Log tersimpan untuk dilampirkan di issue |

## E. Sistem terpasang: boot dan sesi

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| E.1 P1 | Boot pertama | Lepas ISO, boot ulang | GRUB/boot langsung, tidak berhenti di emergency/initramfs |
| E.2 P1 | Login | Login dengan user dari installer | Desktop muncul, `sudo -v` menerima password |
| E.3 P1 | Identitas sistem | `cat /etc/os-release`, `hostnamectl` | Nama BlankOn, versi, hostname sesuai isian |
| E.4 P1 | Zona dan jam | `timedatectl` | Sesuai zona yang dipilih saat install |
| E.5 P1 | Praya saat boot (regresi #150) | `systemctl --user status praya.service`, `journalctl --user -b \| grep -i -e praya -e "cannot open display"` | Service aktif, tidak ada "cannot open display" atau jeda panjang saat login |
| E.6 P2 | Keyring (regresi #146) | Login, lalu `journalctl -b \| grep -i gkr` | Tidak ada "unable to locate daemon control file", keyring terbuka otomatis |
| E.7 P2 | PAM (regresi #149) | `journalctl -b \| grep -i pam` | Tidak ada peringatan konfigurasi PAM yang ditolak setiap sesi |
| E.8 P2 | Override GNOME (regresi #147) | `journalctl --user -b \| grep -i -e xwayland -e "experimental feature"` | Tidak ada pesan "Unknown experimental feature" tiap sesi |
| E.9 P2 | Galat umum | `journalctl -b -p err --no-pager`, `systemctl --failed` | Tidak ada unit gagal; catat error yang berulang |
| E.10 P2 | Wayland dan Xorg | Login ke sesi Wayland lalu sesi Xorg (pilih di login screen) | Keduanya masuk desktop, aplikasi jalan di keduanya |
| E.11 P2 | Logout dan login ulang | Logout, login lagi 3 kali | Tidak ada loop login atau crash sesi |
| E.12 P2 | Mematikan Praya | `gnome-extensions list`, lalu `gnome-extensions disable <uuid-praya>` | UUID sesuai dokumentasi; jika tidak ada, catat UUID sebenarnya |

## F. Desktop Praya dan GNOME

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| F.1 P1 | Panel dan menu | Buka menu aplikasi, aktivitas, panel | Terbuka cepat, tidak ada elemen terpotong |
| F.2 P2 | Kalender | Hover/klik kalender di panel | Tidak men-trigger widget lain |
| F.3 P2 | Garis semu di panel | Perhatikan tengah bar GNOME | Tidak ada batas/garis aneh |
| F.4 P2 | Peluncur aplikasi | Buka aplikasi lewat Praya dan lewat launcher GNOME | Semua aplikasi terbuka dari kedua jalur (regresi #108) |
| F.5 P2 | Multi-workspace | Buat 2+ workspace, pindahkan jendela | Berfungsi, tidak ada glitch render |
| F.6 P2 | Tema dan ikon | Buka aplikasi GTK3, GTK4, dan aplikasi lama | Tema konsisten, tidak ada ikon hilang |
| F.7 P2 | Layar kunci | Atur latar di Pengaturan, kunci layar (Super+L) | Latar kunci sesuai pengaturan, buka kunci sukses |
| F.8 P2 | Notifikasi | `notify-send "tes" "isi"` | Muncul, bisa ditutup |
| F.9 P3 | Pembaruan Praya saat berjalan | Update paket praya saat desktop aktif | Render tidak rusak setelah update |
| F.10 P3 | Pengaturan penuh | Buka tiap panel Pengaturan | Semua terbuka, tidak ada crash |

## G. Hardware dan driver

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| G.1 P1 | Wifi | Cari jaringan, sambung WPA2, `ping`, putus lalu sambung lagi | Daftar jaringan muncul, tersambung, tersambung ulang tanpa restart |
| G.2 P2 | Ethernet | Colok kabel | Dapat IP otomatis |
| G.3 P2 | Bluetooth | Pasangkan perangkat (mouse/headset) | Terdeteksi, terhubung, berfungsi |
| G.4 P1 | Audio | Putar audio, atur volume, ganti output | Suara keluar, slider bekerja, headset terdeteksi |
| G.5 P2 | Mikrofon | Rekam suara di Pengaturan atau aplikasi | Level masuk, rekaman terdengar |
| G.6 P2 | Webcam | Buka aplikasi kamera | Video tampil |
| G.7 P1 | Layar dan resolusi | Ganti resolusi, skala (100%/150%/200%), rotasi | Berubah benar, tidak pecah |
| G.8 P2 | Monitor eksternal | Colok HDMI/DP, mode mirror dan extend | Terdeteksi, pengaturan diingat |
| G.9 P2 | Touchpad | Klik, scroll dua jari, gestur | Berfungsi |
| G.10 P2 | Kecerahan dan tombol Fn | Ubah kecerahan, volume lewat tombol Fn | Berfungsi |
| G.11 P1 | Suspend dan resume | Suspend, lalu bangunkan | Kembali ke sesi, jaringan dan audio masih bekerja |
| G.12 P2 | Tutup laptop (lid) | Tutup layar, buka kembali | Suspend/resume sesuai pengaturan |
| G.13 P2 | Baterai dan daya | Lihat indikator, ganti mode daya | Persen akurat, mode daya berubah |
| G.14 P2 | USB | Colok flashdisk, salin berkas, eject | Otomatis ter-mount, salin sukses, eject aman |
| G.15 P2 | Printer | Tambah printer (atau PDF printer), cetak halaman uji | Terdeteksi dan mencetak |
| G.16 P3 | GPU ganda | Di laptop dengan dGPU, cek `lspci -k \| grep -A3 VGA`, pantau konsumsi daya | Driver terpasang; catat konsumsi saat idle (lihat issue #148) |
| G.17 P3 | Fingerprint | Daftarkan sidik jari (jika ada sensor) | Terdaftar, bisa dipakai login |
| G.18 P2 | Shutdown dan reboot | Matikan dan nyalakan ulang dari menu | Tidak hang, tidak ada pesan error saat mati |

## H. Aplikasi utama

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| H.1 P1 | Browser | Buka 3 tab termasuk video, unduh berkas | Lancar, unduhan ada di folder Unduhan |
| H.2 P1 | LibreOffice | Writer: ketik paragraf, simpan `.odt` dan `.docx`, buka lagi; Calc: isi sel, rumus `=SUM()` | Tersimpan, terbuka kembali, rumus benar |
| H.3 P2 | Media | Putar audio dan video berbagai format (mp3, mp4, ogg) | Terputar, codec tersedia |
| H.4 P2 | Gambar dan PDF | Buka JPG, PNG, PDF | Tampil benar |
| H.5 P2 | File manager | Salin, pindah, hapus, ganti nama, buka ZIP | Berfungsi; berkas terhapus masuk Tempat Sampah |
| H.6 P2 | Terminal | Buka, jalankan perintah, salin-tempel, tab baru | Berfungsi, font terbaca |
| H.7 P2 | Pengelola perangkat lunak | Cari dan pasang aplikasi lewat GUI | Daftar muncul, instal berhasil |
| H.8 P2 | Flatpak/Snap (jika ada) | Pasang satu aplikasi dari Flathub | Terpasang dan jalan |
| H.9 P2 | Penangkap layar dan perekam | Ambil screenshot dan rekam layar | Berkas tersimpan |
| H.10 P2 | Ikon menu | Klik semua ikon di menu aplikasi | Semua membuka sesuatu, tidak ada ikon "missing" |
| H.11 P3 | Font | Buka teks Indonesia, simbol, emoji | Tidak ada kotak (tofu) |

## I. Paket dan update

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| I.1 P1 | Repo | `cat /etc/apt/sources.list /etc/apt/sources.list.d/*`, `sudo apt update` | Sumber ke arsip BlankOn, tanpa NO_PUBKEY dan error TLS |
| I.2 P1 | Upgrade stabil | `sudo apt full-upgrade`, lalu reboot | Selesai tanpa paket rusak, sistem tetap boot |
| I.3 P1 | Pengujian paket baru | Di packages.blankonlinux.id: tab arsip.blankonlinux.id > Diff against arsip-dev > Copy upgrade command, jalankan | Semua perintah berhasil |
| I.4 P1 | Pindah ke arsip-dev | Ubah sumber APT ke `arsip-dev`, lalu `sudo apt update && sudo apt full-upgrade` | Berhasil; tulis paket yang berubah |
| I.5 P2 | Paket rusak | `sudo apt -f install`, `dpkg --audit` | Tidak ada paket setengah terpasang |
| I.6 P2 | Pasang dan hapus | `sudo apt install vlc`, jalankan, lalu `sudo apt remove --purge vlc`, `sudo apt autoremove` | Terpasang, jalan, terhapus bersih |
| I.7 P2 | Paket khas BlankOn | `apt policy praya`, cek versi | Versi sesuai rilis, berasal dari arsip BlankOn |
| I.8 P2 | Instalasi dari .deb | Unduh .deb (mis. paket pihak ketiga), `sudo apt install ./berkas.deb` | Dependensi terpenuhi otomatis |
| I.9 P3 | Pembaruan keamanan | Jika ada pembaruan kritis, konsultasi tim OpSec sebelum menguji | Sesuai arahan tim OpSec |

## J. Lokalisasi dan branding

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| J.1 P1 | Bahasa Indonesia | Pilih Indonesia di installer dan Pengaturan Wilayah | Menu dan aplikasi inti berbahasa Indonesia, tidak campur aksara Jawi/Arab |
| J.2 P2 | Bahasa Inggris | Ganti ke English, login ulang | Semua berubah, tidak ada teks Indonesia nyasar |
| J.3 P2 | Layout keyboard | Tambah layout lain, ganti dengan pintasan | Berpindah benar, indikator di panel sesuai |
| J.4 P2 | Branding | Logo di Tentang, GDM, Plymouth, wallpaper default | Semua BlankOn, bukan Debian |
| J.5 P3 | Format tanggal dan mata uang | Atur Wilayah ke Indonesia | Format sesuai (dd/mm/yyyy, Rp) |

## K. Keamanan dasar dan kinerja

| ID | Kasus | Langkah | Hasil diharapkan |
|---|---|---|---|
| K.1 P2 | Firewall | `sudo ufw status` atau `sudo nft list ruleset` | Status jelas; catat apakah aktif atau tidak |
| K.2 P2 | Port terbuka | `ss -tulpn` | Tidak ada layanan tak dikenal yang terbuka ke luar |
| K.3 P2 | Pengguna dan sudo | `sudo -l`, cek tidak ada akun default tanpa password | Sesuai ekspektasi |
| K.4 P3 | Pemakaian awal | Setelah login, `free -h`, `top`/`htop`, `df -h` | RAM idle wajar (catat angka) |
| K.5 P3 | Disk | `df -h /`, `lsblk` | Ukuran dan sistem berkas sesuai pilihan |

## L. Bukti jika ada FAIL

Jalankan di guest dan lampirkan hasilnya ke issue:

```bash
mkdir -p ~/qa-bukti && cd ~/qa-bukti
cat /etc/os-release > os-release.txt
uname -a > uname.txt
journalctl -b --no-pager > journal-boot.txt
journalctl -b -p err --no-pager > journal-err.txt
systemctl --failed > systemctl-failed.txt
dpkg -l > dpkg-list.txt
lspci -k > lspci.txt
lsusb > lsusb.txt
tar czf ~/qa-bukti.tar.gz -C ~ qa-bukti
```

Jangan lampirkan password, token, atau data pribadi. Periksa dulu isi berkasnya.
