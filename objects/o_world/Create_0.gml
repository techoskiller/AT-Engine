global.lang = ""

global.console = false

global.time = 0
global.room_name = ""

global.name = ""
global.lv = 0
global.maxhp = 0
global.hp = 0
global.att = 0
global.def = 0
global.attack = 0
global.defense = 0
global.exp = 0
global.nextexp = 0

global.facing = 0

global.items = []
global.phonelist = []

global.inventory = [""]

global.weapon = ""
global.armor = ""

global.input_delay = 0;

global.fun_value = 0;

global.current_encounter = 0;

// border_surface = surface_create(window_get_width(),window_get_height());	
dialogue_destroywarn = false;
frames         = 0;
global.borders = true;
border_spr     = spr_ui_border_simple;
old_border     = spr_ui_border_simple;
border_test    = true;
border_alpha   = 1.0;
border_wait    = false;

border_x = 0;
border_y = 0;
game_x = 0;
game_y = 0;
ratio = 0;

BASE_WIDTH     = 320;
BASE_HEIGHT    = 240;

__window_update = function() {
	var _target_w = (global.borders ? 960 : 640);
	var _target_h = (global.borders ? 540 : 480);
	
	window_set_size(_target_w, _target_h);
	surface_resize(application_surface, 640, 480);
	alarm[0] = 1; 
}

application_surface_draw_enable(false);
__window_update()