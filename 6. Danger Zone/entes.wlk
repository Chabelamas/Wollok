import mision.*

class Equipo {
	const equipo = #{} 
	method cumpleHabilidades (habilidadesReq) = habilidadesReq.all{hab => self.alguienTieneHabilidad(habilidad)}
	method alguienTieneHabilidad (habilidad) = equipo.any{empleado => empleado.puedeUsarHabilidad(habilidad)}
	method recibirDanio (cantidad) {
		equipo.forEach{emp => emp.recibirDanio (cantidad / 3)}
	}
	method finalizarMision (mision) {
		sobrevivientes = equipo.filter({empleado => empleado.estaVivo()})
		sobrevivientes.forEach({empleado => empleado.registrarMision(mision)})
	}
}

class Empleado {
	var cantidadDeSalud
	var habilidades = #{}
	const trabajo = oficinista
	method estaIncapacitado () = cantidadDeSalud < trabajo.saludCritica()
	method tieneHabilidad (habilidad) = habilidades.contains(habilidad)
	method puedeUsarHabilidad (habilidad) = tipo.tieneHabilidad (self,habilidad) && !self.estaIncapacitado()
	method cumpleHabilidades (habilidadesReq) = habilidadesReq.all{hab => self.puedeUsarHabilidad(hab)}
	method recibirDanio(cantidad) { 
		salud = salud - cantidad 
	}
	/*method sumarHabilidadesQueNoTenia (habilidadesNuevas) {
		habilidades = habilidades.union(habilidadesNuevas)
	} 
	*/
	method estaVivo () = cantidadDeSalud > 0
	method finalizarMision(mision) = trabajo.registrarMision(self, mision)
	method aprenderHabilidad(habilidad) {
		habilidades.add(habilidad)
	}
	
}

object espia {
	method saludCritica () = 15
	method registrarMision (empleado, mision) {
		//empleado.sumarHabilidadesQueNoTenia(mision.habilidadesReq())
		mision.enseniarHabilidades(empleado)
	}

}

class Oficinista { // tiene que ser clase porque su estado no tiene que ser compartido por los demas (si modifico estrellas, tiene que modicarse solo para uno)
	var estrellas = 0
	method sobreviveMision () = estrellas += 1
	method saludCritica () = 40 - 5 * estrellas
	method registrarMision (empleado, mision) {
		estrellas += 1
		if (estrellas == 3) empleado.trabajo(espia)
	}

}

object jefe inherits Empleado{
	var subordinados = #{}
	override method tieneHabilidad (habilidad) = super(habilidad) || subordinados.any({sub => sub.cuentaCon(habilidad)})

}