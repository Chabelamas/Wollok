class Plato {
	const property cocinero
	method azucar ()
	method esBonito ()
	method calorias () = 3 * self.azucar() + 100
	method cumpleCriterioCal(cantidadDeCalorias) = self.calorias() <= cantidadDeCalorias 
	
}

class Entrada inherits Plato{
	override method azucar () = 0
	override method esBonito () = true
}

class Principal inherits Plato{
	const bonito
	const cantAzucar
	override method azucar () = cantAzucar
	override method esBonito () = bonito
}

class Postre inherits Plato{
	const cantColores
	override method azucar () = 120
	override method esBonito () = cantColores > 3
}