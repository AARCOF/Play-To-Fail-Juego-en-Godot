extends Control

var loginScreenContainer: Node
var registerScreenContainer: Node
onready var animationPlayer1: AnimationPlayer = $NinePatchRect/TextureRect/AnimationPlayer
onready var animationPlayer2: AnimationPlayer = $NinePatchRect/TextureRect2/AnimationPlayer
onready var animationPlayer3: AnimationPlayer = $NinePatchRect/TextureRect3/AnimationPlayer
onready var animationPlayer4: AnimationPlayer = $NinePatchRect2/TextureRect5/TextureRect4/AnimationPlayer
onready var animationPlayer5: AnimationPlayer = $NinePatchRect2/TextureRect5/AnimationPlayer
onready var animationPlayer6: AnimationPlayer = $TextureRect/AnimationPlayer


var connection = null
var quser = null


func _ready():
	OpenConnectionDatabase() # se realiza la conexion a la base de datos
	
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


func _on_LoginRedi_pressed():
	$NinePatchRect.visible = true
	$NinePatchRect2.visible = false
	loginScreenContainer.visible = true
	registerScreenContainer.visible = false
	$TextureRect.visible=true
	animationPlayer6.play("transicion_x")
	$Message._on_Button_pressed()#----------------


func _on_RegisterRedi_pressed():
	$NinePatchRect.visible = false
	$NinePatchRect2.visible = true
	loginScreenContainer.visible = false
	registerScreenContainer.visible = true
	animationPlayer4.play("brazo")
	animationPlayer5.play("mover_arriba")
	$TextureRect.visible=true
	animationPlayer6.play("transicion_x")
	$Message._on_Button_pressed()#--------------



#	Algotrithm ADD
# ====================================================
func OpenConnectionDatabase():
	connection = DBConnection.new()
	connection.openConnection()
	
func _on_RegisterBttn_pressed():
	registerUser()
	
func _on_LoginBttn_pressed():
	logIn()
	

# REGISTRAR USUARIO
func registerUser():
	quser = Quser.new() 
	var name = $NinePatchRect2/RegisterContainer/In_Nombres.text
	var alias = $NinePatchRect2/RegisterContainer/In_Usuario.text
	var password = $NinePatchRect2/RegisterContainer/In_Contrasena.text

	if ( name.empty() or alias.empty() or password.empty() ):
		$Message.showDialog("Llena los campos completos")#------------------------------

	else :
		var apart = name.split(" ", false, 2)
		var firstname = apart[0]
		var surname = name[0]

		if apart.size() > 1 and not apart[1].empty() and name[-1] != "":
			surname = apart[1]

		if apart.size() > 2:
			surname = apart[1] + " " + apart[2]

		print(firstname)
		print(surname)
		print(alias)
		print(password)
		# ==================================== #
		if ( quser.searchAlias(alias) == false ) :
			
			quser.updateID(alias)
			quser.saveUser(
				firstname, 
				surname, 
				alias, 
				password, 
				"L01"
			)
			
			if (quser.searchAlias(alias) == true) :
				$Message.showDialog('Guardado exitoso, ya puedes iniciar sesion')#-------------------------
				
				$NinePatchRect2/RegisterContainer/In_Nombres.text = ""
				$NinePatchRect2/RegisterContainer/In_Usuario.text = ""
				$NinePatchRect2/RegisterContainer/In_Contrasena.text = ""
				print(globalVar.idUSER)
			else :
				$Message.showDialog('El usuario no se guardó ocurrio un error')#-------------------------
			
		else :
			$Message.showDialog('El usuario ya existe')#---------------------------


# LOG IN
func logIn() :
	quser = Quser.new() 
	var user = $NinePatchRect/LoginContainer/In_Usuario.text
	var password = $NinePatchRect/LoginContainer/In_Contrasena.text

	if ( quser.searchAlias(user) == true ) :

		var data = quser.getPassword(user)
		quser.updateID(user)

		if (quser.dencrytData(data, password) == true) :
			#Cambio de escena
			get_tree().change_scene("res://Scenes/game_window.tscn")# INIT GAME
			$Message._on_Button_pressed()
			
		elif (password == "") :
			$Message.showDialog("Digite una contraseña")#---------------------------
		else :
			$Message.showDialog("La contraseña es incorrenta")#---------------------------

	elif (user == "" and password != "") :
		$Message.showDialog("Digite un usuario")#---------------------------
	elif (user == "" and password == ""):
		$Message.showDialog("Llena los campos completos")#---------------------------
	else : 
		$Message.showDialog("El usuario no existe")#---------------------------
