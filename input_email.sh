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
    "APP61I5GDN1EYXIG") EMAIL="bams19feb00027@deyarda.com" ;; # Device Baru
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
    echo "❌ Batal: Device ID tidak terdaftar!"
    exit 1
fi

# ==========================================
# 1. DETEKSI & INPUT EMAIL
# ==========================================
DUMP_FILE="/data/local/tmp/input_detect.xml"
uiautomator dump $DUMP_FILE > /dev/null 2>&1

# Cari kolom input email (teks "Email" atau "ponsel" atau "phone")
NODE_EMAIL=$(grep -iE "Email|ponsel|phone" $DUMP_FILE | head -n 1)

if [ -n "$NODE_EMAIL" ]; then
    echo "Form email terdeteksi, fokus ke kolom..."
    BOUNDS=$(echo "$NODE_EMAIL" | grep -o 'bounds="[^"]*"' | cut -d '"' -f 2)
    COORDS=$(echo "$BOUNDS" | tr '[],' '   ')
    set -- $COORDS
    input tap $(( ($1 + $3) / 2 )) $(( ($2 + $4) / 2 ))
    sleep 1
fi

echo "Memasukkan email: $EMAIL"
input text "$EMAIL"
sleep 1
input keyevent 66 # Enter

# ==========================================
# 2. INPUT PASSWORD
# ==========================================
echo "Menunggu halaman password..."
sleep 7

# Kadang perlu klik form password juga jika tidak auto-fokus
input tap 500 1000 # Klik area tengah layar untuk jaga-jaga fokus
input text "$PASSWORD"
sleep 1
input keyevent 66 # Enter

# ==========================================
# 3. AUTO AGREE (LOOPING)
# ==========================================
echo "Menunggu halaman persetujuan Google..."
sleep 12

for i in 1 2 3 4; do
    echo "Mencari tombol persetujuan (Langkah $i)..."
    uiautomator dump $DUMP_FILE > /dev/null 2>&1
    
    # Deteksi teks setuju/agree/accept/lainnya
    NODE_AGREE=$(grep -iE "agree|setuju|accept|terima|more|lainnya|next|berikutnya|saya" $DUMP_FILE | tail -n 1)
    
    if [ -n "$NODE_AGREE" ]; then
        echo "Tombol ditemukan! Mengeksekusi klik..."
        BOUNDS=$(echo "$NODE_AGREE" | grep -o 'bounds="[^"]*"' | cut -d '"' -f 2)
        COORDS=$(echo "$BOUNDS" | tr '[],' '   ')
        set -- $COORDS
        input tap $(( ($1 + $3) / 2 )) $(( ($2 + $4) / 2 ))
    else
        echo "Tombol tidak terbaca, klik paksa sudut kanan bawah..."
        input tap 850 1850
    fi
    sleep 6
done

echo "✅ PROSES SELESAI UNTUK $EMAIL"