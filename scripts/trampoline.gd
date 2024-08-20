extends Area2D

const JUMP_VELOCITY = -600.0

func _on_body_entered(body):
	print("jump high")
	body.velocity.y = JUMP_VELOCITY 
