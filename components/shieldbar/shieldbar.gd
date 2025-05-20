extends ProgressBar

@export var shield_component: ShieldComponent: set = set_shield_component;

@export var tween_time: float = 0.3;

func set_shield_component(new_shield_component: ShieldComponent) -> void:
	if shield_component:
		disconnect_signals();
	shield_component = new_shield_component;
	update_values();
	connect_signals();

func update_values() -> void:
	value = shield_component.current_shield;
	max_value = shield_component.max_shield;

func disconnect_signals() -> void:
	shield_component.max_shield_changed.disconnect(_on_max_shield_changed);
	shield_component.shield_changed.disconnect(_on_shield_changed);

func connect_signals() -> void:
	shield_component.max_shield_changed.connect(_on_max_shield_changed);
	shield_component.shield_changed.connect(_on_shield_changed);

func _on_max_shield_changed(new_max_shield: int, amount: int) -> void:
	var tween = create_tween();
	tween.set_ease(Tween.EASE_OUT);
	tween.set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(self, "max_value", new_max_shield, tween_time);

func _on_shield_changed(new_shield: int, amount: int) -> void:
	var tween = create_tween();
	tween.set_ease(Tween.EASE_OUT);
	tween.set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(self, "value", new_shield, tween_time);
