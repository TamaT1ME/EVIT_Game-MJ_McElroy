extends CharacterBody2D

@export var doors: Dictionary
@onready var animations = $AnimationPlayer
@onready var frontBoxOrigin: Node2D = $frontBoxOrigin
var speed = 300  # speed in pixels/sec
var direction = 0
var directionNumber = 0
var teacherLookingAt: CollisionShape2D
var currentDoorIn: Area2D
var doorFailSafe:bool = false
var altDoor:bool
var inFontBox: Area2D
var teacherInFront: bool
var moveDirection: Vector2:
	get:
		return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

var mealsLeft: int = 15:
	set(value):
		mealsLeft = value
		$"CanvasLayer/Control/VBoxContainer/Meals Left".text = "Meals Left: " + str(value)
		if value == 0:
			win()

func _ready() -> void:
	Global.playerNode = self
	z_index = 2

func _physics_process(delta):
	handleInput()
	move_and_slide()
	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_down") || Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_right"):
		$CanvasLayer/Control/VBoxContainer/energyBar.value -= .5 * delta
	var movingAngle = Global.calculateAngle(Vector2.ZERO, velocity)
	if velocity != Vector2.ZERO:
		direction = movingAngle
		if movingAngle == 1:
			animations.play("Walk Up")
			frontBoxOrigin.rotation_degrees = 180
		elif movingAngle == 2:
			animations.play("Walk Down")
			frontBoxOrigin.rotation_degrees = 0
		elif movingAngle == 3:
			animations.play("Walk Left")
			frontBoxOrigin.rotation_degrees = 90
		elif movingAngle == 4:
			animations.play("Walk Right")
			frontBoxOrigin.rotation_degrees = 270
	else:
		if direction == 1:
			animations.play("Idle Up")
		elif direction == 2:
			animations.play("Idle Down")
		elif direction == 3:
			animations.play("Idle Left")
		elif direction == 4:
			animations.play("Idle Right")
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		teleportDoorPlayer()
		if teacherInFront and mealsLeft > 0:
			mealsLeft -= 1
		
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("ui_pause"):
		print("Called")
		Global.togglePause()

func handleInput():
	velocity = moveDirection * speed
	
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
	else:
		currentDoorIn = null
		doorFailSafe = false
	
	if node.get_meta("EntityType", "null") == "Enemy" && inBody && flag=="enemy":
		$CanvasLayer/Control/VBoxContainer/energyBar.value -= 5
	if node.get_meta("EntityType", "null") == "Teacher" && inBody && flag=="front":
		teacherInFront = true
	if node.get_meta("EntityType", "null") == "Teacher" && !inBody && flag=="front":
		teacherInFront = false
		
func teleportDoorPlayer():
	if !doorFailSafe and currentDoorIn != null:
		if !altDoor:
			global_position = get_node(doors[get_path_to(currentDoorIn)]).global_position
		else:
			global_position = get_node(doors.find_key(get_path_to(currentDoorIn))).global_position
		doorFailSafe = true

func _on_hurt_box_area_entered(area):
	hitId(area, true, "enemy")

func win():
	pass

func _on_front_box_area_entered(area: Area2D) -> void:
	hitId(area, true, "front")
	inFontBox = area

func _on_front_box_area_exited(area: Area2D) -> void:
	hitId(area, false, "front")
	inFontBox = null
