extends KinematicBody2D
onready var player = $"../Player"
var velocity := Vector2.ZERO
export var strength = 100
var speed = 50
var pushed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
#	print(pushed)
	
	var direction : Vector2 = (player.global_position-global_position).normalized()
	
	if not pushed:
		velocity = move_and_slide(direction*speed)
	else:
		pushed = false
	
	
	
	
