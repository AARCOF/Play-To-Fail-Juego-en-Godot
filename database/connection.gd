extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var db
var db_name = "res://database/dbMultiple"


var database
var db_path = "res://database.db"

func _ready():
	database = SQLite.open(db_path)

#func create_table():
#	var query = "CREATE TABLE IF NOT EXISTS inventory (id TEXT NOT NULL UNIQUE, name TEXT UNIQUE, amount INTEGER, tipe TEXT, image BLOB, PRIMARY KEY(name))"
#	database.exec(query)

func insert_data(id: String, name: String, amount: int, tipe: String, image: PoolByteArray):
	var query = "INSERT INTO inventory (id, name, amount, tipe, image) VALUES (?, ?, ?, ?, ?)"
	var stmt = database.prepare(query)
	stmt.bind_param(1, id)
	stmt.bind_param(2, name)
	stmt.bind_param(3, amount)
	stmt.bind_param(4, tipe)
	stmt.bind_param(5, image)
	stmt.step()
	stmt.finalize()

func update_data(id: String, name: String, amount: int, tipe: String, image: PoolByteArray):
	var query = "UPDATE inventory SET id = ?, amount = ?, tipe = ?, image = ? WHERE name = ?"
	var stmt = database.prepare(query)
	stmt.bind_param(1, id)
	stmt.bind_param(2, amount)
	stmt.bind_param(3, tipe)
	stmt.bind_param(4, image)
	stmt.bind_param(5, name)
	stmt.step()
	stmt.finalize()

func delete_data(name: String):
	var query = "DELETE FROM inventory WHERE name = ?"
	var stmt = database.prepare(query)
	stmt.bind_param(1, name)
	stmt.step()
	stmt.finalize()

func _exit_tree():
	database.close()
