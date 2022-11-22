import suenos.*

class Persona {
	const edad
	const plataAGanar
	const tipo
	var property nivelDeFelicidad
	const carrerasAEstudiar = #{}
	const lugaresVisitados = #{}
	var property cantHijos = 0
	const property suenosCumplidos = []
	const property suenosPendientes = []

	method quiereEstudiar(carrera) = carrerasAEstudiar.contains(carrera)
	method yaCumplioSueno(sueno) = suenosCumplidos.contains(sueno)
	method anadirHijos (cantidad) = cantHijos += cantidad
	method anadirViaje (lugar) = lugaresVisitados.add(lugar)
	method anadirSuenoCumplido (sueno) {
		suenosPendientes.remove(sueno)
		suenosCumplidos.add(sueno)
	}
	method felicidoniosDeSuenosPedientes () = suenosPendientes.map{sueno =>sueno.nivelDeFelicidad()}
	method esFeliz () = nivelDeFelicidad > self.felicidoniosDeSuenosPedientes.sum()
	method suenosAmbiciosos (coleccion) = coleccion.filter{sueno=>sueno.nivelDeFelicidad()>100}
	method esAmbiciosa () {
		const suenosAmbiciosos = self.suenosAmbiciosos (suenosPendientes) + self.suenosAmbiciosos (suenosCumplidos)
		return suenosAmbiciosos.size() > 3
	}
	method cumplirSueno () {
		const suenoElegido = tipo.suenoAPartirDeCondicion(suenosPendientes)
		suenoElegido.cumplirPara(self)
	}
}

object realista {
	method suenoAPartirDeCondicion (suenosPendientes) = suenosPendientes.max{sueno => sueno.nivelDeFelicidad()}
}

object alocados {
	method suenoAPartirDeCondicion (suenosPendientes) =  suenosPendientes.anyOne()
}


object obsesivos {
	method suenoAPartirDeCondicion (suenosPendientes) = suenosPendientes.first()
}
