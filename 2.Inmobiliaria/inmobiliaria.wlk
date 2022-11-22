import inmuebles.*
import operaciones.*

class Inmobiliaria{
	var property porcentajeVentas
	const property montoFijo
	var property empleados = #{}
	var property inmuebles = #{}
	method fueElMejor (condicion) = empleados.max{em => condicion.criterio(em)}
}

object totalComisiones {
	method criterio (empleado) = empleado.totalComisionesGanadas()
}

object cantOpCerradas {
	method criterio (empleado) = empleado.cantOperacionesCerradas()
}

object cantReservas {
	method criterio (empleado) = empleado.cantReservas()
}


class Empleado {
	const property operacionesCerradas = #{}
	const property reservas = #{}
	method reservar (operacion, cliente) {
		operacion.reservar ()
		reservas.add(operacion)
	}
	method concretar (inmueble, cliente) {
		operacion.concretar ()
		operacionesCerradas.add(operacion)
	}
	method totalComisionesGanadas () = operacionesCerradas.map{op => op.comision()}
	method cantOperacionesCerradas () = operacionesCerradas.size()
	method cantReservas () = reservas.size()

	method zonasConOpCerradas () = reservas.map{re => re.zona()}

	method operoEnZona (zona) = self.zonasConOpCerradas().contains(zona)
	method operoEnMismaZonaQue(empleado) =
		self.zonasConOpCerradas() .any({zo => empleado.operoEnZona(zo)})

	method concretoReservaDe(empleado) =
		operacionesCerradas.any({operacion => empleado.reservo(operacion)})
		
	method reservo(operacion) = reservas.contains(operacion) // reconocera el objeto si cambia su estado?
	method tieneProblemasCon (empleado) = concretoReservaDe(empleado) && operoEnMismaZonaQue(empleado)
}

class Cliente {
	const nombre
}