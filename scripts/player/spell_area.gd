extends Area2D
class_name SpellArea

var spell_damage: int

func _ready() -> void:
	for children in get_children():
		if children is Particles2D:
			children.emitting = true

func _on_Animation_animation_finished(_anim_name: String) -> void:
	queue_free()

