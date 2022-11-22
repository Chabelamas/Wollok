import descargas.*
import empresas.*

class Plan {
	method abonarDescarga (contenido)
	method valorAPagarPorDescarga (descarga) = self.valorAPagar(descarga.contenido())
	method valorAPagar (contenido) {
		return contenido.montoPorDerechoDeAutor() + companiaDeComercializacionDeContenido.cobra(contenido) + companiaTelecomunicaciones.cobra (contenido)
	}
}

object prepago inherits Plan{
	override method valorAPagar (contenido) = super (contenido) * 1.1
	override method abonarDescarga (contenido) {
		if (self.valorAPagar (contenido) > saldo) {
			throw new NoPuedeRealizarseDescarga(message = "No tiene suficiente saldo")
		}	
		saldo -= plan.valorAPagar (contenido) 
	}
}
class Facturado  inherits Plan{
	var gastos
	method abonarDescarga (contenido) {
		gastos += self.valorAPagar (contenido) 
	}
}

class NoPuedeRealizarseDescarga inherits DomainException {}