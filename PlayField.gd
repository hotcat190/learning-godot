extends Node2D

signal player_border_collision

func _on_body_entered(body):
	if body.name == "Player":
		player_border_collision.emit()
		
