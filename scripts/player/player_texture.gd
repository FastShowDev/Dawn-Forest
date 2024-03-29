extends Sprite
class_name PlayerTexture

var suffix: String = "_right"
signal game_over

#Player information
var normal_attack: bool = false
var magic_attack: bool = false
var shield_off: bool = false
var crouching_off: bool = false

#Skins
var texture_list: Array = [
	"res://assets/player/char_blue.png",
	"res://assets/player/char_green.png",
	"res://assets/player/char_purple.png",
	"res://assets/player/char_red.png"
]

#References:
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer
export(NodePath) onready var player = get_node(player) as KinematicBody2D
export(NodePath) onready var attack_collision = get_node(attack_collision) as CollisionShape2D

func _ready() -> void:
	
	randomize()
	
	data_management.load_data()
	if data_management.data_dictionary.player_texture != "":
		return
	
	var random_index: int  = randi() % texture_list.size()
	texture = load(texture_list[random_index])
	data_management.data_dictionary.player_texture = texture_list[random_index]
	data_management.save_data()


func animate(direction: Vector2) -> void:
	verify_position(direction)
	if player.on_hit or player.dead:
		hit_behavior()
		pass
	elif player.attacking or player.defending or player.crouching or player.next_to_wall():
		action_behavior()
	elif direction.y != 0:
		vertical_behavior(direction)
	elif player.landing == true:
		animation.play("landing")
		player.set_physics_process(false) #Not allow player to move until landing animation ends
	else:
		horizontal_behavior(direction)
		
		
func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
		suffix = "_right"
		position = Vector2.ZERO
		player.direction = -1
		player.spell_offset = Vector2(100, -50)
		player.flipped = false
		player.wall_ray.cast_to = Vector2(5.5, 0)
	elif direction.x < 0:
		flip_h = true
		suffix = "_left"
		position = Vector2(-2, 0)
		player.direction = 1
		player.spell_offset = Vector2(-100, -50)
		player.flipped = true
		player.wall_ray.cast_to = Vector2(-7.5, 0)


func hit_behavior() -> void:
	player.set_physics_process(false)
	attack_collision.set_deferred("disabled", true)
	if player.dead:
		animation.play("dead")
	elif player.on_hit:
		animation.play("hit")


func action_behavior() -> void:
	if player.next_to_wall():
		animation.play("wall_slide")
	elif player.attacking and normal_attack:
		animation.play("attack" + suffix)
	elif player.attacking and magic_attack:
		animation.play("spell_attack")
	elif player.defending and shield_off:
		animation.play("shield")
		shield_off = false
	elif player.crouching and crouching_off:
		animation.play("crouch")
		crouching_off = false


func vertical_behavior(direction: Vector2) -> void:
	if direction.y > 0:
		player.landing = true
		animation.play("fall")
	elif direction.y < 0:
		animation.play("jump")

func horizontal_behavior(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("run" + suffix)
	else:
		animation.play("idle")


func _on_Animation_animation_finished(anim_name: String):
	match anim_name:
		"landing":
			player.landing = false
			player.set_physics_process(true)
		"attack_left":
			normal_attack = false
			player.attacking = false
		"attack_right":
			normal_attack = false
			player.attacking = false
		"hit":
			player.on_hit = false
			player.set_physics_process(true)
			
			if player.defending:
				animation.play("shield")
			
			if player.crouching:
				animation.play("crouch")
		"dead":
			emit_signal("game_over")
		"spell_attack":
			magic_attack = false
			player.attacking = false
