//--------------------------------
// THE cutscene.
//--------------------------------

// really want to point out that taylordev made this WHOLE system!! tysm
// I (techoskiller) changed it a bit, but except for that, they made everything lol

globalvar __cut_player_spd;
__cut_player_spd = 3;

function cutscene_t() constructor {
	queued	   = [];
	cursor	   = 0;
	is_running = false;
	index	   = -1;

	if (instance_exists(o_actor_mainpl))
		o_actor_mainpl.in_cutscene=is_running
    
	self.event = function() {
		if (!is_running) return false;
		
		var _queued = queued;
		
		if (cursor >= array_length(_queued)) {
			stop();
			return;
		}
		
		is_running	= true;
		
		var _init	= ( _queued[cursor][$ "init"]  ?? C_INIT_AUTO );
		if (is_callable(_init)) {
			_init();
			_queued[cursor][$ "init"] = C_INIT_AUTO;
		}
		
		var _func	= ( _queued[cursor][$ "event"] ?? C_EVENT_AUTO );
		if (is_callable(_func)) {
			if (_func()) cursor++;
		}
		
		return true;
	};

	static play = function() {
		if (is_running) return;
		
		is_running = true;
		
		var _ts = self;
		
		if (index < 0) {
			if (array_length(__cutscene_free_indices) > 0) {
				index = array_pop(__cutscene_free_indices);
				__cutscene_pool[index] = _ts;
			} else {
				array_push(__cutscene_pool, _ts);
				index = array_length(__cutscene_pool) - 1;
			}
		} else {
			__cutscene_pool[index] = _ts;
		}
	}
	
	static stop = function() {
		if (!is_running) return;
		
		if (index >= 0) {
			__cutscene_pool[index] = undefined;
			array_push(__cutscene_free_indices, index);
		}
		
		cursor = 0;
		index = -1;
		is_running = false;
	}
	
	static add = function(struct) {
		if (is_running) return self;
		
		array_push(queued, struct);
		return self;
	}
	
	static wait = function(frames) {
		cutscene_wait(self, frames);
		
		return self;
	}
	
	static wait_until = function(func)
	{
	    if (is_callable(func))
	        cutscene_wait_until(self, func);
	    return self;
	}
	
	static run = function(func) {
		cutscene_run(self, func);
		
		return self;
	}
	
	static dialogue = function(text, force_pos = is_top(), wait = true) {
	    cutscene_dialogue(self, text, force_pos, wait);
	    return self;
	}
	
	static moveable = function(toggle) {
		cutscene_player_moveable(self, toggle);
		return self;
	}
	
	static move = function(to_x, to_y, spd = 3, force_lock = C_FORCELOCK) {
		cutscene_player_move(self, to_x, to_y, spd, force_lock);
		return self;
	}
    
    static moveto = function(_target_x, _target_y, _speed = 3,_force_lock = C_FORCELOCK) {
		cutscene_player_moveto(self, _target_x, _target_y, _speed, _force_lock);
		return self;
	}
	
	static move_char_dir = function(char, dir, frames, wait = true) {
		cutscene_move_char_dir(self, char, dir, frames, wait);
		return self;
	}
}

//-------------------------------------------
// Helper functions
// Very Old-school C-styled
// Which me like
//-------------------------------------------

function cutscene_init() {
	__proc_inline;
	show_debug_message("\nCreated Cutscene Object\n");
	return new cutscene_t();
}

function cutscene_play(cut) {
	__proc_inline;
	cut.play();
}

function cutscene_stop(cut, on_queue = true) {
	__proc_inline;
	if (!on_queue) {
		cut.stop();
	}
	cut.add({
		_this: cut,
		init:  function() {
			_this.stop();
		}
	});
}

function cutscene_raw(cut, struct) {
	__proc_inline; // hope this gets inlined
	cut.add(struct);
}

function cutscene_wait_until(cut, func)
{
    cutscene_raw(cut, {
        init: function() {},
        event: func,
    });
}

