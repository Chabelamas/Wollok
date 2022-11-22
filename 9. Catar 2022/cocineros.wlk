import platos.*

class Cocinero {
	var especialidad
	method catar (plato) = especialidad.clasificacion(plato)
	method cambiarEspecialidadA (otraEspecialidad) {
		especialidad = otraEspecialidad
	} 
	method cocinar () {
		return especialidad.crearPlato(self)
	}	
}

class Pastelero {
	const nivelDeseadoDeDulzor
	method clasificacion (plato) = 10.max(5 * plato.azucar() / nivelDeseadoDeDulzor)
	method cantColores () = nivelDeseadoDeDulzor / 50
	method crearPlato (cocinero) {
		return new Postre (cantColores = self.cantColores (), cocinero = cocinero)
	}
}

class Chef {
	const cantidadDeCalorias
	method puntajeCuandoNoCumpleExp (plato) = 0
	method clasificacion(plato) {
		if (plato.esBonito() && plato.cumpleCriterioCal(cantidadDeCalorias)) return 10
		return self.puntajeCuandoNoCumpleExp (plato)
	}
	method crearPlato (cocinero) {
		return new Principal (bonito = true, cantAzucar = cantidadDeCalorias, cocinero = cocinero)
	}
}

class SousChef inherits Chef {
	override method puntajeCuandoNoCumpleExp (plato) = 6.max(plato.calorias()/100)
	override method crearPlato (cocinero) = new Entrada (cocinero = cocinero)
}