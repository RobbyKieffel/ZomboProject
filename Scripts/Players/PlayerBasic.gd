extends KinematicBody2D


onready var camera = $Camera2D

var cam_limit = 100
var cam_threshold = 0.007

var direction_limit = [180]#[180, 135, 90, 45, 0, -45, -90, -135, -180]

var velocity = Vector2.ZERO
var input_dir = Vector2.ZERO

export(int, 100, 500) var move_speed


func _ready():
	for i in 8:
		print(i)
		direction_limit.append(direction_limit[i] - 360/8)
	print(direction_limit)
	pass


func _input(event):
	input_dir = input_direction()
	aim_direction(get_local_mouse_position())


func aim_direction(mouse_pos):
	if mouse_pos.x < cam_limit and mouse_pos.x > -cam_limit:
		camera.offset_h = mouse_pos.x * cam_threshold
	else:
		if mouse_pos.x > cam_limit: camera.offset_h = cam_limit * cam_threshold
		else: camera.offset_h = -cam_limit *cam_threshold
		
	if mouse_pos.y < cam_limit and mouse_pos.y > -cam_limit:
		camera.offset_v = mouse_pos.y * cam_threshold
	else:
		if mouse_pos.y > cam_limit: camera.offset_v = cam_limit * cam_threshold
		else: camera.offset_v = -cam_limit * cam_threshold


func input_direction() -> Vector2:
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	return Vector2(x, y).normalized()


func _physics_process(delta):
	velocity = move_and_slide(input_dir * move_speed)
	body_direction()
	pass


func body_direction():
	var dir = int(rad2deg(input_dir.angle()))
	if input_dir == Vector2.ZERO:
		return
	for i in direction_limit:
		if dir <= i and dir > i - 45:
			$Sprite.rotation_degrees = i + 90
			break
	pass

