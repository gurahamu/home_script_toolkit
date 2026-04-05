SRC="/media/graham/data/SIENTA_backup"
DEST="/media/graham/SIENTA"

cd "$SRC"

total=$(find . -type f | wc -l)
count=0

find . -type f -print0 | sort -z | while IFS= read -r -d '' file; do
    count=$((count+1))
    dest="$DEST/${file#./}"
    mkdir -p "$(dirname "$dest")"
    
    printf "[%d/%d] %s\n" "$count" "$total" "${file#./}"
    cp "$file" "$dest"
done