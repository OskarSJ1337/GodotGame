extends CharacterBody2D

const speed := 5.0

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.WHITE)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(-speed,0)
	# Sätter så bara servern kör bollen
	set_multiplayer_authority(1)

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	var col :KinematicCollision2D= move_and_collide(velocity)
	if col:
		var normal := col.get_normal()
		velocity = velocity.bounce(normal)
