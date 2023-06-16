extends Node
const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

class_name qleves

var db
var database_path = "res://database/dbMultiple.db3"

# Constructor de la clase
func _init():
	db = null


# Funciones para realizar la conexion con SQLITE
# ==================================================================
func openConnection():
	db = SQLite.new()
	db.path = database_path
	db.open_db()

func closeConnection():
	db.close()
#====================================================================


func getDataById(tableId: String) -> Dictionary:
	openConnection()
	var query = "SELECT * FROM level WHERE idLevel = :id"
	var result = db.query(query, {"id": tableId})
	
	var response = {}
	response["success"] = false
	response["message"] = ""
	response["data"] = null
	
	if result.error != OK:
		response["message"] = "Error al ejecutar la consulta: " + result.error_message
	else:
		response["success"] = true
		response["message"] = "Datos obtenidos correctamente."
		
		if result.next():
			response["data"] = {
				"idLevel": result.get("idLevel"),
				"name": result.get("name"),
				"description": result.get("description"),
				"difficulty": result.get("difficulty"),
				"score": result.get("score"),
				"idGuide": result.get("idGuide")
			}
	
	closeConnection()
	return response
