extends Control

var loginScreenContainer: Node
var registerScreenContainer: Node


onready var animationPlayer3: AnimationPlayer = $NinePatchRect/TextureRect3/AnimationPlayer

onready var animationPlayer5: AnimationPlayer = $NinePatchRect2/TextureRect5/AnimationPlayer
onready var animationPlayer6: AnimationPlayer = $TextureRect/AnimationPlayer


onready var message = $Message
var connection = null
var quser = null


func _ready():
	OpenConnectionDatabase() # se realiza la conexion a la base de datos


	animationPlayer3.play("niña")
	animationPlayer5.stop()
	animationPlayer6.stop()
	
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
	animationPlayer3.play("niña")
	animationPlayer5.stop()
	animationPlayer6.play("transicion_x")
	message._on_Button_pressed()#----------------


func _on_RegisterRedi_pressed():
	$NinePatchRect.visible = false
	$NinePatchRect2.visible = true
	loginScreenContainer.visible = false
	registerScreenContainer.visible = true
	animationPlayer3.stop()
	animationPlayer5.play("mover_arriba")
	$TextureRect.visible=true
	animationPlayer6.play("transicion_x")
	message._on_Button_pressed()#--------------


# =================
#	Algotrithm ADD
# =================
func OpenConnectionDatabase():
	connection = DBConnection.new()
	connection.openConnection()
	
func _on_RegisterBttn_pressed():
	registerUser()
	
func _on_LoginBttn_pressed():
	logIn()
	
	
# =====================
# Validacion de nombres
# =====================
func validarNombreCompleto(nombreCompleto: String) -> bool:
	# Expresión regular para validar el nombre completo
	var patron = "^[A-Za-z]+(?:\\s+[A-Za-z]+)*\\s+[A-Za-z]+$"
	
	var regexp = RegEx.new()
	regexp.compile(patron)
	
	return regexp.search(nombreCompleto) != null


# ==================
# REGISTRAR USUARIO
# ==================
func registerUser():
	quser = Quser.new() 
	var name = $NinePatchRect2/RegisterContainer/In_Nombres.text
	var alias = $NinePatchRect2/RegisterContainer/In_Usuario.text
	var password = $NinePatchRect2/RegisterContainer/In_Contrasena.text

	if ( name.empty() or alias.empty() or password.empty() ):
		message.showDialog("Usted tiene que llenar todos los campos completos")#------------------------------
		
	elif ( (validarNombreCompleto(name) == true) and (alias != "")  and (password != "") and (password.length()>=4)):
		var apart = name.split(" ", false, 2)
		var firstname = apart[0]
		var surname = name[0]

		if apart.size() > 1 and not apart[1].empty() and name[-1] != "":
			surname = apart[1]

		if apart.size() > 2:
			surname = apart[1] + " " + apart[2]


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
				message.showDialog('Guardado exitoso, ya puedes iniciar sesion')#-------------------------
				
				$NinePatchRect2/RegisterContainer/In_Nombres.text = ""
				$NinePatchRect2/RegisterContainer/In_Usuario.text = ""
				$NinePatchRect2/RegisterContainer/In_Contrasena.text = ""
			else :
				message.showDialog('El usuario no se guardó, ocurrió un error')#-------------------------
		else :
			message.showDialog('El usuario ya existe, digite otro Alias')#---------------------------
	elif ( validarNombreCompleto(name) == false):
		message.showDialog("Usted tiene que digitar su nombre y apellido completo")#------------------------------
	elif ( (validarNombreCompleto(name) == true) and (password.length()<4)) :
		message.showDialog("Las contraseñas tiene que ser mayor a 3 digitos")#------------------------------
	else :
		message.showDialog('Upps, Ocurrio algun error')#---------------------------

# ======
# LOG IN
# ======
func logIn() :
	quser = Quser.new() 
	var user = $NinePatchRect/LoginContainer/In_Usuario.text
	var password = $NinePatchRect/LoginContainer/In_Contrasena.text

	if ( quser.searchAlias(user) == true ) :

		var data = quser.getPassword(user)
		quser.updateID(user)

		if (quser.dencrytData(data, password) == true) :

			globalVar.ALIAS = user
			getInformation() 

			get_tree().change_scene("res://Scenes/home/home.tscn")# INIT GAME
			
		elif (password == "") :
			message.showDialog("Digite una contraseña")#---------------------------
			
		else :
			message.showDialog("La contraseña es incorrecta")#---------------------------

	elif (user == "" and password != "") :
		message.showDialog("Digite el nombre de usuario correcto")#---------------------------
	elif (user == "" and password == ""):
		message.showDialog("Usted no digitó ningun dato, llena todos los campos completos")#---------------------------
	else : 
		message.showDialog("El usuario no existe, registrese como un nuevo usuario")#---------------------------


func getInformation() -> void :
	quser = Quser.new() 
	var fk = globalVar.idUSER
	var result = quser.inventoryAll(fk)
	
	var totalPoints = 0
	var totalCoins = 0
	#var itemsList = []
	
	for i in range(result.size()):
		totalPoints +=  result[i]['points']
		totalCoins += result[i]['coin']
		#itemsList += result[i]['idItems']
		
	globalVar.obtainedPoint = totalPoints
	globalVar.obtainedCoin  = totalCoins
	globalVar.points = totalPoints
	globalVar.coins  = totalCoins

