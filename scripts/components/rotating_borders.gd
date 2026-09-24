extends Node2D


@export var rotation_speed: float = 10.0

var is_rotating: bool = false

func _ready() -> void:
	$"../VBoxContainer/Rotate".pressed.connect(_on_rotate_pressed)

func _on_rotate_pressed() -> void:
	is_rotating = not is_rotating

func _process(delta: float) -> void:
	if is_rotating:
		rotation += deg_to_rad(rotation_speed) * delta
