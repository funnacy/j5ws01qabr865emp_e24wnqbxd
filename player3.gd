extends AnimatableBody3D

#@onready var animationplayer = $AnimationPlayer
# speed ３段：25.0　４段：20.0　５段：
@export var speed: float = 0
@export var hit_force: float = 5.0
@export var initial_position: Vector3
@export var left_limit : float = -3.0
@export var right_limit : float = 1.0
@onready var input_dir : float = 0.0

func _ready() -> void:
	Engine.max_fps = 60
	initial_position = global_position
	
	if Global.dansu == 3:
		speed = 25.0
	elif Global.dansu == 4:
		speed = 20.0
	else :
		speed = 15.0		
	pass

	
func _physics_process(delta):
			
	if Input.is_action_just_pressed("ui_left"):
		input_dir += 1.0
	if Input.is_action_just_pressed("ui_right"):
		input_dir -= 1.0

	var next_x = global_position.x -( input_dir * speed * delta )
		
	next_x = clamp(next_x,left_limit,right_limit)

	global_position = Vector3(next_x,global_position.y,global_position.z)
	
	if Input.is_action_just_pressed("reset_button"):
		reset_hammer()
		return
	
func reset_hammer():
	input_dir = 0.0
	global_position = initial_position
	
		
func _on_rigid_body_3d_3_body_entered(body: Node) -> void:
	if body is RigidBody3D:
		var force_direction = -global_transform.basis.z
		body.apply_central_impulse(force_direction * hit_force)
		pass

func _on_rigid_body_3d_body_entered(body: Node) -> void:
	if body is RigidBody3D:
		# ハンマーの正面方向（例：Z軸マイナス方向）に吹き飛ばす
		var force_direction = -global_transform.basis.z
		body.apply_central_impulse(force_direction * hit_force)
		pass

func _on_rigid_body_3d_2_body_entered(body: Node) -> void:
	if body is RigidBody3D:	
		# ハンマーの正面方向（例：Z軸マイナス方向）に吹き飛ばす
		var force_direction = -global_transform.basis.z
		body.apply_central_impulse(force_direction * hit_force)
		pass

func _on_rigid_body_3d_4_body_entered(body: Node) -> void:
	if body is RigidBody3D:
		# ハンマーの正面方向（例：Z軸マイナス方向）に吹き飛ばす
		var force_direction = -global_transform.basis.z
		body.apply_central_impulse(force_direction * hit_force)
		pass

func _on_rigid_body_3d_5_body_entered(body: Node) -> void:
	if body is RigidBody3D:
		# ハンマーの正面方向（例：Z軸マイナス方向）に吹き飛ばす
		var force_direction = -global_transform.basis.z
		body.apply_central_impulse(force_direction * hit_force)
		pass


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	pass # Replace with function body.
