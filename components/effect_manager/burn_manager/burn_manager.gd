class_name BurnManager
extends EffectManager

@onready var particles: CPUParticles2D = $CPUParticles2D;

var burn_counter: int = 0;

func start_effect() -> void:
	particles.emitting = true;

func stop_effect() -> void:
	particles.emitting = false;

func _on_turn_start() -> void:
	if burn_counter > 0:
		burn_counter -= 1;
		var remaining_damage = 2;
		if dispatcher.shield_component:
			remaining_damage = dispatcher.shield_component.absorb_damage(remaining_damage);
		if dispatcher.health_component:
			dispatcher.health_component.damage(remaining_damage);
		
		if burn_counter <= 0:
			stop_effect();

func try_apply(attacker: Node, effect: EntityEffect) -> bool:
	if effect.type != EntityEffect.Type.Burn: return false;
	
	burn_counter += effect.duration;
	if burn_counter > 0:
		start_effect();
	
	return true;
