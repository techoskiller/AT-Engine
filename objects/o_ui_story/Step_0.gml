timer++

if (timer==1){
	t=instance_create(o_text_typer,40+20,140+20)
	t.voice=snd_text2
	t.spd=0.5
	t.spacing=1
	t.can_skip=false
	t.can_continue=false
	t.line_length=250
	t.text="Long ago, two races ruled over Earth:(w,10) HUMANS and MONSTERS."
}
if (timer>400&&timer<420){
	fadeout(0.1)
	instance_destroy(t)
}
if (timer==420){
	image_index=1
}
if (timer>420&&timer<440){
	fadein(0.1)
}
if (timer==420){
	t=instance_create(o_text_typer,40+20,140+20)
	t.voice=snd_text2
	t.spd=0.5
	t.spacing=1
	t.can_skip=false
	t.can_continue=false
	t.line_length=250
	t.text="One day. Both HUMANS and MONSTERS broke war, destroying such peace."
}
if (timer>700&&timer<720){
	fadeout(0.1)
	instance_destroy(t)
}
if (timer==720){
	image_index=2
}
if (timer>720&&timer<740){
	fadein(0.1)
}
if (timer==720){
	t=instance_create(o_text_typer,40+20,140+20)
	t.voice=snd_text2
	t.spd=0.5
	t.spacing=1
	t.can_skip=false
	t.line_length=255
	t.text="And with magic, they were sealed UNDERGROUND."
}
if InputPressed(INPUT.CONFIRM){
	fader(0,1,30,c_black)
	alarm[0]=30
}
image_alpha=alpha