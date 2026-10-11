extends Node3D

@onready var radio_sounds: AudioStreamPlayer3D = $"../Radio/Audio"
#@onready var track: AudioStreamPlaylist = radio_sounds.stream
@onready var can_interact: bool = true
@onready var fan: AnimationPlayer = $"../../Fan/AnimationPlayer"
@onready var lights :Node3D = $"../../Lights"
@onready var compylight :OmniLight3D = $"../TestCompy/OmniLight3D"
func _ready() -> void:
	add_to_group("entities")

func _on_interactable_interacted() -> void:
	if can_interact == true:
		lights_out()
		%ExitDoor.queue_free()
	else:
		return
func lights_out():
	if can_interact == true:
		can_interact = false
		fan.stop()
		lights.visible = false
		compylight.visible = false
		%TestCompy.queue_free()
		%AugBay.queue_free()
		%TestCompyhehe.visible = true
		%AugBayhehe.visible = true
		$CoolAnimationPlayerForCoolGuys.pause()
		radio_sounds.stop()
		%brown.stop()
		%beyuuu.play()
		%stopwall.visible = true
		%Timer.start()
	else:
		return



func _on_timer_timeout() -> void:
	%coolaudioforcoolguys.play()
	%radiolight.visible = true
	%creepytimer.start()
	%creepiertimer.start()
	%dar.start()
	%Stahp.start()

func _on_creepy_timer_timeout() -> void:
	%creepy.play()



func _on_creepiertimer_timeout() -> void:
	%creepier.play()
	%up.play()
	%ceiling.play("raise the roof")
	%Fan.visible = false
func _on_stahp_timeout() -> void:
	%creepier.stop()
	%creepy.stop()
	

func _on_coolaudioforcoolguys_finished() -> void:
	get_tree().quit()
