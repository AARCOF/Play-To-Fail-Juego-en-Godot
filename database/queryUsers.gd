extends Node

class_name Quser

var db = globalVar.DB

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
		"password": password,
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


#func hashPassword(password: String) -> String:


#func checkPassword(password: String, hashedPassword: String) -> bool:
