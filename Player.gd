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
	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()

#var speed = 300
#
#func _unhandled_input(event):
	#if event.is_action_pressed("Up"):
		#$AnimationPlayer.play("Walk Up")
		#velocity
	#move_and_slide()
