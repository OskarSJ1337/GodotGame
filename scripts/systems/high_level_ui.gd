extends Control

@onready var ip_input: LineEdit = $"../IPInput"
@onready var port_input: LineEdit = $"../PortInput"

func _on_server_pressed():
	var ip := ip_input.text.strip_edges()
	var port := int(port_input.text)
	print("IP: ", ip)
	print("Port: ", port)


func _on_client_pressed():
	var ip := ip_input.text.strip_edges()
	var port := int(port_input.text)
	print("IP: ", ip)
	print("Port: ", port)
