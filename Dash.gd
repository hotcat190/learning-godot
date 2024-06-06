extends Node2D

func _on_player_dash():
	#Play animations
	$AnimationPlayer.play("new_animation")
	$explosion.play("explosion_fade_out")
	$explodinghead.emitting = true
	
	#Play sound
	$AudioStreamPlayer.playing = true
	
	#Start cooldown timer
	$DashCooldown.start(-1)
	
