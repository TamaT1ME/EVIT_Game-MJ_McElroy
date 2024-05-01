extends Node
signal gamePauseUpdate(gamePaused)
var playerNode: CharacterBody2D

func togglePause():
	get_tree().paused = !get_tree().paused
	gamePauseUpdate.emit(get_tree().paused)
	
func calculateAngle(pointFrom: Vector2, pointTo: Vector2) -> float:
	var angleToPlayer: float = rad_to_deg(pointFrom.angle_to_point(pointTo))
	if angleToPlayer < -45 and angleToPlayer > -135:
		return 1
	elif angleToPlayer > 45 and angleToPlayer < 135:
		return 2
	elif angleToPlayer < 45 and angleToPlayer > -45:
		return 4
	elif angleToPlayer > 135 or angleToPlayer < -135:
		return 3
	return 0
