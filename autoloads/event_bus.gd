extends Node

#signal execute_action(caster: Unit, origin: Vector2i, target: Vector2i, action: Action);

signal hide_actions;
signal show_actions(actions: Array[Action]);
signal action_chosen(action: Action, position: Vector2i);

signal clear_all_highlights;
signal clear_radius_highlights(center: Vector2i, radius: int);
signal clear_area_highlights(area: Array[Vector2i]);

signal highlight_area(primary: Vector2i, area: Array[Vector2i], color: Color);
signal highlight_radius(center: Vector2i, radius: int, color: Color);


signal set_winner(team: UnitTeam);
signal set_winner_draw;
signal clear_winner;
