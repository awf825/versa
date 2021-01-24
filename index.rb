# important to run this to match config before uploading to bucket
# sox input.mp3 --rate 16k --bits 16 --channels 1 output.flac

require 'bundler/setup'
require 'pocketsphinx-ruby'
require 'awesome_print'
require 'speech'
require 'google/cloud/speech'
require 'google/cloud/storage'
require 'pry'

# system 'echo hello world'

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
audio  = { uri: "gs://versa_audio/ThisIsWater.flac" }

operation = speech.long_running_recognize config: config, audio: audio

puts "Operation Started"

operation.wait_until_done!

raise operation.results.message if operation.error?

operation.results.results.each do |result|
  result.alternatives.each do |alternative|  
    puts "#{alternative.transcript}"    
  end    
end  

# Pocketsphinx::LiveSpeechRecognizer.new.recognize do |speech|
#   puts speech
# end

# decoder = Pocketsphinx::Decoder.new(Pocketsphinx::Configuration.default)
# puts ap decoder
#decoder.decode('./dfw-test.wav') 
#puts decoder.hypothesis