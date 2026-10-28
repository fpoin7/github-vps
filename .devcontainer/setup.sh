#!/bin/bash
# Setup terima jadi untuk Codespace Kali.
# Dijalankan otomatis sekali saat Codespace pertama dibuat (postCreateCommand).
# Aman dijalankan ulang: apt akan melewati paket yang sudah terpasang.
set -u

echo "== Update paket =="
apt-get update || echo "PERINGATAN: apt update gagal, lanjut ke instalasi."

echo "== Instal tool inti =="
# Daftar inti dari repo asli, tanpa paket GUI/berat (zaproxy, wireshark GUI, kismet).
# Jika satu paket tidak tersedia di Kali rolling, instalasi paket lain tetap jalan.
apt-get install -y --no-install-recommends \
  git curl wget build-essential python3 python3-pip \
  neofetch htop nano \
  nmap whois dnsutils \
  sqlmap nikto \
  hashcat john hydra \
  tcpdump binwalk gdb radare2 \
  || echo "PERINGATAN: sebagian paket gagal terpasang, cek daftar di bawah."

echo "== Verifikasi =="
for tool in nmap sqlmap nikto hashcat john hydra tcpdump binwalk gdb; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "OK  $tool"
  else
    echo "GAGAL  $tool"
  fi
done

echo "== Selesai =="
echo "Coba: neofetch ; nmap --version ; pwd ; whoami"
