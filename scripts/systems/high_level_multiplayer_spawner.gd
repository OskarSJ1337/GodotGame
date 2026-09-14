extends MultiplayerSpawner

@export var network_player : PackedScene
const SPAWN_POSITIONS:= [Vector2(384,488), Vector2(792,112)]
const PADDLE_COLORS:= [Color.REBECCA_PURPLE, Color.BLUE]
const PADDLE_ROTATION:= [315.0, 135.0]
var spawn_order := 0

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
	spawn({
		"id": id,
		"position": SPAWN_POSITIONS[spawn_order],
		"color": PADDLE_COLORS[spawn_order],
		"rotation": PADDLE_ROTATION[spawn_order]
	})
	spawn_order += 1

func _spawn_player(data: Dictionary) -> Node:
	var player: Node = network_player.instantiate()
	player.name = str(data["id"])
	player.position = data["position"]
	player.modulate = data["color"]
	player.rotation_degrees = data["rotation"]
	return player
