extends CharacterBody2D

var speed = 250
@onready var guard = $AnimatedSprite2D
var direction = ""
var ogDirection = ""
var playerChase: bool = false

func _physics_process(delta):
	if playerChase == true:
		player = get_node("/root/Main/Floor_InBuildingWalls/Player")
		var moveDirection = global_position.direction_to(player.position)
		velocity = moveDirection * speed
		
		move_and_slide()
		updateAnimation()
	else:
		updateAnimation()
	
func updateAnimation():
	if velocity.x < 0:
		direction = "Walk Left"
		ogDirection = "Walk Left"
	elif velocity.x > 0:
		direction = "Walk Right"
		ogDirection = "Walk Right"
	elif velocity.y < 0:
		direction = "Walk Up"
		ogDirection = "Walk Up"
	elif velocity.y > 0:
		direction = "Walk Down"
		ogDirection = "Walk Down"
	else:
		if velocity.x == 0 && velocity.y == 0: 
			if ogDirection == "Walk Left":
				direction = "Idle Left"
			elif ogDirection == "Walk Right":
				direction = "Idle Right"
			elif ogDirection == "Walk Up":
				direction = "Idle Up"
			else:
				direction = "Idle Down"
	
	guard.play(direction)

var detectArea: CollisionShape2D
var player: CharacterBody2D
var playerInRange: bool = false

func _ready() -> void:
	detectArea = get_node("/root/Main/Floor_InBuildingWalls/enemy/detectionArea/detectionArea")

func _on_detection_area_body_entered(body: Node) -> void:
	if "Player" in body.name:
		playerChase = true

func _on_detection_area_body_exited(body: Node) -> void:
	if "Player" in body.name:  
		playerChase = false

