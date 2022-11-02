extends Sprite
class_name PlayerTexture

#References:
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

func animate(direction: Vector2) -> void:
	verify_position(direction)
	horizontal_animate(direction)

func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
	elif direction.x < 0:
		flip_h = true

func horizontal_animate(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
	
func _ready():
	pass
