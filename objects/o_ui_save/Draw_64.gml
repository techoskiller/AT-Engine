draw_set_font(loc_getfont(fnt_main))
draw_set_color(c_white)
draw_set_halign(fa_left)
ui_dialoguebox_create(54,59,212,87)
if (section == 1)
	draw_set_color(c_yellow)
draw_text_transformed(70-loc(0,6),70,global.name,1,1,0)
draw_text_transformed(146-loc(0,4),70,"LV "+string(global.lv),1,1,0)
draw_set_halign(fa_right)
draw_text_transformed(250+loc(0,2),70,time_reg,1,1,0)
draw_set_halign(fa_left)
var room_display = -1
if (section == 1)
	room_display = get_roomname(room)
else
	room_display = get_roomname(global.room_save)
draw_text_transformed(70+loc(0,90),90,room_display,1,1,0)
if (section == 1)
	draw_text_transformed(85+loc(0,7),120,loc("File saved.","セーブしました。"),1,1,0)
if (section == 0){
	draw_set_color(c_white)
	draw_text_transformed(85+loc(0,7),120,loc("Save","セーブ"),1,1,0)
	draw_text_transformed(175+loc(0,12),120,loc("Return","もどる"),1,1,0)
	var cursor_x=(selection==0)?71:161
	draw_sprite_ext(spr_ui_soul,0,cursor_x,123,1,1,0,c_red,1)
}
draw_set_color(c_white)
draw_set_halign(fa_left)
