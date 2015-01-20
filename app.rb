require 'sinatra'
require 'data_mapper'

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
