class_name FreezeManager
extends EffectManager

@onready var particles: CPUParticles2D = $CPUParticles2D;

var freeze_counter: int = 0;

func _on_turn_start() -> void:
	freeze_counter -= 1;
	if freeze_counter > 0:
		if dispatcher.position_component:
			dispatcher.position_component.enabled = false;
		
		particles.emitting = true;
	else:
		if dispatcher.position_component:
			dispatcher.position_component.enabled = true;
		
		particles.emitting = false;

func try_apply(attacker: Node, effect: EntityEffect) -> bool:
	super(attacker, effect);
	if effect.type != EntityEffect.Type.Freeze: return false;
	
	freeze_counter += effect.duration;
	
	return true;
