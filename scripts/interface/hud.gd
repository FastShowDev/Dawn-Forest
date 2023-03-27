extends CanvasLayer

onready var inventory_container: Control = get_node("InventoryContainer")
onready var stats_container: Control = get_node("StatsContainer")
onready var equipment_container: Control = get_node("EquipamentContainer")

var can_show_container: bool = true


func _ready() -> void:
	inventory_container.is_visible = false


func _process(delta: float) -> void:
	if can_show_container:
		show_inventory()
		show_stats()
		
	
func show_inventory() -> void:
	if Input.is_action_just_pressed("inventory"):
		hide_equipment_container()
		inventory_container.is_visible = !inventory_container.is_visible
		
		if inventory_container.is_visible:
			inventory_container.animation.play("show_container")
		else:
			inventory_container.reset()
			inventory_container.animation.play("hide_container")
			equipment_container.animation.play("show_container")
		
		if stats_container.is_visible:
			stats_container.reset()
			stats_container.is_visible = false
			stats_container.animation.play("hide_container")


func show_stats() -> void:
	if Input.is_action_just_pressed("stats"):
		hide_equipment_container()
		stats_container.is_visible = !stats_container.is_visible
		
		if stats_container.is_visible:
			stats_container.animation.play("show_container")
		else:
			stats_container.reset()
			stats_container.animation.play("hide_container")
			equipment_container.animation.play("show_container")
			
		if inventory_container.is_visible:
			inventory_container.reset()
			inventory_container.is_visible = false
			inventory_container.animation.play("hide_container")


func hide_equipment_container() -> void:
	equipment_container.animation.play("hide_container")
	
	
	
	
