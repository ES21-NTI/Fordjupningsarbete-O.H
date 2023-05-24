extends Node2D

# Variable declaration
var player = null

var health = 100
var inPlayerAttackRange = false
var invulnerable = false

func _physics_process(delta): # Updates stuff when relevant
	updateHealth()
	manageDamage()


func enemy(): # Hacky way to fix an enemy tag
	pass


func _on_hitbox_body_entered(body): # Can be attacked if a player is in range
	if body.has_method("player"):
		inPlayerAttackRange = true


func _on_hitbox_body_exited(body): # Can not be attacked if a player is not in range
	if body.has_method("player"):
		inPlayerAttackRange = false

func manageDamage(): # Updates the crates health when taking damage and destroys it if health is 0
	if inPlayerAttackRange and Director.playerCurrentAttack == true:
		if invulnerable == false:
			health = health - 50
			$InvulnerabilityTimer.start()
			invulnerable = true
			if health <= 0:
				self.queue_free()


func updateHealth(): # Updates the crates healthbar
	var healthbar = $HealthBar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_invulnerability_timer_timeout():
	invulnerable = false
