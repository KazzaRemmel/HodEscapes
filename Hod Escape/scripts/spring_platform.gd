extends "res://scripts/platform.gd"

@onready var spring = $spring

func response():
	spring.play('default')

func _on_spring_animation_finished()->void:
	spring.frame = 0
	spring.stop()
