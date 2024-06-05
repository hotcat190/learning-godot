extends Node

func _on_pause_button_toggled(toggled_on):
	if (toggled_on):
		$"PauseButton".set_text("Unpause")
	else:
		$"PauseButton".set_text("Pause")
