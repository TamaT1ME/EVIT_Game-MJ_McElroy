extends CharacterBody2D

var speed = 300  # speed in pixels/sec
@onready var animations = $AnimationPlayer
var ogDirection = ""
var direction = ""

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
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
	
	animations.play(direction)

var bistroDoorway: CollisionShape2D
var bistroEntrance: CollisionShape2D
var playerInRange: bool = false

func _ready() -> void:
	bistroDoorway = get_node("/root/Main/Floor_InBuildingWalls/BistroDoor/BistroDoor")
	bistroEntrance = get_node("/root/Main/Floor_InBuildingWalls/BistroEnter/BistroEnter")

func _on_bistro_door_body_entered(body: Node) -> void:
	if "Player" in body.name:  # Assuming your player character is named "Player"
		playerInRange = true

func _on_bistro_door_body_exited(body: Node) -> void:
	if "Player" in body.name:
		playerInRange = false

func _on_bistro_enter_body_entered(body: Node) -> void:
	print_debug("testing")
	if "Player" in body.name:
		playerInRange = true
		
func _on_bistro_enter_body_exited(body: Node) -> void:
	if "Player" in body.name:
		playerInRange = false

func door() -> void:
	if bistroEntrance:
		global_position = bistroEntrance.global_position
	if bistroDoorway:
		global_position = bistroDoorway.global_position

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	if Input.is_action_pressed("ui_accept") and playerInRange:
		door()

#var speed = 300
#
#func _unhandled_input(event):
	#if event.is_action_pressed("Up"):
		#$AnimationPlayer.play("Walk Up")
		#velocity
	#move_and_slide()


func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		print_debug(area.get_parent().name)
