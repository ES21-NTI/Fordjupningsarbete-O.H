extends Node2D


func _ready(): # Makes so that the player transitions to the right position
	$player.position.x = Director.currentPosX
	$player.position.y = 9


func _process(delta):
	changeScene()


func changeScene(): # Scene manager
	if Director.transitionScene == true:
		if Director.currentScene == "newArea":
			Director.currentPosX = $player.position.x
			$player.position.x = Director.currentPosX
			Director.currentPosY = 9
			get_tree().change_scene_to_file("res://scenes/map/world.tscn")
			Director.changeScenes()



func _on_world_tp_body_entered(body): # Changes the scene if in the specific area
	if body.has_method("player"):
		Director.transitionScene = true


func _on_world_tp_body_exited(body): # Doesn't change scene if player is not in the specific area
	if body.has_method("player"):
		Director.transitionScene = false
