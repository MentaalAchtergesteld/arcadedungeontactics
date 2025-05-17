class_name Lightning
extends Node2D

signal finished;
signal hit;

func _ready() -> void:
	$AnimatedSprite2D.play("default");

func _on_animated_sprite_2d_animation_finished() -> void:
	$Timer.start();
	await $Timer.timeout;
	
	finished.emit.call_deferred();
	queue_free();

func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.frame == 5:
		$CPUParticles2D.emitting = true;
		hit.emit();
		$HitboxComponent.enabled = true;

const LIGHTNING = preload("res://entities/lightning/lightning.tscn")
static func create(position: Vector2) -> Lightning:
	var lightning = LIGHTNING.instantiate();
	lightning.global_position = position;
	return lightning;
