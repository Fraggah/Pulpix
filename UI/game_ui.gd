extends CanvasLayer
class_name GameUI

@onready var label: Label = %Label
@onready var score_label: Label = %ScoreLabel
@onready var game_over_ui: MarginContainer = $gameOver
@onready var player: CharacterBody2D = $"../player"
@onready var boxes: Node = $"../boxes"

func _ready() -> void:
	label.text = "0"

func update_score(value: int) -> void:
	label.text = str(value)

func game_over(score: int) -> void:
	score_label.text = "Score: " + str(score)
	game_over_ui.show()


func _on_texture_button_pressed() -> void:
	get_tree().reload_current_scene()
