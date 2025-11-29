extends Node2D

@export var HEX_ROWS: int = 8
@export var HEX_COLS: int = 12

var hex_tile_scene = preload("res://scenes/hex_tile.tscn")

var hex_grid: Array[HexTile] = []

enum GameState {
	RED_TURN,
	BLUE_TURN,
}

var current_state: GameState = GameState.RED_TURN

func _ready() -> void:
	for row_num in range(HEX_ROWS):
		for row_col in range(HEX_COLS):
			var new_hex_tile: HexTile = hex_tile_scene.instantiate()
			
			new_hex_tile.position = Vector2(
				row_col * 64 + 32 * (row_num % 2) + 64,
				row_num * 48 + 128
			)
			
			add_child(new_hex_tile)
			hex_grid.push_back(new_hex_tile)
			
			new_hex_tile.clicked.connect(_on_hex_tile_clicked)

func _on_hex_tile_clicked(hex_tile: HexTile) -> void:
	if current_state == GameState.RED_TURN:
		if hex_tile.current_state == HexTile.HexTileState.NEUTRAL:
			current_state = GameState.BLUE_TURN
			hex_tile.capture_as_red()
	elif current_state == GameState.BLUE_TURN:
		if hex_tile.current_state == HexTile.HexTileState.NEUTRAL:
			current_state = GameState.RED_TURN
			hex_tile.capture_as_blue()
