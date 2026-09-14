# https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html
# Följde en tutorial som nyttjade detta
extends Node

signal server_started

const MAX_CLIENTS: int = 10

var peer: ENetMultiplayerPeer

# Create client.
func start_client(ip: String, port: int) -> void:
	peer = ENetMultiplayerPeer.new()
	var error := peer.create_client(ip, port)
	if error != OK:
		push_error("Could not create client: error code %s" % error)
		peer = null
		return
	multiplayer.multiplayer_peer = peer

# Create server.
func start_server(port: int) -> void:
	peer = ENetMultiplayerPeer.new()
	var error := peer.create_server(port, MAX_CLIENTS)
	if error != OK:
		push_error("Could not create server on port %d: error code %s. The port may already be in use." % [port, error])
		peer = null
		return
	multiplayer.multiplayer_peer = peer
	server_started.emit()
