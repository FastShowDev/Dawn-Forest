extends AnimatedSprite
class_name EffectTemplate


func play_effect() -> void:
	play()

func _on_EffectTemplate_animation_finished():
	queue_free()
