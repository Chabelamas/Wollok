import movimientos.*
import condiciones.*

class Pokemon {
	const maximoDeVida
	const movimientos = []
	var puntosDeVida
	var property condicion = normal

	method estaVivo () {
		if (puntosDeVida <= 0) {
			throw new NoPuedeLuchar(message = "El pokemon no esta vivo")
		}
	} 
	method curar (cantidad) {
		puntosDeVida = maximoDeVida.max(puntosDeVida + cantidad)
	}
	method sumaPoderesMov () = movimientos.map({mov => mov.poder()}).sum()
	method grositud () = maximoDeVida * self.sumaPoderesMov()
	method daniar (danio) {
		puntosDeVida = puntosDeVida - danio
	}
	method movimientoDisponible() = movimientos.findOrElse({movimiento =>
 		movimiento.estaDisponible()
 	}, {throw new NoPuedeUsarMovimiento(message = "No tiene movimientos disponibles")})
	method luchar (rival) {
		self.estaVivo()
		condicion.puedeMoverse()
		self.movimientoDisponible().ejecutar(self, rival)
	}
}

class NoPuedeLuchar inherits DomainException {}
class NoPuedeUsarMovimiento inherits DomainException {}