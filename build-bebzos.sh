#!/bin/bash
set -e

echo "🔧 Membuat folder kerja BebzOS..."
mkdir -p build
cd build



echo "⚙️ Setup konfigurasi dasar Debian XFCE..."
lb config \
  --distribution bookworm \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer live \
  --binary-images iso-hybrid \
  --bootappend-live "boot=live components quiet splash" \
  --mirror-bootstrap http://deb.debian.org/debian/ \
  --mirror-binary http://deb.debian.org/debian/

echo "📁 Menyalin konfigurasi tambahan..."
if [ -d ../config ] && [ "$(ls -A ../config)" ]; then
  cp -r ../config/* config/
else
  echo "⚠️  Folder ../config tidak ditemukan atau kosong, melewati penyalinan konfigurasi."
fi

echo "🏗️ Mulai proses build ISO..."
sudo lb build

echo "✅ Build selesai! Cek hasilnya di bawah 👇"
ls -lh live-image-*.iso