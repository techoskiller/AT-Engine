board(board_x,board_y,board_w,board_h,board_a)
{ // buttons
	for (var i=0; i<array_length(buttons); i++){
		var _x = 16+78*i
        if (!(turn==BATTLE_TURN.CUTSCENE))&&(!(turn==BATTLE_TURN.ENEMY)){
		if (button_selection == i) {
			buttons[i].image_index=loc(1,3)
			set_soul(_x+4,216+7)
		} else {buttons[i].image_index=loc(0,2)}
        }
        else{
            set_soul(-10,-10)
            buttons[i].image_index=loc(0,2)
        }
		draw_sprite_ext(buttons[i].sprite,buttons[i].image_index,_x,216,0.5,0.5,0,c_white,1)
	}
}
{
	draw_set_font(loc_getfont(fnt_main))
	switch(menu.current) {
		case BATTLE_MENU.CHOOSE_ENEMY:
            for (var i = 0; i<array_length(enemies); i++){ 
                draw_enemy_list(enemies[i].show_hp)
            }
		break;
		
        case BATTLE_MENU.ACT:
            draw_act_list()
        break;
    
		case BATTLE_MENU.ITEM:
			draw_item_list()
		break;
	}
}
{ // bottom ui
	draw_set_font(fnt_mars)
	draw_text_transformed(15,200,global.name,0.5,0.5,0)
	draw_text_transformed(54+string_length(global.name),200,"LV "+string(global.lv),0.5,0.5,0)
	draw_sprite_ext(spr_enc_ui_hp,0,120,200,0.5,0.5,0,c_white,1)
    draw_healthbar(137,200,137+13+(global.lv-1)*2,200+10,(global.hp/global.maxhp)*100,c_red,c_yellow,c_yellow,0,true,false)
    //draw_sprite_ext(spr_pixel2x,0,137,200,6.6,4.9,0,c_yellow,1)
    //^^ old hp bar system
	draw_text_transformed(156+(global.lv-1)*2,200,string(global.hp)+" / "+string(global.maxhp),0.5,0.5,0)
}
draw_set_font(-1)
draw_set_colour(c_white)
