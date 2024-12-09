extends Control

@onready var bg_music = $bg_music
@onready var highscore = $main/highscore as Label

func _ready() -> void:
	bg_music.play()
	highscore.text = "Highscore\n" + str(Global.highscore)

func _on_startbtn_pressed():
	if get_tree().change_scene_to_file("res://scenes/doodle_jump.tscn") != OK:
		print('Errorr!')


func _on_quitbtn_pressed():
	get_tree().quit()
