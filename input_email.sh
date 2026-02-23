#!/system/bin/sh

# === KONFIGURASI BACKUP ===
PKG_NAME="com.lftgbqi"
# Lokasi output file ZIP gabungan (Sesuaikan dengan target install.sh)
OUTPUT_ZIP="/sdcard/Download/gg_melolo.zip"
# Folder sementara
TMP_DIR="/data/local/tmp/gg_backup_temp"
DATA_DIR="/data/data/$PKG_NAME"

echo "=========================================================="
echo ">>> === Auto-Backup GameGuardian / Tasker ==="
echo "=========================================================="

# 1. Matikan aplikasi agar database tidak corrupt saat dibackup
echo ">>> [1/4] Menghentikan aplikasi..."
am force-stop "$PKG_NAME"

# 2. Siapkan folder sementara
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

# 3. Mencari dan Meng-copy file APK murni dari sistem
echo ">>> [2/4] Mengekstrak file APK..."
APK_PATH=$(pm path "$PKG_NAME" | awk -F':' '{print $2}')
if [ -z "$APK_PATH" ]; then
    echo ">>> ❌ Error: Aplikasi $PKG_NAME belum terinstal di VSP ini!"
    exit 1
fi
cp "$APK_PATH" "$TMP_DIR/app.apk"

# 4. Membungkus Data Settingan (Mode Anti-FC)
echo ">>> [3/4] Membungkus data settingan (Anti-FC)..."
if [ ! -d "$DATA_DIR" ]; then
    echo ">>> ❌ Error: Folder data $DATA_DIR tidak ditemukan!"
    exit 1
fi

# Pindah ke root directory '/' agar saat di-restore dengan '-C /' posisinya pas
cd / || exit
# Membungkus data TAPI mengecualikan folder lib & cache agar aman lintas device
tar -czf "$TMP_DIR/data.tar.gz" \
    --exclude="data/data/$PKG_NAME/lib" \
    --exclude="data/data/$PKG_NAME/cache" \
    --exclude="data/data/$PKG_NAME/code_cache" \
    "data/data/$PKG_NAME" 2>/dev/null

# 5. Menyatukan APK dan Data menjadi 1 file ZIP
echo ">>> [4/4] Menggabungkan menjadi $OUTPUT_ZIP..."
rm -f "$OUTPUT_ZIP"
cd "$TMP_DIR" || exit

# Membungkus kedua file ke dalam zip (tanpa membuat folder ekstra di dalamnya)
zip -q "$OUTPUT_ZIP" app.apk data.tar.gz

# Bersih-bersih sampah sementara
rm -rf "$TMP_DIR"

echo "=========================================================="
echo ">>> [ SUKSES ] File backup siap di: $OUTPUT_ZIP"
echo "=========================================================="
