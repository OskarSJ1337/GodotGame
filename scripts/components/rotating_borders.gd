extends Node2D


@export var rotation_speed: float = 10.0

var is_rotating: bool = false
@onready var rotate_button: Button = $"../VBoxContainer/Rotate"

func _ready() -> void:
	rotate_button.pressed.connect(_on_rotate_pressed)
	rotate_button.disabled = not _can_rotate()

func _on_rotate_pressed() -> void:
	if _can_rotate():
		is_rotating = not is_rotating

func _process(delta: float) -> void:
	var can_rotate := _can_rotate()
	rotate_button.disabled = not can_rotate
	# Bara hosten kan rotera
	if can_rotate and is_rotating:
		rotation += deg_to_rad(rotation_speed) * delta

# Error handling, fick massa bajs errors om hosten lämnade
func _can_rotate() -> bool:
	var peer := multiplayer.multiplayer_peer
	if peer == null:
		return false
	if peer.get_connection_status() != MultiplayerPeer.CONNECTION_CONNECTED:
		return false
	return multiplayer.is_server()
