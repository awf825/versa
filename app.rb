$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'sinatra'
require "sinatra/namespace"
require 'bundler/setup'
require 'pocketsphinx-ruby'
require 'pry'
require 'google/cloud/speech/v1p1beta1'
require 'speech'
require 'lib/media_services'
#require 'env'


# system 'echo hello world'
# sinatra runs on localhost:9292

class VersaApp < Sinatra::Base
	register Sinatra::Namespace
	helpers Sinatra::MediaServices

	get '/' do 
		send_file 'index.html'
	end

	namespace '/services' do 
		get '/live_speech_to_text' do
			#live_speech_recog
			"Speak to render speech on the page"
		end

		post '/video_speech_to_text' do
			filename = params[:audio_file]
			transcription = video_speech_recog(filename)
			if (transcription.length > 0)
				moniker = filename.split('.').first + ".txt"
				f = File.new(moniker, 'w')
				f.write(transcription)
				f.close
				send_file(f.path)
			end
			#return 
		end
	end
end
