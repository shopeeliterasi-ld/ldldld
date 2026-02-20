#!/system/bin/sh

# --- KONFIGURASI ---
PASSWORD="qwertyui"
# -------------------

DEVICE_ID=$(getprop ro.boot.pad_code)
echo "Mendeteksi Device ID: $DEVICE_ID"

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

if [ -z "$EMAIL" ]; then
    echo "❌ Device ID ($DEVICE_ID) tidak terdaftar!"
    exit 1
fi

# ==========================================
# 1. INPUT EMAIL (KLIK PAKSA)
# ==========================================
echo "Memicu form email..."
# Mengetuk area tengah atas layar di mana kotak email biasanya berada
input tap 500 900 
sleep 0.5
input tap 500 900 
sleep 1.5

echo "Mengetik: $EMAIL"
input text "$EMAIL"
sleep 1
input keyevent 66 # Enter
sleep 8

# ==========================================
# 2. INPUT PASSWORD (KLIK PAKSA)
# ==========================================
echo "Memicu form password..."
# Kotak password biasanya sedikit lebih rendah dari email
input tap 500 1000
sleep 1
input text "$PASSWORD"
sleep 1
input keyevent 66 # Enter
sleep 12

# ==========================================
# 3. AUTO AGREE (BRUTE FORCE CLICK)
# ==========================================
# Loop ini akan mencoba mendeteksi tombol, 
# tapi jika gagal tetap klik di pojok kanan bawah
for i in 1 2 3 4; do
    echo "Persetujuan Langkah $i..."
    DUMP_FILE="/data/local/tmp/dump.xml"
    uiautomator dump $DUMP_FILE > /dev/null 2>&1
    
    # Cari teks tombol
    NODE=$(grep -iE "agree|setuju|accept|terima|more|lainnya|next|berikutnya|saya" $DUMP_FILE | tail -n 1)
    
    if [ -n "$NODE" ]; then
        BOUNDS=$(echo "$NODE" | grep -o 'bounds="[^"]*"' | cut -d '"' -f 2 | tr '[],' '   ')
        set -- $BOUNDS
        input tap $(( ($1 + $3) / 2 )) $(( ($2 + $4) / 2 ))
    else
        # Klik paksa di area tombol BIRU (bawah kanan)
        input tap 850 1850 
    fi
    sleep 6
done

echo "✅ PROSES SELESAI UNTUK $EMAIL"
