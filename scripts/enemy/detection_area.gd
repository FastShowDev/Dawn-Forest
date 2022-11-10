extends Area2D
class_name DetectionArea

export(NodePath) onready var enemy = get_node(enemy) as KinematicBody2D


func _on_DetectionArea_body_entered(body: Player) -> void:
	enemy.player_ref = body


func _on_DetectionArea_body_exited(_body):
	enemy.player_ref = null
