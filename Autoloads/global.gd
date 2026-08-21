extends Node

var save_path = 'user://save.json'

var settings: Dictionary = {
	"music": false,
	"sfx": true,
	"fullscreen": false
}

var all_player: Dictionary[String, PackedScene] ={
	"Bunny":  preload("uid://cmdseuqt21ygd"),
	"Cat": preload("uid://bw4jywptniu8h"),
	"Mouse": preload("uid://dhlntpn8dxdvr"),
	"Dog": preload("uid://bw4jywptniu8h")
}

var selected_player: PlayerData
var selected_weapon: WeaponData

func get_player() -> PackedScene:
	return all_player[selected_player.id]

func save_data() -> void:
	var save = settings.duplicate()
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(save)
	file.store_string(json_string)
	file.close()

func load_data() -> void:
	if not FileAccess.file_exists(save_path):
		return 
	var file = FileAccess.open(save_path, FileAccess.READ)
	var json = file.get_as_text()
	var data = JSON.parse_string(json)
	file.close()
	settings = data
	
