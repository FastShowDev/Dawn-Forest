extends KinematicBody2D
class_name Player

#References:
onready var player_sprite: Sprite = get_node("Texture")

#Player physics:
var velocity: Vector2
export(int) var speed = 100
var jump_count: int = 0


#Flags
var landing: bool = false
var attacking: bool = false
var defending: bool = false
var crouching: bool = false

#Flag permisions:
var can_track_input: bool = false

export(int) var jump_speed
export(int) var player_gravity

func _physics_process(delta: float):
	horizontal_movement_env()
	vertical_moviment_env()
	actions_env()
	gravity(delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	animate(velocity)
	#print(velocity.y)
	
	
func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if can_track_input == false or attacking:
		velocity.x = 0
		return
	
	velocity.x = input_direction * speed
	
	
func vertical_moviment_env():
	#Verifica se o player está no chão e reseta o jump_count
	if is_on_floor():
		jump_count = 0
		
	var jump_condition: bool = can_track_input and not attacking
	if Input.is_action_just_pressed("jump") and jump_count < 2 and jump_condition:
		jump_count += 1
		velocity.y = jump_speed


func animate(velocity: Vector2) -> void:
	player_sprite.animate(velocity)


func actions_env() -> void:
	attack()
	crouch()
	defense()


func attack() -> void:
	var attack_condition: bool = not attacking and not crouching and not defending
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		attacking = true
		player_sprite.normal_attack = true


func crouch() -> void:
	if Input.is_action_pressed("crouch") and is_on_floor() and not defending:
		crouching = true
		can_track_input = false
	elif not defending:
		crouching = false
		can_track_input = true
		player_sprite.crouching_off = true

func defense() -> void:
	if Input.is_action_pressed("defense") and is_on_floor() and not crouching:
		defending = true
		can_track_input = false
	elif not crouching:
		defending = false
		can_track_input = true
		player_sprite.shield_off = true


func gravity(delta: float) -> void:
	velocity.y += delta * player_gravity
	#Limita a velocidade máxima na vertical em quedas longas
	if velocity.y >= player_gravity:
		velocity.y = player_gravity
