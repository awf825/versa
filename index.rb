# important to run this to match config before uploading to bucket
# sox input.mp3 --rate 16k --bits 16 --channels 1 output.flac

require 'bundler/setup'
require 'pocketsphinx-ruby'
require 'awesome_print'
require 'speech'
require 'google/cloud/speech'
require 'google/cloud/storage'
require 'pry'

storage_path = "Path to file in Cloud Storage, eg. gs://bucket/audio.raw"

speech = Google::Cloud::Speech.speech

storage = Google::Cloud::Storage.new(
  project_id: "crypto-reality-3022622"
)

# binding.pry

bucket = storage.bucket "versa_audio"
# bucket.file("male.flac")
#binding.pry

config = { encoding:          :FLAC,
           sample_rate_hertz: 16_000,
           language_code:     "en-US" }
audio  = { uri: "gs://versa_audio/stress-test.flac" }

operation = speech.long_running_recognize config: config, audio: audio

puts "Operation Started"

operation.wait_until_done!

raise operation.results.message if operation.error?

operation.results.results.first.alternatives.each do |alternatives| 
	puts "#{alternatives.transcript}"
end

# system 'echo hello world'
# audio = Speech::AudioToText.new("stress-test.wav")
# puts ap audio.to_text.inspect
# require "google/cloud/storage"

# # If you don't specify credentials when constructing the client, the client
# # library will look for credentials in the environment.
# storage = Google::Cloud::Storage.new project: "crypto-reality-3022622"

# # Make an authenticated API request
# storage.buckets.each do |bucket|
#   puts bucket.name
# end

# CONVERT WAV FILE TO RAW AUDIO FILE
# system 'sox stress-test.wav stress-test.raw'

# recognizer = Pocketsphinx::AudioFileSpeechRecognizer.new
# text = []
# recognizer.recognize('./minute-test.raw') do |speech|
#   text << speech # => "go forward ten meters"
# end

# puts text
#return text

# Pocketsphinx::LiveSpeechRecognizer.new.recognize do |speech|
#   puts speech
# end

# decoder = Pocketsphinx::Decoder.new(Pocketsphinx::Configuration.default)
# puts ap decoder
#decoder.decode('./dfw-test.wav') 
#puts decoder.hypothesis