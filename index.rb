require 'bundler/setup'
require 'pocketsphinx-ruby'
require 'awesome_print'
require 'speech'
require 'google/cloud/speech/v1p1beta1'
require 'google/cloud/storage'
require 'pry'

# system 'echo hello world'

speech = Google::Cloud::Speech.speech(version: :V1p1beta1)
TTSConfig = Google::Cloud::Speech::V1p1beta1::RecognitionConfig.new encoding:          :FLAC,
																    sample_rate_hertz: 16_000,
																    language_code:     "en-US",
																    enable_word_time_offsets: true,
																    enable_automatic_punctuation: true,
																    diarization_config: {
																    	enable_speaker_diarization: true,
																    	min_speaker_count: 1,
																    	max_speaker_count: 1
																    },
																    metadata: {
																    	original_mime_type: "audio/mp4",
																   		audio_topic: "David Foster Wallace Speech"
																    },
																   model: "video"
# storage = Google::Cloud::Storage.new(
#   project_id: "crypto-reality-3022622"
# )
# bucket = storage.bucket "versa_audio"
audio  = { uri: "gs://versa_audio/stress-test.flac" }

operation = speech.long_running_recognize config: TTSConfig, audio: audio

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