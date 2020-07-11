import simulacion.*

class Persona {
	var property estaAislada = false
	
	var property respetaCuarentena = false
	var property diaInfeccion = 0
	var estaInfectada = false
	
	method estaInfectada(){
		/* 
		//si la probalidad es mayor a 2	SI
		//si la prob es menor 2
			NO
		*/
		return false
	}
	
	method infectarse() {
		estaInfectada = true
		diaInfeccion = simulacion.diaActual()
	
		// implementar 
	}

	
	method presentaSintomas(){
		var estado = false
		if (self.estaInfectada()){
			estado = true //VER QUE ONDA
		}
		return estado
	}
}

