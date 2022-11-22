import pack.*
import linea.*

class Consumo {
	const fecha
	method costo () 
	method estaEntre (fechaInicial, fechaFinal) = fecha.between(fechaInicial, fechaFinal)
	method esCubiertoPorLlamada (pack) = false
	method esCubiertoPorMB (pack)
	method esCubiertoPor (pack) = self.esCubiertoPorLlamada(pack) || self.esCubiertoPorMB(pack)
	method realizarseCon (pack)
}

class ConsumoInternet inherits Consumo {
	var property cantMB
	override method costo () = pdpfonia.precioMB() * cantMB
	override method esCubiertoPorMB (pack) = pack.satisfaceMB(cantMB)
	override method realizarseCon (pack) = pack.efectuar(cantMB)
}

class ConsumoLlamada inherits Consumo {
	var property cantSegundos
	override method costo () = pdpfonia.precioFijo() + if (cantSegundos > 30) (cantSegundos - 30) * pdpfonia.precioPorSegundo() else 0
	override method esCubiertoPorLlamada (pack) = pack.satisfaceLlamada(cantSegundos)
	override method realizarseCon (pack) = pack.efectuar(cantSegundos)
}