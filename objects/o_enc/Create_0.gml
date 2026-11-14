audio_stop_all()
fader(1,0,15,c_black)
enum BATTLE_MENU {
	MAIN,
	FIGHT,
	CHOOSE_ENEMY, 
    ITEM,
	MERCY,
	ACT,
}

enum BATTLE_TURN {
	PLAYER,
	CUTSCENE,
	ENEMY,
	RESULT,
}

enum BG_TYPE {
	NOONE,
	DEFAULT,
	BOSS,
	DEPTHS,
}

encounterid = undefined
bgmid       = -1
enemies     = []
encounterbg = BG_TYPE.DEFAULT

buttons=[
	new enc_button_fight(),
	new enc_button_act(),
	new enc_button_item(),
	new enc_button_mercy(),
]

button_selection = 0

index = {
	current: 0,
	previous: [],
}

flavort    = ""
flavorinst = noone

textinst    = false
turncreated = false

input = 0

act_enemy_index = 0
act_index       = 0

board_x = 158
board_y = 158
board_w = 285
board_h = 67.5
board_a = 0

board_surface = -1

menu = {
    subcurrent: BATTLE_MENU.MAIN,
	current: BATTLE_MENU.MAIN,
	previous: [],
}

txt = {
	x: 26,
	y: 135,
}

turn = BATTLE_TURN.PLAYER

function init(_enc){
    encounterid = _enc;
    enemies = encounterid.enemies;
    flavort = encounterid.flavor;
    bgmid = encounterid.bgm;
    encounterbg = encounterid.bg_type;

    instance_create(o_enc_bg)
    for (var i=0; i<array_length(enemies); i++) {
        var enemy_data=enemies[i]
        var inst=instance_create(enemy_data.obj,320/2+(i-(array_length(enemies)-1)/2)*80,120,DEPTH_ENCOUNTER.ENEMY)
    }
    audio_play_sound(bgmid, 1, true);
}


set_controls = function(inputs,limit) {
	var prev_index = index.current
 
	index.current += inputs; //defines the input that affects the index
	
	//index limit
	if (index.current > limit) {index.current = 0};
	if (index.current < 0) {index.current = limit};
	if (prev_index != index.current) {audio_play_sound(snd_ui_move,0,0)} //sound if the index changed
}

set_controls_grid = function(list_length){
    if (list_length<=0)
        return

    var cols = 2
    var rows = ceil(list_length/cols)

    var cur = index.current
    var col = cur mod cols
    var row = cur div cols

    var moved = false

    if (InputPressed(INPUT.RIGHT)) {
        col = (col+1) mod cols
        moved = true
    }
    if (InputPressed(INPUT.LEFT)) {
        col = (col-1+cols) mod cols
        moved = true
    }
    if (InputPressed(INPUT.DOWN)) {
        row = (row+1) mod rows
        moved = true
    }
    if (InputPressed(INPUT.UP)) {
        row = (row-1+rows) mod rows
        moved = true
    }

    if (!moved)
        return

    var new_index = row*cols+col
    if (new_index>=list_length){
        new_index = row*cols
        if (new_index>=list_length){
            new_index = cur
        }
    }

    if (new_index!=cur) {
 
        index.current = new_index //defines the input that affects the index

        audio_play_sound(snd_ui_move,0,false) //sound if the index changed
    }
}

set_soul = function(_x,_y) {
	while (!instance_exists(o_enc_soul)) {instance_create(o_enc_soul,_x,_y)}
	o_enc_soul.x = _x
	o_enc_soul.y = _y
}

