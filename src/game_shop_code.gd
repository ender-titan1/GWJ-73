extends Control

@export var Money: int = 0

@onready var money_lablel: Label = $VBoxContainer/ColorRect/HBoxContainer/money

func money_display(_money: int):
	money_lablel.set_text(str(_money))

func _ready():
	money_display(Money)
