extends Node3D

signal phone_area_entered
signal phone_area_exited

@onready var app_screen = $PhoneCase/AppAction/Appscreen
@onready var app_action = $PhoneCase/AppAction
@export var message_app : Area3D
@export var navigation_app : Area3D
@export var uber_app : Area3D

func on_mouse_enter():
	print("Enter phone")
	phone_area_entered.emit()
	
func on_mouse_exit():
	print("Exit phone")
	phone_area_exited.emit()

func disable_apps():
	message_app.input_ray_pickable = false
	message_app.visible = false
	navigation_app.input_ray_pickable = false
	navigation_app.visible = false
	uber_app.input_ray_pickable = false
	uber_app.visible = false
	app_action.input_ray_pickable = true
	app_action.visible = true
	
func enable_apps():
	message_app.input_ray_pickable = true
	message_app.visible = true
	navigation_app.input_ray_pickable = true
	navigation_app.visible = true
	uber_app.input_ray_pickable = true
	uber_app.visible =true
	app_action.input_ray_pickable = false
	app_action.visible = false

func _on_message_app_open_message_app() -> void:
	disable_apps()
	app_screen.texture = load("res://assets/sprites/messageapp/textexample.png")

func _on_navigation_app_open_navigation_app() -> void:
	disable_apps()
	app_screen.texture = load("res://assets/sprites/navigationapp/navigationexample.png")

func _on_app_action_close_app() -> void:
	enable_apps()
