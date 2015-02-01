require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'data_mapper'
require 'json'
require 'sinatra/flash'

enable :sessions

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/flashcards.db")

class Flashcard
	include DataMapper::Resource
	property :id,           Serial
  	property :word,         String, :required => true
  	property :definition,	  Text, :required => true
  	property :difficulty,	  Integer, :required => true, :min => 1, :max => 10
end
DataMapper.finalize

get '/' do
	@flashcards = Flashcard.all
	erb :index
end

post '/flashcard' do
	flashcard = Flashcard.create params[:flashcard]
	if flashcard.save
		redirect to('/'), flash[:notice] = 'Flash card successfully created.'
	else
		redirect to('/'), flash[:error] = "The difficulty field must be between 1 and 10."
	end
end

delete '/flashcard/:id' do
    flashcard = Flashcard.get params[:id]
    if flashcard.destroy
        redirect to('/'), flash[:notice] = 'Flash card deleted successfully.'
    else
        redirect to('/'), flash[:error] = 'Error deleting flash card.'
    end
end

put '/flashcard/:id' do
  	@flashcard = Flashcard.get params[:id]
  
  	@flashcard.word = params[:word]
  	@flashcard.difficulty = params[:difficulty]
 	@flashcard.definition = params[:definition]
  	if @flashcard.save
  		 redirect to('/'), flash[:notice] = "Flash card successfully updated."
  	else
  		 redirect to('/'), flash[:error] = "The difficulty field must be between 1 and 10."
  	end
end

get '/random' do
	@flashcard = Flashcard.first(:offset => rand(Flashcard.count))
	erb :random, {:layout => :study}
end

get '/nextrandom' do
  	content_type :json
  	flashcard = Flashcard.first(:offset => rand(Flashcard.count))
  	{ :word => flashcard.word, :difficulty => flashcard.difficulty, :definition => flashcard.definition}.to_json
end

get '/easy' do
	@flashcard = Flashcard.first(:order => [ :difficulty.asc ])
	erb :easy, {:layout => :study}
end

get '/nexteasy' do
  	content_type :json
	  flashcards = Flashcard.all(:order => [ :difficulty.asc ])
  	flashcards.to_json
end

get '/hard' do
	@flashcard = Flashcard.first(:order => [ :difficulty.desc ])
	erb :hard, {:layout => :study}
end

get '/nexthard' do
  	content_type :json
	flashcards = Flashcard.all(:order => [ :difficulty.desc ])
  	flashcards.to_json
end
