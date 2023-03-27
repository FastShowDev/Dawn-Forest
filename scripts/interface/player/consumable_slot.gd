extends TextureRect
class_name ConsumableContainer

onready var consumable_item : TextureRect = get_node("Item")
onready var consumable_amount: Label = get_node("Amount")

var consumable_item_name: String = ""
var consumable_item_type: String = ""
var consumable_texture_path: String = ""

var consumable_item_price: int
var consumable_item_amount: int
var consumable_item_type_value: int

var can_click : bool = false


func _ready() -> void:
	var file: File = File.new()
	if file.file_exists(data_management.save_path):
		data_management.load_data()
		
		if data_management.data_dictionary.consumable_container.empty():
			return
			
		var data:Array = data_management.data_dictionary.consumable_container
		var item_texture: StreamTexture = load(data[0])
		update_consumable_slot(item_texture, data)

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("click") and can_click:
		if consumable_item_amount > 0:
			match consumable_item_type:
				"Health":
					get_tree().call_group("player_stats", "update_health", "Increase", consumable_item_type_value)
				"Mana":
					get_tree().call_group("player_stats", "update_mana", "Increase", consumable_item_type_value)
					
			consumable_item_amount -= 1
			data_management.data_dictionary.consumable_container = [
				consumable_texture_path,
				consumable_item_amount,
				consumable_item_name,
				consumable_item_type,
				consumable_item_type_value,
				consumable_item_price,
			]
			data_management.save_data()
			
			if consumable_item_amount == 0:
				reset()
				
			consumable_amount.text = str(consumable_item_amount)



func update_consumable_slot(item_texture: StreamTexture, item_info: Array) -> void:
	if item_info[2] == consumable_item_name:
		print("O item já estava equipado!")
		consumable_item_amount += item_info[1]
		
		if consumable_item_amount > 9:
			print("Sobrou resto!")
			var leftover: int = consumable_item_amount - 9
			item_info[1] = leftover
			consumable_item_amount = 9
			
			get_tree().call_group(
				"inventory", 
				"update_slot", 
				consumable_item_name, 
				consumable_item.texture,
				[
					consumable_texture_path,
					consumable_item_type,
					consumable_item_type_value,
					consumable_item_price,
					leftover
				]
			)
		
		consumable_amount.text = str(consumable_item_amount)
		return
		
	if consumable_item_name != "":
		print("Tinha item equipado!")
		get_tree().call_group(
			"inventory",
			"update_slot",
			consumable_item_name,
			consumable_item.texture,
			[
				consumable_texture_path,
				consumable_item_type,
				consumable_item_type_value,
				consumable_item_price,
				consumable_item_amount
			]
		)
		
	consumable_texture_path = item_info[0]
	consumable_item_amount = item_info[1]
	consumable_item_name = item_info[2]
	consumable_item_type = item_info[3]
	consumable_item_type_value = item_info[4]
	consumable_item_price = item_info[5]
	
	consumable_amount.text = str(consumable_item_amount)
	consumable_item.texture = item_texture
	consumable_amount.show()
	
	data_management.data_dictionary.consumable_container = item_info
	data_management.save_data()
	

func _on_ConsumableBackground_mouse_entered():
	can_click = true
	modulate.a = 0.5


func _on_ConsumableBackground_mouse_exited():
	can_click = false
	modulate.a = 1.0


func reset() -> void:
	consumable_item_name = ""
	consumable_item_type = "" 
	consumable_texture_path = ""
	
	consumable_item_price = 0
	consumable_item_type_value = 0
	
	consumable_amount.hide()
	consumable_item.texture = null
	
	data_management.data_dictionary.consumable_container = []
	data_management.save_data()
	

