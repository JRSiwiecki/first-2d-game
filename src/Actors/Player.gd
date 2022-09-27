extends Actor

export var stomp_impulse := 1000.0

func _on_EnemyDetector_area_entered(_area):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(_body):
	queue_free()

func _physics_process(_delta):
	
	var is_jump_interrupted := Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction := get_direction()
	check_sprint()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	
	var new_direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0)
	
	return new_direction

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	
	var out := linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	
	if is_jump_interrupted:
		out.y = 0.0
	
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	
	var out := linear_velocity
	out.y = -impulse
	return out

func check_sprint():
	
	if (Input.is_action_just_pressed("Sprint")):
		speed.x *= 2.0
	elif (Input.is_action_just_released("Sprint")):
		speed.x /= 2.0
