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
	
@export var doors: Dictionary
var currentDoorIn: Area2D
var doorFailSafe:bool = false
var altDoor:bool

func _ready() -> void:
	pass

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func _physics_process(delta):
	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_down") || Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_right"):
		$CanvasLayer/Control/energyBar.value -= .5 * delta
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	

#var speed = 300
#
#func _unhandled_input(event):
	#if event.is_action_pressed("Up"):
		#$AnimationPlayer.play("Walk Up")
		#velocity
	#move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		teleportDoorPlayer()


func _on_hit_box_detection_area_entered(area: Area2D) -> void:
	hitId(area, true)

func _on_hit_box_detection_area_exited(area: Area2D) -> void:
	hitId(area, false)

func hitId(node:Area2D, inBody:bool, flag:String="") -> void:
	var getStringPath:NodePath = get_path_to(node)
	if inBody:
		if doors.has(getStringPath):
			currentDoorIn = node
			altDoor = false
		elif doors.find_key(getStringPath):
			currentDoorIn = node
			altDoor = true
			
		print(currentDoorIn, " | ", inBody)
	else:
		currentDoorIn = null
		doorFailSafe = false
		
	if node.get_meta("Enemy") != null && inBody && flag=="enemy":
		#print_debug("hitteded")
		$CanvasLayer/Control/energyBar.value -= 5
	#print_debug(node.get_meta_list(), node)

func teleportDoorPlayer():
	if !doorFailSafe and currentDoorIn != null:
		if !altDoor:
			global_position = get_node(doors[get_path_to(currentDoorIn)]).global_position
		else:
			global_position = get_node(doors.find_key(get_path_to(currentDoorIn))).global_position
		doorFailSafe = true

func _on_hurt_box_area_entered(area):
	hitId(area, true, "enemy")

var gamePaused: bool = false

func _input(event):
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("ui_pause"):
		togglePause()

func togglePause():
	gamePaused = !gamePaused
	if gamePaused == true:
		get_tree().paused = true
		$CanvasLayer2/Pause.showPauseMenu()
	else:
		get_tree().paused = false
		gamePaused = false
		$CanvasLayer2/Pause.hidePauseMenu()
		
		
