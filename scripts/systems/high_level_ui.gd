extends Control


func _on_server_pressed():
	HighLevelNetworkHandler.start_server()


func _on_client_pressed():
	HighLevelNetworkHandler.start_client()
