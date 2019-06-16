for FILE in *.mp4; do
    echo -e "Processing video '\e[32m$FILE\e[0m'";
    ffmpeg -i "${FILE}" -vn -acodec libmp3lame -ac 2 -ab 160k -ar 48000 "${FILE%.mp4}.mp3"
done;

# find . -type f -iname "*.webm" -exec bash -c 'FILE="$1"; ffmpeg -i "${FILE}" -vn -ab 128k -ar 44100 -y "${FILE%.webm}.mp3";' _ '{}' \;
#ffmpeg -i video.mp4 -vn \
#       -acodec libmp3lame -ac 2 -ab 160k -ar 48000 \
#        audio.mp3
