extends Node2D

class_name HexTile

signal clicked(tile: HexTile)

enum HexTileState {
	NEUTRAL, RED, BLUE
}

var current_state: HexTileState = HexTileState.NEUTRAL

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var input_mouse_event: InputEventMouseButton = event
		
		if input_mouse_event.button_index == MOUSE_BUTTON_LEFT and input_mouse_event.is_pressed():
			clicked.emit(self)

func _ready() -> void:
	current_state = HexTileState.NEUTRAL
	
	$NeutralHex.visible = true
	$RedHex.visible = false
	$BlueHex.visible = false

func capture_as_red() -> void:
	current_state = HexTileState.RED
	
	$RedHex.visible = true
	$BlueHex.visible = false
	$NeutralHex.visible = false

func capture_as_blue() -> void:
	current_state = HexTileState.BLUE
	
	$BlueHex.visible = true
	$RedHex.visible = false
	$NeutralHex.visible = false
