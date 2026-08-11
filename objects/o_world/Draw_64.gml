display_set_gui_maximise(1, 1, 0, 0);

if (global.borders) {
	var _border_spr = border_spr;

	if (!is_ptr(_border_spr) && sprite_exists(_border_spr)) {
		draw_sprite_stretched_ext(_border_spr, 0, border_x, border_y, 960 * ratio, 540 * ratio, c_white, border_alpha);
	}
	else if (_border_spr == B_PILLARBOX) {
		var _bg_w = 960 * ratio;
		var _bg_h = 720 * ratio;
		var _bg_y_offset = (540 * ratio - _bg_h) * 0.5;

		draw_surface_stretched_ext(application_surface, border_x, border_y + _bg_y_offset, _bg_w, _bg_h, BORDER_PB_COL, border_alpha);
		draw_sprite_stretched_ext(spr_ui_border_outline, 0, border_x, border_y, 960 * ratio, 540 * ratio, c_white, border_alpha);
	}
}

display_set_gui_size(BASE_WIDTH, BASE_HEIGHT);
display_set_gui_maximise(ratio * 2, ratio * 2, game_x, game_y);