function cutscene_wait(cut, frames) {
	__proc_inline;
	cutscene_raw(cut, {
		wait:  floor(frames), // strictly integers
		event: function() {
			return !( wait-- );
		}
	});
}

function cutscene_run(cut, func) {
	__proc_inline;
	cutscene_raw(cut, {
		init: func
	});
}

function __cutscene_player_move_logic(_tx, _ty, _ms) {
	__proc_inline;
	var _done = false;
	
	if (instance_exists(o_actor_mainpl)){
		with(o_actor_mainpl) {
			state = PLAYER_STATES.froozen;
			var _dist = point_distance(x, y, _tx, _ty);
			cut_moved = true;
		
			if (_dist <= _ms) {
				x = _tx;
				y = _ty;
				xprevious = x;
				yprevious = y;
				hsp = 0;
				vsp = 0;
				_done = true;
			} else {
				var _dir = point_direction(x, y, _tx, _ty);
				hsp = lengthdir_x(_ms, _dir);
				vsp = lengthdir_y(_ms, _dir);
			
				collision(o_solidparent);
			
				x += hsp;
				y += vsp;
				xprevious = x - hsp;
				yprevious = y - vsp;
				direction_animation();
			}
		
			if (_done) {
				cut_moved = false;
			}
		}
	}
	return _done;
}

function cutscene_player_moveto(cut, _target_x, _target_y, _speed = 3, _force_lock = C_FORCELOCK) {
	__proc_inline;
	cutscene_raw(cut, {
		tx: _target_x,
		ty: _target_y,
		ms: _speed,
		lock: _force_lock,
		event: function() {
			var _done = __cutscene_player_move_logic(tx, ty, ms);
			if (_done && instance_exists(o_actor_mainpl)) {
				o_actor_mainpl.cut_moved = false;
			}
			return _done;
		}
	});
}

function cutscene_player_move(cut, _rel_x, _rel_y, _speed = 3, _force_lock = C_FORCELOCK) {
	__proc_inline;
	cutscene_raw(cut, {
		rx:   _rel_x,
		ry:   _rel_y,
		ms:   _speed,
		lock: _force_lock,
		tx: 0,
		ty: 0,
		init_done: false,
		event: function() {
			if (!init_done) {
				if (instance_exists(o_actor_mainpl)) {
					tx = o_actor_mainpl.x + rx;
					ty = o_actor_mainpl.y + ry;
					init_done = true;
				}
			}
			return __cutscene_player_move_logic(tx, ty, ms);
		}
	});
}

function cutscene_dialogue(cut, text, force_pos = is_top(), wait = true) {
	__proc_inline;

	cutscene_raw(cut, {
		text_arr: is_array(text) ? text : [text],
		dia_inst: noone,
		pos: force_pos,
		wait: wait,

		init: function() {
			if (instance_exists(o_enc)) {
				dia_inst = enc_dialogue(text_arr);
			}
			else {
				dia_inst = Dialogue_Create(text_arr);
				dia_inst.top = pos;
			}
		},

		event: function() {
			if (!wait)
				return true;
				
			return !instance_exists(dia_inst);
		}
	});
}

function cutscene_player_moveable(cut, _moveable) {
	__proc_inline;
	cutscene_raw(cut, {
		val: _moveable,
		init: function() {
			if (instance_exists(o_actor_mainpl)){
				with(o_actor_mainpl) {
					moveable = other.val;
					if (!moveable) state = PLAYER_STATES.froozen;
					else state = PLAYER_STATES.free;
				}
			}
		}
	});
}

// wait is useful for digonal movement
// but undertale doesn't usually does diagonal movement
function cutscene_move_char_dir(cut, char, dir, frames, wait = true) {
	__proc_inline;
	cutscene_raw(cut, {
		val   : frames,
		to    : dir,
		targ  : char,
		
		init  : function() {
			var tar = self.targ;
			if (!instance_exists(tar)) return;
			tar.move[$ to] = int64(abs(val)); // truncate
		},
		
		event : function() {
			var tar = targ;
			if (!wait || !instance_exists(tar)) return 1;
			return !tar.move[$ to];
		}
	});
}