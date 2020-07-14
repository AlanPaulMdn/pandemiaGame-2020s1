import simulacion.*

class Persona {
	var property estaAislada = false
	var property respetaCuarentena = false
	
	var property diaInfeccion = 0
	var property estaInfectada = false
	var property presentaSintomas = false
	
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
		presentaSintomas = simulacion.tomarChance(simulacion.chanceDePresentarSintomas())
	}
	
	
	/*method presentaSintomas(){
		if (self.estaInfectada() and not tieneSintomas) {
				tieneSintomas = simulacion.tomarChance(simulacion.chanceDePresentarSintomas()) }
	return tieneSintomas
	}*/
	
	
	method curarse(){
		if (self.estaInfectada()){
			if(simulacion.diaActual() > diaInfeccion + simulacion.duracionInfeccion()){
				 estaInfectada = false
				 diaInfeccion = 0
				 presentaSintomas= false
			}
		}
	}
}

class Infectade inherits Persona {
	override method diaInfeccion()= simulacion.diaActual()
	override method estaInfectada()= true
	override method presentaSintomas() = simulacion.tomarChance(simulacion.chanceDePresentarSintomas())
}

