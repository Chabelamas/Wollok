import entes.*

class Mision {
	const property habilidadesReq = #{}
	const property gradoPeligrosidad = 0

	method puedeSerCumplidaPor (ente) = ente.cumpleHabilidades(habilidadesReq)
	method realizarPor (ente) {
		if (!self.puedeSerCumplidaPor(ente)) {
			throw new NoSePuedeRealizarMision (message = "No cumple/n con todas las habilidades")
		}
		ente.recibirDanio(gradoPeligrosidad)
		ente.finalizarMision(mision)
	}
	method enseniarHabilidades(empleado) {
		self.habilidadesQueNoPosee(empleado).forEach({hab => empleado.aprenderHabilidad(hab)})
	}
	
	method habilidadesQueNoPosee(empleado) = habilidadesReq.filter({hab => not empleado.tieneHabilidad(hab)})
	
}

class NoSePuedeRealizarMision inherits DomainException {}