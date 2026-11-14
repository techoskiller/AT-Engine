global.dialogue_typers = {};
function Dialogue_Make_Typer(name, substitute) {
	global.dialogue_typers[$ name] = substitute;
}
Dialogue_Make_Typer(
	"sans",
	"(face,spr_ex_faces_sans,0)(voice,snd_ex_voice_sans)(font,font_comicsans)(offy,3)"
);
function Dialogue_Parse_Typers(text) {
	var con = {t: text, o: "", i: 1};
	
	while (con.i <= string_length(con.t)) {
		var ch = string_char_at(con.t, con.i);
		
		if (ch == "(" && string_char_at(con.t, con.i + 1) == "(") {
			con.o += "(";
			con.i += 2;
			continue;
		}
		
		if (ch != "(") {
			con.o += ch;
			con.i += 1;
			continue;
		}
		
		var paren_open = con.i;
		var paren_close = 0;
		var i = paren_open + 1;
		
		while (i <= string_length(con.t)) {
			if (string_char_at(con.t, i) == ")") {
				paren_close = i;
				break;
			}
			
			i += 1;
		}
		
		if (paren_close == 0) {
			con.o += string_copy(
				con.t,
				con.i,
				string_length(con.t) - con.i + 1
			);
			break;
		}
		
		var tag = string_copy(
			con.t,
			paren_open + 1,
			paren_close - paren_open - 1
		);
		
		var parts = string_split(tag, ",");
		
		if (array_length(parts) == 2 && string_lower(string_trim(parts[0])) == "typer") {
			var name = string_trim(parts[1]);
			
			if (variable_struct_exists(global.dialogue_typers, name)) {
				con.o += global.dialogue_typers[$ name];
			}
			else {
				con.o += string_copy(
					con.t,
					paren_open,
					paren_close - paren_open + 1
				);
			}
		}
		else {
			con.o += string_copy(
				con.t,
				paren_open,
				paren_close - paren_open + 1
			);
		}
		
		con.i = paren_close + 1;
	}
	
	return con.o;
}
function Dialogue_Create(text, parse_typers = true) {
    var d = instance_create(o_ow_dialog,0,0,DEPTH_UI.DIALOGUE_UI);
	
	var text_arr = [];
	
	if (is_array(text)) {
		array_copy(text_arr, 0, text, 0, array_length(text));
	} else {
		text_arr[0] = text;
	}
	
	if (parse_typers) {
		for (var i = 0, n = array_length(text_arr); i < n; i++) {
			text_arr[i] = Dialogue_Parse_Typers(text_arr[i]);
		}
	}
	
	if (instance_exists(d)) d.text = text_arr;
	
	return d
}
function Dialogue_CheckLine(){
    if instance_exists(o_ow_dialog)
        return o_ow_dialog.line
    else
        return -1
}
function Dialogue_CheckEnd(){
    if (o_world.dialogue_destroywarn==true){
        return true
    }
    else{
        return false
    }
}
function Dialogue_CheckText(_text){
    if instance_exists(o_ow_dialog){
        if (o_ow_dialog.text==_text){
            return true
        }
        else {
            return false
        }
    }
    else{
        return false
    }
}






