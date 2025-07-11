extends CharacterState
class_name TestUpSpecial

@export var speed : float = 300
var up_special_end = false
var can_land = false

@export var up_special_hb1 : Hitbox
@export var up_special_hb2 : Hitbox

func Enter():
	print("Up Special state")
	up_special_end = false
	can_land = false
	character.velocity.y = char_attributes.JUMP_POWER
	playanim("up_special")

#This is called by the animation player.
func end_of_up_special():
	up_special_end = true

func allow_land():
	can_land = true

func Physics_Update(delta):
	if char_attributes.just_took_damage:
		up_special_hb1.deactivate_hitbox()
		up_special_hb2.deactivate_hitbox()
		Transitioned.emit(self, "hitfreeze")
	elif char_attributes.just_hit_enemy:
		freeze_frame(0.2)
		char_attributes.just_hit_enemy = false
	elif character.is_on_floor() and can_land:
		up_special_hb1.deactivate_hitbox()
		up_special_hb2.deactivate_hitbox()
		Transitioned.emit(self,"idle")
	elif up_special_end:
		up_special_hb1.deactivate_hitbox()
		up_special_hb2.deactivate_hitbox()
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
