if (xx!=0||yy!=0){
    if (ready) ui_dialoguebox_create(xx+camerachangex, yy+camerachangey, width, height);
    
    if (asset_get_type(face) == asset_sprite) {
    	draw_sprite(face,faceid,xx+camerachangex+13+25,yy+camerachangey+14+23)
		if instance_exists(t)
			t.x = xx + typer_x_offset + 58
    } else {
		if instance_exists(t)
			t.x = xx + typer_x_offset;
	}
    if (instance_exists(t)) {
    	if (on_choice) {
    		draw_set_font(loc_getfont(fnt_main))
    		for(var i = 0; i < array_length(choices); i++) {
    			var soul_width = sprite_get_width(spr_ui_soul)
    			var name = choices[i].name
    			var more = 0
    			var four = 0.01
    			var total = 0
    			if (array_length(choices)==1){
    				more=40
    			}else if array_length(choices)>2{
    				more=20
    			}
    			if array_length(choices)==4{
    				four=1.5
    				total=xx+(width/array_length(choices)*0.6)+(86+soul_width)*i/four-more
    			}
    			else{
    				total=xx+(width/array_length(choices)*0.6)+(86+soul_width)*i-more
    			}
    			var pos = {
    				x: total,
    				y: yy+height-30,
    				width: string_width(choices[i].name)
    			}
    
    			if (ch_index == i) {
    				draw_sprite_ext(spr_ui_soul,0,pos.x-sprite_get_width(spr_ui_soul)-4+camerachangex,pos.y+string_height(name)/3-2+camerachangey,1,1,0,c_red,draw_get_alpha)
    			}
    			draw_text(pos.x+camerachangex,pos.y+camerachangey,name)
    		}
    		draw_set_font(-1)
    	}
    }
    draw_set_colour(c_white)
}