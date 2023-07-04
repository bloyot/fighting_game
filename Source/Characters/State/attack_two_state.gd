extends BaseCharacterState

class_name AttackTwoState

@export var state_name: StringName = "attack_2"
@export var animation_name: StringName = "attack_2"
@export var attack_buffer: int = 10
@export var damage: int = 20

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func should_freeze_facing(): 
    return true

func get_damage():
    return damage

func update(_delta) -> String:
    super.update(_delta)    
    if (animation_player.current_animation_position >= animation_length):        
        if (has_buffered_input("attack", attack_buffer)):
            return "attack_3"
        return "idle"	

    return ""