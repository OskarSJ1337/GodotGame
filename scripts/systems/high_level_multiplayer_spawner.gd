extends MultiplayerSpawner

@export var network_player : PackedScene
@onready var SPAWN_POSITION: Array[Marker2D] = [
	$"../RotatingBorders/Borders/Spawn1",
	$"../RotatingBorders/Borders/Spawn2",
	$"../RotatingBorders/Borders/Spawn3",
	$"../RotatingBorders/Borders/Spawn4",
]
	
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
	if !multiplayer.is_server():
		return
	if spawn_order >= SPAWN_POSITION.size():
		return

	var marker := SPAWN_POSITION[spawn_order]
	spawn({
		"id": id,
		"position": marker.position,
		"rotation": marker.rotation_degrees,
		"color": Color.from_hsv(randf(), 0.8, 1.0),
		"spawn_order": spawn_order,
	})
	spawn_order += 1

func _spawn_player(data: Dictionary) -> Node:
	var player: Node = network_player.instantiate()

	player.name = str(data["id"])
	player.position = data["position"]
	player.modulate = data["color"]
	player.rotation_degrees = data["rotation"]

	if data["spawn_order"] == 2:
		$"../RotatingBorders/Borders/2p border1".queue_free()
	if data["spawn_order"] == 3:
		$"../RotatingBorders/Borders/2p border2".queue_free()

	return player
