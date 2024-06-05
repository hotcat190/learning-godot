extends CharacterBody2D

const angular_speed:float = PI

@export var speed:float = 6
var screen_size:Vector2 = Vector2.ZERO

signal dash

@onready 
var dash_cooldown:Timer = get_node("DashCooldownTimer")

func _ready():
	screen_size = get_viewport_rect().size
	dash_cooldown.timeout.connect(_on_timer_timeout)	
	
func _on_timer_timeout():
	dash_cooldown.stop()
	
func _on_button_pressed():
	set_process(not is_processing())

func _process(delta):
	var direction:int = 0
	if Input.is_action_pressed("move_left"):
		direction = -1
	if Input.is_action_pressed("move_right"):
		direction = 1

	rotation += angular_speed * direction * delta	
	
	var distance = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		distance = Vector2.UP.rotated(rotation) * speed
	
	if Input.is_action_pressed("move_down"):
		distance = - Vector2.UP.rotated(rotation) * speed
		
	if Input.is_action_pressed("dash"):
		if (dash_cooldown.is_stopped()):
			distance = Vector2.UP.rotated(rotation) * speed * 20
			if Input.is_action_pressed("move_down"):
				distance = - distance			
			dash.emit()			
	
	move_and_collide(distance)
	velocity = Vector2.ZERO

func _on_pause_button_toggled(toggled_on):
	set_process(not is_processing())

