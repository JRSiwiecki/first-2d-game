extends Actor


func _physics_process(delta):
	
	# move right is 0 for no movement, 1 for movement
	# move left is 0 for no movement, 1 for movement
	# ex: D is pressed -> move_right (1) - move_left(0) = 1
	# ex: nothing is pressed -> move_right (0) - move_left(0) = 0
	# ex: A and D are pressed -> move_right (1) - move_left(1) = 0
	# ex: A is pressed -> move_right (0) - move_left(1) = -1
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		1.0
	)
	
	velocity = speed * direction
	velocity = move_and_slide(velocity)
