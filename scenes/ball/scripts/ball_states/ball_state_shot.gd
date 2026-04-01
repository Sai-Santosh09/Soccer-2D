class_name BallStateShot extends BallState


func _enter_tree() -> void:
	if ball.velocity.x >= 0:
		animation_player.play("roll")
	else:
		animation_player.play_backwards("roll")


func _process(delta: float) -> void:
	ball.move_and_collide(ball.velocity * delta)
	
