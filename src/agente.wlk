import wollok.game.*
import simulacion.*
import manzanas.*
import personas.*


object agente {
	var property position = game.at(0,0)
	var property image = "ambulancia.png"
	const manzanaActual = game.colliders(self)
	
	method respetarCuarentena(persona){
		persona.respetarCuarentena()
	}
	
	method aislarInfectades(){ // Se aislan todes che! que tamos desbordades...
		const infectades = manzanaActual.conSintomasNoAislades() 
		if ( infectades.size()> 0 ){
			manzanaActual.aislar(infectades)
		}
	}
	
	method respetarCuarentena(){ //Todes a respetar la cuarentena! vamos... rápido
		manzanaActual.todesRespetanCuarentena() 
	}

	
	method moveRight() {self.position(self.position().right(1))}
	method moveLeft() {self.position(self.position().left(1))}
	method moveUp() {self.position(self.position().up(1))}
	method moveDown() {self.position(self.position().down(1))}
	
}