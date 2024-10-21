extends Node

const MAX_COINS = 10
var score = 0


@onready var score_label: Label = $ScoreLabel
@onready var hud_score: Label = %HUDScore

func _ready():
	update_score()

func add_point():
	score += 1
	if score == 1:
		score_label.text = "Obtuviste una sola moneda! Aún te faltan "  + str(MAX_COINS - score)
	elif (MAX_COINS - score) > 1:
		score_label.text = "Obtuviste " + str(score) + " monedas! Pero aún te faltan "  + str(MAX_COINS - score)
	elif (MAX_COINS - score) == 1:
		score_label.text = "Obtuviste " + str(score) + " monedas! Pero aún te falta una"
	else:
		score_label.text = "Obtuviste todas las monedas!"
	update_score()

func update_score():
	hud_score.text = "Monedas: " + str(score) + "/" +str(MAX_COINS)
