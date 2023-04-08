extends KinematicBody2D


var velocity = Vector2.ZERO
var input_dir = Vector2.ZERO

export(int, 100, 500) var move_speed


func _input(event):
	input_dir = input_direction()
	pass

func input_direction() -> Vector2:
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	return Vector2(x, y).normalized()

func _physics_process(delta):
	velocity = move_and_slide(input_dir * move_speed)
	pass
