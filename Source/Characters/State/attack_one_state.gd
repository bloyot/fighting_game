extends BaseCharacterState

class_name AttackOneState

@export var state_name: StringName = "attack_1"
@export var animation_name: StringName = "attack_1"
@export var attack_buffer: int = 10
@export var damage: int = 10

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
            return "attack_2"
        return "attack_1_end"	

    return ""

func on_enter():
    super.on_enter()
    character.velocity = Vector2.ZERO
    character.game_audio.attack()