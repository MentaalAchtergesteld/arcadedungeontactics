extends Node

signal execute_action(caster: Unit, origin: Vector2i, target: Vector2i, action: Action);

signal hide_actions;
signal show_actions(actions: Array[Action]);
signal action_chosen(action: Action);

signal highlight_area(primary: Vector2i, area: Array[Vector2i], color: Color);
signal clear_area_highlight(area: Array[Vector2i]);

signal highlight_tiles(tiles: Array[TileInfo]);
signal clear_highlights;
signal tile_clicked(pos: Vector2i);

signal set_winner(team: UnitTeam);
signal set_winner_draw;
signal clear_winner;
