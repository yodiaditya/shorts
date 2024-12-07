#!/bin/bash

# Create the output folder if it doesn't exist
mkdir -p small

# Get the list of .mp4 files in the current directory
files=(*.mp4)

for i in "${!files[@]}"; do
  file="${files[$i]}"
  filename=$(basename "$file" .mp4)
  output="small/${filename}.mp4"
  gpu=$((i % 2))

  CUDA_VISIBLE_DEVICES="$gpu" ffmpeg -hwaccel cuda -i "$file" -vf "fps=1,scale=1024:1024:force_original_aspect_ratio=decrease,pad=1024:1024:(ow-iw)/2:(oh-ih)/2" \
    -c:v h264_nvenc -preset slow -cq 30 -c:a aac -b:a 96k -movflags +faststart "$output" &

  echo "Started processing: $file on GPU $gpu"

  # Wait for processes to complete every two files
  if ((i % 2 == 1)); then
    wait
  fi
done
echo "All files have been processed and stored in the 'small' folder."
