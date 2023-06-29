extends Node

class_name Quser

var db = globalVar.DB
var aes = AESContext.new() # Declaracion para la encriptacion de datos

# ====================================
# CRUD PARA EL USUARIO Y SU INVENTARIO
#=====================================

# Retorna los datos por tupla de la tabla "user" segun id
func user(id: String) -> Dictionary :
	db.query( str("SELECT * FROM user WHERE idUser = '" , id , "'") )
	var result = db.query_result[0]
	return result

# Retorna los datos por tupla de la tabla "inventory" segun id
func inventory(id: String) -> Dictionary :
	db.query( str("SELECT * FROM inventory WHERE idInventory = '" , id , "'") )
	var result = db.query_result[0]
	return result


# Guarda los datos en la tabla "user"
func saveUser( firstname:String, surname:String, alias:String, password:String, idLevel:String) -> void:
	var data = {
		"idUser": idUsers(),
		"firstName": firstname,
		"surName": surname,
		"alias": alias,
		"password": encryptData(password),
		"registerDate": dateTime(),
		"idLevel": idLevel
	}
	db.insert_row('user', data)

# Guarda los datos en la tabla "Inventory"
func saveInventory( points:String, coin:String ,idItems:String, idUser:String) -> void:
	var data = {
		"idInventory": idInventory(),
		"dateObtained": dateTime(),
		"points": int(points),
		"coin": float(coin),
		"idItems": idItems,
		"idUser": idUser
	}
	db.insert_row('inventory', data)

# Actualiza los datos en la tabla "user"
func updateUser(id:String, firstname:String, surname:String, alias:String, password:String)-> void:
	var data = {
		"firstName": firstname,
		"surName": surname,
		"alias": alias,
		"password": password,
		#"registerDate": dateTime(),
		#"idLevel": idLevel,
	}
	var condition = str("idUser = '" , id , "'")
	#Boolean success = update_rows( String table_name, String query_conditions, Dictionary updated_row_dictionary )
	db.update_rows('user', condition, data)

# Actualiza los datos en la tabla "Inventory"
func updateInventory(id:String, points:String, coin:String ,idItems:String, idUser:String)-> void:
	var data = {
		"dateObtained": dateTime(),
		"points": int(points),
		"coin": float(coin),
		"idItems": idItems,
		"idUser": idUser
	}
	var condition = str("idInventory = '" , id , "'")
	db.update_rows('inventory', condition, data)

# Elimina un usuario con la ID
func deleteUser( id:String )-> void:
	#Boolean success = delete_rows( String table_name, String query_conditions )
	var condition = str("idUser = '" , id , "'")
	db.delete_rows('user', condition)



#=========================================================
# Busca la ultima insercion y genera ID para la tabla user
# ========================================================
func idUsers() -> String:
	db.query( "SELECT MAX(idUser) FROM user" )
	var resultQ = db.query_result[0]
	var resultId = resultQ['MAX(idUser)']
	
	if resultId != null :
		var part = resultId.substr(1, resultId.length())
		var increment = int(part) + 1
		var dataId

		if increment < 10:
			dataId = "U0" + str(increment)
		else:
			dataId = "U" + str(increment)
		return dataId
	else :
		return "U01"


# Busca la ultima insercion y genera ID para la tabla inventory
func idInventory() -> String :
	db.query( "SELECT MAX(idInventory) FROM inventory" )
	var resultQ = db.query_result[0]
	var resultId = resultQ['MAX(idInventory)']
	
	if resultId != null :
		var part = resultId.substr(1, resultId.length())
		var increment = int(part) + 1
		var dataId

		if increment < 10:
			dataId = "I0" + str(increment)
		else:
			dataId = "I" + str(increment)
		return dataId
	else :
		return "I01"


# Obtener id de usuario mediante alias
func updateID(alias:String) -> void:
	db.query( str("SELECT idUser FROM user where  alias = '" + alias + "'") )
	var resultQ = db.query_result
	if (resultQ.empty()):
		globalVar.idUSER = idUsers()
	else :
		globalVar.idUSER = resultQ[0]['idUser']
	

# Buscar alias
func searchAlias(alias:String) -> bool:
	db.query( str("SELECT alias FROM user where  alias = '" + alias + "'") )
	var resultQ = db.query_result
	if (resultQ.empty()):
		return false
	else :
		return true


# Obtener pasword
func getPassword(alias:String) -> String:
	db.query( str("SELECT password FROM user where  alias = '" + alias + "'") )
	var resultQ = db.query_result[0]
	if (resultQ.empty()):
		return ""
	else :
		return resultQ['password']


# Obtiene la fecha actual
func dateTime()-> String :
	var date = OS.get_datetime()
	var year = date['year']
	var month = date['month']
	var day = date['day']
	var hour = date['hour']
	var minute = date['minute']
	var second = date['second']

	var formattedDate = str(year, "-", month , "-", day, " ", hour, ":", minute, ":",second)
	return formattedDate



# =====================
# ENCRIPTACION DE DATOS
# =====================

# Encriptacion de datos
func encryptData(password: String) -> PoolByteArray:
	var key = globalVar.idUSER
	var clave = completeBytes(key) # La clave debe ser de 16 o 32 bytes. (1 byte = 1 char) normalmdlkd
	var datos = completeBytes(password) # La clave debe ser de 16 o 32 bytes. (1 byte = 1 char) normalmdlkd
	
	# Encriptar ECB
	aes.start(AESContext.MODE_ECB_ENCRYPT, clave.to_utf8())
	var encriptado = aes.update(datos.to_utf8())
	aes.finish()
	
	return encriptado
	
	
	# Desencriptacion de datos
func dencrytData(encriptado: Array, password:String):
	var key = globalVar.idUSER
	var flag = false
	var clave = completeBytes(key) # La clave debe ser de 16 o 32 bytes. (1 byte = 1 char) normalmdlkd
	var datos = completeBytes(password) # La clave debe ser de 16 o 32 bytes. (1 byte = 1 char) normalmdlkd

	# Desencriptar ECB
	aes.start(AESContext.MODE_ECB_DECRYPT, clave.to_utf8())
	var desencriptado = aes.update(encriptado)
	aes.finish()

	# Comprobar ECB
	if (desencriptado == datos.to_utf8()):
		flag = true
	return flag


# Conpleta los datos para la encryptacion en 16bytes
func completeBytes(data: String) -> String:
	var targetLength = 16
	if data.length() < targetLength:
		var padding = targetLength - data.length()
		var paddingString = ''
		while padding > 0:
			paddingString += 'g'
			padding -= 1
		return data + paddingString
	elif data.length() > targetLength:
		return data.substr(0, targetLength)
	else:
		return data