board = function(_x, _y, _w, _h, _angle){
    var spr = spr_pixel2x
    var bg = spr_pixel
    var pw = sprite_get_width(spr)
    var ph = sprite_get_height(spr)
    var cx = _x
    var cy = _y
    var hw = _w*0.5
    var hh = _h*0.5
    var ca = dcos(_angle)
    var sa = -dsin(_angle)
    var tlx = cx+(-hw)*ca-(-hh)*sa
    var tly = cy+(-hw)*sa+(-hh)*ca

    draw_sprite_ext(bg,0,tlx,tly,_w,_h,_angle,c_black,1)

    for (var i=-hw; i<=hw; i+=pw){
        var ox = i
        var oy = -hh
        var rx = cx+ox*ca-oy*sa
        var ry = cy+ox*sa+oy*ca
        draw_sprite_ext(spr,0,rx,ry,1,1,_angle,c_white,1)

        oy = hh
        rx = cx+ox*ca-oy*sa
        ry = cy+ox*sa+oy*ca
        draw_sprite_ext(spr,0,rx,ry,1,1,_angle,c_white,1)
    }

    for (var j=-hh+ph; j<hh; j+=ph){
        var ox = -hw
        var oy = j
        var rx = cx+ox*ca-oy*sa
        var ry = cy+ox*sa+oy*ca
        draw_sprite_ext(spr,0,rx,ry,1,1,_angle,c_white,1)

        ox = hw
        rx = cx+ox*ca-oy*sa
        ry = cy+ox*sa+oy*ca
        draw_sprite_ext(spr,0,rx,ry,1,1,_angle,c_white,1)
    }
}

draw_list_2x2 = function(list,get_name_func)
{
    draw_set_font(loc_getfont(fnt_main));

    for (var i=0; i<array_length(list); i++){

        var col = i mod 2;
        var row = i div 2;

        var xx = board_x - board_w*0.5 + 30 + col*120;
        var yy = board_y - board_h*0.5 + 10 + row*16;

        scr_draw_each_letter(xx, yy,"* " + string(get_name_func(list[i])),false,1,c_black);

        if (index.current == i)
            set_soul(xx - 8, yy + 4);
    }

    draw_set_font(-1);
}

draw_enemy_list = function(show_hp=false) {
    draw_set_font(loc_getfont(fnt_main))
    for (var i = 0; i<array_length(enemies); i++){
        var xx = board_x-board_w*0.5+20
        var yy = board_y-board_h*0.5+10+16*i
        if (show_hp){
            var text_w = string_width(enemies[i].name)
            var bar_x1 = xx+15+text_w+8+40
            var bar_x2 = bar_x1+40+20
            draw_healthbar(bar_x1,yy+6,bar_x2,yy+14,enemies[i].hp/enemies[i].maxhp*100,c_red,c_lime,c_lime,0,true,false)
        }
        if (enemies[i].can_mercy)
            scr_draw_each_letter(xx+15,yy+1,"(yellow)* "+string(enemies[i].name),false,1,c_black)
        else
            scr_draw_each_letter(xx+15,yy+1,"* "+string(enemies[i].name),false,1,c_black)

        if (index.current == i)
            set_soul(xx-4,yy+5)
    }
    draw_set_font(-1)
}

draw_act_list = function(){

    if (turn != BATTLE_TURN.PLAYER)
        return;

    var enemy = enemies[act_enemy_index];
    if (enemy == undefined)
        return;

    var acts = enemy.acts;
    if (array_length(acts) <= 0)
        return;

    draw_set_font(loc_getfont(fnt_main));

    for (var i = 0; i < array_length(acts); i++) {

        var col = i mod 2
        var row = i div 2

        var xx = board_x - board_w*0.5 + 30 + col*120
        var yy = board_y - board_h*0.5 + 10 + row*16

        scr_draw_each_letter(xx, yy,"* " + acts[i].name,false,1,c_black)

        if (i == act_index)
            set_soul(xx-14,yy+5)
    }

    draw_set_font(-1);
}

draw_item_list = function(){
    if (turn==BATTLE_TURN.PLAYER)
        return

    draw_list_2x2(global.items,function(i){
        return ItemGetName(i)
    })
}


set_menu = function(state, _index=0) {
	array_push(menu.previous,menu.current);
	array_push(index.previous,index.current);
	menu.current = state;
	index.current = _index;	
}

previous_state = function() {
	if (array_length(menu.previous) > 0) {
		menu.current = array_pop(menu.previous)
		index.current = array_pop(index.previous)
	}
}

alarm[0]=1