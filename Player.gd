extends KinematicBody2D

onready var line = $Line2D

var velocity := Vector2.ZERO
export var speed = 300
export var strength = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction*speed
	
	move_and_slide(velocity)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if collider is KinematicBody2D:
			# Dot product will determine movement direction aligning with the collision direction:
			var aligned_push = -direction.dot(collision.normal)
			
			var net_push = aligned_push*strength - collider.strength
			net_push = max(net_push, 0)  # if net push negative, treat as zero
#			print("Push: ", net_push)
			var push_velocity = -collision.normal*net_push
			
			collider.move_and_slide(push_velocity)
			collider.being_pushed = true
			
