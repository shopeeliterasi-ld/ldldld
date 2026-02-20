#!/system/bin/sh

# --- KONFIGURASI ---
PASSWORD="qwertyui"
# -------------------

# MENGAMBIL ID DARI ro.boot.pad_code
DEVICE_ID=$(getprop ro.boot.pad_code)
echo "Mendeteksi Device ID: $DEVICE_ID"

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

# ==========================================
# EKSEKUSI LOGIN & AUTO AGREE
# ==========================================
if [ -z "$EMAIL" ]; then
    echo "❌ Batal: Device ID tidak terdaftar!"
    exit 1
fi

echo "1. Memasukkan email: $EMAIL"
input text "$EMAIL"
sleep 2
input keyevent 66
    
echo "Menunggu halaman password..."
sleep 7 
    
echo "2. Memasukkan password..."
input text "$PASSWORD"
sleep 2
input keyevent 66
    
echo "Menunggu halaman persetujuan Google (12 detik)..."
sleep 12

# LOOPING UNTUK KLIK SEMUA TOMBOL PERSETUJUAN
# (Langkah ini akan mencoba klik tombol 'I Agree' dan 'Accept')
for i in 1 2 3 4; do
    echo "Mencari tombol persetujuan (Langkah $i)..."
    DUMP_FILE="/data/local/tmp/g_dump.xml"
    uiautomator dump $DUMP_FILE > /dev/null 2>&1
    
    # Mencari kata kunci persetujuan (I Agree, Accept, More, etc.)
    NODE=$(grep -iE "agree|setuju|accept|terima|more|lainnya|next|berikutnya" $DUMP_FILE | tail -n 1)
    
    if [ -n "$NODE" ]; then
        echo "Tombol teks ditemukan! Mengeksekusi klik..."
        BOUNDS=$(echo "$NODE" | grep -o 'bounds="[^"]*"' | cut -d '"' -f 2)
        COORDS=$(echo "$BOUNDS" | tr '[],' '   ')
        set -- $COORDS
        CX=$(( ($1 + $3) / 2 ))
        CY=$(( ($2 + $4) / 2 ))
        input tap $CX $CY
    else
        echo "Tombol teks tidak terbaca, melakukan klik paksa di area tombol umum..."
        # Klik area bawah kanan (posisi standar tombol I Agree/Accept)
        input tap 800 1900
        sleep 1
        input tap 850 1750
    fi
    sleep 6 # Tunggu proses loading setelah klik
done

echo "✅ PROSES LOGIN SELESAI UNTUK $EMAIL"

