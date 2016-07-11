require "sinatra"
require "sinatra/reloader" if development?
require "./lib/codebreaker.rb"

game = Codebreaker.new

helpers do
	def selected? color_choice, index, game
	  return false if game.rounds_of_guessing.empty?
	  if game.rounds_of_guessing[-1].guess[index] == color_choice.to_sym
	    true
	  else 
	    false
	  end
	end
end

get "/" do
  erb :index, :locals => {:game => game}
end

post "/" do
  if not game.playing
  	@msg = "Press 'New Game' on the top left!"
  else
	  guess = []
	  guess << params['guess_choice_0'].to_sym
	  guess << params['guess_choice_1'].to_sym
	  guess << params['guess_choice_2'].to_sym
	  guess << params['guess_choice_3'].to_sym
	  game.store_round(guess)

	  if game.win? guess
	  	@msg = "You Win!"
	  elsif game.lose? guess
	  	@msg = "You Lose!"
	  else
	  	@msg = "Nope! (tries left: #{game.tries_left})"
	  end
	end
  erb :index, :locals => {:game => game}
end

put "/" do
	game = Codebreaker.new
	@msg = "New Game Started!"
	erb :index, :locals => {:game => game}
end



