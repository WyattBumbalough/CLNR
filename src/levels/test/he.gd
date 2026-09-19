extends Interactable

var dude = 0

func _on__looked_at():
	if %BDR.visible == true and dude < 20:
		%HUH.play()
		print("Your ass is mine, little Bumby.")
		dude +=1
	if %BDR.visible == true and dude >= 20:
		print("Alright nigga, calm down.")
		%HUH.play()
		dude +=1

func _on_huh_finished() -> void:
	get_tree().quit()
