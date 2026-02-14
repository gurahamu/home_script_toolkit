#!/usr/bin/env bash

INPUT_DIR="~/"
OUTPUT_DIR="~/"
JPEG_QUALITY=95
JOBS=$(( $(nproc) / 2 ))

export INPUT_DIR OUTPUT_DIR JPEG_QUALITY

find "$INPUT_DIR" -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.tif" -o -iname "*.webp" -o -iname "*.raf" \
\) -not -name "*~*" -print0 |
parallel -0 -j "$JOBS" --bar '
  file="{}"

  rel="${file#$INPUT_DIR/}"
  out="$OUTPUT_DIR/$rel"

  # Convert RAF files to JPG
  [[ "${file}" =~ \.[Rr][Aa][Ff]$ ]] && out="${out%.*}.jpg"

  mkdir -p "$(dirname "$out")"

  convert "$file" \
    -auto-orient \
    -resize "2200x2200>" \
    -quality "$JPEG_QUALITY" \
    -strip \
    "$out"
'
