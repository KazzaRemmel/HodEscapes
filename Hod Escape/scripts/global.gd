extends Node

var highscore := 0
var lastscore := 0
var scoreId

func _ready():
	print('in ready')
	SilentWolf.configure({
		"api_key": "nUjniBWlir7XQ1u9X3lWJ5beFYTG427Q8bJJfjye",
		"game_id": "hodescape",
		"game_version":"1.0",
		"log_level":1
	})
