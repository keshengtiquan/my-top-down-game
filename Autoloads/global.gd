extends Node

var save_path = 'user://save.json'
const EXPLOSION_EFFECT_SCENE = preload("uid://bexbkifsv7d80")
const DAMAGE_TEXT_SCENE = preload("uid://cvnxkoqod0ibi")

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

var all_weapons: Dictionary[String, PackedScene] = {
	"Ak47": preload("uid://clx1lme8pgmec"),
	"Mac10": preload("uid://d05drxv7bv61v"),
	"Mp5": preload("uid://cxboio328tpdq"),
	"Pistol": preload("uid://d1l2oaro5petc"),
	"Shotgun": preload("uid://c2oe17ju3j2nr"),
	"Sniper": preload("uid://ktirn1vydynj"),
	"Uzi": preload("uid://dwtb4xxdpdgnv"),
	"Sword": preload("uid://drwrspwat1dbb"),
	"Axe": preload("uid://cpp0gt7qyvgm6")
}

var selected_player: PlayerData
var selected_weapon: WeaponData

func _ready() -> void:
	load_data()

func get_player() -> PackedScene:
	return all_player[selected_player.id]

func get_weapon() -> PackedScene:
	return all_weapons[selected_weapon.weapon_name]

func create_explosion(pos: Vector2) -> void:
	var explosion: Node2D = EXPLOSION_EFFECT_SCENE.instantiate()
	explosion.global_position = pos
	get_tree().root.add_child(explosion)

func create_damage(value: float, pos: Vector2) -> void:
	var damage: DamageText = DAMAGE_TEXT_SCENE.instantiate()
	get_tree().root.add_child(damage)
	var rand_pos = randf_range(0, TAU)
	damage.global_position = pos + Vector2.RIGHT.rotated(rand_pos) * 20
	damage.setup(value)

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
	
