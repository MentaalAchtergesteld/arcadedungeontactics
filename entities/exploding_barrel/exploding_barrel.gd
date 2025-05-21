class_name ExplodingBarrel
extends Node2D

@onready var particles: GPUParticles2D = $GPUParticles2D;
@onready var hurtbox: HurtboxComponent = $HurtboxComponent;
@onready var hitbox: HitboxComponent = $HitboxComponent;
@onready var timer: Timer = $Timer;

func _on_hurt(attacker: Node, effects: Array[EntityEffect]) -> void:
	particles.emitting = true;
	hitbox.enabled = true;
	
	timer.start(0.5);
	await timer.timeout;
	queue_free();

func _ready() -> void:
	hurtbox.hurt.connect(_on_hurt);
