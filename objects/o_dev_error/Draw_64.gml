draw_set_font(loc_getfont(fnt_main));
draw_set_halign(fa_center)
draw_text_transformed(320/2,53+74/2-50,loc("It looks like nothing\nhas been done here yet...","ここは まだ 何も\nされていないみたいだ…"),1,1,0)
draw_sprite(spr_dev_dogshrine,o_world.frames/30,320/2,53+74/2+120-50)
draw_set_halign(fa_left)
