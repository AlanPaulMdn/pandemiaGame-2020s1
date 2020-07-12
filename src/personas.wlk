import simulacion.*

class Persona {
	var property estaAislada = false
	var property respetaCuarentena = false
	
	var diaInfeccion = 0
	var estaInfectada = false
	var tieneSintomas = false
	
	method estaInfectada(){
		if (	estaInfectada and 
			simulacion.diaActual() > diaInfeccion+simulacion.duracionInfeccion()	)
		{ estaInfectada = false	}
		return estaInfectada
	}
	
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
}


