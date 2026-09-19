extends Interactable

var noteface = 0

func _on__looked_at():
	mesh.material_overlay = mat_overlay

func _on_interacted_with():
	if noteface == 0:
		%thenote.visible = true
		Refs.main.player.allow_move = false
		Refs.main.player.allow_look = false
		Refs.main.player.allow_crouch = false
		Refs.main.player.allow_sprint = false
		Refs.main.player.allow_jump = false
		noteface = 1
		%BDR.visible = true
		%crinkle.play()
	
	else:
		%thenote.visible = false
		Refs.main.player.allow_move = true
		Refs.main.player.allow_look = true
		Refs.main.player.allow_crouch = true
		Refs.main.player.allow_sprint = true
		Refs.main.player.allow_jump = true
