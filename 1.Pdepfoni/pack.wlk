import consumo.*
import linea.*

class Pack {
	const vigencia = ilimitado
	method satisfaceLlamada (cantSegundos) = false
	method satisfaceMB (consumo) = false
	method cubre (consumo) = consumo.esCubiertoPor(pack) && vigencia.puedeUtilizarse ()
	method realizar (consumo)
	method esInutil () = !vigencia.puedeUtilizarse()
}

class PackConLimite inherits Pack {
	const cantDisponible
	var cantConsumida
	method cubreConsumo (gasto) = cantDisponible >= cantConsumida + gasto
	method sumarNuevoConsumo (gasto) = cantConsumida -= gasto
	method realizar (consumo) = consumo.realizarseCon(self)
	method override method esInutil () = super () || cantConsumida == cantDisponible
}

class LlamadasGratis inherits Pack {
	override method satisfaceLlamada (cantSegundos) = true
	override method realizar (consumo) {}
}

class CantMBLibres inherits PackConLimite {
	override method satisfaceMB (cantMB) = self.cubreConsumo(cantMB)
    override efectuar(cantMB) = self.sumarNuevoConsumo (cantMB)
}

class CantMBLibresPlus inherits CantMBLibres {
	override method satisfaceMB (cantMB) = super() || cantMB < 0.1
}

class CreditoDisponible inherits PackConLimite {
	override method cubre (consumo) = self.cubreConsumo(consumo.costo()) && vigencia.puedeUtilizarse ()
	override method realizar (consumo) = self.sumarNuevoConsumo (consumo.costo()) 
}

class InternetIlimitadoFindes inherits Pack {
	method esFinDeSemana () {
		var hoy = new Date ()
		return hoy.dayOfWeek() == sunday || hoy.dayOfWeek() == saturday
	}
	override method satisfaceMB (consumo) = self.esFinDeSemana()
	override method realizar (consumo) {}
}


// Vigencia
object ilimitado {
	method puedeUtilizarse () = true
}

class Vencimiento {
	const fechaDeVencimiento
	method puedeUtilizarse () {
		var hoy = new Date()
		return hoy < fechaDeVencimiento
	}
}