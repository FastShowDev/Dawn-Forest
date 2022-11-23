extends CanvasLayer

onready var inventory: Control = get_node("InventoryContainer")

func _ready() -> void:
	inventory.is_visible = false
	print("oi")


func _process(delta) -> void:
	show_inventory()
	
func show_inventory() -> void:
	if Input.is_action_just_pressed("inventory"):
		print("Abre inventário!")
		if inventory.is_visible:
			print("Fecha porra")
			inventory.is_visible = false
			inventory.animation.play("hide_container")
			return
		
		if inventory.is_visible == false:
			print("Abre porra!")
			inventory.is_visible = true
			inventory.animation.play("show_container")
			return
