#!/bin/bash

# Default values
resize=false

# Function to display usage information
usage() {
    echo "Usage: $0 [-r] <youtube_url>"
    echo "Options:"
    echo "  -r    Reduce the size of the output video (optional)"
    exit 1
}

# Cleanup function
cleanup() {
    echo "Cleaning up..."
    rm -f "${filename}.fa.vtt" "${filename}.fa.srt" "${filename}.mkv" "${filename}_resized.mkv"
}

# Trap function to ensure cleanup even if script is interrupted
trap cleanup EXIT

# Parse command-line options
while getopts ":r" opt; do
    case ${opt} in
        r )
            resize=true
            ;;
        \? )
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "Error: yt-dlp is not installed. Please install yt-dlp (https://github.com/yt-dlp/yt-dlp) and make sure it's in your PATH." >&2
    exit 1
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install ffmpeg (https://ffmpeg.org) and make sure it's in your PATH." >&2
    exit 1
fi

# Check if a URL is provided
if [ -z "$1" ]; then
    usage
fi

# Download video with Persian subtitle using yt-dlp
echo "Downloading video with Persian subtitles..."
yt-dlp --sub-lang fa --write-auto-sub -o "%(title)s.%(ext)s" "$1"

# Get the filename without extension
filename=$(yt-dlp --get-filename -o "%(title)s" -- "$1")

# Check if subtitle file exists
subtitle_file="${filename}.fa.vtt"
if [ ! -f "$subtitle_file" ]; then
    echo "Error: Persian subtitle not found." >&2
    exit 1
fi

# Convert subtitle to SRT format
srt_file="${filename}.fa.srt"
ffmpeg -i "$subtitle_file" "$srt_file"

# Check if video file exists
video_file="${filename}.mkv"
if [ ! -f "$video_file" ]; then
    echo "Error: Video file not found." >&2
    exit 1
fi

# Resize the video if the option is provided
if [ "$resize" = true ]; then
    echo "Resizing video..."
    resized_file="${filename}_resized.mkv"
    ffmpeg -i "$video_file" -vf "scale=iw/2:ih/2" "$resized_file"
    video_file="$resized_file"
fi

# Burn subtitles into the video
output_file="${filename}_with_subtitles.mkv"
ffmpeg -i "$video_file" -vf subtitles="$srt_file" "$output_file"

echo "Video with subtitles created: $output_file"

# Remove all files except the output video file
cleanup
