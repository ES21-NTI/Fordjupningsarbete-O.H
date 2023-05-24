extends Node

var currentScene = "world"
var transitionScene = false
var firstBoot = true # If it's the first time booting up the game
var devMenu = false

# Player stats
var playerHealth = 100
var playerSpeed = 100
var regenSpeed = 10
var regenValue = 20
var attackSpeed = 0.5
var invulnerable = 0


# Player positions for scene transitions 
var startPosX = 24
var startPosY = 62
var currentPosX = 0
var currentPosY = 0
var tempPosX = 0
var tempPosY = 0

var playerCurrentAttack = false


func changeScenes(): # Scene manager
	if transitionScene == true:
		transitionScene = false
		if currentScene == "world":
			currentScene = "newArea"
		else:
			currentScene = "world"
		
