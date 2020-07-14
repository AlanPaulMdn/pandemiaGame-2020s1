import simulacion.*
//ok
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
		if (not estaInfectada) { 
			estaInfectada = true 
			diaInfeccion = simulacion.diaActual()
			presentaSintomas = simulacion.tomarChance(simulacion.chanceDePresentarSintomas())
		}
	}
	
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

