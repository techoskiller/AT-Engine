var _old_bord = global.borders
frames ++

if keyboard_check_pressed(vk_f2) {
	game_restart()
}

if keyboard_check_pressed(vk_f4) {
	window_set_fullscreen(!window_get_fullscreen())
    if !window_get_fullscreen() {
        alarm[0] = 1;
	}
}

if (keyboard_check(vk_shift)&&keyboard_check_pressed(ord("D"))){
	global.debug = !global.debug
	if (global.debug) {
		instance_create(o_dev_debug)	
	} else {instance_destroy(o_dev_debug)}
}

if (keyboard_check(vk_shift)&&keyboard_check_pressed(ord("L"))) {
	room_restart()
	audio_stop_all()
	global.time=0
	if (global.lang == "en"){
		global.lang = "ja"
	}else
	{
		global.lang = "en"
	}
}
if (keyboard_check(vk_shift)&&keyboard_check_pressed(ord("R"))) {
	if (!instance_exists(o_dev_roomselect)) {
		instance_create(o_dev_roomselect,0,0,-9999)
	} else {instance_destroy(o_dev_roomselect)}
}

if (keyboard_check(vk_shift)&&keyboard_check_pressed(ord("E"))) {
	if (!instance_exists(o_dev_encounterselect)) {
		instance_create(o_dev_encounterselect,0,0,-9999)
	} else {instance_destroy(o_dev_encounterselect)}
}

if (frames % 30 == 0) { global.time++ }

global.room_name=room_get_name(room)
if (global.input_delay > 0) global.input_delay--


//---------------------------------
// For the border testing stuff
//---------------------------------
if (border_test && keyboard_check_pressed(ord("H"))) {
	border_set_state(!border_get_state());
}

if (global.borders != _old_bord) __window_update();
    
if (border_alpha < 1.0) {
    border_alpha += 0.050; // adjust this, maybe?
    
    if (border_alpha >= 1.0) {
        old_border  = border_spr;
        border_wait = false;
    }
}

// this could be overriden mid-wait
// but thats a rare thing to happen
if (!border_wait && old_border != border_spr && border_alpha >= 1.0) {
    border_alpha = 0;
    border_wait  = true;
}

/* --------------------------------
 * For the border system (new)
 * -------------------------------- */
var _win_w = window_get_width();
var _win_h = window_get_height();

var _target_w = (global.borders ? 960 : 640);
var _target_h = (global.borders ? 540 : 480);
ratio = min(_win_w / _target_w, _win_h / _target_h);

border_x = (_win_w - (_target_w * ratio)) * 0.5;
border_y = (_win_h - (_target_h * ratio)) * 0.5;

game_w = 640 * ratio;
game_h = 480 * ratio;

game_x = border_x + (global.borders ? 160 * ratio : 0);
game_y = border_y + (global.borders ? 30 * ratio : 0);