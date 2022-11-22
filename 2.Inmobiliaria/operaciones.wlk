import inmuebles.*
import operaciones.*

class Operacion {
	var property estado = disponible
	const property inmueble
	method comision ()
	method zona () = inmueble.zona()
	method reservarPara (cliente) {
		estado.reservar(self, cliente)
	}
	method concretarPara (cliente) {
		estado.concretar(self, cliente)
	}

}

class Alquiler inherits Operacion{
	const property cantMeses
	override method comision () = (cantMeses * inmueble.precio())/50000
}

class Venta inherits Operacion {
	override method comision () = (inmueble.precio() * inmobiliaria.porcentajeVentas())/100
	override method reservarPara (cliente) {
		inmueble.esVendible()
		super(cliente)
	}
	override method concretarPara (cliente) {
		inmueble.esVendible()
		super(cliente)
	}
}

class Estado {
	method reservar (operacion, cliente)
	method concretar (operacion, cliente)
}

object disponible {
	override method reservar (operacion, cliente){
		operacion.estado(new Reservado(cliente))
	}
	override method concretar (operacion, clienteSolicitando) {
		operacion.estado(concretado)
	}

}

class Reservado {
	var property cliente
	override method reservar (operacion, clienteSolicitando) {
		throw new NoSePuedeRealizarReserva (message = "El inmueble ya se encuentra reservado")
	}
	override method concretar (operacion, clienteSolicitando) {
		if (cliente != clienteSolicitando){
			throw new NoSePuedeConcretar (message = "El inmueble ya se encuentra reservado por otro cliente")
		}
		operacion.estado(concretado)
	}

}

object concretado {
	override method reservar (operacion, clienteSolicitando) {
		throw new NoSePuedeRealizarReserva (message = "El inmueble ya se encuentra concretado")
	}

	override method concretar (operacion, clienteSolicitando) {
		throw new NoSePuedeConcretar (message = "El inmueble ya se encuentra concretado")
	}

}

class NoSePuedeConcretar inherits DomainException {}
class NoSePuedeRealizarReserva inherits DomainException {}