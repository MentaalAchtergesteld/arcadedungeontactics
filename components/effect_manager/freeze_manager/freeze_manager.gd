class_name FreezeManager
extends EffectManager

@onready var particles: GPUParticles2D = $GPUParticles2D;

@export var max_cooldown: int = 1;

var freeze_counter: int = 0;
var cooldown_counter: int = 0;

func start_effect() -> void:
	particles.emitting = true;
	
	if dispatcher.position_component:
		dispatcher.position_component.enabled = false;

func stop_effect() -> void:
	particles.emitting = false;
	if dispatcher.position_component:
		dispatcher.position_component.enabled = true;

func _on_turn_start() -> void:
	if freeze_counter > 0:
		freeze_counter -= 1;
		
		if freeze_counter <= 0:
			stop_effect();
	elif cooldown_counter > 0:
		cooldown_counter -= 1;

func try_apply(attacker: Node, effect: EntityEffect) -> bool:
	match effect.type:
		EntityEffect.Type.Burn:
			cooldown_counter = 0;
			return false;
		EntityEffect.Type.Freeze:
			if cooldown_counter > 0: return true;
			freeze_counter += effect.duration;
			if freeze_counter > 0:
				cooldown_counter = max_cooldown;
				start_effect();
			return true;
		_:
			return false;
