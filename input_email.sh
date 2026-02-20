#!/system/bin/sh

# --- KONFIGURASI ---
PASSWORD="qwertyui"
# -------------------

DEVICE_ID=$(getprop ro.boot.pad_code)
echo "Processing Device: $DEVICE_ID"

# ==========================================
# DAFTAR DEVICE ID -> EMAIL
# ==========================================
case "$DEVICE_ID" in
    "APP61I5GDN1EYXIG") EMAIL="bams19feb00027@deyarda.com" ;;
    "APP62F5UQGCXWE16") EMAIL="bams19feb00027@deyarda.com" ;;
    "ATP5CO53L4P2BK0J") EMAIL="bams19feb00028@deyarda.com" ;;
    "APP62C5TE8YRILHC") EMAIL="bams19feb00029@deyarda.com" ;;
    "ATP5CN5325L23HC8") EMAIL="bams19feb00030@deyarda.com" ;;
    "APP5CJ510CBI5GFC") EMAIL="bams19feb00031@deyarda.com" ;;
    "APP62C5TE8ZLHDLU") EMAIL="bams19feb00032@deyarda.com" ;;
    "APP62F5UQGCNWSN8") EMAIL="bams19feb00033@deyarda.com" ;;
    "APP62C5TE8ZLHDLT") EMAIL="bams19feb00034@deyarda.com" ;;
    "APP62C5TE8ZLHDLY") EMAIL="bams19feb00035@deyarda.com" ;;
    "APP6295RVATRL602") EMAIL="bams19feb00036@deyarda.com" ;;
    "APP62C5TE8YRILH9") EMAIL="bams19feb00037@deyarda.com" ;;
    "APP62C5TE8YRILHA") EMAIL="bams19feb00038@deyarda.com" ;;
    "APP5CJ511CYKDJI8") EMAIL="bams19feb00039@deyarda.com" ;;
    "APP5C64UAZZKIP6S") EMAIL="bams19feb00040@deyarda.com" ;;
    "APP5BC4I6H7TXBC2") EMAIL="bams19feb00041@deyarda.com" ;;
    "APP62C5TE8YRILHD") EMAIL="bams19feb00042@deyarda.com" ;;
    "APP62F5UQGCXWE15") EMAIL="bams19feb00043@deyarda.com" ;;
    "APP62F5UQGCXWE14") EMAIL="bams19feb00044@deyarda.com" ;;
    "APP62F5UQGEBUCYI") EMAIL="bams19feb00045@deyarda.com" ;;
    "APP5CJ511CY0ECRS") EMAIL="bams19feb00046@deyarda.com" ;;
    *) EMAIL="" ;;
esac

if [ -z "$EMAIL" ]; then echo "❌ Email tidak ditemukan untuk ID ini."; exit 1; fi

# ==========================================
# EKSEKUSI KOORDINAT TETAP (1080p)
# ==========================================

echo "1. Memfokuskan & Mengetik Email..."
# Klik area kotak email (beberapa titik agar pasti kena)
input tap 540 800
input tap 540 900
sleep 1
input text "$EMAIL"
sleep 1
# Klik tombol 'Next' biru (kanan bawah area tengah)
input tap 900 1200
input keyevent 66
sleep 8

echo "2. Memfokuskan & Mengetik Password..."
# Klik area kotak password
input tap 540 950
sleep 1
input text "$PASSWORD"
sleep 1
# Klik tombol 'Next' biru
input tap 900 1200
input keyevent 66
sleep 12

echo "3. Melewati Halaman Persetujuan..."
# Tombol 'I Agree' di kanan bawah
input tap 900 1800
sleep 7

echo "4. Melewati Layar Google Services..."
# Klik 'More' (jika ada) lalu 'Accept'
input tap 900 1800
sleep 2
input tap 900 1800
sleep 3

echo "✅ SELESAI: Akun $EMAIL berhasil diproses."
