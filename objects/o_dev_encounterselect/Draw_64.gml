draw_set_font(loc_getfont(fnt_main))
draw_set_color(c_white)
draw_set_alpha(1)

var xx          = 30
var yy          = 10
var max_visible = 12

draw_set_alpha(0.5)
draw_set_color(c_black)
draw_rectangle(0,0,320,240,false)
draw_set_alpha(1)
draw_set_color(c_white)

draw_text_outline(xx,yy,"AT-Engine/encounters")
draw_set_halign(fa_right)

if (array_length(list)==0){
	draw_text_outline(310,yy,"(no results)")
}
else{
	draw_text_outline(310,yy,"("+string(array_length(list))+" results)")
}

draw_set_halign(fa_left)
var scroll_target = clamp(selection-max_visible+4,0,max(0,array_length(list)-max_visible))
scroll_current    = lerp(scroll_current,scroll_target,0.15)

var surf_x = 0
var surf_y = yy+32
var surf_w = 320
var surf_h = max_visible*16

if (!surface_exists(menu_surface))
	menu_surface = surface_create(surf_w,surf_h)
surface_set_target(menu_surface)
draw_clear_alpha(c_black,0)
draw_set_color(c_white)

for (var i=0; i<array_length(list); i++){
	var draw_y = (i-scroll_current)*16
	if (draw_y<-16||draw_y>surf_h)
		continue
	var encounter = list[i]
	var name      = encounter.name
	
	if (array_contains(cant_use,encounter)){
		draw_set_color(c_gray)
	}
	else if (i==selection){
		draw_set_color(c_yellow)
	}
	else{
		draw_set_color(c_white)
	}
	draw_text_outline(xx,draw_y," "+name)
}

var soul_target_y = (selection-scroll_current)*16
if (soul_y==-999)
    soul_y = soul_target_y
soul_y     = lerp(soul_y,soul_target_y,0.25)

draw_set_color(c_white)
draw_sprite_ext(spr_ui_soul,0,xx-10,soul_y+5,1,1,0,c_red,1)
surface_reset_target()
draw_surface(menu_surface,surf_x,surf_y)
var max_scroll = max(0,array_length(list)-max_visible)
var wave       = sin(current_time/150)*3

if (scroll_target<max_scroll)
	draw_sprite_ext(spr_ui_arrow,0,15,surf_y+surf_h-20+wave,1,1,0,c_white,1)
if (scroll_target>0)
	draw_sprite_ext(spr_ui_arrow,0,15,surf_y-10-wave,1,1,180,c_white,1)

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_halign(fa_left)