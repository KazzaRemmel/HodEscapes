extends Control

@onready var bg_music = $bg_music

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_music.play()
