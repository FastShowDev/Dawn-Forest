extends RigidBody2D
class_name PhysicItem


onready var sprite: Sprite = get_node("Texture")

var player_ref: KinematicBody2D = null

var item_name: String
var item_info_list: Array
var item_texture: StreamTexture

func _ready():
	randomize()
	apply_random_impulse()
	
func apply_random_impulse() -> void:
	apply_impulse(
		Vector2.ZERO,
		Vector2(
			rand_range(-30,30),
			-90
		)
	)
	
func update_item_info(key: String, texture: StreamTexture, item_info: Array) -> void:
	yield(self, "ready")
	item_name = key
	item_info_list = item_info
	item_texture = texture
	
	sprite.texture = texture

func _on_Notifier2D_screen_exited():
	queue_free()


func _on_InteractionArea_body_entered(body: Player):
	player_ref = body


func _on_InteractionArea_body_exited(_body: Player):
	player_ref = null
	
func _process(_delta: float) -> void:
	if player_ref != null and Input.is_action_just_pressed("interact"):
		#Emitir sinal
		queue_free()
		pass
