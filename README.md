### Important Scripts
 Use this to convert files to flac before uploading to Storage. Very important because this applies to the config headers passed to the recognition operation
 ```sox input.mp3 --rate 16k --bits 16 --channels 1 output.flac

 Use this to download audio from youtube ()
 ```youtube-dl -x --audio-format mp3 "ytsearch:{https://www.youtube.com/watch?v=7E-cwdnsiow}"