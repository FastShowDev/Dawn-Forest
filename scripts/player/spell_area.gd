extends Area2D
class_name FireSpell

var spell_damage: int = 5
onready var animation: AnimationPlayer = get_node("Animation")

func _ready() -> void:
	spell_damage = 5
	for children in get_children():
		if children is Particles2D and children.name != "ExplosionParticles":
			children.emitting = true
	animation.play("light_strength")
	
func _on_Animation_animation_finished(_anim_name: String) -> void:
	queue_free()

