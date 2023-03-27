extends Node

var save_path: String = "user://save.dat"
var initial_position: Vector2 = Vector2(700, 160)

var data_dictionary: Dictionary = {
	"current_exp" : 0,
	"current_level": 1,
	
	"current_health" : 15,
	"current_mana" : 10,
	
	"player_texture": "",
	"player_position": initial_position,
	
	"base_stats": [
		15, #Health
		10, #Mana
		5,  #Attack
		3,  #MagicAttack
		1   #Defense
	],
	
	"available_points" : 0,
	
	"armor_container" : [],
	"weapon_container" : [],
	"consumable_container" : [],
	
}


func save_data() -> void:
	var file: File = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data_dictionary)
		file.close()
		

func load_data() -> void:
	var file: File = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			data_dictionary = file.get_var()
			file.close()
