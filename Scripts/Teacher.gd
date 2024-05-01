extends CharacterBody2D

@onready var teach = $AnimationPlayer
var direction = ""
var playerDirection = ""
var playerLook: bool = false

func _physics_process(_delta):
	if Global.playerNode.position.y > $hitBox.global_position.y:
		z_index = Global.playerNode.z_index - 1
	else:
		z_index = Global.playerNode.z_index + 1
	if playerLook == true:
		player = $"../Player"
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

func _process(_delta: float) -> void:
	if playerLook:
		var angleIndex = Global.calculateAngle(position, $"../Player".position)
		if angleIndex == 1:
			teach.play("Idle Up")
		if angleIndex == 2:
			teach.play("Idle Down")
		if angleIndex == 3:
			teach.play("Idle Left")
		if angleIndex == 4:
			teach.play("Idle Right")
			
		
func _ready() -> void:
	turnArea = $turnArea/turnArea

func _on_turn_area_body_entered(body: Node) -> void:
	if "Player" in body.name:
		playerLook = true

func _on_turn_area_body_exited(body: Node) -> void:
	if "Player" in body.name:
		playerLook = false
