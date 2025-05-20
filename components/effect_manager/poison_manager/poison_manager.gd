class_name PoisonManager
extends EffectManager

@onready var particles: CPUParticles2D = $CPUParticles2D;

var poison_counter: int = 0;

func start_effect() -> void:
	particles.emitting = true;

func stop_effect() -> void:
	particles.emitting = false;

func _on_turn_start() -> void:
	if poison_counter > 0:
		poison_counter -= 1;
		if dispatcher.health_component:
			dispatcher.health_component.damage(2);
		
		if poison_counter <= 0:
			stop_effect();

func try_apply(attacker: Node, effect: EntityEffect) -> bool:
	if effect.type != EntityEffect.Type.Poison: return false;
	
	poison_counter += effect.duration;
	if poison_counter > 0:
		start_effect();
	
	return true;
