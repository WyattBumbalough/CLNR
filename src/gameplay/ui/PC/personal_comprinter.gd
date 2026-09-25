extends Control


func _on_tab_container_tab_selected(tab: int) -> void:
	if tab == 1:
		$AudioStreamPlayer.play()
