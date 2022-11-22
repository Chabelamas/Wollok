import inmobiliaria.*

class Inmueble {
	const property valor
	const property tamano
	const property cantAmbientes
	const property operacion
	const property zona
	method valor ()
	method precio () = self.valor() + zona.plus()
	method esVendible ()
}

class Casa inherits Inmueble {
	const property precio
	override method valor () = precio
}

object pH inherits Inmueble {
	override method valor () =  500000.min(14000*tamano)
}

object depto inherits Inmueble {
	override method valor () =  350000*cantAmbientes
}

class Local inherits Casa {
	var property tipo
	override method valor () = tipo.sale(precio)
}

object Galpones {
	method sale (precioInmueble) = precioInmueble / 2
}

object ALaCalle {
	method sale (precioInmueble) = precioInmueble + inmobiliaria.montoFijo() // esto lo puedo hacer?
	override esVendible () {
		throw new VentaInvalida("Los locales no son vendibles")
	}
}

class Zona{
	var property plus
}

class VentaInvalida inherits DomainException {}