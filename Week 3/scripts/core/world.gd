extends Node2D


func _ready(): 
	if Director.firstBoot == true: # Values for if it's the first time booting the game
		Director.firstBoot = false
		$player.position.x = Director.startPosX
		$player.position.y = Director.startPosY
	else: # Values for if it's not the first time booting the game
		$player.position.x = Director.currentPosX
		$player.position.y = 459


func _process(delta):
	changeScene()


func changeScene(): # Scene manager
	if Director.transitionScene == true:
		if Director.currentScene == "world":
			Director.currentPosX = $player.position.x
			$player.position.x = Director.currentPosX
			$player.position.y = 459
			Director.firstBoot = false
			get_tree().change_scene_to_file("res://scenes/map/NewArea.tscn")
			Director.changeScenes()


func _on_new_area_tp_body_entered(body): # Changes the scene if in the specific area
	if body.has_method("player"):
		Director.transitionScene = true


func _on_new_area_tp_body_exited(body): # Doesn't change scene if player is not in the specific area
	if body.has_method("player"):
		Director.transitionScene = false


