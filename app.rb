require 'sinatra'
require 'data_mapper'
require 'json'

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

post '/addflashcard' do
	Flashcard.create params[:flashcard]
	redirect to('/')
end

delete '/deleteflashcard/:id' do
	Flashcard.get(params[:id]).destroy
	redirect to('/')
end

put '/editflashcard/:id' do
  	flashcard = Flashcard.get params[:id]
  
  	flashcard.word = params[:word]
  	flashcard.difficulty = params[:difficulty]
 	flashcard.definition = params[:definition]
  	flashcard.save
  	redirect to('/')
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











