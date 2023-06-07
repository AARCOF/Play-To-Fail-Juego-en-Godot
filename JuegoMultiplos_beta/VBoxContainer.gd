extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	#Funcion para ramdomizar el rand_range()
	randomize()
	
	#Se declara en una variable y se convierte a cadena para el numero base 
	var numAleatorio: int = rand_range(2,4)
	var cadena: String = str(numAleatorio)
	
	#Se declara en una variable y se convierte a cadena para los botones
	var numAleatBttn: int = rand_range(1,30)
	var cadenaBttn: String = str(numAleatBttn)
	
	var numAleatBttn2: int = rand_range(1,30)
	var cadenaBttn2: String = str(numAleatBttn2)
	
	var numAleatBttn3: int = rand_range(1,30)
	var cadenaBttn3: String = str(numAleatBttn3)
	
	#Lógica para que si o si uno sea divisible
	while false:
		if numAleatBttn % numAleatorio != 0 and numAleatBttn2 % numAleatorio != 0 and numAleatBttn3 % numAleatorio != 0:
			numAleatBttn2 = rand_range(1,30)
			break

	#Imprime el número base y los numeros de los botones
	$numeroBase.text = cadena 
	$Button.text = cadenaBttn
	$Button2.text = cadenaBttn2
	$Button3.text = cadenaBttn3
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
