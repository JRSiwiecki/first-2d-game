extends "res://src/Actors/Actor.gd"

# called on game start
func _ready():
	_velocity.x = -speed.x

func _physics_process(delta):
	
	_velocity.y += gravity * delta
	
	if is_on_wall():
		_velocity.x *= -1.0
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
