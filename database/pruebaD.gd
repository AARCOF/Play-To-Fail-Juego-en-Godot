extends Node


var quser
var connection

func _ready():
	quser = null
	connection = null
	pruebaDatos()

func pruebaDatos():
	connection = DBConnection.new()
	connection.openConnection()
	quser = Quser.new()

	quser.getUpdateID('RAY')
	quser.saveUser("Henry","Leon","RAY","lokitos2023","L01")
	#quser.saveInventory("1000","500.50","item1,item2","U01")

	#quser.updateUser("U02","Lukas","Gozu","GalloTronic","lokito" )
	#quser.updateInventory("I04","100","200.5","item1,item2,item3,item4")

	#quser.deleteUser('U01')
	

	#var s = quser.encryptData("misdatos","key")
	#print(s)
	#var com = quser.dencrytData(s,"misdatos","key")
	#print(com)

	print(globalVar.idUSER)

	var tupla = quser.user(globalVar.idUSER)
	var clave = tupla['password']
	var comprbar = quser.dencrytData(clave,'lokitos2023')
	print(comprbar)
