extends KinematicBody2D
class_name Player

#References:
onready var player_sprite: Sprite = get_node("Texture")

#Player physics:
var velocity: Vector2
export(int) var speed = 100

func _physics_process(delta: float):
	horizontal_movement_env()
	animate()
	
func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = input_direction * speed
	velocity = move_and_slide(velocity)

func animate() -> void:
	player_sprite.animate(velocity)
