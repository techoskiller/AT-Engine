ready = true;

if (instance_exists(t)){
	on_choice = line>=array_length(text)-1&&array_length(choices)>0&&t.finished
	t.line_length = width-10
	if (asset_get_type(face)==asset_sprite){
		t.line_length-=14
	}
	if (on_choice){
		ch_index+=(InputPressed(INPUT.RIGHT)-InputPressed(INPUT.LEFT))
		ch_index=clamp(ch_index,0,array_length(choices)-1)
		if (InputPressed(INPUT.CONFIRM)){
			var choice=choices[ch_index]
			if (variable_struct_exists(choice,"action")){
				if (is_callable(choice.action)){
					choice.action()
				}
			}
			if (variable_struct_exists(choice,"result")&&array_length(choice.result)>0){
				Dialogue_Create(choice.result)
			}
			instance_destroy(t)
			instance_destroy(id,false)
		}
	} 
	else if (InputPressed(INPUT.CONFIRM)&&t.finished){
		line++;
		instance_destroy(t)
	}
} 
else{
	if (line>=array_length(text)){
		if (save)
			instance_create(o_ui_save)
		instance_destroy()
		exit
	}
	t=instance_create(o_text_typer,xx+14,yy+9)
	t.x = xx+14
	t.y = yy+9
	t.on_gui=true
	t.text=text[line]
}