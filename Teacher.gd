extends CharacterBody2D

@onready var teach = $AnimatedSprite2D
var direction = ""
var playerDirection = ""
var playerLook: bool = false

func _physics_process(delta):
	if playerLook == true:
		player = get_node("/root/Main/Floor_InBuildingWalls/Player")
		#updateAnimation()
	#
	#playerDirection = player.get_children(direction)
	#
#func updateAnimation():
	#
	#if playerDirection == "Walk Left" || "Idle Left":
		#direction = "Idle Right"
	#elif playerDirection == "Walk Right" || "Idle Right":
		#direction = "Idle Left"
	#elif playerDirection == "Walk Down" || "Idle Down":
		#direction = "Idle Up"
	#else:
		#direction = "Idle Down"
	#
	#teach.play(direction)

var turnArea: CollisionShape2D
var player: CharacterBody2D
var playerInRange: bool = false

func _ready() -> void:
	turnArea = get_node("/root/Main/Floor_InBuildingWalls/Teacher1/turnArea/turnArea")

func _on_turn_area_body_entered(body: Node) -> void:
	if "Player" in body.name:
		playerLook = true

func _on_turn_area_body_exited(body: Node) -> void:
	if "Player" in body.name:
		playerLook = false
