function check_line_break(text, number, line_length, space, char_spacing, return_length=false) {
	var cur_index = number
	var length = 0
	var text_length = string_length(text);
	while (cur_index <= text_length) {
		var cj = string_char_at(text, cur_index);
		if (cj == " "||cj == "\t"||cj == "\n")
			break;
		if (cj == CMD_START) {
			var command_end_index = string_pos_ext(CMD_END, text, cur_index);
			if (command_end_index > 0) {
			    cur_index = command_end_index + string_length(CMD_END);
			    continue;
			}
		}
		
		length += string_width(cj) * char_spacing;
		cur_index++;
	}
	return return_length ? length : ((space + length) > line_length);
}

function scr_draw_each_letter(_x, _y, text, _outlineEnabled = false, _outlineSpace = 1, _outlineColour = c_black, spacing = 1, line_length = infinity, draw_count = string_length(text)) {
	static rainbow_time = 0;
	
	var font = draw_get_font() != -1 ? draw_get_font() : loc_getfont(fnt_main);
	if (spacing <= 1 && font = loc_getfont(fnt_main))
		spacing = loc(0.89, 0.94);
	var xx = _x;
	var yy = _y;
	var shake = false;
	var wave = false;
    var wavy = false;
	var shake_intensity = 1;
	var rainbow = false;
	var darkcol = false;
	var text_len = string_length(text);
	
	for (var i = 1; i < draw_count + 1; i++)
	{
	    var ch = string_char_at(text, i);
		var prev_char = string_char_at(text, i - 1);
		if (prev_char == "\t" || check_line_break(text, i, line_length, xx, spacing)) {
			xx = _x;
			yy += 18;
		}
	
		if (ch == CMD_START) {
			var end_index = string_pos_ext(CMD_END, text, i);
			if (string_char_at(text, i + 1) == CMD_START) {
				i++;
			} else {
				var cur_command = string_copy(text, i + 1, end_index - i - 1);
				var arg = string_split(string_lower(cur_command), ",");
				var arg_count = string_count(",", cur_command);
				switch(arg[0]) {
					case "font":
						if (arg_count == 0)
							draw_set_font(loc_getfont(fnt_main))
						else
							draw_set_font(asset_get_index(arg[1]))
					break;
					case "darkcol": case "dark_col": case "dark_color": case "darkcolor":
						darkcol^=true;
					break;
					case "red": case "c_red":
						draw_set_colour(c_red);
					break;
				
					case "blue": case "c_blue":
						draw_set_colour(c_blue);
					break;
                
					case "yellow": case "c_yellow":
						draw_set_colour(c_yellow);
					break;
                
					case "cyan": case "c_cyan":
						draw_set_colour(c_aqua);
					break; 
                
					case "rainbow": case "c_rainbow":
						rainbow ^= true;
						if (!rainbow)
							draw_set_colour(c_white);
					break;
				
					case "c":
						rainbow = false;
						draw_set_colour(c_white);
					break;
				
					case "voice":
						if (arg_count >= 1)
							voice = asset_get_index(arg[1]);
					break;
                
                    case "choice":
						if (arg_count == 0 || !instance_exists(o_ow_dialog))
							break;
						with (o_ow_dialog)
						{
							choices = arg[arg_count];
							on_choice = true;
						}
                    break;
				
					case "instant":
						pos = text_len;
					break;
				
					case "shake":
						shake ^= true;
						if (arg_count >= 1)
							shake_intensity = real(arg[1]);
					break;
				
					case "wave":
						wave ^= true;
					break;
                
					case "wavy":
						wavy ^= true;
					break;
				
					case "offx":
						if (arg_count>0)
							xx+=arg[1]
					break;
				
					case "offy":
						if (arg_count>0)
							yy+=arg[1]
					break;
				}

				if (instance_exists(o_ow_dialog)) {
					switch(arg[0]) {
						case "face":
							//only execute if the text isn't paused!
							if (wait > 0 && pos < text_len - 1)
								break;
							with (o_ow_dialog)
							{
								if (arg_count < 1)
								{
									face = undefined;
									break;
								}
								var asset = asset_get_index(arg[1]);
								if (asset_get_type(asset) == asset_sprite) {
									face = asset;
									if (sprite_get_speed(asset) <= 0 && arg_count >= 2)
										faceid = real(arg[2]);
								} else if (is_numeric(real(arg[1])))
									faceid = real(arg[1]);
							}
						break;
					}
				}

				i = end_index;
				continue;
			}
		}

	    if (ch == "\n")	{
	        xx = _x;
	        yy += 18;
	        continue;
	    }
		if (xx = _x && string_count("*", text) > 0 && ch != "*") {
			xx += string_width("* ") * spacing;
		}

		var ox = 0, oy = 0;

		if (shake) {
			var p = shake_intensity / 2;
			ox += random_range(-p, p);
			oy += random_range(-p, p);
		}

		if (wave) {
			oy += cos((i / 4) - ((current_time*.05) * 0.15)) * 2.5;
		}
        
		if (wavy) {
			var displace = cos((i / 4) - (current_time * 0.05 * 0.15)) * 2.5;
			ox += displace;
			oy += displace;
        }
        
		if (rainbow) {
			draw_set_colour(make_colour_hsv(abs(rainbow_time) % 290 - (i * 0.5), 255, 255));
		}
        
        if (_outlineEnabled) {
            var _textCol = draw_get_colour();
            
            draw_set_colour(_outlineColour);
            
            for (var ii = 0; ii < 360; ii += 45) 
            {
                draw_text(xx + ox + lengthdir_x(_outlineSpace, ii), yy + oy + lengthdir_y(_outlineSpace, ii), ch);
            }
            draw_set_colour(_textCol);
        }
        if (darkcol)
			draw_text_colour(xx+ox,yy+oy,ch,c_white,c_white,draw_get_colour(),draw_get_colour(),1)
		else
			draw_text(xx + ox, yy + oy, ch);

	    xx += string_width(ch) * spacing;
	}
	rainbow_time += 4;
	draw_set_color(c_white);
}

/* ---------------
 * by NamuFrames
 * Changes by Techoskiller and TK
 * ---------------
*/