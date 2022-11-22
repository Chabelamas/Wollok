import planes.*
import empresas.*

class Descarga {
	const property fecha
	const property contenido
	method fueEnElMes(fechaSolicitada) {
		return fecha.month() == fechaSolicitada.month() && fecha.year() == fechaSolicitada.year()
	}
	method fueEnElMismoDia (fechaSolicitada) = fecha == fechaSolicitada
	
}

class Ringtone {
	const duracion
	const precioPorMinuto
	method montoPorDerechoDeAutor () = duracion * precioPorMinuto
}

class Chiste {
	const texto
	method cantCaracteres () = texto.size()
	method montoPorDerechoDeAutor () = empresaPdp.montoFijoChiste() + self.cantCaracteres()
}

class Juego {
	const monto
	method montoPorDerechoDeAutor () = monto
}

object empresaPdp {
	const property montoFijoChiste
	var property impuestoPrestacion
	method actualizarImpuesto (impuestoActualizado) {
		impuestoPrestacion(impuestoActualizado)
	}
}