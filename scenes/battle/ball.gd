extends CharacterBody2D

const start_speed := 5.0
const ACCELERATION : int = 5
const paddle_vel := 0.5
var dir : Vector2

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.WHITE)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(-start_speed,0)
	# Sätter så bara servern kör bollen
	set_multiplayer_authority(1)

func new_ball():
	# start position
	position.x = 576
	position.y = 312
	dir = random_direction()
	velocity = Vector2(-start_speed,0)

func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()


func _physics_process(delta: float) -> void:
	# Kolla så det är en aktiv multiplayer instans igång
	var peer := multiplayer.multiplayer_peer
	if peer == null or peer.get_connection_status() != MultiplayerPeer.CONNECTION_CONNECTED:
		return
	if not is_multiplayer_authority():
		return
		
	var col :KinematicCollision2D= move_and_collide(velocity)
	if col:
		var normal := col.get_normal()
		velocity = velocity.bounce(normal)
		
		var collider := col.get_collider()
		if collider is CharacterBody2D:
			velocity += collider.velocity * paddle_vel
			velocity = velocity.normalized() * (velocity.length() + ACCELERATION)
		
