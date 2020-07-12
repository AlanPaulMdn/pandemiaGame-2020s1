import personas.*
import manzanas.*
import wollok.game.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []

	// parametros del juego
	const property chanceDePresentarSintomas = 30
	
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	
	
	const property personasPorManzana = 10
	const property duracionInfeccion = 20

	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */
	
	method tomarChance(porcentaje) = 0.randomUpTo(100) < porcentaje

	method agregarManzana(manzana) { manzanas.add(manzana) }
	
	method debeInfectarsePersona(persona, cantidadContagiadores) {
		const chanceDeContagio = if (persona.respetaCuarentena()) 
			self.chanceDeContagioConCuarentena() 
			else 
			self.chanceDeContagioSinCuarentena()
		return (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) })	
	}

	method crearManzana() {
		const nuevaManzana = new Manzana()
		(1..self.personasPorManzana()-8).forEach({ cant => //SACAR EL -8
			nuevaManzana.ingresarPersona(new Persona())	})
		return nuevaManzana
	}
	
	method sumarInfectade() {
		if (not manzanas.isEmpty()) {
			self.manzanaAzarosa().ingresarPersona(new Infectade())
		}
		else
			{console.println("No hay manzanas en el pueblo")}
	}
	
	method manzanaAzarosa()=
		manzanas.get(0.randomUpTo(manzanas.size()))
	
	method pasarDia(){
		diaActual += 1
		manzanas.forEach({m=> m.pasarUnDia()})
		console.println("terminó el día")
	}
	
	method totalPersonas()=
		manzanas.sum({m => m.personas().size()})
	method totalInfectades()=
		manzanas.sum({m => m.infectades().size()})
	method totalConSintomas()=
		manzanas.sum({m => m.conSintomas().size()})
	
	method estadoGeneral(){
		return "Día " + diaActual + ", total de personas: "+ self.totalPersonas() +
		 ", infectados: " + self.totalInfectades() + ", con síntomas: "+ self.totalConSintomas()
	}
}
