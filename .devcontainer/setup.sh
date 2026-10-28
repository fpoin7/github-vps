#!/bin/bash
# Setup terima jadi untuk Codespace Kali.
# Dijalankan otomatis sekali saat Codespace pertama dibuat (postCreateCommand).
# Aman dijalankan ulang: apt akan melewati paket yang sudah terpasang.
set -u

echo "== Update paket =="
apt-get update || echo "PERINGATAN: apt update gagal, lanjut ke instalasi."

echo "== Instal tool inti =="
# Daftar inti dari repo asli, tanpa paket GUI/berat (zaproxy, wireshark GUI, kismet).
# neofetch DIHAPUS 2026-10-28: terbukti tidak tersedia di Kali Rolling 2026.3 dan
# satu paket yang hilang membatalkan seluruh transaksi apt, sehingga semua tool gagal.
apt-get install -y --no-install-recommends \
  git curl wget build-essential python3 python3-pip \
  htop nano \
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
echo "Coba: nmap --version ; pwd ; whoami"
