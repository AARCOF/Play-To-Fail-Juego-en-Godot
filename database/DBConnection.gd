extends Node
const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")


class_name DBConnection

var db_path = "res://database/dbMultiple.db3"


func openConnection():
	globalVar.DB = SQLite.new()
	globalVar.DB.path = db_path
	globalVar.DB.open_db()

	print("Conexión establecida")



# Método para cerrar la conexión a la base de datos
func closeConnection():
	globalVar.DB.close_db()
	print("Conexión cerrada")