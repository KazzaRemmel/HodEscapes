extends CharacterBody2D

@onready var anim = $anim

func _ready():
	anim.play('idle')
