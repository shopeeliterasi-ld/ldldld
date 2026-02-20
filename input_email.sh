#!/system/bin/sh

# --- KONFIGURASI ---
PASSWORD="qwertyui"
# -------------------

# MENGAMBIL DEVICE ID & MEMBERSIHKAN KARAKTER TERSEMBUNYI
RAW_ID=$(getprop ro.boot.pad_code)
DEVICE_ID=$(echo "$RAW_ID" | tr -d '[:space:]' | tr -d '\r')

echo "------------------------------------------"
echo "Mendeteksi Device ID: |$DEVICE_ID|"
echo "------------------------------------------"

# ==========================================
# DAFTAR PEMETAAN DEVICE ID -> EMAIL
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

# VALIDASI EMAIL
if [ -z "$EMAIL" ]; then
    echo "❌ ERROR: Device ID [$DEVICE_ID] TIDAK TERDAFTAR!"
    echo "Pastikan ID di script sama persis dengan ID di atas."
    exit 1
fi

# ==========================================
# LANGKAH 1: INPUT EMAIL
# ==========================================
echo "1. Memproses Email: $EMAIL"
# Klik area kotak email (tengah layar 1080p)
input tap 540 850
sleep 1
input text "$EMAIL"
sleep 1
input keyevent 66 # Enter

# ==========================================
# LANGKAH 2: INPUT PASSWORD
# ==========================================
echo "Menunggu halaman password..."
sleep 8
# Klik area kotak password
input tap 540 950
sleep 1
input text "$PASSWORD"
sleep 1
input keyevent 66 # Enter

# ==========================================
# LANGKAH 3: AUTO AGREE (LOOPING 4 KALI)
# ==========================================
echo "Menunggu halaman persetujuan (12 detik)..."
sleep 12

for i in 1 2 3 4; do
    echo "Mencari tombol persetujuan (Langkah $i)..."
    DUMP_FILE="/data/local/tmp/g_dump.xml"
    uiautomator dump $DUMP_FILE > /dev/null 2>&1
    
    # Cari tombol berdasarkan teks (I Agree, Saya Setuju, Accept, dll)
    NODE=$(grep -iE "agree|setuju|accept|terima|more|lainnya|next|berikutnya" $DUMP_FILE | tail -n 1)
    
    if [ -n "$NODE" ]; then
        echo "Tombol teks ditemukan! Klik..."
        BOUNDS=$(echo "$NODE" | grep -o 'bounds="[^"]*"' | cut -d '"' -f 2 | tr '[],' '   ')
        set -- $BOUNDS
        input tap $(( ($1 + $3) / 2 )) $(( ($2 + $4) / 2 ))
    else
        echo "Tombol tidak terbaca, klik koordinat pojok kanan bawah..."
        # Klik area bawah kanan (untuk layar 1080p)
        input tap 900 1800
    fi
    sleep 6 
done

echo "------------------------------------------"
echo "✅ PROSES LOGIN SELESAI UNTUK $EMAIL"
echo "------------------------------------------"
