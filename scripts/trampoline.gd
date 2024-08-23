extends Area2D

const JUMP_VELOCITY = -2500.0

func _on_body_entered(body):
	body.velocity.y = JUMP_VELOCITY 
