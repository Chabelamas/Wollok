import consumo.*
import pack.*

object pdpfonia {
	const property precioPorSegundo = 0.05
	const property precioFijo = 1
	const property precioMB = 0.1
}

class Linea {
	const telefono
	var tipo = comun
	var deuda
	const property packs = []
	const consumos = []

	method costoPromedio (fechaInicial, fechaFinal) {
		const costos = costosConsumosEntreFechas (fechaInicial, fechaFinal)
		return costos.sum() / costos.size()
	} 
	method consumosEntreFechas (fechaInicial, fechaFinal) {
		return consumos.filter({consumo => consumo.estaEntre(fechaInicial, fechaFinal)})
	}
	method costosConsumosEntreFechas (fechaInicial, fechaFinal) {
		const consumos = self.consumosEntreFechas (fechaInicial, fechaFinal)
		consumos.map({consumo => consumo.costo()})
	}
	method costoTotal30Dias () {
		var hoy = new Date ()
		return self.costosConsumosEntreFechas(hoy, hoy.minusDays(29))
	}
	method registrar (consumo) = consumos.add(consumo)
	method anadirPack (pack) = packs.add(pack)
	method packsQueCubren (consumo) = packs.filter({pack => pack.cubre(consumo)})
	method puedeRealizar (consumo) = self.packsQueCubren(consumo).size() > 0
	method packElegidoParaCubrir (consumo) = self.packsQueCubren(consumo).last()
	method realizar (consumo) {
		if (!self.puedeRealizar(consumo)) {
			tipo.accionConsumoNoRealizable(self, consumo)
		}
		const pack = packElegidoParaCubrir(consumo)
		pack.realizar(consumo)
		self.registrar(consumo)
	}
	method limpiezaPacks () = packs.removeAllSuchThat ({pack => pack.esInutil()})
	method sumarDeuda(cantidadDeuda) =	deuda += cantidadDeuda
}

object platinum {
	method accionConsumoNoRealizable(linea, consumo) {
	}
}

object black {
	method accionConsumoNoRealizable(linea, consumo) {
		linea.sumarDeuda(consumo.costo())
	}
}

object comun {
	method accionConsumoNoRealizable(linea, consumo) {
		throw new NoPuedeRealizarseElConsumo (message = "No tiene ningun plan que satisfaga completamente el consumo")
	}
}

class NoPuedeRealizarseElConsumo inherits DomainException {}