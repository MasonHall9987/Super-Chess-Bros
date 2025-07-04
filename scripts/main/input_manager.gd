class_name InputManager
extends RefCounted



# Player device tracking
var white_player_device: Dictionary = {}
var black_player_device: Dictionary = {}

func _init():
	initialize_player_devices()


func initialize_player_devices():
	white_player_device = {
		"device_type": "",
		"device_id": -1,
		"device_name": ""
	}
	black_player_device = {
		"device_type": "",
		"device_id": -1,
		"device_name": ""
	}

# Player device management
func set_white_player_device(device_type: String, device_id: int = -1, device_name: String = ""):
	white_player_device = {
		"device_type": device_type,
		"device_id": device_id,
		"device_name": device_name
	}
	print("White player device set: ", white_player_device)

func set_black_player_device(device_type: String, device_id: int = -1, device_name: String = ""):
	black_player_device = {
		"device_type": device_type,
		"device_id": device_id,
		"device_name": device_name
	}
	print("Black player device set: ", black_player_device)

func get_action(action_base: String, id: int, event) -> String:
	#1 is white and 2 is black
		if id == 1 && is_correct_device_type(id, event):
			return "%s_%d" % [action_base, white_player_device.get("device_id", -1)+1]
		elif id == 2 && is_correct_device_type(id, event):
			return "%s_%d" % [action_base, black_player_device.get("device_id", -1)+1]
		return "pass"

func get_device_type(event) -> String:
	if event is InputEventKey:
		return "keyboard"
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		return "controller"
	return "unknown"

	
func is_correct_device_type(id: int, event) -> bool:
	if id == 1 and white_player_device.get("device_type", "") == get_device_type(event):
		return true
	elif id == 2 and black_player_device.get("device_type", "") == get_device_type(event):
		return true
	return false

func get_white_player_device() -> Dictionary:
	return white_player_device.duplicate()

func get_black_player_device() -> Dictionary:
	return black_player_device.duplicate()

func clear_player_devices():
	initialize_player_devices()
	print("Player devices cleared")
