class_name PoisonDart
extends Node2D

signal finished;
signal hit;

@onready var hitbox: HitboxComponent = $HitboxComponent;

@export var speed: float = 250;

var target: Vector2 = Vector2.ZERO;

func rotate_to_target():
	var delta = target-global_position;
	self.rotation = delta.angle();

func move_to_target():
	var distance = global_position.distance_to(target);
	var tween_time = distance / speed;
	
	var tween = create_tween();
	tween.set_ease(Tween.EASE_OUT);
	tween.set_trans(Tween.TRANS_QUAD);
	tween.tween_property(self, "position", target, tween_time);
	
	await tween.finished;
	
	hitbox.enabled = true;
	hit.emit();
	
	finished.emit.call_deferred();
	
func _ready() -> void:
	rotate_to_target();
	move_to_target();
	hitbox.hit.connect(func(_victim: Node): queue_free());


const POISON_DART = preload("res://entities/poison_dart/poison_dart.tscn")
static func create(position: Vector2, target: Vector2) -> PoisonDart:
	var poison_dart = POISON_DART.instantiate();
	poison_dart.global_position = position;
	poison_dart.target = target;
	return poison_dart;
