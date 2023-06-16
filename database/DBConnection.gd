extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

class_name DBConnection

var db = null
var database_path = "res://database/dbMultiple"

# Constructor de la clase
func _init():
	db = null

# Método para abrir la conexión a la base de datos
func open_connection():
	db = SQLite.new()
	db.path = database_path

	if db.open_db() == true:
		print("Conexión establecida")
		return db
	else:
		print("Error al abrir la conexión")

# Método para cerrar la conexión a la base de datos
func close_connection():
	if db:
		db.close_db()
		print("Conexión cerrada")
	else:
		print("No hay conexión abierta")
