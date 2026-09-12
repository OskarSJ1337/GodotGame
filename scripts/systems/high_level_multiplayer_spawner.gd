extends MultiplayerSpawner

@export var network_player : PackedScene
@export var spawn_position := Vector2(400, 320)

func _ready() -> void:
	spawn_function = Callable(self, "_spawn_player")
	multiplayer.peer_connected.connect(spawn_player)
	
func spawn_player(id: int) -> void:
	if !multiplayer.is_server(): return
	spawn({"id": id, "position": spawn_position})

func _spawn_player(data: Dictionary) -> Node:
	var player: Node = network_player.instantiate()
	player.name = str(data["id"])
	player.position = data["position"]
	return player
