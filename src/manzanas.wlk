import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image()=
		// agregar un cantInfectades y cantInfectades == cantPersonas
		if (personas.all({p => p.estaInfectada()}))							"rojo.png"
		else if (self.infectades().size().between(8,personas.size()-1))		"naranjaOscuro.png"
		else if (self.infectades().size().between(4,7))						"naranja.png"
		else if (self.infectades().size().between(1,3))						"amarillo.png"
		else 																"blanco.png"
	
	
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		// despues agregar la curacion ????????????????????????????????
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
	
	method noInfectades()=
		personas.filter({ pers => not pers.estaInfectada() }).asSet() 	
	
	method infectades()=
	 	personas.asSet().difference(self.noInfectades())
	
	method conSintomas()=
		personas.filter({ pers => pers.presentaSintomas() })
	
	method conSintomasNoAislades()=
		self.conSintomas().asSet().difference(self.aisladas())


	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
		/* 
		else if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				(1..cantidadContagiadores).forEach({ 
					if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores))
						{	persona.infectarse() } 
				})
				
			})
		}
		
		*/
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
	method todesRespetanCuarentena(){
		personas.forEach({p => p.respetaCuarentena(true)})
	}
	
	method aislar(grupoDePersonas)= 
		grupoDePersonas.forEach({ p => p.estaAislada(true)})
		
}
