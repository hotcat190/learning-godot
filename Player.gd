extends Area2D

const angular_speed = PI

@export var speed = 400

@onready 
var dash_cooldown:Timer = get_node("DashCooldownTimer")

func _ready():
	dash_cooldown.timeout.connect(_on_timer_timeout)	
	
func _on_timer_timeout():
	dash_cooldown.stop()
	
func _on_button_pressed():
	set_process(not is_processing())

func _process(delta):
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction = -1
	if Input.is_action_pressed("move_right"):
		direction = 1

	rotation += angular_speed * direction * delta	
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
	
	if Input.is_action_pressed("move_down"):
		velocity = - Vector2.UP.rotated(rotation) * speed
		
	if Input.is_action_pressed("dash"):
		if (dash_cooldown.is_stopped()):
			$explodinghead.emitting = true
			$AudioStreamPlayer.playing = true
			$AnimationPlayer.play("new_animation")
			$explosion.play("explosion_fade_out")
			velocity = Vector2.UP.rotated(rotation) * speed * 40
			if Input.is_action_pressed("move_down"):
				velocity = - velocity
			dash_cooldown.start(-1)
	position += velocity * delta

func _on_pause_button_toggled(toggled_on):
	set_process(not is_processing())
