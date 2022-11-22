import pokemon.*
import movimientos.*

object normal {
	method puedeMoverse(pokemon){

	}
}

class Especial {
	method valorDePoder ()
	method puedeMoverse(pokemon){
		if(!self.intentoDeMoverse ()){
			throw new NoPuedeMoverse(message = "El pokemon todavia no puede moverse")
		}
	}

	method intentoDeMoverse () = 0.randomUpTo(2).roundUp().even()
}

object paralisis inherits Especial {
	override method valorDePoder () = 30
}

object suenio inherits Especial {
	override method valorDePoder () = 50
	override method puedeMoverse(pokemon) {
		super(pokemon)
		pokemon.condicion(normal)
	}
}

class Confusion inherits Especial {
	const cantTurnos
	override method valorDePoder () = 40 * cantTurnos
	override method puedeMoverse(pokemon) {
		self.pasoUnTurno(pokemon)
		try {
			super(pokemon)
		}
		catch e : NoPuedeMoverse {
			pokemon.daniar(20)
			throw new NoPuedeMoverse(
				message = "El pokémon no pudo moverse y se daño",
				cause = e
			)
		}
		/* Si no es antes, puede ser
		then always {
			self.pasoUnTurno(pokemon)
		}*/
	}
	method pasoUnTurno(pokemon){
		if(cantTurnos > 1){
			pokemon.condicion(new Confusion(turnosQueDura = turnosQueDura - 1))
		} else {
			pokemon.condicion(normal)
		}
	}
}

class NoPuedeMoverse inherits DomainException {}