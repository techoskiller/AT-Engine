draw_set_font(loc_getfont(fnt_main));

{
	draw_text_transformed(54+20.5-4-loc(0,6),106+74-20-80-10-9,string(global.name),1,1,0)
	draw_text_transformed(54+20.5-4+75.75+8-loc(0,4),106+74-20-80-10-9,"LV "+string(global.lv),1,1,0)
	draw_set_halign(fa_right)
	draw_text_transformed(54+20.5+75.75+62+38+loc(0,2),53+37-20-9,time_reg,1,1,0)
	draw_set_halign(fa_left)
	
	// all types
	draw_sprite(spr_bg_floweyglow,0,0,-120)
	if (types==1)
		draw_sprite(spr_ow_flowey,0,147,169)
	if (types==2)
		draw_sprite(spr_ow_chairiel,0,125,138)
	if (types==3){
		draw_sprite(spr_ow_chairiel_sleep,o_world.frames/8,125,138)
		draw_sprite(spr_ow_papyrusd_dark,0,241,151)
		draw_sprite(spr_ow_sanssh_dark,0,271,164)
	}
	if (types==4){ 
		draw_sprite(spr_ow_chairiel_sleep,o_world.frames/8,125,138)
		draw_sprite(spr_ow_papyrusc_dark,0,loc(243, 251),151)
		draw_sprite(spr_ow_undyneyrm_dark,0,loc(243, 251)-3,103)
		draw_sprite(spr_ow_sanssh_dark,0,63,loc(33,28))
	}
	if (types==5){ 
		draw_sprite(spr_ow_chairiel_sleep,o_world.frames/8,125,138)
		draw_sprite(spr_ow_alphysd_dark,0,270,167)
		draw_sprite(spr_ow_papyrusc_dark,0,272,132)
		draw_sprite(spr_ow_undyneyrm_dark,0,269,84)
		draw_sprite(spr_ow_otl_sign,loc(0,1),20,169)
	}
	if (types==6){ 
        draw_sprite(spr_ow_torield_dark,0,143,138)
        draw_sprite(spr_ow_papyrusd_dark,0,119,147)
        draw_sprite(spr_ow_sansd_dark,0,172,161)
        draw_sprite(spr_ow_undyned_dark,0,99,136)
        draw_sprite(spr_ow_alphysd_dark2,0,74,158)
        draw_sprite(spr_ow_asgored_dark,0,195,130)
        draw_sprite(spr_ow_napstablookd,0,9,157)
        draw_sprite(spr_ow_mettatonpu,0,28,139)
        draw_sprite(spr_mkidd_dark,0,262,162)
	}
	
	if (global.lang=="ja")
		draw_set_halign(fa_center)
	draw_text_transformed(54+20.5-4+loc(0,90),53+74/2-11,get_roomname(global.room_save),1,1,0)

	if (section==0){
		draw_set_color(selection==0?c_yellow:c_white)
		draw_text_transformed(54+35-4+loc(0,7),53+67.5-16,loc("Continue","コンティニュー"),1,1,0)
		draw_set_color(selection==1?c_yellow:c_white)
		draw_text_transformed(54+70+90-39+loc(0,12)+20,53+67.5-16,loc("Reset","リセット"),1,1,0)
	}
	
	draw_set_color(8421504)
	draw_set_font(fnt_menu)
	draw_set_halign(fa_center)
	draw_text(160,232,"UNDERTALE ENGINE "+ENGINE_VERSION+" (C) Toby Fox 2015-2017")
	draw_set_halign(fa_left)
	draw_set_color(c_white)
}
