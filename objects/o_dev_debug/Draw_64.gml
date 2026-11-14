draw_set_font(loc_getfont(fnt_main))
draw_set_color(c_white)
draw_set_alpha(1)

var xx = 30
var yy = 10

var options_main = [
	"Info",
	"Stats",
	"Console",
]

draw_set_color(c_black)
draw_set_alpha(0.5)
draw_rectangle(0,0,320,240,false)
draw_set_alpha(1)
draw_set_color(c_white)

if (menu==0){
	draw_text_outline(xx,yy,"AT-Engine/debug")

	for (var i=0; i<array_length(options_main); i++){
		var option_y = yy+32+i*16
		draw_set_color(i==selection?c_yellow:c_white)
		draw_text_outline(xx+10,option_y,options_main[i])
	}

	var soul_target_y = yy+37+selection*16
	if (soul_y==-999)
		soul_y = soul_target_y
	soul_y     = lerp(soul_y,soul_target_y,0.25)
	draw_set_color(c_white)
	draw_sprite_ext(spr_ui_soul,0,xx,soul_y,1,1,0,c_red,1)
}

if (menu==1){
	draw_text_outline(xx,yy,"AT-Engine/scripts/engine_info")
	
    var info = [
		"ENGINE: "+ENGINE_NAME,
		"VERSION: "+ENGINE_VERSION,
		"BRANCH: "+ENGINE_BRANCH
	]

	for (var i=0; i<array_length(info); i++){
		draw_text_outline(xx+10,yy+32+i*16,info[i])
	}
}

if (menu==2){
	draw_text_outline(xx,yy,"AT-Engine/objects/o_world/create/global.")

	for (var i=0; i<array_length(stats_options); i++){
		var option    = stats_options[i]
        var option_y  = yy+32+i*16
        var value     = option.get()
        var max_value = is_callable(option.max)?option.max():option.max

		draw_set_color(i==stats_selection?c_yellow:c_white)
		draw_text_outline(xx+10,option_y,option.name+": "+string(value))
		draw_text_outline(137,option_y,string(option.get())+"/"+string(option.max()))
	}

	var soul_target_y = yy+37+stats_selection*16
	if (soul_y==-999)
		soul_y = soul_target_y
	soul_y     = lerp(soul_y,soul_target_y,0.25)

	draw_set_color(c_white)
	draw_sprite_ext(spr_ui_soul,0,xx,soul_y,1,1,0,c_red,1)
}

if (menu==3){
	draw_text_outline(xx,yy,"AT-Engine/objects/o_world/create/global.")

    var console = [
		"TIME: "+string(global.time),
		"ROOM: "+string(global.room_name),
		"LANG: "+string(global.lang),
	]

	for (var i=0; i<array_length(console); i++){
		draw_text_outline(xx+10,yy+32+i*16,console[i])
	}
}

if (menu!=0){
	draw_set_color(c_gray)
    draw_text_outline(xx,215,"[CANCEL] BACK")
}

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_halign(fa_left)