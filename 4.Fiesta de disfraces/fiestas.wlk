import disfraces.*

class Fiesta {
	const lugar
	const property fecha
	const invitados = #{}

	method esUnBodrio () = invitados.all{inv => !inv.satisfechoConDisfraz(fiesta)}
	method mejorDifraz () = invitados.max{inv => inv.puntajeDisfraz(self)}
	method estaEnFiesta (persona) = invitados.contains(asistente)
	method estanEnFiesta (asistente, otroAsistente) = estaEnFiesta(asistente) && estaEnFiesta(otroAsistente)
	method sumarInvitado (asistente) {
		if (!asistente.tieneDisfraz() || self.estaEnFiesta(asistente)) {
			throw new NoPuedeSumarseALaFiesta(message = "El asistente no se puede sumar a la fiesta")
		}
		invitados.add(asistente)
	}
	method pasanAEstarConformes(asistente, otroAsistente) {
		const disfraz1 = asistente.disfraz()
		const disfraz2 = otroAsistente.disfraz()
		asistente.disfraz(disfraz2)
		otroAsistente.disfraz(disfraz1)
		return asistente.satisfechoConDisfraz(self) && otroAsistente.satisfechoConDisfraz(self)
	}
	method algunoEstaDisconforme (asistente, otroAsistente) = !asistente.satisfechoConDisfraz(self) || !otroAsistente.satisfechoConDisfraz(self)
	// method fiestaInolvidable () = invitados.all{inv => inv.esSexy() && inv.satisfechoConDisfraz(fiesta)}
	method intercambiarDisfraz (asistente, otroAsistente) {
		return self.estanEnFiesta(asistente, otroAsistente) && self.algunoEstaDisconforme(asistente, otroAsistente) && self.pasanAEstarConformes(asistente, otroAsistente)
	}
}

class FiestaInolvidable inherits Fiesta{
	override method sumarInvitado (invitado){
		super(invitado)
		if(!invitado.esSexy() || !invitado.satisfechoConDisfraz(self))
		{
			throw new NoSePudoAgregarInvitado()
		}
	}
}

class Persona {
	const property edad
	var property disfraz
	var personalidad
	
	method tieneDisfraz() = disfraz != 0
	method puntajeDisfraz (fiesta) = disfraz.puntuacion (self, fiesta)
	method satisfechoConDisfraz (fiesta) = disfraz.puntuacion(self, fiesta)
	method esSexy () = personalidad.esSexy(self)
}

object caprichoso inherits Persona {
	override method satisfechoConDisfraz (fiesta) = super (fiesta) && disfraz.nombrePar()
}

object pretencioso inherits Persona {
	const puntajeExacto
	override method satisfechoConDisfraz (fiesta) = super (fiesta) && disfraz.puntuacion(self, fiesta) == puntajeExacto
}

class Numerologo inherits Persona {
	override method satisfechoConDisfraz (fiesta) = super (fiesta) && (fiesta.fecha() - disfraz.fechaConfeccion())<30
}

object alegre {
	method esSexy(persona) = false
}

object taciturna {
	method esSexy(persona) = persona.edad() < 30
}


class NoPuedeSumarseALaFiesta inherits DomainException {}
class NoSePudoAgregarInvitado inherits DomainException {}