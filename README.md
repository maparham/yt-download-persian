### Setup Instructions:

#### 1. Install Necessary Tools:

Before running the script, you need to install the following tools:

- **yt-dlp** (YouTube downloader):
  - For Ubuntu:
    ```bash
    sudo apt-get install python3
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
    ```
  - For macOS (assuming you have Homebrew installed):
    ```bash
    brew install python
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
    ```
- **ffmpeg**:
  - For Ubuntu:
    ```bash
    sudo apt-get install ffmpeg
    ```
  - For macOS (using Homebrew):
    ```bash
    brew install ffmpeg
    ```

#### 2. Download the Script:

Save the provided Bash script to a file, e.g., `ytdownload.sh.sh`.

#### 3. Make the Script Executable:

Make the script executable using the following command:
```bash
chmod +x ytdownload.sh.sh
```

### Running the Script:

Now, you can run the script as follows:

```bash
./ytdownload.sh.sh [-r] <youtube_url>
```

- Replace `<youtube_url>` with the URL of the YouTube video you want to download.
- Optionally, you can include the `-r` flag to reduce the size of the output video.

### Example Usage:

- Download and burn subtitles without resizing:
  ```bash
  ./ytdownload.sh.sh <youtube_url>
  ```

- Download and burn subtitles with resizing:
  ```bash
  ./ytdownload.sh.sh -r <youtube_url>
  ```

### Notes:

- The script will download the video and subtitles, convert subtitles to SRT format, and then burn the subtitles into the video.
- After execution, the script will remove all temporary files except the output video file.
