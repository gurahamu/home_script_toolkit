#!/bin/bash

INPUT_DIR="~/"   # Source directory
OUTPUT_DIR="~/"  # Destination directory
num_jobs=8        # Number of parallel jobs (adjust based on CPU cores)

process_file() {
    file="$1"

    # Ensure the file exists
    if [[ ! -e "$file" ]]; then
        echo "File not found: $file"
        return
    fi

    # Build output path preserving relative structure
    rel="${file#$INPUT_DIR/}"
    output="$OUTPUT_DIR/${rel%.*}-flac.mp4"

    mkdir -p "$(dirname "$output")"

    # Skip if output already exists
    if [[ -e "$output" ]]; then
        echo "Skipping: Output file already exists - $output"
        return
    fi

    echo "Processing: $file -> $output"

    # Ensure the file is not empty
    if [[ ! -s "$file" ]]; then
        echo "Skipping empty file: $file"
        return
    fi

    # Convert audio to FLAC and copy video, ensuring no stdin interaction
    ffmpeg -nostdin -v verbose -i "$file" -acodec flac -vcodec copy "$output" &> "$(dirname "$output")/ffmpeg_log.txt"

    # Check if ffmpeg succeeded
    if [[ $? -eq 0 ]]; then
        echo "Successfully processed: $file -> $output"
    else
        echo "Error processing file: $file. Check ffmpeg_log.txt for details."
    fi
}

export -f process_file
export INPUT_DIR OUTPUT_DIR

# Find files and process them in parallel
find "$INPUT_DIR" -type f \( -iname "*.mp4" -o -iname "*.MP4" \) -print0 | parallel -0 -j "$num_jobs" process_file {}

