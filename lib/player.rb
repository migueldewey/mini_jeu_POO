require "pry"

class Player
	attr_accessor :name
	attr_reader :life_points

	def initialize(name)
		@name = name
		@life_points = 10
	end

	def show_state
		return "#{@name} a #{@life_points} points de vie"
	end

	def gets_damage(damage)
		@life_points = @life_points - damage
		if @life_points <= 0
			puts "Le joueur #{@name} a été tué"
		end
	end

	def attacks(player)
		puts "#{@name} ataque #{player.name}"
		damage = compute_damage
		player.gets_damage(damage)
		puts "il lui inflinge #{damage} points de damage"
	end

	def compute_damage
		return rand(1..6)
	end
end

binding.pry

