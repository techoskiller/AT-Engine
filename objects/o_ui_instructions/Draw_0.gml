draw_set_font(loc_getfont(fnt_main));
var lines;
lines[0] = "Confirm";
lines[1] = "Cancel";
lines[2] = "Menu (In-game)";
lines[3] = "Fullscreen";
lines[4] = "Quit";
keys[0] = "[Z or ENTER]";
keys[1] = "[X or SHIFT]";
keys[2] = "[C or CTRL]";
keys[3] = "[F4]";
keys[4] = "[Hold ESC]";
var num_lines = 5;
draw_set_color(12632256);
draw_set_halign(fa_left)
var label_x = 0;
draw_text(85,20-1," --- Instruction ---")
for (var i = 0; i<num_lines; i++){
	var key = keys[i] + " - " + lines[i]; // <localization fetch error>
	draw_text(85, 45 + 4 + (i * 18), key);
	var xx = 50 + string_width(key) + 20;
	if (xx > label_x)
		label_x = xx;
}
draw_text(85, 140-1, "When HP is 0, you lose.")
draw_set_color(c_white)

draw_set_color(8421504);
draw_set_font(fnt_menu)
draw_set_halign(fa_center)
draw_text(160, 232, "AT ENGINE " + ENGINE_VERSION + " (C) Toby Fox 2015-2017");
draw_set_halign(fa_left)
draw_set_color(c_white)
