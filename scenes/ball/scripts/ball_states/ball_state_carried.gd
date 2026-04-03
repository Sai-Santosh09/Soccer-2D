class_name BallStateCarried extends BallState

const OFFSET_FROM_PLAYER := Vector2(10, 4)
const BOB_SPEED := 2.6
const BOB_AMOUNT := 1.5
const SWAY_SPEED := 10.0
const SWAY_AMOUNT := 3.5

func _enter_tree() -> void:
	assert( carrier != null )



func _process(delta: float) -> void:
	var time_factor = Time.get_ticks_msec() * 0.001
	var bob_offset = sin( time_factor * BOB_SPEED) * BOB_AMOUNT
	var sway_offset = 0.0
	if carrier.velocity.x != 0:
		sway_offset = cos( time_factor * SWAY_SPEED ) * SWAY_AMOUNT
	
	ball.position = carrier.position + Vector2(carrier.Left_or_Right.x * OFFSET_FROM_PLAYER.x + sway_offset, OFFSET_FROM_PLAYER.y + bob_offset)
	
	if carrier.velocity != Vector2.ZERO:
		animation_player.play("roll")
		if carrier.Left_or_Right.x >= 0:
			animation_player.speed_scale = 1.0
		else:
			animation_player.speed_scale = -1.0
	else:
		ball.position = carrier.position + Vector2(carrier.Left_or_Right.x * OFFSET_FROM_PLAYER.x, OFFSET_FROM_PLAYER.y)
		animation_player.play("idle")
		animation_player.speed_scale = 1.0
	process_gravity(delta)
