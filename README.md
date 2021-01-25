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
 export GOOGLE_APPLICATION_CREDENTIALS=path/to/my/jsonServiceAccountCreds
 echo $GOOGLE_APPLICATION_CREDENTIALS
 gcloud auth login
 gcloud auth activate-service-account <my-service-account-email> --key-file=path/to/my/jsonServiceAccountCreds
 ```
 To start WEBrick listening on port 9292, simply run from the root folder:
 ```
 rackup
 ```

 Look into how this (GAC) needs to be configured so this app can exist as a service: seems like I have to refresh my creds every couple hours cos access token keeps changing (?). Authorize this command for user to grab access token at any given time?
 ```
 gcloud auth application-default print-access-token
 ```