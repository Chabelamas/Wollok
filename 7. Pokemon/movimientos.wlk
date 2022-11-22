import pokemon.*
import condiciones.*

class Movimiento {
	const cantUsos
	method aplicarEfecto (pokemon, rival)
	method estaDisponible () = cantUsos > 0
	method ejecutar (pokemon, rival) {
		cantUsos -= 1
		if (cantUsos < 0)  {
			throw new NoPuedeUsarMovimiento(message = "Agoto los usos del movimiento")
		}
		self.aplicarEfecto(pokemon, rival)
	}
}

class MCurativo inherits Movimiento{
	const cantidad 
	override method aplicarEfecto (pokemon, rival) {
		pokemon.curar(cantidad)
	}
	method poder () = cantidad
}

class MDaninos inherits Movimiento{
	const danio 
	override method aplicarEfecto (pokemon, rival) {
		rival.daniar(danio)
	}
	method poder () = 2 * danio
}

class MEspecial inherits Movimiento{
	const condicion
	override method aplicarEfecto (pokemon, rival) {
		rival.tener(condicion)
	}
	method poder () = condicion.valorDePoder()
}