/*
Más sobre packs:
Realizar una limpieza de packs, que elimine los packs vencidos o completamente acabados.
Agregar los packs “MB libres++”, que son como los packs de MB libres pero que cuando se gastan los MB libres igual te siguen sirviendo... Pero sólo para consumos de 0.1 MB o menos.

*/
/* archivo 1*/
class Linea {
	const telefono
	const property packs = []
	const consumos = []

	method calcularCostoTotal(hoy) {
		const treintaDiasAntes = hoy.minusDays(30)
		const consumosTreintaDias = consumos.filter{consumo -> consumo.realizadoEntre(treintaDiasAntes,hoy) }
		return consumosTreintaDias.sum()    

	}

	method calcularCostoPromedioEntre(fechaInicial, fechaFinal) {
		const consumoEntreDias = consumos.filter{consumo -> consumo.realizadoEntre(fechaInicial,fechaFinal) }
		return consumoEntreDias.sum() / consumoEntreDias.size()
	}

	method agregarPack(pack)= packs.add(pack)
	
	method puedeSatisfacer(consumo) = packs.any{pack -> pack.puedeSatisfacer(consumo)}

	method realizar(consumo) {
		self.validarConsumo(consumo)
		const pack = self.ultimoQuePuedeSatisfacer(consumo)
		pack.consumirPack(consumo)

	}

	method ultimoQuePuedeSatisfacer(consumo) = packs.filter{pack => pack.puedeSatisfacer(consumo)}.last()
	
	method validarConsumo(consumo) {
		if(not self.puedeSatisfacer(consumo)) {
			throw new NoPuedeRealizarseElConsumo(message = "El consumo no puede realizarse")
		}
	}
}
/* archivo 2 consumos */
class Consumo {
	const property fecha 
	method realizadoEntre(fechaInicial,fechaFinal) = fecha.between(fechaInicial,fechaFinal)
		
}

class ConsumoLlamadas inherits Consumo {
	const segundosLLamadas
	method calcularCosto()= preciosPdpFoni.precioFijoLLamadas + if(segundosLLamadas>=30) preciosPdpfoni.precioPorSegundo() * (segundosLLamadas-30) else 0
	
	method esCubierto(pack) = pack.segundosLLamadasPack() >= segundosLLamadas
		 
	
}

class ConsumoInternet inherits Consumo {
	const mbConsumidos
	method calcularCosto() = preciosPdpFoni.precioMB() * mbConsumidos
	method esCubierto(pack) = pack.mbPack() >= mbConsumidos
	
}

object preciosPdpfoni {
	const property precioFijoLLamadas
	const property precioPorSegundo
	const property precioMB

}

/*archivo 3 packs */
class Pack {
	const property vigencia = ilimitado
	method puedeSatisfacer(consumo) = consumo.esCubierto(self) && not vigencia.vencido(consumo.fecha())
}

class PackMBLibres inherits Pack {
	const property mbPack
	method consumirPack(consumo){
		mbPack -= consumo.mbConsumidos()
	}
	
}

class PackLLamadas inherits Pack {
	const property segundosLLamadasPack
	method consumirPack(consumo) {
		segundosLLamadasPack -= consumo.segundosLLamadas()
	}
	
}

class PackCredito inherits Pack {
	const property credito
	override method puedeSatisfacer(consumo) = credito >= consumo.calcularCosto()
	method consumirPack(consumo) {
		credito -= consumo.calcularCosto()
	}
}

//Vigencias
object ilimitado {
	method vencido() = false
}

class Vencimiento {
	const fecha
	method vencido(fechaDelConsumo) = fecha < fechaDelConsumo
}



class NoPuedeRealizarseElConsumo inherits DomainException {}