import planes.*
import descargas.*

object empresaPdp {
	const property montoFijoChiste
	var property impuestoPrestacion
	method actualizarImpuesto (impuestoActualizado) {
		self.impuestoPrestacion(impuestoActualizado)
	}
}

class CompaniaDeComercializacionDeContenido {
	var usuarios = #{}
	method cobra (contenido) =  contenido.montoPorDerechoDeAutor() * 0.25
	method descargasDeDia (fechaSolicitada) {
		return usuarios.map{usuario => usuario.contenidosDescargadosEn(fechaSolicitada)}.flatten() //para volverla una lista y que no sea una lista con sublistas
	}
	method contenidosDescargadosDeDia (fechaSolicitada) = self.descargasDeDia(fechaSolicitada).map{descarga => descarga.contenido()}
	method mayorDescargaDeContenidoDelDia (fechaSolicitada) {
		const contenidos = self.contenidosDescargadosDeDia(fechaSolicitada)
		return contenidos.max{contenido => contenidos.count(contenido)}
	}
}

class CompaniaDeTelecomunicacionesNacional {
	method cobra (contenido) =  contenido.montoPorDerechoDeAutor() * 0.05
}

class ComapaniaDeTelecomunicacionesInternacional inherits ComapaniaDeTelecomunicacionesNacional {
	override method cobra (contenido) = super(contenido) + empresaPdp.impuestoPrestacion()
}

class Usuario {
	var property saldo
	const property companiaTelecomunicaciones
	const property plan
	const descargas = []
	method realizarDescarga (contenido) {
		plan.abonarDescarga(contenido)
		const descarga = new Descarga (fecha = newDate(), contenido = contenido)
		self.agregar(descarga)
	}
	method agregar(descarga) = descargas.add(descarga)
	method descargasDeMes (fechaSolicitada) = descargas.filter{des => des.fueEnElMes(fechaSolicitada)}
	method gastoEnElMesActual () {
		const fechaActual = new Date()
		return self.descargasDeMes(fechaActual).sum({descarga => plan.valorAPagarPorDescarga(descarga)}) 
	}
	method contenidosDescargados () = descargas.map({descarga => descarga.contenido()})
	method seRepiteMasDeUnaVez (contenido) = self.contenidosDescargados().count(contenido) > 1
	method esColgado () {
		return self.contenidosDescargados().any({contenido => self.seRepiteMasDeUnaVez(contenido)})
	}
	method contenidosDescargadosEn (fechaSolicitada) = descargas.filter{descarga => descarga.fueEnElMismoDia(fechaSolicitada)}.map{descarga => descarga.contenido()}
}