extends Node3D

@onready var app_screen = $PhoneCase/AppAction/Appscreen
@onready var app_action = $PhoneCase/AppAction
@export var message_app : Area3D
@onready var message_app_icon = $PhoneCase/MessageApp/AppIcon
@export var navigation_app : Area3D
@export var uber_app : Area3D
@onready var phone_sfx = $PhoneCase/SFX
@onready var notification_sfx = $NotificationSFX
@onready var timer = $PhoneCase/UberApp/Timer
@onready var taxi_label : Label3D = $PhoneCase/AppAction/TaxiLabel
@onready var taxi_button = $PhoneCase/AppAction/TaxiButton
@onready var close_app_button = $PhoneCase/AppAction/CloseAppButton

@export var hidden_position: Vector3
@export var visible_position: Vector3

@export var hidden_rotation: Vector3
@export var visible_rotation: Vector3

@export var slide_duration := 0.35
@export var slide_ease := Tween.EASE_OUT
@export var slide_trans := Tween.TRANS_QUAD

enum NotificationMode {
	RANDOM,
	FIXED
}

@onready var notification_timer: Timer = $NotificationTimer
@export var notification_mode := NotificationMode.RANDOM

@export var min_notify_time := 4.0
@export var max_notify_time := 16.0
@export var fixed_notify_time := 8.0

@export var notification_sound: AudioStream


var slide_tween: Tween

var timerVisible = false

var taxi_called = false

func _ready():
	randomize()
	start_notifications()

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
	
	if notification_timer:
		notification_timer.start()

func start_notifications():
	schedule_next_notification()

func schedule_next_notification():
	var wait_time := 0.0

	match notification_mode:
		NotificationMode.RANDOM:
			wait_time = randf_range(min_notify_time, max_notify_time)
		NotificationMode.FIXED:
			wait_time = fixed_notify_time

	notification_timer.start(wait_time)

func _on_notification_timer_timeout():
	notification_sfx.stream = notification_sound
	notification_sfx.play()
	message_app_icon.texture = load("res://assets/sprites/MessageAppNotif.png")
	
	schedule_next_notification()

func stop_notification_sound():
	if notification_sfx.playing:
		notification_sfx.stop()
	
func _process(_delta: float) -> void:
	if (timerVisible):
		taxi_label.text = "Your taxi will arrive in: \n%s" % roundi(timer.time_left)

func _on_open_message_app() -> void:
	stop_notification_sound()
	disable_apps()
	play_phone_sfx()
	app_screen.texture = load("res://assets/sprites/messageapp/textexample.png")
	message_app_icon.texture = load("res://assets/sprites/MessageApp.png")
	
	if notification_timer:
		notification_timer.stop()

func _on_open_navigation_app() -> void:
	disable_apps()
	play_phone_sfx()
	app_screen.texture = load("res://assets/sprites/navigationapp/navigationexample.png")
	taxi_button.visible = false

func _on_open_uber_app() -> void:
	disable_apps()
	play_phone_sfx()
	app_screen.texture = null
	if not taxi_called:
		taxi_button.visible = true

func _on_app_close() -> void:
	enable_apps()
	play_phone_sfx()

func on_phone_opened():
	if notification_timer:
		notification_timer.stop()
	stop_notification_sound()

func on_phone_closed():
	start_notifications()

func play_phone_sfx() -> void:
	phone_sfx.stream = load("res://assets/sounds/phone_tap.wav")
	phone_sfx.play()
	
func _on_taxi_called():
	taxi_called = true
	taxi_button.visible = false
	taxi_label.show()
	timer.start()
	timerVisible = true
	close_app_button.disabled = false

func _on_fade_out_completed():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/cutscenes/taxi_scene.tscn")
