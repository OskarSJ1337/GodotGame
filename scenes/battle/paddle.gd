extends CharacterBody2D

const speed := 800.0
var start_position: Vector2
var move_axis: Vector2

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	start_position = position
	move_axis = Vector2(0,1).rotated(deg_to_rad(rotation_degrees))

func getYDir() -> float:
	return Input.get_action_strength("down") - Input.get_action_strength("up")


func _physics_process(delta: float) -> void:
	# Kolla så det är en aktiv multiplayer instans igång
	var peer := multiplayer.multiplayer_peer
	if peer == null or peer.get_connection_status() != MultiplayerPeer.CONNECTION_CONNECTED:
		return

	if !is_multiplayer_authority(): return
	velocity = Vector2.DOWN.rotated(global_rotation) * getYDir() * speed
	move_and_slide()
	
	var offset := position - start_position
	position = start_position + offset.project(move_axis)
