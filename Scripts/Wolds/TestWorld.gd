extends Node2D


func _physics_process(delta):
	if not $Navigation2D/EnemyBasic.nav_agent.get_nav_path().empty():
		$Line2D.points = $Navigation2D/EnemyBasic.nav_agent.get_nav_path()
