import simulacion.*

class Persona {
	var property estaAislada = false
	var property respetaCuarentena = false
	
	var property diaInfeccion = 0
	var property estaInfectada = false
	var tieneSintomas = false
	
	/*
	method estaInfectada(){
		if (	estaInfectada and 
			simulacion.diaActual() > diaInfeccion+simulacion.duracionInfeccion()	)
		{ estaInfectada = false	}
		return estaInfectada
	}
	*/
	
	method infectarse() {
		estaInfectada = true
		diaInfeccion = simulacion.diaActual()
	}
	
	method presentaSintomas(){
		if (self.estaInfectada() and not tieneSintomas) {
				tieneSintomas = simulacion.tomarChance(simulacion.chanceDePresentarSintomas()) }
		else if (not self.estaInfectada()){
			tieneSintomas = false
		}
		return tieneSintomas
	}
	
	method curarse(){
		if (self.estaInfectada()){
			if(simulacion.diaActual() > diaInfeccion + simulacion.duracionInfeccion()){
				 estaInfectada = false
				 diaInfeccion = 0
			}
		}
	}
}

class Infectade inherits Persona {
	override method diaInfeccion()= simulacion.diaActual()
	override method estaInfectada()= true
}

