extends HudElement


func _on_tab_container_tab_selected(tab: int) -> void:
	if tab == 1:
		$AudioStreamPlayer.play()


func _on_close_button_pressed() -> void:
	hide()
	InterfaceManager.current.close_hud()
