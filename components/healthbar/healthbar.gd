class_name Healthbar
extends ProgressBar

@export var health_component: HealthComponent: set = set_health_component;

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

func _on_max_health_changed(max_health: int, amount: int) -> void:
	max_value = max_health;

func _on_health_changed(current_health: int, amount: int) -> void:
	value = current_health;
