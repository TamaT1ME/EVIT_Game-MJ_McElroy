extends CharacterBody2D

var speed = 300  # speed in pixels/sec

func _physics_process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed

	move_and_slide()

#var speed = 300
#
#func _unhandled_input(event):
	#if event.is_action_pressed("Up"):
		#$AnimationPlayer.play("Walk Up")
		#velocity
	#move_and_slide()
