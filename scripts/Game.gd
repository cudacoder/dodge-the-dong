extends Node

var score

export (PackedScene) var Dong

func _ready():
	randomize();
	pass

func game_over():
	$UI.show_game_over()
	$Timers/DongTimer.stop()
	$Timers/ScoreTimer.stop()
	
func new_game():
	score = 0
	$UI.update_score(score)
	$UI.show_message("Get Ready")
	$Timers/GameTimer.start()
	$Player.start($StartPosition.position)

func _on_GameTimer_timeout():
	$Timers/DongTimer.start()
	$Timers/ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$UI.update_score(score)

func _on_DongTimer_timeout():
	$DongPath/DongSpawnLocation.set_offset(randi())
	var dong = Dong.instance()
	add_child(dong)
	
	var direction = $DongPath/DongSpawnLocation.rotation + PI / 2
	dong.position = $DongPath/DongSpawnLocation.position
	direction += rand_range(-PI / 4, PI / 4)
	
	dong.rotation = direction
	var new_rotation = Vector2(rand_range(dong.min_speed, dong.max_speed),0)
	dong.set_linear_velocity(new_rotation.rotated(direction))
