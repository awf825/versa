require 'sinatra/base'
require 'google/cloud/speech/v1p1beta1'
require 'speech'
# require 'sinatra'
# require "sinatra/namespace"
require 'bundler/setup'
# require 'pocketsphinx-ruby'
require 'pry'
require 'google/cloud/speech/v1p1beta1'
require 'speech'
require 'lib/media_services'
require 'google/cloud/storage'

module Sinatra
  module MediaServices
 	def video_speech_recog(filename)
 		speech_options = {
 			encoding:          :FLAC,
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
		    	original_mime_type: "audio/mp3",
		   		audio_topic: "VERSA"
		    },
		    model: "video"
 		}
 		speech = Google::Cloud::Speech.speech(version: :V1p1beta1)
		config = Google::Cloud::Speech::V1p1beta1::RecognitionConfig.new(speech_options)
		audio  = { uri: "gs://versa_audio/#{filename}" }

		operation = speech.long_running_recognize config: config, audio: audio

		puts "Operation Started"

		operation.wait_until_done!

		raise operation.results.message if operation.error?

		out = ""

		operation.results.results.each do |result|
		  result.alternatives.each do |alternative|
		  	out << alternative.transcript
		  end   
		end 

		return out
 	end

 	def live_speech_recog
 		Pocketsphinx::LiveSpeechRecognizer.new.recognize do |speech|
		  puts speech
		end

		# decoder = Pocketsphinx::Decoder.new(Pocketsphinx::Configuration.default)
		# puts ap decoder
		#decoder.decode('./dfw-test.wav') 
		#puts decoder.hypothesis
 	end
  end
  helpers MediaServices
end