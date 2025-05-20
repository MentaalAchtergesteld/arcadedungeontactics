class_name Healthbar
extends ProgressBar

@export var health_component: HealthComponent: set = set_health_component;

@export var tween_time: float = 0.3;

func set_health_component(new_health_component: HealthComponent) -> void:
	if health_component:
		disconnect_signals();
	health_component = new_health_component;
	update_values();
	connect_signals();

func update_values() -> void:
	value = health_component.current_health;
	max_value = health_component.max_health;

func disconnect_signals() -> void:
	health_component.max_health_changed.disconnect(_on_max_health_changed);
	health_component.health_changed.disconnect(_on_health_changed);

func connect_signals() -> void:
	health_component.max_health_changed.connect(_on_max_health_changed);
	health_component.health_changed.connect(_on_health_changed);

func _on_max_health_changed(new_max_health: int, amount: int) -> void:
	var tween = create_tween();
	tween.set_ease(Tween.EASE_OUT);
	tween.set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(self, "max_value", new_max_health, tween_time);

func _on_health_changed(new_health: int, amount: int) -> void:
	var tween = create_tween();
	tween.set_ease(Tween.EASE_OUT);
	tween.set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(self, "value", new_health, tween_time);
