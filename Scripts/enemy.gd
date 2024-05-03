extends CharacterBody2D

var speed = 250
@onready var guard = $AnimationPlayer
var direction
var ogDirection
var playerChase: bool = false
var detectArea: CollisionShape2D
var player: CharacterBody2D
var playerInRange: bool = false

func _physics_process(_delta):
	if playerChase == true:
		player = $"../Player"
		var moveDirection = global_position.direction_to(player.global_position)
		velocity = moveDirection * speed
		move_and_slide()
		
	if playerChase:
		var angleIndex = Global.calculateAngle(Vector2.ZERO, velocity)
		direction = angleIndex
		if angleIndex == 1:
			guard.play("Walk Up")
		if angleIndex == 2:
			guard.play("Walk Down")
		if angleIndex == 3:
			guard.play("Walk Left")
		if angleIndex == 4:
			guard.play("Walk Right")

func _ready() -> void:
	detectArea = $detectionArea/detectionArea

func _on_detection_area_body_entered(body: Node) -> void:
	if "Player" in body.name and "Invincibility" not in Global.powerups:
		playerChase = true

func _on_detection_area_body_exited(body: Node) -> void:
	if direction == 1:
		guard.play("Idle Up")
	if direction == 2:
		guard.play("Idle Down")
	if direction == 3:
		guard.play("Idle Left")
	if direction == 4:
		guard.play("Idle Right")
	if "Player" in body.name:  
		playerChase = false

