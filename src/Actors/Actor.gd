extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL := Vector2.UP

export var speed := Vector2(800.0, 1400.0)
export var gravity := 4000.0

var velocity := Vector2.ZERO
