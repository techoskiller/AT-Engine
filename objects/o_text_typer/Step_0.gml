if (!finished){
	var txt_len = string_length(text)
	while (string_char_at(text,pos) == CMD_START) {
		var end_index = string_pos_ext(CMD_END,text,pos)
		if (string_char_at(text,pos+1) == CMD_START) {
			pos++;
			break;
		} else {
			var arg = string_split(string_lower(string_copy(text, pos+1, (end_index - pos)-1)),",")
			var arg_count = array_length(arg)-1
			switch(arg[0]) {
				
				case "can_continue":
					if (arg_count > 0)
						can_continue=bool(arg[1])
				break;
				
				case "can_skip":
					if (arg_count > 0)
						can_skip=bool(arg[1])
				break;
				
				case "spd": case "speed":
					if (arg_count > 0) {
						spd = real(arg[1])
					} else {spd = 1}
				break;
				
				case "w": case "wait": case ",":
					if (arg_count >= 1) { 
                        wait = real(arg[1])	
					} else {wait = 10}
				break;
            
                case "choice":
                    if (arg_count>0){
                        if instance_exists(o_ow_dialog){
                            o_ow_dialog.choices=arg[arg_count]
                            o_ow_dialog.on_choice=true
                        }
                    }
                break;
                            
                case "setvar": case "varset":
                	if (arg_count>=3) {
                		var inst=asset_get_index(arg[1])
                		var var_name=string(arg[2])
                		var value_raw=arg[3]
                		var value
                		if (string_char_at(value_raw,1)=="'"&&string_char_at(value_raw,string_length(value_raw))=="'"){
                			value=string_copy(value_raw,2,string_length(value_raw)-2)
                		}
                		else{
                			var is_number=true
                			var has_dot=false
                			
                			for (var i=1; i<=string_length(value_raw); i++){
                				var c=string_char_at(value_raw,i)
                				if (c=="."){
                					if(has_dot){
                						is_number=false
                						break;
                					}
                					has_dot = true;
                				}
                				else if !(c == "-" && i == 1) && (string_pos(c, "0123456789") == 0){
                					is_number=false
                					break;
                				}
                			}
                			if (is_number){
                				value=real(value_raw)
                			}
                			else{
                				var asset=asset_get_index(value_raw)
                				if (asset!=-1){
                					value=asset
                				}
                                else{
                					value=value_raw
                				}
                			}
                		}
                		with (inst)
                			variable_instance_set(id, var_name, value);
                	}
                break;
				
				case "snd": case "sound":
					if (arg_count >= 1) {
						var asset = asset_get_index(arg[1])
						var loops = arg_count >= 3 ? real(arg[3]) : 0
						var pri = arg_count >= 2 ? real(arg[2]) : 0
						var gain = arg_count >= 4 ? real(arg[4]) : 1
						var pitch = arg_count >= 5 ? real(arg[5]) : 1
						if (asset_get_type(asset) == asset_sound) {
							audio_play_sound(asset,pri,loops,gain,0,pitch)	
						}
					}
				break;
            
                case "esnd": case "esound":
					if (arg_count >= 1) {
						var asset = asset_get_index(arg[1])
						if (asset_get_type(asset) == asset_sound) {
							audio_stop_sound(asset)	
						}
					}
				break;
			}
			pos += (end_index-pos)+1;
		}
	}	
	if (wait <= 0) {
		pos+=spd
	} else {wait--}

	var current_index = floor(pos)
	if (current_index != last_pos){
		cur_char=string_char_at(text,current_index)
		if (string_count(cur_char,".,") >= 1){
			wait=10
		}
		if (string_count(cur_char," .,:;!?-=+[]()<>{}@#$%¨&*´`~^/\"'") <= 0){
			audio_play_sound(voice,0,false)
		}
		last_pos = current_index;
	}
	
	if (pos >= txt_len){
		finished = true
	}
}

if (InputPressed(INPUT.CONFIRM)){
	if (finished){
		if can_continue
			line++
	}
}
if (can_skip && InputPressed(INPUT.CANCEL))
	pos = string_length(text)