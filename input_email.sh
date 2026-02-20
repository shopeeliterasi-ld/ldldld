#!/system/bin/sh

# --- KONFIGURASI ---
PASSWORD="qwertyui"
# -------------------

# MENGAMBIL ID DARI TEMPAT YANG BENAR (ro.boot.pad_code)
DEVICE_ID=$(getprop ro.boot.pad_code)

echo "Mendeteksi Device ID: $DEVICE_ID"

# ==========================================
# DAFTAR PEMETAAN DEVICE ID -> EMAIL
# ==========================================
case "$DEVICE_ID" in
    "APP61I5GDN1EYXIG") EMAIL="bams19feb00027@deyarda.com" ;;
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
# EKSEKUSI LOGIN OTOMATIS
# ==========================================
if [ -n "$EMAIL" ]; then
    echo "1. Memasukkan email: $EMAIL"
    input text "$EMAIL"
    sleep 1
    input keyevent 66 # Tekan Enter
    
    echo "Menunggu halaman password loading..."
    sleep 6 
    
    echo "2. Memasukkan password..."
    input text "$PASSWORD"
    sleep 1
    input keyevent 66 # Tekan Enter
    
    echo "Menunggu halaman persetujuan Google..."
    sleep 8 
    
    echo "3. Mencari tombol Setuju / I agree..."
    DUMP_FILE="/data/local/tmp/g_dump.xml"
    uiautomator dump $DUMP_FILE > /dev/null 2>&1
    
    NODE=$(grep -iE "setuju|agree" $DUMP_FILE | tail -n 1)
    
    if [ -n "$NODE" ]; then
        echo "Tombol ditemukan! Melakukan klik otomatis..."
        BOUNDS=$(echo "$NODE" | grep -o 'bounds="[^"]*"' | cut -d '"' -f 2)
        COORDS=$(echo "$BOUNDS" | tr '[],' '   ')
        set -- $COORDS
        
        CX=$(( ($1 + $3) / 2 ))
        CY=$(( ($2 + $4) / 2 ))
        
        input tap $CX $CY
    else
        echo "Peringatan: Tombol tidak terbaca. Melakukan klik paksa di sudut kanan bawah..."
        input tap 850 1800 
    fi
    
    echo "✅ Proses eksekusi untuk $EMAIL selesai!"
    
else
    echo "❌ Batal: Device ID tidak terdaftar di script!"
fi
