extends Node

class_name Qleves

var db = globalVar.DB

# =========================================
# GET PARA LEVEL, SUBLEVEL, GUIDE, OBJETIVE
#==========================================

# Obtiene un vector de diccionarios de cualquier tabla
func table(nametable: String) -> Dictionary :
	var result = []
	var queries = "SELECT * FROM "+ nametable + ""
	db.query(queries)

	for i in range(0 , db.query_result.size() ):
		result.append( db.query_result[i] )
	
	return result



# Retorna los datos por tupla de la tabla "LEVEL" segun id
func level(id: String) -> Dictionary :
	var result = {}
	var queries = "SELECT * FROM level WHERE idLevel = '" + id + "'"
	db.query(queries)
	result = db.query_result[0]
	return result


# Retorna una tupla de la tabla "SUBLEVEL" segun id
func sublevel(id: String) -> Dictionary :
	var result = {}
	var queries = "SELECT * FROM sublevel WHERE idSublevel = '" + id + "'"
	db.query(queries)
	result = db.query_result[0]
	return result


# Retorna una tupla de la tabla "GUIDE" segun id
func guide(id: String) -> Dictionary :
	var result = {}
	var queries = "SELECT * FROM guide WHERE idGuide = '" + id + "'"
	db.query(queries)
	result = db.query_result[0]
	return result


# Retorna una tupla de la tabla "OBJECTIVE" segun id
func objective(id: String) -> Dictionary :
	var result = {}
	var queries = "SELECT * FROM objective WHERE idObjetive = '" + id + "'"
	db.query(queries)
	result = db.query_result[0]
	return result


# Retorna la id de las OBJECTIVE segun id de la tabla LEVEL
func level_objective(id: String):
	var result = []
	var queries = "SELECT * FROM level_objective WHERE idLevel = '" + id + "'"
	db.query(queries)

	for i in range(0 , db.query_result.size() ):
		if db.query_result[i]['idLevel'] == id :
			result.append( db.query_result[i] )

	return result
