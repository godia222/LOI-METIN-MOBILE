
extends Node3D

var player: CharacterBody3D
var monster: MeshInstance3D
var info: Label

func _ready():
	var ground = MeshInstance3D.new()
	var plane = PlaneMesh.new()
	plane.size = Vector2(40, 40)
	ground.mesh = plane
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0.18, 0.35, 0.20)
	ground.material_override = mat
	add_child(ground)

	var sun = DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-55, -25, 0)
	add_child(sun)

	var camera = Camera3D.new()
	camera.position = Vector3(0, 9, 12)
	camera.rotation_degrees = Vector3(-30, 0, 0)
	camera.current = true
	add_child(camera)

	player = CharacterBody3D.new()
	player.position = Vector3(0, 1, 0)
	add_child(player)

	var body = MeshInstance3D.new()
	var capsule = CapsuleMesh.new()
	capsule.radius = 0.45
	capsule.height = 1.8
	body.mesh = capsule
	var blue = StandardMaterial3D.new()
	blue.albedo_color = Color(0.1, 0.45, 0.95)
	body.material_override = blue
	player.add_child(body)

	monster = MeshInstance3D.new()
	var cube = BoxMesh.new()
	cube.size = Vector3(1, 1.5, 1)
	monster.mesh = cube
	monster.position = Vector3(4, 0.75, -3)
	add_child(monster)

	var ui = CanvasLayer.new()
	add_child(ui)
	info = Label.new()
	info.position = Vector2(20, 20)
	info.text = "LOI METIN MOBILE - WASD: mover | ESPACO: atacar"
	ui.add_child(info)

func _physics_process(delta):
	var dir = Vector3.ZERO
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		dir.x -= 1
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		dir.x += 1
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		dir.z -= 1
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		dir.z += 1

	dir = dir.normalized()
	player.velocity.x = dir.x * 5.0
	player.velocity.z = dir.z * 5.0
	player.move_and_slide()

	if Input.is_key_pressed(KEY_SPACE):
		if player.global_position.distance_to(monster.global_position) < 3.0:
			info.text = "Ataque de treino!"
