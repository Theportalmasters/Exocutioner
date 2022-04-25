extends CharacterController

onready var gun : Gun = $MagmaMagnum
onready var shoot_timer = $ShootTimer
onready var animator : AnimatedSprite3D = $Sprite3D

export var target_player_distance : float = 1

var target : Spatial

func _process(_delta):
	if target:
		var position = target.to_global(target.translation)
		position = to_local(position)
		if position.distance_squared_to(Vector3.ZERO) > pow(target_player_distance,2):
			request_movement(Vector2(position.x,position.z).normalized() * speed)
		elif shoot_timer.time_left == 0:
			shoot_timer.start()


func _on_Area_area_entered(area):
	target = area

func _on_Area_area_exited(area):
	if area == target:
		target = null

func _on_HitBox_area_entered(_area):
	queue_free()

func _on_ShootTimer_timeout():
	gun._shoot()
	
