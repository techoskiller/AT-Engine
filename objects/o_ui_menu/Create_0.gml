state=0
prev_state=state
sub_state=0
item_selection=0
item_action_selection=0
waiting=false
xxx=o_cam.x-320/2
yyy=o_cam.y-240/2
top=is_top()

options = [
	{
		name: "ITEM",
		selectable: array_length(global.items) > 0,
		state: 1,
	},
	{
		name: "STAT",
		selectable: true,
		state: 2,
	},
	{
		name: "CELL",
		selectable: true,
		state: 3,
	},
]

item_actions = [
	{
		name: "USE",
		selectable: true
	},
	{
		name: "INFO",
		selectable: true
	},
	{
		name: "DROP",
		selectable: true
	},
]

cell_selection = 0;

call_dialogue = function(dial_text,text, end_text) {
	var t = []
	if (is_array(text)) {
		array_copy(t,0,text,0,array_length(text))
	} else {t = [text]}

	array_insert(t,0,dial_text)
	array_insert(t,array_length(t),end_text)
	return t
}

cells = [
	new phone_wrongnum(),
]

selection = 0
depth=DEPTH_UI.MENU_UI
