extends KinematicBody2D
class_name Player

#References:
onready var player_sprite: Sprite = get_node("Texture")

#Player physics:
var velocity: Vector2
export(int) var speed = 100
var jump_count: int = 0
var landing: bool = false

export(int) var jump_speed
export(int) var player_gravity

func _physics_process(delta: float):
	horizontal_movement_env()
	vertical_moviment_env()
	gravity(delta)
	
	animate()
	
func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = input_direction * speed
	velocity = move_and_slide(velocity)

func animate() -> void:
	player_sprite.animate(velocity)
	
func vertical_moviment_env():
	#Verifica se o player está no chão e reseta o jump_count
	if is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		jump_count += 1
		velocity.y = jump_speed

func gravity(delta: float) -> void:
	velocity.y += delta * player_gravity
	#Limita a velocidade máxima na vertical em quedas longas
	if velocity.y >= player_gravity:
		velocity.y = player_gravity
