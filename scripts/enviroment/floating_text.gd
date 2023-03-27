extends Label
class_name FloatText

onready var tween: Tween = get_node("Tween")

var value: int
var mass: int = 20

var velocity: Vector2
var gravity: Vector2 = Vector2.UP

var type: String = ""
var type_sign: String = ""

export(Color) var exp_color
export(Color) var heal_color
export(Color) var mana_color
export(Color) var damage_color

func _ready() -> void:
	randomize()
	#Inicial random impulse
	velocity = Vector2(
		rand_range(-10,10),
		-30
	)
	
	floating_text()
	
func floating_text() -> void:
	#Modifica a cor do texto com base no type:
	text = type_sign + str(value)
	match type:
		"Exp":
			modulate = exp_color
		"Heal":
			modulate = heal_color
		"Mana":
			modulate = mana_color
		"Damage":
			modulate = damage_color
	interpolate()

func interpolate() -> void:
	#Diminui a visibilidade
	var _interpolate_modulate = tween.interpolate_property(
		self,
		"modulate:a",
		1.0,
		0.0,
		0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT,
		0.7
	)
	#Invoca o label aumentando a escala
	var _interpolate_scale_up = tween.interpolate_property(
		self,
		"rect_scale",
		Vector2(0.0, 0.0),
		Vector2(1.0, 1.0),
		0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	#Diminui a escala dele
	var _interpolate_scale_down = tween.interpolate_property(
		self,
		"rect_scale",
		Vector2(1.0, 1.0),
		Vector2(0.4, 0.4),
		1.0,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT,
		0.6
	)
	
	var _start = tween.start()
	yield(tween, "tween_all_completed")
	queue_free()
	

func _process(delta: float) -> void:
	#Aplica o impulso inicial
	velocity += gravity * mass * delta
	rect_position += velocity * delta

