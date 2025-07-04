extends CharacterState
class_name TestUpSpecial

@export var speed : float = 300
var up_special_end = false

func Enter():
	print("Up Special state")
	up_special_end = false
	character.velocity.y = char_attributes.JUMP_POWER
	playanim("up_special")

#This is called by the animation player.
func end_of_up_special():
	up_special_end = true

func Physics_Update(delta):
	if char_attributes.just_took_damage:
		Transitioned.emit(self, "hitstun")
	elif character.is_on_floor():
		Transitioned.emit(self,"idle")
	elif up_special_end:
		Transitioned.emit(self, "SpecialFall")
	
	#handles horizontal events
	elif Input.is_action_pressed(get_action("left")):
			character.velocity.x = lerp(character.velocity.x,-speed,char_attributes.AIRSPEEDLERP)
			character.move_and_slide()
	elif Input.is_action_pressed(get_action("right")):
			character.velocity.x = lerp(character.velocity.x,speed,char_attributes.AIRSPEEDLERP)
			character.move_and_slide()
	else:
		character.move_and_slide()
