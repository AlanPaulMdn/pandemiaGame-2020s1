import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	//var property cantInfectades = self.infectades().size()
	
	method image()=
	/* 	NO ANDA ASI
		if (cantInfectades == personas.size())							"rojo.png"
		else if (cantInfectades.between(8,personas.size()-1))			"naranjaOscuro.png"
		else if (cantInfectades.between(4,7))							"naranja.png"
		else if (cantInfectades.between(1,3))							"amarillo.png"
		else 															"blanco.png"
	
	*/ 
		if (self.cantidadInfectades() == self.totalPersonas())							"rojo.png"
		else if (self.cantidadInfectades().between(8,self.totalPersonas()-1))			"naranjaOscuro.png"
		else if (self.cantidadInfectades().between(4,7))								"naranja.png"
		else if (self.cantidadInfectades().between(1,3))								"amarillo.png"
		else 																			"blanco.png"
	
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		self.curacion()
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
	
	method totalPersonas()=
		personas.size()
	
	method cantidadInfectades()=
		self.infectades().size()
	
	method cantidadConSintomas()=
		self.conSintomas().size()
		
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
	
	method situacionInfectades(){
		return "Cantidad de infectades en manzana actual " + self.infectades().size()
	}

	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores() 
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				(1..cantidadContagiadores).forEach({ 
					if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores))
						{	persona.infectarse() } 
				})
				
			})
		}
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
	
	method curacion(){
		self.infectades().forEach({i => i.curarse()})
	}
		
}
