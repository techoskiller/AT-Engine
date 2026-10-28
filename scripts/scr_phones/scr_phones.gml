function phone_default(){
	name = ""
	exec = noone
}

function phone_wrongnum() : phone_default() constructor{
	name = "???"
	exec = function(){
		var _c = new cutscene_t()
		cutscene_run(_c,function(){audio_play_sound(snd_ui_ring,0,false)})
		cutscene_dialogue(_c,
			[
				"* ((Ring... ring...)",
				"* Hello!\n* Can I speak to G...",
				"* ...\n* Wait a second.",
				"* Is this the wrong number?",
				"* Oh it's the wrong number)!\n* The wrong number song!",
				"* We're very very sorry that\nwe got it wrong!",
				"* Oh it's the wrong number!\n* The wrong number song!",
				"* We're very very sorry that\nwe got it wrong!",
				"* ((Click...)",
			]
		)
		cutscene_run(_c,function(){instance_destroy(o_ui_menu)})
		cutscene_play(_c)
	}
}
