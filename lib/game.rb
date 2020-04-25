require "pry"
require_relative "player"

class Game
	attr_accessor :human_player, :enemies_left, :enemies_in_sight

	def initialize(name)
		@human_player = HumanPlayer.new(name)
		@enemies_in_sight = []
		for i in 0..5
		@enemies_in_sight[i] = Player.new("Ennemie #{i}")
		end
		@enemies_left = 6
	end

	def kill_player(player)
		i = 0
		@enemies_in_sight.each do |enemi|
		if enemi.name == player
			@enemies_in_sight.delete_at(i)
			@enemies_left -= 1	
		end
		i += 1
		end
		
	end

	def is_still_ongoing?
		if @human_player.life_points > 0 && @enemies_left > 0 #!@enemies.empty?
			return true
		else
			return false
		end
	end

	def show_players
		puts @human_player.show_state, ""
		if @enemies_left == 1
			puts "il y a #{@enemies_left} ennemi encore"
		else
			puts "il y a #{@enemies_left} ennemies encore"
		end
		
	end

	def menu
		puts ""
		puts "Quelle action veux-tu effectuer ?", "" 
		puts "a - chercher une meilleure arme"
		puts "s - chercher à se soigner"
		puts "m - attaquer plusieurs joueurs (arme niveau 3 min)", ""
		puts "attaquer un joueur en vue :"
		for i in 0..(@enemies_in_sight.size - 1) 
			puts "#{i} - #{@enemies_in_sight[i].show_state}"
		end
	end

	def menu_choice
		option = gets.chomp
		puts "", ""
		if option == "a"
			@human_player.search_weapon
		elsif option == "s"
			@human_player.search_health_pack
		elsif option == "m"
				multiply_attack
		elsif option.to_i != 0 || option == "0"  
			if option.to_i < @enemies_in_sight.size
				@human_player.attacks(@enemies_in_sight[option.to_i])
			else
				puts "Option non valide, tu attaques le vide"
			end
		else
			puts "Option non valide, tu perds un tour"
		end
		@enemies_in_sight.each do |enemi|
			if enemi.life_points <= 0
				kill_player(enemi.name)
			end
		end
			
	end
	def enemies_attack
		puts ""
		if !@enemies_in_sight.empty?
			puts "Les autres joueurs t'attaquent"
			@enemies_in_sight.each do |enemi|
				if enemi.life_points > 0
				enemi.attacks(@human_player)
				end
			end
		end
	end
	def multiply_attack
		puts "Tu peux attaquer #{@human_player.weapon_level-1} enemies"
		if @human_player.weapon_level >= 3
			for i in 1..(@human_player.weapon_level-1)
			option = gets.chomp.to_i
			@human_player.attacks(@enemies_in_sight[option])
			show_players
			puts "Tu peux attaquer encore #{@human_player.weapon_level-i-1} enemies"
			print"attaquer aussi: >"
			end
		else
			puts "Tu as besoin d'une arme de niveau supérieur"
		end
	end
	def new_players_in_sight
		if @enemies_in_sight.size >= 6
			puts "Tous les joueurs sont déjà en vue"
		else
			e = rand(1..6)
			if e == 1
				puts "Aucun nouveau joueur n'arrive "
			elsif e > 1 && e <= 4
				puts "Un nouveau joueur arrive "
				@enemies_left += 1
				@enemies_in_sight << Player.new("Robot #{e}023")
			else #e == 5 || e == 6
				puts "Deux nouveaux joueurs arrivent"
				@enemies_left += 2
				@enemies_in_sight << Player.new("Robot #{e}025")
				@enemies_in_sight << Player.new("Robot 0#{e}5")			
			end
		end
	end

	def end
	puts "La partie est finie" 
	if @human_player.life_points > 0
		puts "BRAVO ! TU AS GAGNE !"
	else
		puts "Loser ! Tu as perdu !"
	end
end
end
#binding.pry