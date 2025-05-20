class_name Icicle
extends Node2D

signal finished;
signal hit;

@export var rest_position: int = -64;
@export var hit_position: int = -18;
@export var tween_time: float = 0.2;

@onready var sprite: Sprite2D = $Sprite2D;
@onready var hitbox: HitboxComponent = $HitboxComponent;
@onready var particles: CPUParticles2D = $CPUParticles2D;
@onready var timer: Timer = $Timer;

func drop() -> void:
	var tween = create_tween();
	tween.set_ease(Tween.EASE_IN);
	tween.set_trans(Tween.TRANS_QUAD);
	tween.tween_property(sprite, "position:y", hit_position, tween_time);
	await tween.finished;
	hitbox.enabled = true;
	particles.emitting = true;
	
	hit.emit();
	
	timer.start();
	await timer.timeout;
	
	finished.emit.call_deferred();
	queue_free();

func _ready() -> void:
	sprite.position.y = rest_position;
	drop();



const ICICLE = preload("res://entities/icicle/icicle.tscn")
static func create(position: Vector2) -> Icicle:
	var icicle = ICICLE.instantiate();
	icicle.global_position = position;
	return icicle;
