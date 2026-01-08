extends CanvasLayer

var phone_on: bool = false
@onready var phone_rect: TextureRect = $PhoneRect

var onscreen_pos = Vector2(935, 760)
var offscreen_pos = Vector2(935, 1806)

func _input(event: InputEvent) -> void:

	if event.is_action_pressed("phone"):
		if not phone_on:
			phone_on = true
			var tween = create_tween()
			tween.tween_property(phone_rect, "position", onscreen_pos, 0.2) \
				.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		else:
			phone_on = false
			var tween = create_tween()
			tween.tween_property(phone_rect, "position", offscreen_pos, 0.2) \
				.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			
