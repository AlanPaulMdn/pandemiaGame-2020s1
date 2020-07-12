import personas.*
import manzanas.*
import wollok.game.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []

	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20
	
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
		(1..self.personasPorManzana()-5).forEach({ cant => ///////////////////////////////////////////SACAR EL -5
			nuevaManzana.ingresarPersona(new Persona())	})
		return nuevaManzana
	}
	
	method sumarInfectade() {
		if (not manzanas.isEmpty()) {
			self.manzanaAzarosa().ingresarPersona(new Infectade())
			console.println("Se sumó un infectade")
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
		manzanas.sum({m => m.totalPersonas()})
	method totalInfectades()=
		manzanas.sum({m => m.cantidadInfectades()})
	method totalConSintomas()=
		manzanas.sum({m => m.cantidadConSintomas()})
	
	method estadoGeneral(){
		return "Día " + diaActual + ", total de personas: "+ self.totalPersonas() +
		 ", infectados: " + self.totalInfectades() + ", con síntomas: "+ self.totalConSintomas()
	}
}
