import cocineros.*

class Torneo {
	const catadores = #{}
	const platos = #{}
	method puntuacionTotal(plato) = catadores.sum{catador => catador.catar (plato)}
	method cocineroGanador() {
		if (platos.isEmpty()) {
			throw new NoHayCocineros(message = "No se puede establecer un ganador")
		}
		return platos.max{plato => self.puntuacionTotal(plato)}.cocinero()
	} 
	method sumarParticipante(cocinero) {
		platos.add(cocinero.cocinar())
	}
}

class NoHayCocineros inherits DomainException {}