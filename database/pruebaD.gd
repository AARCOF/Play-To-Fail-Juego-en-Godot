extends Node


var instancia: qleves

func _ready():
	instancia = qleves.new()  # Crear una instancia de la clase 'qleves'

	# Llamar al método 'getDataById()' pasando el ID de la tabla como argumento
	var result = instancia.getDataById("123")

	if result["success"]:
		var data = result["data"]
		print("ID Level:", data["idLevel"])
		print("Name:", data["name"])
		print("Description:", data["description"])
		print("Difficulty:", data["difficulty"])
		print("Score:", data["score"])
		print("ID Guide:", data["idGuide"])
	else:
		print(result["message"])

