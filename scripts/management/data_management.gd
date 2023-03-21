extends Node

var save_path: String = "user://save.dat"
var initial_position: Vector2 = Vector2(700, 160)

var data_dictionary: Dictionary = {
	"current_exp" : 0,
	"current_level": 1,
	
	"player_texture": "",
	"player_position": initial_position
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
