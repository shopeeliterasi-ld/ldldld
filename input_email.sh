#!/system/bin/sh

# === KONFIGURASI BACKUP ===
PKG_NAME="com.lftgbqii"
# Lokasi output file ZIP gabungan
OUTPUT_ZIP="/sdcard/Download/gg_melolo.zip"
# Folder sementara
TMP_DIR="/data/local/tmp/gg_backup_temp"
DATA_DIR="/data/data/$PKG_NAME"
# Link script install dari GitHub Mas
INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/shopeeliterasi-ld/ldldld/refs/heads/main/input_email.sh"

echo "=========================================================="
echo ">>> === Auto-Backup GameGuardian (Full Settings) ==="
echo "=========================================================="

echo ">>> [1/5] Menghentikan aplikasi..."
am force-stop "$PKG_NAME"

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

echo ">>> [2/5] Mengekstrak file APK..."
APK_PATH=$(pm path "$PKG_NAME" | awk -F':' '{print $2}')
if [ -z "$APK_PATH" ]; then
    echo ">>> ❌ Error: Aplikasi $PKG_NAME belum terinstal di VSP ini!"
    exit 1
fi
cp "$APK_PATH" "$TMP_DIR/app.apk"

echo ">>> [3/5] Membungkus data settingan (Anti-FC)..."
if [ ! -d "$DATA_DIR" ]; then
    echo ">>> ❌ Error: Folder data $DATA_DIR tidak ditemukan!"
    exit 1
fi

cd / || exit
tar -czf "$TMP_DIR/data.tar.gz" \
    --exclude="data/data/$PKG_NAME/lib" \
    --exclude="data/data/$PKG_NAME/cache" \
    --exclude="data/data/$PKG_NAME/code_cache" \
    "data/data/$PKG_NAME" 2>/dev/null

echo ">>> [4/5] Mengunduh script installer dari GitHub..."
curl -sL "$INSTALL_SCRIPT_URL" -o "$TMP_DIR/install.sh"

echo ">>> [5/5] Menggabungkan menjadi $OUTPUT_ZIP..."
rm -f "$OUTPUT_ZIP"
cd "$TMP_DIR" || exit

zip -q "$OUTPUT_ZIP" app.apk data.tar.gz install.sh

rm -rf "$TMP_DIR"

echo "=========================================================="
echo ">>> [ SUKSES ] File backup siap di: $OUTPUT_ZIP"
echo "=========================================================="
