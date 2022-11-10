extends Area2D
class_name FireSpell

var spell_damage: int
onready var animation: AnimationPlayer = get_node("Animation")

func _ready() -> void:
	for children in get_children():
		if children is Particles2D:
			children.emitting = true
	animation.play("light_strength")
	
func _on_Animation_animation_finished(_anim_name: String) -> void:
	queue_free()

