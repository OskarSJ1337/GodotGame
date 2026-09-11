extends CharacterBody2D

const speed := 800.0


func getYDir() -> float:
	return Input.get_action_strength("down") - Input.get_action_strength("up")


func _physics_process(delta: float) -> void:
	var dir: Vector2=Vector2(0,getYDir())
	velocity = dir * speed
	move_and_slide()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
