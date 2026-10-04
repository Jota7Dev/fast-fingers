extends Area2D

@onready var text_label = $PanelContainer/RichTextLabel

var target_word: String = "TESTEANDO"
var current_index: int = 0
var is_focused: bool = true
var fall_speed: float = 150.0

func _ready():
    text_label.bbcode_enabled = true
    update_colors()

func update_colors():
    var bbcode_text = "[center]"

    var correct_part = target_word.substr(0, current_index)
    var remaining_part = target_word.substr(current_index, target_word.length() - current_index)

    if correct_part.length() > 0:
        bbcode_text += "[color=green]" + correct_part + "[/color]"

    if remaining_part.length() > 0:
        if is_focused:
            bbcode_text += "[color=yellow]" + remaining_part + "[/color]"
        else:
            bbcode_text += "[color=gray]" + remaining_part + "[/color]"

        bbcode_text += "[/center]"

        text_label.text = bbcode_text

func _input(event):
    if event.is_action_pressed("ui_accept"):
        if current_index < target_word.length():
            current_index += 1
            update_colors()

func _process(delta):
    position.y += fall_speed * delta