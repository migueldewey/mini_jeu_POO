#require "bundler"
#Bundler.require

require_relative "lib/game"
require_relative "lib/player"

player1 = Player.new("Josiane")
player2 = Player.new("José")
puts "#{player1.name} vs #{player2.name}"

while player1.life_points > 0 && player2.life_points > 0
	break if player1.life_points <= 0
	puts "Voici l'état de chaque joueur: "
	puts player1.show_state
	puts player2.show_state
	puts ""
	puts "Passons à la phase d'ataque"
	player1.attacks(player2)
	player2.attacks(player1)
	puts ""
end

binding.pry
#1.	À ma droite "Josiane" : crée un Player répondant à 
#	ce doux prénom et stocké dans la variable player1.
#2.	À ma gauche "José" : crée un autre Player répondant à 
#	ce joli prénom et stocké dans la variable player2.
#3.	Présentons les deux combattants : affiche dans le terminal 
#	l'état de chaque combattant grâce à des puts et des show_state. 
#	Juste avant, affiche un petit puts "Voici l'état de chaque joueur :".
#4.	Fight ! Indique que le combat commence avec un puts 
#	"Passons à la phase d'attaque :".
#5.	Josiane aura l'honneur d'attaquer la première : 
#	fais attaquer player2 par player1 avec la méthode attacks.
#6.	José ne va pas se laisser faire : fais l'attaque inverse.

