class_name EnemySpawner extends Path2D

@export var spawn_time : float = 2

@onready var spawn_point : PathFollow2D = $EnemySpawnPoint
var spawn_timer : Timer = Timer.new()

var enemy_scene : PackedScene = preload("res://Entities/Enemies/enemy.tscn")

var slime : EnemyStats = preload("res://Resources/Enemies/slime.tres")

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	spawn_timer.start(spawn_time)

func _on_spawn_timer_timeout():
	spawn_point.progress_ratio = randf_range(0, 1)
	
	var enemy : Enemy = enemy_scene.instantiate()
	enemy.position = spawn_point.position
	enemy.enemy_stats = slime
	
	get_parent().add_child(enemy)
