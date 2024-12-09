extends Node2D

@onready var platform_container = $platform_container
@onready var platform_initial_position_y = $platform_container/Platform.position.y
@onready var camera = $Camera as Camera2D
@onready var player = $Player as CharacterBody2D
@onready var score_label = $Camera/Score as Label
@onready var camera_start_position = $Camera.position.y
@onready var bg_music = $bg_music

var last_platform_is_cloud := false
var score := 0

@export var platform_scene: Array[PackedScene]

func level_generator(amount):
	for items in amount:
		var new_type = randi() % 4
		platform_initial_position_y -= randf_range(36,54)
		var new_platform
		if new_type == 0:
			new_platform = platform_scene[0].instantiate() as StaticBody2D
		elif new_type == 1:
			new_platform = platform_scene[1].instantiate() as StaticBody2D
		elif new_type >= 2:
			if last_platform_is_cloud == false and score > 1000:
				new_platform = platform_scene[new_type].instantiate() as StaticBody2D
				#new_platform.queue_free()
				last_platform_is_cloud = true
			else:
				new_platform = platform_scene[0].instantiate() as StaticBody2D
				new_platform.scale = new_platform.scale * 2
				last_platform_is_cloud = false

		if new_type != null:
			new_platform.position = Vector2(randf_range(20,160), platform_initial_position_y)
			#REMOVE LATER ONCE YOU RESKIN
			if new_type != 2 && new_platform.scale != Vector2(2,2):
				new_platform.scale = new_platform.scale * 2
			platform_container.call_deferred("add_child",new_platform)

func _ready() -> void:
	bg_music.play()
	randomize()
	level_generator(20)

func _physics_process(delta: float)->void:
	if player.position.y < camera.position.y:
		camera.position.y = player.position.y
	score_update()

func delete_object(obstacle):
	if obstacle.is_in_group("player"):
		Global.lastscore = score
		if score > Global.highscore:
			Global.highscore = score
		if get_tree().change_scene_to_file("res://scenes/score_screen.tscn") != OK:
			print('Errorr!')
		if obstacle.has_method('die'):
			obstacle.die()
	elif obstacle.is_in_group('platform') or obstacle.is_in_group('enemies'):
		obstacle.queue_free()
		level_generator(1)

func _on_area_2d_body_entered(body):
	delete_object(body)

func score_update():
	score = camera_start_position - camera.position.y
	score_label.text= str(int(score))
