extends Interactable

func _on__looked_at():
	if %BDR.visible == true:
		%HUH.play()
		print("Your ass is mine, little Bumby.")
	else:
		pass
	


func _on_huh_finished() -> void:
	get_tree().quit()
