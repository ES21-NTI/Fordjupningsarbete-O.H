extends Control


func _input(event): # Shows or hides the dev menu whenever combination is pressed
	if event.is_action_pressed("devMenu"):
		visible = !visible
		Director.devMenu = !Director.devMenu



func _on_health_slider_value_changed(value):
	Director.playerHealth = value
	$Panel/VBoxContainer/Health/Value.text = str(value)


func _on_inv_slider_value_changed(value):
	Director.invulnerable = value
	$Panel/VBoxContainer/Invulnerable/Value.text = str(value)


func _on_reg_spd_slider_value_changed(value):
	Director.regenSpeed = value
	$Panel/VBoxContainer/RegenSpeed/Value.text = str(value)


func _on_reg_val_slider_value_changed(value):
	Director.regenValue = value
	$Panel/VBoxContainer/RegenValue/Value.text = str(value)


func _on_move_spd_slider_value_changed(value):
	Director.playerSpeed = value
	$Panel/VBoxContainer/MovementSpeed/Value.text = str(value)
