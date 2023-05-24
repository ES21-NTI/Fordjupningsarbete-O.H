extends Control


const SAVE_PATH := "user://save.json"


@onready var playerHP = Director.playerHealth


func _ready() -> void:
	save_json()
	

func save_json() -> void:
	var data := {
		"playerHP": Director.playerHealth,
	}
	var json_data := JSON.stringify(data)
	var file_access := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file_access.store_line(json_data)
	file_access.close()


func load_json() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file_access := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_data := file_access.get_line()
	file_access.close()
	var data: Dictionary = JSON.parse_string(json_data)
	Director.playerHealth = data.playerHP
