#!/bin/bash
for f in *.flac; do
    filename="${f%.flac}"
    ffmpeg -i "$f" -map 0:a -c:a aac -b:a 256k -map_metadata 0 -f ipod "${filename}.m4a"
done
