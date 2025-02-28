---
layout: post
title: "Local audio transcriptions with whisper-cpp"
--

If you want to do audio transcriptions on your machine, here is a bunch of scripts that show how to do it with [whisper-cpp](https://github.com/ggerganov/whisper.cpp).

I found the transcription results to be better than what youtube et al generate automatically. On my M1 MacBook Air the transcription is mostly faster than real time.

install.sh:
```bash
#!/bin/bash
brew install whisper-cpp ffmpeg wget
```
download-model.sh:

```bash
#!/bin/bash
wget https://ggml.ggerganov.com/ggml-model-whisper-large-q5_0.bin
```

transcode-to-wave.sh:

```bash
#!/bin/bash

# Check if an argument was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Extract filename without extension
input_file="$1"
base_name="$(basename "$input_file" | sed -E 's/[^a-zA-Z0-9]//g')"
output_file="${base_name}.wav"

# Run FFmpeg command
ffmpeg -i "$input_file" -ac 1 -ar 16000 "$output_file"whisper-
```

transcribe.sh:
```bash
#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <wav_file> <language>"
    exit 1
fi

WAV_FILE="$1"
LANGUAGE="$2"

if [ ! -f "$WAV_FILE" ]; then
    echo "Error: File '$WAV_FILE' not found!"
    exit 1
fi

MODEL="ggml-model-whisper-large-q5_0.bin"

echo "Transcribing '$WAV_FILE' to language '$LANGUAGE'..."
whisper-cli \
    -l "$LANGUAGE" \
    -m "$MODEL" \
    --output-txt \
    --output-vtt \
    --output-srt \
    --output-lrc \
    --output-words \
    --output-csv \
    --output-json \
    --output-json-full \
    "$WAV_FILE"

echo "Transcription completed!"
```
