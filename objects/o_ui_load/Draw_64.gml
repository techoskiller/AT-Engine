/*
draw_set_font(loc_getfont(fnt_main));

if (section==2){
   draw_text_transformed(320/2.5, 240/2 + (20 / 2), "CHARA", 1 + (85 / 40), 1 + (85 / 40), irandom_range((-random(3) * 80) / 60, (random(3) * 80) / 60))
}else{
draw_sprite(spr_bg_floweyglow,0,0,-120)

if (section==1)
	draw_set_color(c_yellow)

draw_text_transformed(54+20.5-4-loc(0,6),106+74-20-80-10-9,string(global.name),1,1,0)
draw_text_transformed(54+20.5-4+75.75+8-loc(0,4),106+74-20-80-10-9,"LV "+string(global.lv),1,1,0)
draw_set_halign(fa_right)
draw_text_transformed(54+20.5+75.75+62+38+loc(0,2),53+37-20-9,time_reg,1,1,0)
draw_set_halign(fa_left)

if (global.lang=="ja")
	draw_set_halign(fa_center)
if !(section==1){
	ini_open("config.ini")
	draw_text_transformed(54+20.5-4+loc(0,90),53+74/2-11,global.room_save,1,1,0)
}
draw_set_halign(fa_left)
if (section==1){
	draw_text_transformed(54+20.5-4+loc(0,90),53+74/2-11,get_roomname(global.room_save),1,1,0)
	draw_text_transformed(54+35-4,53+67.5-11,loc("File saved.","セーブしました。"),1,1,0)
	global.room_save=room
	//saving part
    ini_open("config.ini")
    ini_write_string("config","lang",global.lang)
	ini_write_string("config","time",global.time)
	ini_write_string("config","room",global.room_save)
	ini_write_string("config","name",global.name)
	ini_write_string("config","lv",global.lv)
	ini_write_string("config","att",global.att)
	ini_write_string("config","def",global.def)
	ini_write_string("config","attack",global.attack)
	ini_write_string("config","defense",global.defense)
	ini_write_string("config","exp",global.exp)
	ini_write_string("config","gold",global.gold)
	ini_write_string("config","weapon",global.weapon)
	ini_write_string("config","armor",global.armor)
	ini_close()
}
if (section==0){
	if (selection==0)
		draw_set_colour(c_yellow)
	else
		draw_set_colour(c_white)
	draw_text_transformed(54+35-4+loc(0,7),53+67.5-16,loc("Continue","セーブ"),1,1,0)
	if (selection==1)
		draw_set_colour(c_yellow)
	else
		draw_set_colour(c_white)
	draw_text_transformed(54+70+90-39+loc(0,12)+20,53+67.5-16,loc("Reset","もどる"),1,1,0)
}

draw_set_color(c_white)
draw_set_color(8421504);
draw_set_font(font_menu)
draw_set_halign(fa_center)
var version = "0.0.9"
draw_text(160, 232, "UNDERTALE ENGINE v" + version + " (C) Toby Fox 2015-2017");
draw_set_halign(fa_left)
}
draw_set_color(c_white)
draw_set_halign(fa_left)
