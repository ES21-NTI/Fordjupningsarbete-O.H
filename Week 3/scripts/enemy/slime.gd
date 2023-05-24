extends CharacterBody2D

# Variable declaration
@export var speed = 35

var playerChase = false
var player = null

var health = 100
var inPlayerAttackRange = false
var invulnerable = false

func _physics_process(delta):
	manageDamage()
	updateHealth()
	
	if playerChase: # Plays the jumping animation and starts moving if enemy starts chasing player
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("jumpMedium")
		
		if (player.position.x - position.x) < 0: # Flips the sprites so that they're facing the right direction
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")



func _on_detection_area_body_entered(body): # Enemy can see the player and starts to chase
	player = body
	playerChase = true


func _on_detection_area_body_exited(body): # Enemy can not see the player and won't chase
	player = null
	playerChase = false


func enemy():
	pass


func _on_hitbox_body_entered(body): # Player is in enemys attack range
	if body.has_method("player"):
		inPlayerAttackRange = true


func _on_hitbox_body_exited(body): # Player is no longer in enemys attack range 
	if body.has_method("player"):
		inPlayerAttackRange = false

func manageDamage(): # Updates enemy health when taking damage and kills the enemy if health is 0
	if inPlayerAttackRange and Director.playerCurrentAttack == true:
		if invulnerable == false:
			health = health - 34
			$InvulnerabilityTimer.start()
			invulnerable = true
			if health <= 0:
				self.queue_free()


func _on_invulnerability_timer_timeout():
	invulnerable = false

func updateHealth(): # Updates the enemy healthbar
	var healthbar = $HealthBar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
