import nivelAprendizaje.*
import producciones.*

class Academia {
	var cocineros = #{}
	const recetario = #{}
	var property experienciaMaxima
	method entrenarCocineros () {
		cocineros.forEach({cocinero => cocinero.prepararRecetaQueAportaMas(recetario)})
	}
}

class Cocinero {
	const preparaciones = []
	var property nivelDeAprendizaje = principiante
	
	method experiencia () = (self.experienciasDePreparaciones()).sum()
	method experienciasDePreparaciones () = preparaciones.map({comida => comida.experiencia()})
	method recetasPreparadas () = preparaciones.map({comida => comida.receta()}) 
	method comidasConRecetasSimilaresA (receta) = preparaciones.filter({comida => comida.tieneRecetaSimilarA(receta)})
	method tieneRecetaSimilarA (receta) = (self.comidasConRecetasSimilaresA(receta)).size() > 0
	method expComidasConRecetasSimilarA (receta) = ((self.comidasConRecetasSimilaresA (receta)).map({comida => comida.experiencia()})).sum()
	method convertirseEnExperto () = nivelDeAprendizaje(experto)
	method convertirseEnChef () = nivelDeAprendizaje(chef)
	method superarNivel () = nivelDeAprendizaje.verificarSuperarNivel(self)
	method calcularPlus (receta) = (self.comidasConRecetasSimilaresA(receta)).size() / 10
	method recetaQueAportaMas (recetas) = recetas.max({receta => receta.experienciaAportada()})
	method prepararRecetaQueAportaMas (recetas) {
		const receta = self.recetaQueAportaMas(recetas)
		self.preparar(receta)
	}
	method sumarPreparacion(receta) {
		const comida = new Comida (receta = receta, calidad = nivelDeAprendizaje.calidadComida(receta))
	}
	method preparar (receta) {
		if (!nivelDeAprendizaje.puedePreparar(self, receta)) {
			throw new NoPuedePrepararComida(message = "Debido a su nivel, no puede preparar esta comida")
		}
		self.sumarPreparacion(receta)
		self.superarNivel()
	}
}

class NoPuedePrepararComida inherits DomainException {}