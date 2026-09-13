extends MultiplayerSpawner

@export var network_player : PackedScene
@export var spawn_position := Vector2(400, 320)

func _ready() -> void:
	spawn_function = Callable(self, "_spawn_player")
	multiplayer.peer_connected.connect(spawn_player)
	HighLevelNetworkHandler.server_started.connect(_spawn_host_player)
	if multiplayer.is_server():
		call_deferred("_spawn_host_player")

func _spawn_host_player() -> void:
	var spawn_parent := get_node(spawn_path)
	if spawn_parent.get_node_or_null("1") == null:
		spawn_player(1)
	
func spawn_player(id: int) -> void:
	if !multiplayer.is_server(): return
	spawn({"id": id, "position": spawn_position})

func _spawn_player(data: Dictionary) -> Node:
	var player: Node = network_player.instantiate()
	player.name = str(data["id"])
	player.position = data["position"]
	return player
