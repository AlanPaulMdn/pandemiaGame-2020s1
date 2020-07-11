import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
		if (personas.all({p => p.estaInfectada()}))
			{return "rojo.png"}
		else if (self.infectades().size().between(8,personas.size()-1))
			{return "naranjaOscuro.png"}
		else if (self.infectades().size().between(4,7))
			{return "naranja.png"}
		else if (self.infectades().size().between(1,3))
			{return "amarillo.png"}
		else {return "blanco.png"}
	}
	
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		// despues agregar la curacion
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		personas.remove(persona)
		manzanaDestino.ingresarPersona(persona)
	}
	
	method ingresarPersona(persona){
		personas.add(persona)
	}
	
	method cantidadContagiadores()= 
		self.infectades().difference(self.aisladas()).size()
	
	method aisladas()=
		personas.filter({pers => pers.estaAislada()}).asSet()
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() }).asSet()
	} 	
	
	method infectades() {
		return personas.asSet().difference(self.noInfectades())
	}
	
	method conSintomas()=
		personas.filter({ pers => pers.presentaSintomas() })


	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
	}
	
	method transladoDeUnHabitante() { //chequearlo
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	

}
