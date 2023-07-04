extends Control

var loginScreenContainer: Node
var registerScreenContainer: Node
onready var animationPlayer1: AnimationPlayer = $NinePatchRect/TextureRect/AnimationPlayer
onready var animationPlayer2: AnimationPlayer = $NinePatchRect/TextureRect2/AnimationPlayer
onready var animationPlayer3: AnimationPlayer = $NinePatchRect/TextureRect3/AnimationPlayer
onready var animationPlayer4: AnimationPlayer = $NinePatchRect2/TextureRect5/TextureRect4/AnimationPlayer
onready var animationPlayer5: AnimationPlayer = $NinePatchRect2/TextureRect5/AnimationPlayer
onready var animationPlayer6: AnimationPlayer = $TextureRect/AnimationPlayer

	

func _ready():
	animationPlayer1.play("circular")
	animationPlayer2.play("niño")
	animationPlayer3.play("niña")
	
	loginScreenContainer = $NinePatchRect/LoginContainer
	registerScreenContainer = $NinePatchRect2/RegisterContainer

	var registerRediButton = loginScreenContainer.get_node("RegisterRedi")
	if !registerRediButton.is_connected("pressed", self, "_on_RegisterRedi_pressed"):
		registerRediButton.connect("pressed", self, "_on_RegisterRedi_pressed")
		
	var loginRediButton = registerScreenContainer.get_node("LoginRedi")
	if !loginRediButton.is_connected("pressed", self, "_on_LoginRedi_pressed"):
		loginRediButton.connect("pressed", self, "_on_LoginRedi_pressed")


func _physics_process(delta: float) -> void:
	$NinePatchRect/ParallaxBackground/ParallaxLayer.motion_offset.x +=1

func _on_LoginRedi_pressed():
	$NinePatchRect.visible = true
	$NinePatchRect2.visible = false
	loginScreenContainer.visible = true
	registerScreenContainer.visible = false
	$TextureRect.visible=true
	animationPlayer6.play("transicion_x")

func _on_RegisterRedi_pressed():
	$NinePatchRect.visible = false
	$NinePatchRect2.visible = true
	loginScreenContainer.visible = false
	registerScreenContainer.visible = true
	animationPlayer4.play("brazo")
	animationPlayer5.play("mover_arriba")
	$TextureRect.visible=true
	animationPlayer6.play("transicion_x")

	



