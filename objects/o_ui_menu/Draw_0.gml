draw_set_font(loc_getfont(fnt_main));

var addy = 136;
if (!top){
	addy = 0;
}
{ // box
	ui_dialoguebox_create(16+xxx, 26+4-5+addy+yyy, 71, 55)
	
	if array_length(options) > 3 { 
		// FIXED: Removed +yyy from the end (height) and added it to the second argument (y)
		ui_dialoguebox_create(16+xxx, 84 + 4-5 + yyy, 71, 35 + (array_length(options) - 1) * 18 + 3)
	}
	else {
		// FIXED: Removed +yyy from the end (height) and added it to the second argument (y)
		ui_dialoguebox_create(16+xxx, 84 + 4-5 + yyy, 71, 35 + 2 * 18 + 3)
	}
}
{ // top box
	draw_text(23+xxx,30+4-5+addy+yyy,string(global.name))
	
	draw_set_font(fnt_menu)
	draw_text(23+xxx,50-3+4+4-5+addy+yyy,"lv")
	draw_text(41+xxx,50-3+4+4-5+addy+yyy,string(global.lv))
	draw_text(23+xxx,59-3+4+4-5+addy+yyy,"hp")
	draw_text(41+xxx,59-3+4+4-5+addy+yyy,$"{string(global.hp)}/{string(global.maxhp)}")
	draw_text(23+xxx,68-3+4+4-5+addy+yyy,"G")
	draw_text(41+xxx,68-3+4+4-5+addy+yyy,string(global.gold))
}
{ // options
	draw_set_font(loc_getfont(fnt_main));
	for (var i = 0; i < array_length(options); ++i) {
		
		if (selection == i && state == 0)
			if (!instance_exists(o_ow_dialog)&&!waiting)
				draw_sprite_ext(spr_ui_soul,0,28+xxx,98+18*i+4-5+yyy,1,1,0,c_red,1)
			
		if (!options[i].selectable)
            draw_set_color(c_gray)
			
		draw_text_transformed(42+xxx,98+18*i+4-4-5+yyy,options[i].name,1,1,0)
		draw_set_color(c_white)
	}
}
{ // box for each state
	if (state==1){
		ui_dialoguebox_create(94+xxx, 26+yyy, 173, 181)
	}else
		if (state==2){
			ui_dialoguebox_create(94+xxx, 26-1+yyy, 173, 209)
	}else
		if (state==3){
			ui_dialoguebox_create(94+xxx, 26+yyy, 173, 181)
	}
}
{ // state 1 (ITEM)
	if (state==1) {
		for (var i=0; i<array_length(global.items); i++){
			if (sub_state==0&&i==item_selection)
				draw_sprite_ext(spr_ui_soul,0,104+xxx,44+i*16+yyy,1,1,0,c_red,1)
			draw_text(116+xxx,40+i*16+yyy,global.items[i].name.normal)
		}

		for (var i=0; i<array_length(item_actions); i++){
				var xx=116+i*48
				if (!item_actions[i].selectable)
					draw_set_color(c_gray)
				draw_text(xx+xxx,180+yyy,item_actions[i].name)
		}
	}
	if (state==1&&sub_state==1){
		for (var i=0; i<array_length(item_actions); i++){
			var xx=116+i*48
			if (i==item_action_selection)
				draw_sprite_ext(spr_ui_soul,0,xx-12+xxx,184+yyy,1,1,0,c_red,1)
			draw_set_color(c_white)
		}
	}
}
{ // state 2 (STAT)
	if (state==2){
		draw_text(108+xxx, 42-1+yyy, $"\"{global.name}\"")
		draw_text(108+xxx, 72-1+yyy, "LV")
		draw_text(128+xxx, 72-1+yyy, $"{global.lv}")
		draw_text(108+xxx, 88-1+yyy, "HP")
		draw_text(128+xxx, 88-1+yyy, $"{global.hp} / {global.maxhp}")
	
		draw_text(108+xxx, 120-1+yyy, "AT")
		draw_text(128+xxx, 120-1+yyy, $"{global.att} ({global.attack})")
		draw_text(108+xxx, 136-1+yyy, "DF")
		draw_text(128+xxx, 136-1+yyy, $"{global.def} ({global.defense})")
	
		draw_text(192+xxx, 120-1+yyy, $"EXP: {global.exp}")
		draw_text(192+xxx, 136-1+yyy, $"NEXT: {global.nextexp}")
	
		draw_text(108+xxx, 166-1+yyy, $"WEAPON: {is_struct(global.weapon) ? global.weapon.name.normal : "(NONE)"}")
		draw_text(108+xxx, 182-1+yyy, $"ARMOR: {is_struct(global.armor) ? global.armor.name.normal : "(NONE)"}")
		draw_text(108+xxx, 202-1+yyy, $"GOLD: {global.gold}")
	}
}
{ // state 3 (CELL)
	if (state==3){
		for (var i=0; i<array_length(cells); i++) {
			if (i==cell_selection)
				draw_sprite_ext(spr_ui_soul,0,104+xxx,44+i*16+yyy,1,1,0,c_red,1)
			draw_text(116+xxx,40+i*16+yyy,cells[i].name)
		}
	}
}
draw_set_color(c_white)
