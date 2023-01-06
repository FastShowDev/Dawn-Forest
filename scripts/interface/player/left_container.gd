extends TextureRect
class_name StatsLeftContainer

onready var grid_container: GridContainer = get_node("GridContainer")

export(NodePath) onready var stats_info = get_node(stats_info) as TextureRect


func _ready() -> void:
	for container in grid_container.get_children():
		container.connect("mouse_exited", self, "mouse_interaction", ["exited", container])
		container.connect("mouse_entered", self, "mouse_interaction", ["entered", container])
		

func mouse_interaction(state: String, container: HBoxContainer) -> void:
	match state:
		"entered":
			container.modulate.a = 0.5
			match container.name:
				"HealthContainer":
					update_stats_info_container("health")
					
				"ManaContainer":
					update_stats_info_container("mana")
					
				"AttackContainer":
					update_stats_info_container("attack")
					
				"MagicAttackContainer":
					update_stats_info_container("magic_attack")
					
				"DefenseContainer":
					update_stats_info_container("defense")
					
			pass
		"exited":
			container.modulate.a = 0.5
			stats_info.play_animation("hide_container")
			
			
			
func update_stats_info_container(stats: String) -> void:
	stats_info.update_container(stats)
