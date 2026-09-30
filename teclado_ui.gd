extends Control

signal pressed_key(key)

func _ready():
    for button in get_children():
        if button is TextureButton:
            var key_value = button.name.split("_")[0].to_upper()

            button.pressed.connect(_on_pressed_key.bind(key_value))

func _on_pressed_key(key: String):
    print("Presionando: ", key)
    pressed_key.emit(key)