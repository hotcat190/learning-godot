extends CharacterBody2D

signal dash

const ANGULAR_SPEED = PI
const DASH_MULTIPLIER: int = 25

@export var speed = 6

@onready 
var dash_cooldown:Timer = get_node("Dash/DashCooldown")

func _ready():
	dash_cooldown.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout():
	dash_cooldown.stop()

func _process(delta):
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction = -1
	if Input.is_action_pressed("move_right"):
		direction = 1

	rotation += ANGULAR_SPEED * direction * delta
	
	var distance = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		distance = Vector2.UP.rotated(rotation) * speed
	
	if Input.is_action_pressed("move_down"):
		distance = - Vector2.UP.rotated(rotation) * speed
		
	if Input.is_action_pressed("dash"):
		if (dash_cooldown.is_stopped()):
			distance = Vector2.UP.rotated(rotation) * speed * DASH_MULTIPLIER
			if Input.is_action_pressed("move_down"):
				distance = - distance
			dash.emit()
		
	move_and_collide(distance)


func _on_pause_button_toggled(toggled_on):
	set_process(not is_processing())
