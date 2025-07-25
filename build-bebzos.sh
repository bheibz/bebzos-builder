#!/bin/bash
set -e

echo "🔧 Membuat folder kerja BebzOS..."
mkdir -p build
cd build

echo "📦 Install live-build..."
sudo apt update && sudo apt install -y live-build debootstrap

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
cp -r ../config/* config/

echo "🏗️ Mulai proses build ISO..."
sudo lb build

echo "✅ Build selesai! Cek hasilnya di bawah 👇"
ls -lh live-image-*.iso