extends MarginContainer

@onready var loading_screen = preload("res://scenes/loading_screen.tscn")
@onready var leaderboard_screen = preload("res://scenes/leaderboard.tscn")
@onready var header = $"../header"
@onready var alert = $row_container/alert
@onready var row_container = $row_container
@onready var name_input = $row_container/name_input

func _on_submit_btn_pressed():
	if name_input.text !='':
		var loading_scene = loading_screen.instantiate()
		row_container.add_child(loading_scene)
		var sw_result = await SilentWolf.Scores.save_score(name_input.text, Global.lastscore).sw_save_score_complete
		Global.scoreId = sw_result.score_id
		print_debug("Score persisted successfully: "+str(sw_result.score_id))
		var sw_result2: Dictionary = await SilentWolf.Scores.get_scores(10).sw_get_scores_complete
		print("Scores: " + str(sw_result2.scores))

		loading_scene.queue_free()

		for nodes in row_container.get_children():
			row_container.remove_child(nodes)
			nodes.queue_free()
		header.visible = true

		var idx = 1
		for score in SilentWolf.Scores.scores:
			var items = leaderboard_screen.instantiate()
			items.get_node('PlayerPosition').text = '#'+str(idx)
			items.get_node('PlayerName').text = score.player_name
			items.get_node('PlayerScore').text = str(score.score)
			row_container.add_child(items)
			idx+=1
	else:
		alert.visible = true


func _on_retry_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/doodle_jump.tscn")


func _on_name_input_focus_entered():
	alert.visible = false
