extends KinematicBody2D


onready var player:KinematicBody2D = get_tree().get_nodes_in_group("Player")[0]
onready var nav_agent = $NavigationAgent2D


var velocity = Vector2.ZERO

export(int, 100, 500) var move_speed


func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
	
	var direction = global_position.direction_to(nav_agent.get_next_location()).normalized()
	
#	var desire_vel = direction * move_speed
#	var steering = (desire_vel - velocity) * delta * 0.4
#	velocity += steering
	
	velocity = move_and_slide(direction * move_speed)


func _on_UpdateTargetPos_timeout():
	nav_agent.set_target_location(player.global_position)
