extends Control

var loginScreenContainer: Node
var registerScreenContainer: Node
var connection = null
var quser = null

func _ready():
	OpenConnectionDatabase() # se realiza la conexion a la base de datos

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


func _on_RegisterRedi_pressed():
	$NinePatchRect.visible = false
	$NinePatchRect2.visible = true
	loginScreenContainer.visible = false
	registerScreenContainer.visible = true

	

func OpenConnectionDatabase():
	connection = DBConnection.new()
	connection.openConnection()


func _on_RegisterBttn_pressed() -> void:
	registerUser()

func _on_LoginBttn_pressed() -> void:
	logIn()

	
# REGISTRAR USUARIO
func registerUser():
	quser = Quser.new() 
	var name = $NinePatchRect2/RegisterContainer/In_Nombres.text
	var alias = $NinePatchRect2/RegisterContainer/In_Usuario.text
	var password = $NinePatchRect2/RegisterContainer/In_Contrasena.text

	if ( name.empty() or alias.empty() or password.empty() ):
		print('Ingrese todos los campos')#===============================>

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

			print('Guardado exitoso')#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>MOSTRAR MENSAJE EN PANTALLA

			$NinePatchRect2/RegisterContainer/In_Nombres.text = ""
			$NinePatchRect2/RegisterContainer/In_Usuario.text = ""
			$NinePatchRect2/RegisterContainer/In_Contrasena.text = ""
			
			print(globalVar.idUSER)
		else :
			print('El usuario ya existe')#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>MOSTRAR MENSAJE EN PANTALLA
		

# LOG IN
func logIn() :
	quser = Quser.new() 
	var user = $NinePatchRect/LoginContainer/In_Usuario.text
	var password = $NinePatchRect/LoginContainer/In_Contrasena.text

	if ( quser.searchAlias(user) == true ) :

		var data = quser.getPassword(user)
		quser.updateID(user)

		if (quser.dencrytData(data, password) == true) :

			print("Logeo exitoso") # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			#Cambio de escena
			get_tree().change_scene("res://database/pruebaD.tscn")

		else :
			print("La contraseña es incorrenta")#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	elif(user == "" or password == "") :
		print("Llena los campos completos") #>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	else : 
		print("El usuario no existe")#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



