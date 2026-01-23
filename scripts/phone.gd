extends Node3D

@onready var app_screen = $PhoneCase/AppAction/Appscreen
@onready var app_action = $PhoneCase/AppAction
@export var message_app : Area3D
@export var navigation_app : Area3D
@export var uber_app : Area3D
@onready var phone_sfx = $PhoneCase/SFX
@onready var timer = $PhoneCase/UberApp/Timer
@onready var taxi_label : Label3D = $PhoneCase/AppAction/TaxiLabel
@onready var taxi_button = $PhoneCase/AppAction/TaxiButton
@onready var close_app_button = $PhoneCase/AppAction/CloseAppButton

var timerVisible = false

func disable_apps():
	message_app.input_ray_pickable = false
	message_app.visible = false
	navigation_app.input_ray_pickable = false
	navigation_app.visible = false
	uber_app.input_ray_pickable = false
	uber_app.visible = false
	app_action.input_ray_pickable = true
	app_action.visible = true
	close_app_button.visible = true
	
func enable_apps():
	message_app.input_ray_pickable = true
	message_app.visible = true
	navigation_app.input_ray_pickable = true
	navigation_app.visible = true
	uber_app.input_ray_pickable = true
	uber_app.visible =true
	app_action.input_ray_pickable = false
	app_action.visible = false
	close_app_button.visible = false
	
func _process(_delta: float) -> void:
	if (timerVisible):
		taxi_label.text = "Your taxi will arrive in: \n%s" % roundi(timer.time_left)

func _on_open_message_app() -> void:
	disable_apps()
	play_phone_sfx()
	app_screen.texture = load("res://assets/sprites/messageapp/textexample.png")

func _on_open_navigation_app() -> void:
	disable_apps()
	play_phone_sfx()
	app_screen.texture = load("res://assets/sprites/navigationapp/navigationexample.png")

func _on_open_uber_app() -> void:
	disable_apps()
	play_phone_sfx()
	app_screen.texture = null
	taxi_button.visible = true

func _on_app_close() -> void:
	enable_apps()
	play_phone_sfx()

func _on_phone_opened() -> void:
	visible = true

func on_phone_closed() -> void:
	visible = false

func play_phone_sfx() -> void:
	phone_sfx.stream = load("res://assets/sounds/phone_tap.wav")
	phone_sfx.play()
	
func _on_taxi_called():
	taxi_button.visible = false
	taxi_label.show()
	timer.start()
	timerVisible = true
	close_app_button.disabled = true

func _on_fade_out_completed():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/cutscenes/taxi_scene.tscn")
