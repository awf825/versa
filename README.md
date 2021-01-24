### Important Scripts & Commands
 Use this to convert files to flac before uploading to Storage. Very important because this applies to the config headers passed to the recognition operation:
 ```
 sox input.mp3 --rate 16k --bits 16 --channels 1 output.flac
 ```
 Use this to download audio from youtube:
 ```
 youtube-dl -x --audio-format wav "ytsearch:{<full-url-here>}"
 ```
 Use this to activate gcloud "locally"
 ```
 export GOOGLE_APPLICATION_CREDENTIALS=path/to/my/jsoncreds
 echo $GOOGLE_APPLICATION_CREDENTIALS
 gcloud auth login
 gcloud auth activate-service-account <my-service-account-email> --key-file=path/to/my/jsonServiceAccountCreds
 ```
 To start WEBrick listening on port 9292, simply run from the root folder:
 ```
 rackup
 ```