import inmobiliaria.*

class Inmueble {
	const property valor
	const property tamano
	const property cantAmbientes
	const property operacion
	const property zona
	const property inmobiliaria
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
	override method valor () = tipo.sale(precio, inmobiliaria)
}

object Galpones {
	method sale (precioInmueble, inmobiliaria) = precioInmueble / 2
}

object ALaCalle {
	method sale (precioInmueble, inmobiliaria) = precioInmueble + inmobiliaria.montoFijo()
	override esVendible () {
		throw new VentaInvalida(message = "Los locales no son vendibles")
	}
}

class Zona{
	var property plus
}

class VentaInvalida inherits DomainException {}