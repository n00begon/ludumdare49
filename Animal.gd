extends KinematicBody2D

export var speed = 300
var collide_time = 0

func _process(delta):
	pass
#	var player = get_parent().get_node("Player")
#	var tile_map = get_parent().get_node("Map").get_node("TileMap")
#	var player_pos = player.position
#	var mob_pos = position
#
#	var velocity = Vector2()
#	if randf() < 0.1:
#		velocity = Vector2(randf(), randf())
#	else:
#		var path = tile_map.find_path(mob_pos, player_pos)		
#		if path and len(path) > 1:
#			velocity = path[1] - position
#		else:
#			velocity = player_pos - position
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed

	#move(velocity * delta)

#	var is_collided = position.distance_to(player.position) <= 50
#	if is_collided:
#		if collide_time == 0:
#			player.hit()
#		collide_time += delta
#	else:
#		collide_time = 0
#	if collide_time > 0.5:
#		collide_time -= 0.5
#		player.hit()
