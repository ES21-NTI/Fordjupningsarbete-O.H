extends CharacterBody2D


var enemyInRange = false
var enemyCanHit = false
var invulnerable = false
var health = Director.playerHealth
var alive = true

var moving = false
var attacking = false


@export var speed = 100

var currentDir = "none"


func _ready():
	$AnimatedSprite2D.play("idleFront")


func _physics_process(delta):
	playerMovement(delta)
	updateHealth()
	enemyAttack()
	attack()
	
	if health <= 0:
		alive = false # Add end screen after dying
		health = 0
		print("nini")
		self.queue_free()


func playerMovement(delta):
	
	if Input.is_action_pressed("moveUp"):
		moving = true
		velocity.x = 0
		velocity.y = -speed
		currentDir = "up"
		playAnim(1)
		$Attackbox.rotation_degrees = 0
		$Attackbox.position.x = 0
		$Attackbox.position.y = -17
	elif Input.is_action_pressed("moveDown"):
		moving = true
		velocity.x = 0
		velocity.y = speed
		currentDir = "down"
		playAnim(1)
		$Attackbox.rotation_degrees = 0
		$Attackbox.position.x = -1
		$Attackbox.position.y = 8
	elif Input.is_action_pressed("moveLeft"):
		moving = true
		velocity.x = -speed
		velocity.y = 0
		currentDir = "left"
		playAnim(1)
		$Attackbox.rotation_degrees = 90
		$Attackbox.position.x = -13
		$Attackbox.position.y = -6
	elif Input.is_action_pressed("moveRight"):
		moving = true
		velocity.x = speed
		velocity.y = 0
		currentDir = "right"
		playAnim(1)
		$Attackbox.rotation_degrees = 90
		$Attackbox.position.x = 11
		$Attackbox.position.y = -6
	else:
		moving = false
		velocity.x = 0
		velocity.y = 0
		playAnim(0)
	
	move_and_slide()


func playAnim(movement):
	var dir = currentDir
	var anim = $AnimatedSprite2D
	
	if dir == "up":
		anim.flip_h = true
		if movement == 1: # Checks if moving
			anim.play("walkUp")
		elif movement == 0: # Checks if idle
			if attacking == false: # Also checks that an attack isn't happening
				anim.play("idleBack")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1: # Checks if moving
			anim.play("walkDown")
		elif movement == 0: # Checks if idle
			if attacking == false: # Also checks that an attack isn't happening
				anim.play("idleFront")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1: # Checks if moving
			anim.play("walkSide")
		elif movement == 0: # Checks if idle
			if attacking == false: # Also checks that an attack isn't happening
				anim.play("idleSide")
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1: # Checks if moving
			anim.play("walkSide")
		elif movement == 0: # Checks if idle
			if attacking == false: # Also checks that an attack isn't happening
				anim.play("idleSide")


func player():
	pass


func enemyAttack(): # Manages player health and makes player invulnerable for a short time after taking damage
	if enemyCanHit and invulnerable == false:
		health = health - 20
		invulnerable = true
		$InvulnerabilityTimer.start() # Starts invulnerability phase
		print(health)


func _on_cooldown_timer_timeout(): # Stops invulnerability phase 
	invulnerable = false


func attack():
	var dir = currentDir
	
	if Input.is_action_just_pressed("attack"):
		Director.playerCurrentAttack = true # Tells the Director that player is attacking
		attacking = true
		if dir == "up":
			$AnimatedSprite2D.play("attackBack")
			$AttackTimer.start()
		if dir == "down":
			$AnimatedSprite2D.play("attackFront")
			$AttackTimer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true # Flips the sprites horizontally so that they face left
			$AnimatedSprite2D.play("attackSide")
			$AttackTimer.start()
		if dir == "right":
			$AnimatedSprite2D.flip_h = false # Unflips the sprites horizontally since they originally face right
			$AnimatedSprite2D.play("attackSide")
			$AttackTimer.start()


func _on_attack_timer_timeout(): # Ends the attack phase 
	$AttackTimer.stop()
	Director.playerCurrentAttack = false # Tells the Director that player isn't attacking
	attacking = false


func updateHealth():
	var healthbar = $HealthBar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_regen_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0


func _on_attackbox_body_entered(body):
	if body.has_method("enemy"): 
		enemyInRange = true


func _on_attackbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInRange = false


func _on_hitbox_body_entered(body):
	if body.has_method("enemy"): 
		enemyCanHit = true


func _on_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyCanHit= false
