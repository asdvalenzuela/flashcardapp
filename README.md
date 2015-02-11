A Simple Flashcard Web App!
===========================

A simple way to keep track of words and definitions that I'm trying to memorize. 

User Stories
------------

- I can visit the flash card app in my browser
- I can create a new card with a word, a definition, and a difficulty rating
- I can see a list of all my cards
- I can edit an existing card's word, definition, and difficulty
- I can go into "study" mode, where I see the word and the definition is hidden
- When I'm in study mode, I can reveal the definition
- When I'm in study mode, I can click "Next" to move to the next word
- I can choose a study mode algorithm - random, easy, or hard

Tech stack
----------

- Ruby
- Sinatra
- JS
- Jquery
- SQLite

Installation
------------

1. Clone this repository
	`$ git clone https://github.com/loupe/flashcard-homework-alaina.git`
2. cd into the directory
	`$ cd flashcard-homework-alaina`
3. Use bundler to install dependencies
	`$ gem install bundler`
	`$ bundle install` 
4. Start up the app 
	`$ ruby app.rb` 
5. Navigate to localhost:4567 to use the flashcard app