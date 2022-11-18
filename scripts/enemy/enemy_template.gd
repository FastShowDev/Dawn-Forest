extends KinematicBody2D
class_name EnemyTemplate

onready var texture: Sprite = get_node("Texture")
onready var floor_ray: RayCast2D = get_node("FloorCast")
onready var animation: AnimationPlayer = get_node("Animation")

var can_die: bool = false
var can_hit: bool = false
var can_attack: bool = false

var velocity: Vector2
var player_ref: Player = null
var drop_list: Dictionary
var drop_bonus: int = 1
var attack_animation_suffix: String = "_left"

export(int) var enemy_exp #5
export(int) var speed #60
export(int) var gravity_speed #350
export(int) var proximity_threshold #15
export(int) var raycast_default_position #-33

export(PackedScene) var floating_text


func _physics_process(delta: float) -> void:
	gravity(delta)
	move_behavior()
	verify_position()
	texture.animate(velocity)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func gravity(delta: float) -> void:
	velocity.y += delta * gravity_speed


func move_behavior() -> void:
	if player_ref != null:
		var distance: Vector2 = player_ref.global_position - self.global_position
		var direction: Vector2 = distance.normalized()
	
		if abs(distance.x) <= proximity_threshold:
			velocity.x = 0
			can_attack = true
		elif floor_collision() and not can_attack:
			velocity.x = direction.x * speed
		else:
			velocity.x = 0
		return
	velocity.x = 0


func floor_collision() -> bool:
	if floor_ray.is_colliding():
		return true
		
	return false


func verify_position() -> void:
	if player_ref != null:
		var direction: float = sign(player_ref.global_position.x - self.global_position.x) 
		#Sprite dos inimigos é invertida
		if direction > 0:
			attack_animation_suffix = "_right"
			texture.flip_h = true
			floor_ray.position.x = abs(raycast_default_position)
		elif direction < 0:
			attack_animation_suffix = "_left"
			texture.flip_h = false
			floor_ray.position.x = raycast_default_position

func kill_enemy() -> void:
	animation.play("kill")
	get_tree().call_group("player_stats", "update_exp", enemy_exp)
	spawn_item_probability()

func spawn_item_probability() -> void:
	var random_number: int = randi() % 21
	if random_number <= 6:
		drop_bonus = 1
	elif random_number >= 7 and random_number <= 13:
		drop_bonus = 2
	else:
		drop_bonus = 3
	
	print("Multiplicador de Drop: " + str(drop_bonus))
	
	for key in drop_list.keys():
		var rng: int = randi() % 100+ 1
		if rng <= drop_list[key][1] * drop_bonus:
			#Drop success!
			var item_texture: StreamTexture = load(drop_list[key][0])
			var item_info: Array = [
				drop_list[key][0], #Item path
				drop_list[key][2], #Type
				drop_list[key][3], #Value
				drop_list[key][4], #Sell value
				1 #Amoutn of itens dropped
			]
			spawn_physic_item(key, item_texture, item_info)

func spawn_physic_item(key: String, item_texture: StreamTexture, item_info: Array) -> void:
	var physic_item_scene = load("res://scenes/enviroment/physic_item.tscn")
	var item: PhysicItem = physic_item_scene.instance()
	get_tree().root.call_deferred("add_child", item)
	item.global_position = self.global_position
	item.update_item_info(key, item_texture, item_info)

func spawn_floating_text(type_sign: String, type:String, value: int) -> void:
	var text: FloatText = floating_text.instance()
	text.rect_global_position = self.global_position
	
	text.value = value
	text.type = type
	text.type_sign = type_sign
	
	get_tree().root.call_deferred("add_child", text)

