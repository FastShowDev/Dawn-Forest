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
