import wollok.game.*
import simulacion.*
import manzanas.*
import personas.*

object agente {
	var property position = game.origin()
	method image()= "ambulancia.png"
	
	/*  BORRAR
	method respetarCuarentena(persona){
		persona.respetarCuarentena()
	}
	*/
	
	method aislarInfectades(manzanaActual){ // Se aislan todes che! que tamos desbordades...
		const infectades = manzanaActual.conSintomasNoAislades() 
		if ( infectades.size()> 0 ){	manzanaActual.aislar(infectades)	}
	}
	
	method respetarCuarentena(manzanaActual){ //Todes a respetar la cuarentena! vamos... rápido
		manzanaActual.todesRespetanCuarentena() 
	}
	
	method moveRight(x){ 
		if (self.position().x() < x-1 ){
		self.position(self.position().right(1)) }
	}
	method moveLeft(){ 
		if (self.position().x() > 0 ){
		self.position(self.position().left(1))}
	}
	method moveUp(y){
		if (self.position().y() < y-1 ){
		self.position(self.position().up(1))}
	}
	method moveDown(){
		if (self.position().y() > 0 ){
		self.position(self.position().down(1)) }
	}
}