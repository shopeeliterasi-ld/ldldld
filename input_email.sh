#!/system/bin/sh

# --- KONFIGURASI ---
PASSWORD="qwertyui"
# -------------------

# MENGAMBIL ID DAN MEMBERSIHKANNYA TOTAL
# tr -cd '[:alnum:]' akan menghapus SEMUA karakter kecuali huruf dan angka
RAW_ID=$(getprop ro.boot.pad_code)
DEVICE_ID=$(echo "$RAW_ID" | tr -cd '[:alnum:]')

echo "----------------------------------------------"
echo "DEBUG ID: *${DEVICE_ID}*" 
echo "----------------------------------------------"

# ==========================================
# DAFTAR PEMETAAN DEVICE ID -> EMAIL
# ==========================================
# Pastikan ID di bawah ini TIDAK ada spasi di dalamnya
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

if [ -z "$EMAIL" ]; then
    echo "❌ GAGAL: ID *${DEVICE_ID}* tidak cocok dengan daftar di atas."
    exit 1
fi

# ==========================================
# EKSEKUSI KOORDINAT (1080p)
# ==========================================
echo "1. Mengetik Email: $EMAIL"
input tap 540 850
sleep 1
input text "$EMAIL"
sleep 1
input keyevent 66 
sleep 8

echo "2. Mengetik Password..."
input tap 540 950
sleep 1
input text "$PASSWORD"
sleep 1
input keyevent 66
sleep 12

echo "3. Auto Agree & Accept..."
for i in 1 2 3 4; do
    # Klik area pojok kanan bawah untuk resolusi 1080p
    input tap 950 1800
    sleep 5
done

echo "✅ PROSES LOGIN SELESAI"
