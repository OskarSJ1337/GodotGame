extends Button

@export var next_scene: PackedScene

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	
func _on_mouse_entered() -> void:
	UiSounds.hover.play()

func _pressed() -> void:
	UiSounds.click.play()
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
