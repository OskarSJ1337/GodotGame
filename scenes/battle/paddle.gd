extends CharacterBody2D

const speed := 800.0


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func getYDir() -> float:
	return Input.get_action_strength("down") - Input.get_action_strength("up")


func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	var base_dir = Vector2(0,getYDir())
	var dir: Vector2=base_dir.rotated(deg_to_rad(rotation_degrees))
	velocity = dir * speed
	move_and_slide()
