extends Button

func _toggled(toggled_on):
	if (toggled_on):
		set_text("Unpause")
		set_focus_mode(Control.FOCUS_ALL)
	else:
		set_text("Pause")
		set_focus_mode(Control.FOCUS_NONE)
