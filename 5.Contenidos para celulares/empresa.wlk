import planes.*
import descargas.*

class CompaniaDeComercializacionDeContenido {
	var usuarios = #{}
	method cobra (contenido) =  contenido.montoPorDerechoDeAutor() * 0.25
	method descargasDeDia (fechaSolicitada) {
		usuarios.map{usuario => usuario.contenidosDescargadosEn(fechaSolicitada)}
	}
	method mayorDescargaDelDia (fechaSolicitada) // VER QUE NO SE COMO HACER
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
	method contenidoDeDescarga (descarga) = descarga.contenido() 
	method realizarDescarga (contenido) {
		plan.abonarDescarga(contenido)
		descarga = new Descarga (fecha = newDate(), contenido = contenido)
		descargas.add(descarga)
	}
	method descargasDe (fechaSolicitada) {
		return descargas.filter{des => des.fueEnElMes(fechaSolicitada)}
	}
	method gastoEnElMesActual () {
		const fechaActual = new Date()
		const listaDeGastos = (self.descargasDe(fechaActual)).map{descarga => plan.valorAPagar(self.contenidoDeDescarga(descarga))} //esta bien?
		return listaDeGastos.sum()
	}
	method contenidosDescargados () = descargas.map{descarga => descarga.contenido()}
	method esColgado () {
		const contenidos = self.contenidosDescargados()
		contenidos.findOrElse(
			{contenido, otroContenido => contenido == otroContenido
			 return true}
			 , 
			 {return false})
	}
	method contenidosDescargadosEn (fechaSolicitada) = (descargas.filter{descarga => descarga.fueEnElMismoDia(fechaSolicitada)}).map{descarga => descarga.contenido()}
}