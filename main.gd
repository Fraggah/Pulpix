extends Node2D

@onready var game_ui: GameUI = $gameUI
@onready var player: CharacterBody2D = $player
@onready var boxes: Node2D = $boxes
@onready var spawner: Node2D = $spawner
@onready var score_audio: AudioStreamPlayer2D = $scoreAudio
@onready var theme: AudioStreamPlayer2D = $theme

var score = 0

func add_score():
	score += 1
	print("puntos: ", score)
	score_audio.play()
	game_ui.update_score(score)

func game_over() -> void:
	game_ui.game_over(score)
	player.hide()
	boxes.hide()
	spawner.game_over()
	theme.volume_db = -20
