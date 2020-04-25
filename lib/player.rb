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
		puts ""
	end

	def compute_damage
		return rand(1..6)
	end
end

class HumanPlayer < Player
	attr_accessor :weapon_level

	def initialize(name)
		@weapon_level = 1
		super(name)
		@life_points = 200
	end

	def show_state
		return super + " et une arme de niveau #{@weapon_level}"
	end

	def compute_damage
		return super * @weapon_level
	end

	def search_weapon
		new_weapon_level = rand(1..6)
		puts "Tu as trouvé une arme de niveau #{new_weapon_level} !"
		if new_weapon_level > @weapon_level
			@weapon_level = new_weapon_level
			puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends"
		else
			puts "Dommage... elle n'est pas mieux que ton arme actuelle..."
		end
	end

	def search_health_pack
		c_life = rand(1..6)
		if c_life == 1
			puts "Tu n'as rien trouvé"
		elsif c_life > 1 && c_life <= 5
			puts "Bravo, tu as trouvé un pack de +50 points de vie !"
			@life_points = @life_points + 50
		else #c_life == 6
			puts "Waow, tu as trouvé un pack de +80 points de vie !"
			@life_points = @life_points + 80			
		end
		if @life_points > 200
			@life_points = 200
		end
	end
end


#binding.pry