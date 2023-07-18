extends VBoxContainer


var loginScreenContainer: Node
var registerScreenContainer: Node

func _ready():
	loginScreenContainer = $NinePatchRect/LoginContainer
	registerScreenContainer = $NinePatchRect/RegisterContainer

	var registerRediButton = loginScreenContainer.get_node("RegisterRedi")
	registerRediButton.connect("pressed", self, "_on_RegisterRedi_pressed")
	
	var loginRediButton = registerScreenContainer.get_node("LoginRedi")
	loginRediButton.connect("pressed", self, "_on_LoginRedi_pressed")

func _on_LoginRedi_pressed():
	registerScreenContainer.visible = false
	loginScreenContainer.visible = true

func _on_RegisterRedi_pressed():
	registerScreenContainer.visible = true
	loginScreenContainer.visible = false
	
