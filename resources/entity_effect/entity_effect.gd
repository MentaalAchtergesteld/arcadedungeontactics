class_name EntityEffect
extends Resource

enum Type {
	Damage, # Instant plain damage
	Heal, # Instant plain heal
	Shield, # Instant plain shield
	Burn, # Deals 2 damage each turn when counter > 1
	Freeze, # Stuns unit when counter > 1, has slight cooldown when applied, can be removed with burn/time.
	Poison, # Deals 1 damage each turn when counter > 1, ignores shield.
};

@export var type: Type;
@export var amount: int = 0;
@export var duration: int = 1;

static func create(type: Type, amount: int, duration: int) -> EntityEffect:
	var e = EntityEffect.new();
	e.type = type;
	e.amount = amount;
	e.duration = duration;
	return e;

static func create_instant(type: Type, amount: int) -> EntityEffect:
	return create(type, amount, 1);

static func create_instant_damage(amount: int) -> EntityEffect:
	return create_instant(Type.Damage, amount);

static func create_instant_heal(amount: int) -> EntityEffect:
	return create_instant(Type.Heal, amount);

static func create_burn(duration: int) -> EntityEffect:
	return create(Type.Burn, 1, duration);

static func create_freeze(duration: int) -> EntityEffect:
	return create(Type.Freeze, 0, duration);

static func create_poison(duration: int) -> EntityEffect:
	return create(Type.Poison, 1, duration);
