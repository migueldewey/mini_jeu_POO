#require 'bundler'
#Bundler.require
require "pry"

require_relative 'lib/game'
require_relative 'lib/player'

def accueil
	puts "-"*51
	puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' !       |"
	puts "| Le but du jeu est d'être le dernier survivant ! |"
	puts "-"*51
	puts ""
	puts "Tape entrer pour comencer :"
	gets.chomp
end
def initialisation
	puts "Entre ton prénom : "
	print"> "
	name = gets.chomp
	my_game = Game.new(name)
	return my_game
end
def perform
	accueil
	my_game = initialisation
	while my_game.is_still_ongoing?
		my_game.show_players
		gets.chomp
		my_game.new_players_in_sight
		my_game.menu
		my_game.menu_choice
		my_game.enemies_attack
	end
	my_game.end
end

perform


#binding.pry