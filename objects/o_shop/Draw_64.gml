draw_set_font(loc_getfont(fnt_main))

{ // main boxes
    if (menu==SHOP_STATES.MAINMENU||SHOP_STATES.OTHERMENU){
        ui_dialoguebox_create(0,120,213,120)
        ui_dialoguebox_create(211,120,109,120)
    }
    if (menu==SHOP_STATES.TALKING){
        ui_dialoguebox_create(0,120,320,120)
    }
}
{ // stats
    draw_text(230,210,string(global.gold)+"G")
    draw_text(280,210,string(array_length(global.items))+"/"+"8")
}
{ // main menu
    if (menu==SHOP_STATES.MAINMENU){
        draw_sprite_ext(spr_ui_soul,0,225,134+20*mselection,1,1,0,c_red,1)
        for (var i = 0; i<array_length(mainmenu); i++){
            if !(mainmenu[i].selectable)
                draw_set_colour(c_gray)
            else
            	draw_set_colour(c_white)
            
            draw_text(240,130+20*i,mainmenu[i].name)
        }
    }
    draw_set_colour(c_white)
}
