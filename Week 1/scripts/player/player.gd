extends CharacterBody2D

# Variable declaration
@export var speed = 100

var currentDir = "none"

func _ready(): # Play the idle front animation on boot
	$AnimatedSprite2D.play("idleFront")


func _physics_process(delta):
	playerMovement(delta)


func playerMovement(delta): # Manages the players movement
	
	if Input.is_action_pressed("moveUp"):
		velocity.x = 0
		velocity.y = -speed
		currentDir = "up"
		playAnim(1)
	elif Input.is_action_pressed("moveDown"):
		velocity.x = 0
		velocity.y = speed
		currentDir = "down"
		playAnim(1)
	elif Input.is_action_pressed("moveLeft"):
		velocity.x = -speed
		velocity.y = 0
		currentDir = "left"
		playAnim(1)
	elif Input.is_action_pressed("moveRight"):
		velocity.x = speed
		velocity.y = 0
		currentDir = "right"
		playAnim(1)
	else:
		velocity.x = 0
		velocity.y = 0
		playAnim(0)
	
	move_and_slide()


func playAnim(movement): # Plays the correct animations for each state
	var dir = currentDir
	var anim = $AnimatedSprite2D
	
	if dir == "up":
		anim.flip_h = true
		if movement == 1: # Checks if moving
			anim.play("walkUp")
		elif movement == 0: # Checks if idle
			anim.play("idleBack")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1: # Checks if moving
			anim.play("walkDown")
		elif movement == 0: # Checks if idle
			anim.play("idleFront")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1: # Checks if moving
			anim.play("walkSide")
		elif movement == 0: # Checks if idle
			anim.play("idleSide")
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1: # Checks if moving
			anim.play("walkSide")
		elif movement == 0: # Checks if idle
			anim.play("idleSide")
