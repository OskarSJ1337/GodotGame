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
