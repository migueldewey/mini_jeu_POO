require "pry"
#require 'bundler'
#Bundler.require

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
	player1 = HumanPlayer.new(name)
	return player1
end
def enemies
	enemies = []
	enemies[0] = Player.new("Josiane")
	enemies[1] = Player.new("José")
	return enemies
end
def combat(player1,enemy)
	puts "#{player1.name} vs #{enemy[0].name} et #{enemy[1].name}"

	while player1.life_points > 0 && (enemy[0].life_points > 0 || enemy[1].life_points > 0)
		puts player1.show_state, ""
		puts "Quelle action veux-tu effectuer ?", "" 
		puts "a - chercher une meilleure arme"
		puts "s - chercher à se soigner", "" 
		puts "attaquer un joueur en vue :"
		for i in 0..(enemy.size-1) 
			puts "#{i} - #{enemy[i].show_state}"
		end
		option = gets.chomp
		puts "", ""
		if option == "a"
			player1.search_weapon
		elsif option == "s"
			player1.search_health_pack
		elsif option.to_i == 1 || option.to_i == 0
			player1.attacks(enemy[option.to_i])
		else
			puts "Option non valide, tu perds un tour"
		end
		puts ""
		puts "Les autres joueurs t'attaquent"
		enemy.each do |enemi|
			if enemi.life_points > 0
			enemi.attacks(player1)
			end
		end
		break if player1.life_points <= 0
	end
end
def fin(player1)
	puts "La partie est finie" 
	if player1.life_points > 0
		puts "BRAVO ! TU AS GAGNE !"
	else
		puts "Loser ! Tu as perdu !"
	end
end
accueil
player1 = initialisation
enemies
combat(player1,enemies)
fin(player1)


binding.pry

#1)Accueil :
#2)Initialisation du joueur :
#3)Initialisation des ennemis : 
#4)Le combat : 

#a - chercher une meilleure arme
#s - chercher à se soigner 

#attaquer un joueur en vue :
#0 - Josiane a 10 points de vie
#1 - José a 10 points de vie

#5)Fin du jeu
